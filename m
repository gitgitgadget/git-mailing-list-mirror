From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Allow building without any git installed
Date: Mon, 28 Jul 2008 00:09:26 -0700
Message-ID: <7vsktutrh5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jul 28 09:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMsM-0002Xm-26
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 09:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304AbYG1HJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 03:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbYG1HJd
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 03:09:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbYG1HJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 03:09:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 191DD3F732;
	Mon, 28 Jul 2008 03:09:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7BDED3F731; Mon, 28 Jul 2008 03:09:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 206A5E94-5C74-11DD-8D6F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90424>

This is a follow-up patch to 49fa65a (Allow the built-in exec path to be
relative to the command invocation path, 2008-07-23).  Without specific
gitexecdir passed from the command line, git-gui's build procedure would
try to figure out the value for it by running an installed git.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 798a2f2..7e30b30 100644
--- a/Makefile
+++ b/Makefile
@@ -1067,7 +1067,7 @@ endif
 
 all::
 ifndef NO_TCLTK
-	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) all
+	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
 endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
-- 
1.6.0.rc1
