From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitk: map / to focus the search box
Date: Tue,  2 Dec 2008 02:19:22 +0100
Message-ID: <1228180762-15739-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <18740.26151.55900.953153@cargo.ozlabs.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 02:20:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Jw9-0005Dn-LR
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 02:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYLBBTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 20:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752177AbYLBBTH
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 20:19:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:9476 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbYLBBTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 20:19:06 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2865623ugf.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 17:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WKl4tXz5go5Ug4H2GbrKevxfbWZtnpEQMH6fx3CdxpY=;
        b=ak1n451nfdTg4hmobBziAqUgzSjXeXUS0XFKiziAgXJozLM7L2nhbSyIQd2DkfIdv6
         RW0xYVStLg3siPH1a5tGcHDGmYC4haBq8TR7WPmTQV41SDmhYEQ5A963FEBELzBwNO1x
         s7VwRHPY87ABjJhqZliXejvQo3gcn7Q8sbSKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lM/0tmVx1RYM5aYkLmo4pFvaPJOF358dq7QdhDKoyuvyHZPCxPSnPk2wWUtu9xyIWM
         iyRfn128Y6zP/pPUMR/ThUvC+ngj1jwDizHTfrZukZh3wU4qgH3quAMQMU0n/DoC3eoC
         Y3/PlPpaZG9Xx9KDaQFf4LDas3IDa+qA6hL3A=
Received: by 10.103.173.5 with SMTP id a5mr4901815mup.57.1228180743826;
        Mon, 01 Dec 2008 17:19:03 -0800 (PST)
Received: from localhost ([78.13.62.94])
        by mx.google.com with ESMTPS id y37sm10004413mug.36.2008.12.01.17.19.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 17:19:03 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <18740.26151.55900.953153@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102087>

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
