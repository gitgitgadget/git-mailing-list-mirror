From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Wed, 25 Jul 2012 16:34:09 +0800
Message-ID: <100127d788275535c8079288ef9720f462a176b4.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
 <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343205009.git.worldhello.net@gmail.com>
 <a8429a6fed3eb0d83d92f798ebf8241a0eeb49c1.1343205009.git.worldhello.net@gmail.com>
 <1ddee15de2edd59f870023ea25cefb5846daeba4.1343205009.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 10:35:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stx3t-0002ew-EI
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 10:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932836Ab2GYIfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 04:35:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40839 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802Ab2GYIfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 04:35:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1062095pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 01:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=lH1osKITRIOQWi6bOPXclYrdIKf+HLsOzM0EJf5Ok5s=;
        b=ZGBYfiYquXldAGONH7ozJpLBtPshtKNC3Jzx5vx4OvDb7XshCTaqZcqL1AH9HuKruG
         Yr5TN0wrSgyvoN8g8I0k690KKTwD94HGglzZtAxJ5Pgm084gF3wInknuuVSOyE48DYwe
         E1Mkd2W++guDklJXuVt0OS0n/LO270UZKn334B475FSskf77v/rdZAOnQheR7hb826QI
         GAE4VqjBwBx/mmATRUJr8/A0qJUbaWHzHqyX3NAUun5QflBQPVLZ0evadRWzetA47PsB
         x4EPoGlJREL8kk6ZIlECVuu0CSvt/gIhJtOiq7zISzTFOhSmSD1Ef+8tAE4y2rH0CfUI
         7Nhw==
Received: by 10.68.222.103 with SMTP id ql7mr51399005pbc.48.1343205308896;
        Wed, 25 Jul 2012 01:35:08 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1313386pbb.49.2012.07.25.01.35.01
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 01:35:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <1ddee15de2edd59f870023ea25cefb5846daeba4.1343205009.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202137>

The obsolete LONG_USAGE variable has the following message in it:

    A'\''--B'\''--C'\''

And such complex LONG_USAGE message will breaks xgettext when extracting
l10n messages. But if single quotes are removed from the message, xgettext
works fine on 'git-rebase.sh'.

Since there is a modern OPTIONS_SPEC variable in use in this script,
it's safe to remove the obsolete USAGE and LONG_USAGE variables.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 git-rebase.sh | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 705bd..0e6fd 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,31 +3,6 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [--exec | -x <cmd>] [-v] [--force-rebase | -f]
-       [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
-LONG_USAGE='git-rebase replaces <branch> with a new branch of the
-same name.  When the --onto option is provided the new branch starts
-out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
-It then attempts to create a new commit for each commit from the original
-<branch> that does not exist in the <upstream> branch.
-
-It is possible that a merge failure will prevent this process from being
-completely automatic.  You will have to resolve any such merge failure
-and run git rebase --continue.  Another option is to bypass the commit
-that caused the merge failure with git rebase --skip.  To check out the
-original <branch> and remove the .git/rebase-apply working files, use the
-command git rebase --abort instead.
-
-Note that if <branch> is not specified on the command line, the
-currently checked out branch is used.
-
-Example:       git-rebase master~1 topic
-
-	A---B---C topic                   A'\''--B'\''--C'\'' topic
-       /                   -->           /
-  D---E---F---G master          D---E---F---G master
-'
-
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-- 
1.7.12.rc0.16.gf4916ac
