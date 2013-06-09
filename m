From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 31/45] rebase: trivial cleanup
Date: Sun,  9 Jun 2013 11:40:43 -0500
Message-ID: <1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulijr-0007i7-Ka
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372Ab3FIQoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:23 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34025 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362Ab3FIQoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:19 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so8925293obq.35
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hWn5iOXexO3POUrlAMQElGpq7Esg2SnIXJKN6Kpn3CA=;
        b=ypojL8l1MxvZZAEX0cGWc76HSTP5HjMALyje5k7jkD2XCyo4u8ySvWq+3KCGQkP84c
         3qk6HzAz2UYgUlU03/0ASiHQ0ILn1gBwA1MtF/4IWPBbiJGGw0X0Db1ELDqvGyF8xSN7
         Ca+GYpHi8M5NzBpYod0SdLWYetESCzlxFPQpjcRH1Uui3owQBTPK1WgrVCyj3rFaBZN6
         nrrbweMk/GCHEgoMF82+9QikqBhAzZhNwNmtFdE4d+UglxHwaD+NKJiDm/aMmmF9y6Dg
         js9naxgIYkn+0V5chqUV2kxYjxGvS1qhoQmfm65dkKif1AU6YQqXxUbtPbSkkgTlRWuZ
         dUIw==
X-Received: by 10.60.44.168 with SMTP id f8mr5324564oem.133.1370796258658;
        Sun, 09 Jun 2013 09:44:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm14875491obz.11.2013.06.09.09.44.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227012>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--am.sh | 1 +
 git-rebase.sh     | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 6460028..2ce7570 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -51,6 +51,7 @@ then
 	return $?
 fi
 
+test -n "$GIT_QUIET" && git_am_opt="$git_am_opt -q"
 git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" <"$GIT_DIR/rebased-patches"
 ret=$?
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 0937e2c..6be247d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -285,7 +285,6 @@ do
 		;;
 	-q)
 		GIT_QUIET=t
-		git_am_opt="$git_am_opt -q"
 		verbose=
 		diffstat=
 		;;
-- 
1.8.3.698.g079b096
