From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 15/28] rebase: cherry-pick: fix sequence continuation
Date: Fri, 30 Aug 2013 00:56:09 -0500
Message-ID: <1377842182-18724-16-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmJ-0007TR-4V
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755788Ab3H3GBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64353 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab3H3GBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:39 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so1477352obb.33
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KsPLZfOxhWw2dz8tkejz/KwQLjm7QlS7GsP5LuXDvDg=;
        b=U+ECTYdJlWF+lWZna652yX9in58eLeydLOVFBQqsORmPhjD9reH0arCxpgdXK0eH8x
         gMgjZiT+CSQKqffFK21EndWgPXMpzWgumd+Ss4KfqL1gFxY9KLx6JSF8JZQJBJH968dA
         klmV6NZspyEI47aBKHnO/wpzT17oXWP3vForgf5WnyVOM/0MdKRFj0w1sYyxAvo+Azd7
         wYwLhafjwdU5EC1uraXJWUnXJBrKraEdAbaKeBigK8RzRZhHPBXtWtN/6XZN55O8yvWX
         AFLvLxmfXv8qVZWVXEU64BjmHwz6HvAZHonglUm8Et6PhRsW/EvA6HkDzDjzInxQkodZ
         ljjw==
X-Received: by 10.182.119.169 with SMTP id kv9mr5508591obb.66.1377842498658;
        Thu, 29 Aug 2013 23:01:38 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id z5sm35756170obg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233409>

We are not in am mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index e142cfb..d8d32fe 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -5,12 +5,12 @@
 
 case "$action" in
 continue)
-	git am --resolved --resolvemsg="$resolvemsg" &&
+	git cherry-pick --continue &&
 	move_to_original_branch
 	return
 	;;
 skip)
-	git am --skip --resolvemsg="$resolvemsg" &&
+	git cherry-pick --skip &&
 	move_to_original_branch
 	return
 	;;
-- 
1.8.4-fc
