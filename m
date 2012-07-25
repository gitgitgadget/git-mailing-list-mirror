From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 5/7] i18n: am: mark more strings for translation
Date: Wed, 25 Jul 2012 16:34:10 +0800
Message-ID: <6d764280b65f1eeb96bed77cdbfead465f8b99e4.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
 <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343205009.git.worldhello.net@gmail.com>
 <a8429a6fed3eb0d83d92f798ebf8241a0eeb49c1.1343205009.git.worldhello.net@gmail.com>
 <1ddee15de2edd59f870023ea25cefb5846daeba4.1343205009.git.worldhello.net@gmail.com>
 <100127d788275535c8079288ef9720f462a176b4.1343205009.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 10:36:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stx4o-0003Ky-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 10:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874Ab2GYIgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 04:36:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40839 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837Ab2GYIfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 04:35:16 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1062095pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 01:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=fd0yFRzzH0kzQhFZ383s4KO0eG9Li82dBU4MBiP0mdk=;
        b=WlZ68uVWA2OJZ6BXki+lUu0vGTlHKSfrUxbApSiJDwiWnnTNfknn5YY+lVmzE/45H1
         CIIQvEFdsn1sd6VnVkuKVSZoDJvQzA/oj/DtgcTVGZaB+knB85H8h8i2hE3/hrlqXCvR
         w+RxNva07BAPTntNQuST9fpxJfnujguKSpjp3gZqFY8ktM45iWX8FIz+/bRjEKAacO+z
         NZEh8+2JxKN/9kH+tT8qmIW0reuOAN7Ugkjdp2ztffe5Y7C/N5w5ZCQpiLOQ5UjogK00
         c9d39FWuIyEux9SllVipkf+u8kas8Gkrme21XvR+Urd4VjQsxJJ7S3JYnR2681K4ljys
         PzKQ==
Received: by 10.68.232.104 with SMTP id tn8mr6461881pbc.118.1343205316440;
        Wed, 25 Jul 2012 01:35:16 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1313386pbb.49.2012.07.25.01.35.09
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 01:35:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <100127d788275535c8079288ef9720f462a176b4.1343205009.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202142>

Mark strings in 'git-am.sh' for translation. In the last chunk, I
changed '$1' to '-b/--binary' for this reason:

 * First, if there is a variable in the l10n message, we could not use
   gettext. Because the variable will be expanded (evaluated) and will
   never match the entry in the po file.

 * Second, if there is a positional parameter ($1, $2,...) in the
   message, we could not use eval_gettext either. Because
   eval_gettext may be a wapper for gettext, and the positional
   parameter would loose it's original context.

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
