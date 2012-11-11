From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 11/15] remote-testgit: make clear the 'done' feature
Date: Sun, 11 Nov 2012 14:59:48 +0100
Message-ID: <1352642392-28387-12-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY6M-0007td-12
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab2KKOBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:01:14 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOBM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:01:12 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0UyvuGbYRzGWxtcsUEHnLCBRIwf/Nbdl5cTxV5IvsdU=;
        b=I101085cN1yVMeaWhBImpKGt9PS21kcoBvjQlTJgAgptdG5ouibHzryVC0+YxTRr/l
         kps+vW8tBOqsuHFuPwS0ze7qzhCisdEFCbKgdph1w7qt77/8u884L5RecXE+SNx5nOfA
         aydFqNVEGwT9GmCODDHI5w1EVaM3pN6CQlXotX1TK3m/cHGF5Wo56+nas6YRBYvn5VgG
         y1UGu1sSOV0OrHVqtMMlbQq2bFavYFa6P70T9fMn6ktBhOU5FhlqkYvtMZhcMNLe9icd
         mhVy5sjJcdTaPv4zwQPcA5ja7W4VJIBBc21yZXa7ZGX+RE9VWGt5sapllG7u7lxKBdHA
         sa1A==
Received: by 10.204.7.136 with SMTP id d8mr5901134bkd.85.1352642471361;
        Sun, 11 Nov 2012 06:01:11 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id g8sm1491227bkv.6.2012.11.11.06.01.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:01:10 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209366>

People seeking for reference would find it useful.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 698effc..812321e 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -55,8 +55,10 @@ while read line; do
 
 		echo "feature import-marks=$gitmarks"
 		echo "feature export-marks=$gitmarks"
-		git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs | \
+		echo "feature done"
+		git fast-export --{import,export}-marks="$testgitmarks" $refs | \
 			sed -e "s#refs/heads/#${prefix}/heads/#g"
+		echo "done"
 		;;
 	export)
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
-- 
1.8.0
