From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 5/7] i18n: am: mark more strings for translation
Date: Wed, 25 Jul 2012 11:53:46 +0800
Message-ID: <1493bd09efd0ba6e1d56500305d989047da245ec.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
 <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343188013.git.worldhello.net@gmail.com>
 <915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
 <79fe36e1c66cec02eb54c48390d59bb1714c4736.1343188013.git.worldhello.net@gmail.com>
 <aea1284d5d0d441c8c85af3961d8c9062c2412e0.1343188013.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 05:54:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StsgS-0000GU-QP
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932783Ab2GYDyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:54:40 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52643 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756316Ab2GYDyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:54:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so705020pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=FW/F34f2F3/nSFV+MWqfoiWFY2PVTyXg/RdqTuoKic4=;
        b=wMQhx3l77VXGAf7mOgX5JtS+3FUclVxbovrnixWqjb1CkzItSgTj+tSGz64GE79nXS
         NKpOFOgNNOFP40NTA7BK2u2Yixt4QbA/MKvw1Tx6EuB+eJN6PnC7D1wtzsdc3qHt0Y6+
         pNkZgO+3V3svi+9+an55UGQkRIbnJjAOEydRzVtzFah2TtWumyXtj8ANU+HF1EvjNZuX
         Kxs8hW8ywO1Af5rAMCNfcU5v0rHk3ukgiQUuPSaQs55NDlhCYC6+tEAhRXyb2Nw4cwUH
         t/+W2e4FztVlf/xDf9mMVfjDku+sUA9A7k+9B40o5Sil99JcqP2MAqxJkrrwGP317C12
         R2Rw==
Received: by 10.68.135.201 with SMTP id pu9mr49432998pbb.146.1343188477294;
        Tue, 24 Jul 2012 20:54:37 -0700 (PDT)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id rg10sm13463345pbc.54.2012.07.24.20.54.33
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:54:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <aea1284d5d0d441c8c85af3961d8c9062c2412e0.1343188013.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202115>

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
index 8961a..3f654 100755
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
+		echo >&2 $(gettext "The -b/--binary option has been a no-op for long time, and
+it will be removed. Please do not use it anymore.")
 		;;
 	-3|--3way)
 		threeway=t ;;
-- 
1.7.12.rc0.16.gf4916ac
