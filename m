From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 29/31] git-rebase--am: remove unnecessary --3way option
Date: Sun,  6 Feb 2011 13:43:58 -0500
Message-ID: <1297017841-20678-30-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9eH-0005ZO-Nk
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab1BFSqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:46:40 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48348 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab1BFSqi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:46:38 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so1045841qyj.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=/W9eKbA6DzlKeFtlpZ7SC1JkHziET07UuCLyjG7+/EQ=;
        b=RYPNyXptaj3S1jMGRlyZsABiVCWOREyM560wsnNGxtn9y8/6v4pNQ3qZCyjvG6xDxe
         wEIoDtoOjnL/p4OpkY3VToRUjTlfQN/cdzQkOXRC+LNDShhtCi6/i2azizklJnxT9EqU
         plEfQo596h0M4EZLSdmodduZysqUVg4hIj+dg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PY8cYG39TYElt7IsMeiqDdNVQ1bs4IT9VW0FSiier2rSpJSHxpilTvmnLdZpkLQJIa
         A2VtCtvpKFwJh0FK0UxHoNRxVfgup+rd+9YcqPSuS7eVywWRlZITZue+RpJN2lSuONwx
         Ri33XWNnq8LHxYT2nSb/8WSTPcQX2FnPq60WI=
Received: by 10.229.245.1 with SMTP id ls1mr12476192qcb.13.1297017997885;
        Sun, 06 Feb 2011 10:46:37 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.46.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:46:37 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166187>

Since 22db240 (git-am: propagate --3way options as well, 2008-12-04),
the --3way has been propageted across failure, so it is since
pointless to pass it to git-am when resuming.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--am.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index c9604a6..c815a24 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -7,12 +7,12 @@
 
 case "$action" in
 continue)
-	git am --resolved --3way --resolvemsg="$resolvemsg" &&
+	git am --resolved --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
 	exit
 	;;
 skip)
-	git am --skip -3 --resolvemsg="$resolvemsg" &&
+	git am --skip --resolvemsg="$resolvemsg" &&
 	move_to_original_branch
 	exit
 	;;
-- 
1.7.4.rc2.33.g8a14f
