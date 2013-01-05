From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/10] t5531: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:53:04 -0800
Message-ID: <1357368788-28035-7-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:53:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdZ-0000vb-1r
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab3AEGx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56467 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab3AEGxW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AF0F8CE3
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=cQ6q
	1vdBFkDfJLLS6GogCR4JKRg=; b=LNUPFIBjsg1PTM71rdsituNaqa+kQBmp/V6f
	KdLV6aoy5BpJPUWqr6tKEShszHOayMwDWAi9OLs1P+N7MsxiRQD2lUvXFuNaXi3a
	KMy7LQlJIHWropE6XMzfXiu8ZJtrV7rMP4EuRI8mhhxw/jdXWG9wlSLypf2sxJoE
	OE2GMBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=p6X3BD
	LIpbNvu6OpcXHi7erENq9ErxfvRal6OafqGI+TecnWIh2dHdpOIISQeoJaIdSGpl
	EjCS7yuu1o0To71uKCIeLfqjd/V7epff0gXAqdQX2YAN5zEmhur+EnfD4DMIdxwk
	h9iLIxLyWgvRs31b052B/ahY19bqS5DcyOcwQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E3828CE2
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B4CD8CE1 for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:21 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 97FA0E2A-5704-11E2-B6D8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212673>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5531-deep-submodule-push.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 1947c28..8c16e04 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -16,6 +16,7 @@ test_expect_success setup '
 		(
 			cd gar/bage &&
 			git init &&
+			git config push.default matching &&
 			>junk &&
 			git add junk &&
 			git commit -m "Initial junk"
-- 
1.8.1.299.gc73b41f
