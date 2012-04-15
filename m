From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 2/5] completion: simplify by using $prev
Date: Sun, 15 Apr 2012 22:44:17 +0300
Message-ID: <1334519060-2348-3-git-send-email-felipe.contreras@gmail.com>
References: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 21:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJVNY-0002Nm-80
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 21:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab2DOTou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 15:44:50 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53524 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751052Ab2DOTos (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 15:44:48 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so3492422lah.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=i5XVPl4W2crl2m23FgR8XPa7/TI+dKVqBWLM8xdqPu4=;
        b=GaODQGf7lxbd8swiaKwS0O85ObBSBuVCHBj0blyJqBpSW5+TJpMSXuKuj6yohGshEA
         WVNYMGzU+8X9NiOzWo5/R2Cqs7ySOhPYjyCSyTHHcUULl1UbZak7tOOro1WhINcjt1Gq
         0ceAr9BgAozfV1pB5hhBsQq7nL6mflYUloPx04MTy779evD4tcM3N1KYxSwfs9nNX9uC
         FzVBGXwUwJ9mtFazzd85lwhEHrY1rBymzCQdKQsjsRIzqBrYCG8qDP3WdghqeBIX542l
         1WbAdC/4klr8Pe09iGUDcyQPWk62zGm18YCKECWaXlMGE1tCWMtkLtVDsFVyjoWS95dV
         nnrw==
Received: by 10.112.101.162 with SMTP id fh2mr4071339lbb.20.1334519087737;
        Sun, 15 Apr 2012 12:44:47 -0700 (PDT)
Received: from localhost (84-231-107-120.elisa-mobile.fi. [84.231.107.120])
        by mx.google.com with ESMTPS id r5sm21530720lbj.12.2012.04.15.12.44.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 12:44:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.g1f19b8.dirty
In-Reply-To: <1334519060-2348-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195579>

cword-1 is the previous word ($prev).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index db2d3cc..8c91faf 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1658,7 +1658,7 @@ _git_notes ()
 		__gitcomp '--ref'
 		;;
 	,*)
-		case "${words[cword-1]}" in
+		case "$prev" in
 		--ref)
 			__gitcomp_nl "$(__git_refs)"
 			;;
@@ -1684,7 +1684,7 @@ _git_notes ()
 	prune,*)
 		;;
 	*)
-		case "${words[cword-1]}" in
+		case "$prev" in
 		-m|-F)
 			;;
 		*)
-- 
1.7.10.1.g1f19b8.dirty
