From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 20/20] rebase: show consistent conflict resolution hint
Date: Thu, 25 Nov 2010 20:58:03 +0100
Message-ID: <1290715083-16919-21-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLnaz-00026e-CB
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261Ab0KZB6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:42 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63197 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0KZB63 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:29 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347966vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=3zbr1vDuTegx3bhxD9oIuqa+fX7mO5PaNhgDthaOT7E=;
        b=VBI9wob3OwUttiJuzMvJjpqVDbUUzP9PspHCnHPQQ/gTiWp6YRedrJMxcQHzONu/YO
         RDu1tphxavDavK+kY2c1p+L2GdNmsT+dsHjOjTTsLB4hTtEbp3ZdaVxSQrHaHHD0W2OI
         T3hwg3gCqmX8pB03M0729uCc4NL8i6+HrZ62Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m2sfyMrVQSWAqIOTtas384+kjmzObALobg5pBXHry5mkw2lLLCACVd9PjISrDT+9gl
         k+MdUwssU8hzsXBb0hKQxU8axayenMn0Yiys4E4gNf8NCNjFZW65xW3RIi7S8kRX+Bkx
         Fic5VxxtrhSp5zY9myK8PXRk/42Tysk/2kSAU=
Received: by 10.220.76.196 with SMTP id d4mr387769vck.37.1290736709424;
        Thu, 25 Nov 2010 17:58:29 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:29 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162172>

When rebase stops due to conflict, interactive rebase currently
displays a different hint to the user than non-interactive rebase
does. Use the same message latter message for both types of rebase.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d60977d..b810197 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -82,9 +82,7 @@ AMEND="$DOTEST"/amend
 REWRITTEN_LIST="$DOTEST"/rewritten-list
 REWRITTEN_PENDING="$DOTEST"/rewritten-pending
 
-GIT_CHERRY_PICK_HELP="\
-hint: after resolving the conflicts, mark the corrected paths
-hint: with 'git add <paths>' and run 'git rebase --continue'"
+GIT_CHERRY_PICK_HELP="$RESOLVEMSG"
 export GIT_CHERRY_PICK_HELP
 
 warn () {
-- 
1.7.3.2.864.gbbb96
