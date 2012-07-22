From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 6/7] Remove unused and bad gettext block from git-am
Date: Sun, 22 Jul 2012 09:26:10 +0800
Message-ID: <4cf7af65d3f14f61d165fa971e3784d4553d030b.1342920089.git.worldhello.net@gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
 <e488b5e8f40859a842f80855a3dd4861a4ced6d0.1342920089.git.worldhello.net@gmail.com>
 <724ca3989123159c9970b3276b4764dcbd5fd56e.1342920089.git.worldhello.net@gmail.com>
 <b3d82ce0b35597c90bf8280f38a5b336066cea18.1342920089.git.worldhello.net@gmail.com>
 <16d740e2d6e38e1ce8f3770f506623068b1cf309.1342920089.git.worldhello.net@gmail.com>
 <247c407ce218c77a603eb6cf93228d94adc48f04.1342920089.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SskxM-0000tS-R3
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 03:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2GVB11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 21:27:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52289 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab2GVB1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 21:27:25 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8575153pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=aMzk5xftPC5mrpqKQWBRj0YhTs0UI6wfD7nVVlU5Eho=;
        b=RrHwj3rVoFvckBbnDwaUZRZnwZmeEsWA0tpNGF7+b0RZvU5U6lH7JmvueuesHjioZi
         LdjqmMG8NEW8a6kYvT+weN5Krp2Tb3euHSKYZcd4d9aKivbtp+E95+1qOeYOaTWzoFtI
         9GXL3Um8gnozd2xiNCWZnwEGGqnRZ85CqnH9o9aPqZ4qO49vwSpdx63LVyJ5CEvZszDC
         sDYvDBvtVVH70mUk64+fPcYcyQAGaQxWl0ZjAvDexrkJCdLSDo8UyRia9mQhzuaTtz6n
         1KWTbNsGWdF/fdsz/DkUKUfcsHTf2QMamU9nkvWf3jvVQhYrvW0gfEqAkKfYMGFW/wGI
         GGYw==
Received: by 10.68.221.227 with SMTP id qh3mr24698266pbc.115.1342920445201;
        Sat, 21 Jul 2012 18:27:25 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id rg10sm6946850pbc.54.2012.07.21.18.27.20
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 18:27:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <247c407ce218c77a603eb6cf93228d94adc48f04.1342920089.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342920089.git.worldhello.net@gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201838>

Gettext message should not start with '-' nor '--'. Since the '-d' and
'--dotest' options do not exist in OPTIONS_SPEC variable, it's safe to
remove the block.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 git-am.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 20c1a..cfa63 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -413,9 +413,6 @@ it will be removed. Please do not use it anymore.")
 		abort=t ;;
 	--rebasing)
 		rebasing=t threeway=t ;;
-	-d|--dotest)
-		die "$(gettext "-d option is no longer supported.  Do not use.")"
-		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace|--directory|--exclude|--include)
-- 
1.7.11.2.259.g37fc0e1
