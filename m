From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git_remote_helpers: remove GIT-PYTHON-VERSION upon "clean"
Date: Wed, 30 Jan 2013 11:30:10 -0800
Message-ID: <7vzjzqjwot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 20:30:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dMj-000158-9B
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 20:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747Ab3A3TaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 14:30:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755333Ab3A3TaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 14:30:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 452B6C6CD;
	Wed, 30 Jan 2013 14:30:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=3
	gHoERYQFvX/CNVnXOx0xdQz0Lc=; b=mEcNpEc7PLg1P6L/FPsImu1vNpTbrWUDW
	OItkKwpktERlS0rcf6/hHlSfI6cAACF6zTPEvJD18uvZb7vK1tZffI99N6Ys/mtP
	KozlCaLtBC+tYYJh7VFLEMAP9OTJMPP8tt7asnrFQKsvGM8YrM+wN7IsXHCNY7et
	SgBTJfDMVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=vZoOIo81pVR68zHymkqDkl3+96ZjUup/ZEQqZ1VJCxD8ZspMUPUC2fTG
	RvSl52jDwmknr5E+Fp6nDIqDegyE0tkxKPo1icQ1TkW493PgyGg02lbJM6cabFoI
	NcmqTsAU+J9NnU2SZULwMQ9AYT9mxv1GOvSKw86m4GP6FD5zV5s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38DEBC6CB;
	Wed, 30 Jan 2013 14:30:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5824C6CA; Wed, 30 Jan 2013
 14:30:11 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76D69CEA-6B13-11E2-A127-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215061>

fadf8c7 (git_remote_helpers: force rebuild if python version changes, 2013-01-20)
started using a marker file to keep track of the version of Python interpreter
used for the last build, but forgot to remove it when asked to "make clean".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git_remote_helpers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index 0d2ae74..3d12232 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -42,4 +42,4 @@ instlibdir: $(pysetupfile)
 
 clean:
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
-	$(RM) *.pyo *.pyc
+	$(RM) *.pyo *.pyc GIT-PYTHON-VERSION
