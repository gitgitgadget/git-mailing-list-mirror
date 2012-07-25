From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 5/7] i18n: am: mark more strings for translation
Date: Wed, 25 Jul 2012 22:53:11 +0800
Message-ID: <7483bb4c75600ac3ffd4f740040a4256ff70821f.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
 <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com>
 <051a48c40cd144e36c4cd5798376d56bdc4705bf.1343227806.git.worldhello.net@gmail.com>
 <0aa19c8238587fc04616b67bc6dfa9c926fcfb5f.1343227806.git.worldhello.net@gmail.com>
 <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227806.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:54:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su2yw-0007UJ-U4
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933449Ab2GYOyQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:54:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37092 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933188Ab2GYOyM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:54:12 -0400
Received: by yhmm54 with SMTP id m54so781596yhm.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=30xuIDpzhzsLVwnkJFUe+IqqxpTzEq9MY2toGRAKAtc=;
        b=NOsx/V+3FV99LilfDKin11NP6y71qJa9gdk6jyNG9E555yHVxS53kZ/Fjh+xVX6QdC
         0CW1fFjVO/jD3rKNvNAzhevUpBSAVlNYRGY1E8R8FPE1g/UpsmaOhWuyRWN1RILVUd34
         Ip96LtbhdfQA/d9kjbLO1X9nuu36dKoHLJtX7NUo5hc0wSf4avOV6dpCt/G5t5uITaQh
         FIAfAmv5AUMCIC1Lsquhm0Ah0f5Vc4a1/cedn15Z3AqFQ4UJ3QVWXp3xijzYtcJrNJQZ
         4Ghha4I/Ga9BFUy2/DE0r8xqGyfb7mt4j1tI0EcqdAQ/RXR+RSneASbgP3CvCiPfntjt
         /YAA==
Received: by 10.68.216.2 with SMTP id om2mr54042664pbc.26.1343228051479;
        Wed, 25 Jul 2012 07:54:11 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1886775pbb.49.2012.07.25.07.54.02
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:54:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227806.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202161>

Mark strings in 'git-am.sh' for translation. In the last chunk, I
changed '$1' to '-b/--binary' for this reason:

 * First, if there is a variable in the l10n message, we could not use
   gettext. Because the variable will be expanded (evaluated) and will
   never match the entry in the po file.

 * Second, if there is a positional parameter ($1, $2,...) in the
   message, we could not use eval_gettext either. Because eval_gettext
   may be a wapper for gettext, and the positional parameter would
   lose its original context.

Also reduce one indentation level for one gettextln clause introduced
in commit de88c1c.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-am.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 8961a..25d0e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -92,7 +92,7 @@ safe_to_abort () {
 	then
 		return 0
 	fi
-		gettextln "You seem to have moved HEAD since the last 'am' failure.
+	gettextln "You seem to have moved HEAD since the last 'am' failure.
 Not rewinding to ORIG_HEAD" >&2
 	return 1
 }
@@ -136,7 +136,7 @@ fall_back_3way () {
     git write-tree >"$dotest/patch-merge-base+" ||
     cannot_fallback "$(gettext "Repository lacks necessary blobs to fall back on 3-way merge.")"
 
-    say Using index info to reconstruct a base tree...
+    say "$(gettext "Using index info to reconstruct a base tree...")"
 
     cmd='GIT_INDEX_FILE="$dotest/patch-merge-tmp-index"'
 
@@ -176,8 +176,7 @@ It does not apply to blobs recorded in its index.")"
     fi
     git-merge-recursive $orig_tree -- HEAD $his_tree || {
 	    git rerere $allow_rerere_autoupdate
-	    echo Failed to merge in the changes.
-	    exit 1
+	    die "$(gettext "Failed to merge in the changes.")"
     }
     unset GITHEAD_$his_tree
 }
@@ -387,8 +386,8 @@ do
 	-i|--interactive)
 		interactive=t ;;
 	-b|--binary)
-		echo >&2 "The $1 option has been a no-op for long time, and"
-		echo >&2 "it will be removed. Please do not use it anymore."
+		gettextln >&2 "The -b/--binary option has been a no-op for long time, and
+it will be removed. Please do not use it anymore."
 		;;
 	-3|--3way)
 		threeway=t ;;
-- 
1.7.12.rc0.16.gf4916ac
