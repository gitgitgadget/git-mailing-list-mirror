From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitk: map / to focus the search box
Date: Tue,  2 Dec 2008 02:18:56 +0100
Message-ID: <1228180736-15707-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 02:19:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Jvh-00056q-3E
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:19:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYLBBSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYLBBSk
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:18:40 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:31428 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbYLBBSj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:18:39 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1171990eyi.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=WKl4tXz5go5Ug4H2GbrKevxfbWZtnpEQMH6fx3CdxpY=;
        b=Y1TbCqRlnAQMWR5XKh/PAXUDAsMB3duHX3GKQseSFNOefAIQXy6XGDFM0TBzkoaCet
         kIj68qvns7HbWAoMyVTmjN9K5XaUZSp+krIQfXCihms+ZRYDd4IJ5SrQmHg7lTjnSLfQ
         x8SMWyJu3kFTIpir8JZhmZkrGjc2Of9Fd1Vjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZMTkIW9aUCFDRGJmOh1caS0tf5D1mVULg+lP8A6HJ68BOz3VXPmtTAfkbrhuvXrQUO
         edeUnoU6oDu1ucjYqhgPuJLthBuIlvbniPyvXzgZXIINo1PCDkSwqHbo/qQFSwD+LRnJ
         z1iw/X+XqsAVl7zMiUJU6SAi5flale2JlK9+s=
Received: by 10.103.176.20 with SMTP id d20mr4900496mup.27.1228180718096;
        Mon, 01 Dec 2008 17:18:38 -0800 (PST)
Received: from localhost ([78.13.62.94])
        by mx.google.com with ESMTPS id t10sm10012330muh.51.2008.12.01.17.18.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 17:18:37 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102086>

The / key is often used to initiate searches (less, vim, some web
browsers). We change the binding for the / (slash) key from 'find next'
to 'focus the search box' to follow this convention.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

Like this?

 gitk-git/gitk |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 6b671a6..0c0350b 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2271,7 +2271,7 @@ proc makewindow {} {
     bindkey b prevfile
     bindkey d "$ctext yview scroll 18 units"
     bindkey u "$ctext yview scroll -18 units"
-    bindkey / {dofind 1 1}
+    bindkey / {focus $fstring}
     bindkey <Key-Return> {dofind 1 1}
     bindkey ? {dofind -1 1}
     bindkey f nextfile
@@ -2652,7 +2652,7 @@ proc keys {} {
 [mc "<%s-F>		Find" $M1T]
 [mc "<%s-G>		Move to next find hit" $M1T]
 [mc "<Return>	Move to next find hit"]
-[mc "/		Move to next find hit, or redo find"]
+[mc "/		Focus the search box"]
 [mc "?		Move to previous find hit"]
 [mc "f		Scroll diff view to next file"]
 [mc "<%s-S>		Search for next hit in diff view" $M1T]
-- 
1.5.6.5
