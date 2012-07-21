From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Sat, 21 Jul 2012 23:50:53 +0800
Message-ID: <941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
 <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com>
 <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com>
 <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:52:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssbz0-0005VS-DL
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807Ab2GUPwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:52:32 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55391 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601Ab2GUPwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:52:12 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8041000pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=DaCo1lSMoIrheNhklYC45yvDN6reFhK34rJM6IkdY5s=;
        b=lyvM+CWMpHy1tfpVoQlXDR1NGDS+9HUAQ4t2xNAfKhTkSA3tb2zna5mdliSDnTgHFI
         BD6cXrFD/1YoicvRKMyxesprR1UlGrei9hELmWUS+8vgqEK3u7A0Pe8dRyXY1A0ymXRr
         CDxRd/+kWxeh2R/4ZhgFQSTLzTZpKKnu1dcknGIguBkPWG/34RTUZZw2oKmeShO14XPf
         pApVZbC/vup5BXrR5EoAYQEnFGW9IATllrvepqBhGP29e3EPazwL4vDazwnooQQIQ7Qv
         B4IV5kB+QWeEOLGrljk/TmDwgfhqROe2//StdJpy5tz8Ei468dOZUc8edyeLHskFw//I
         y2sA==
Received: by 10.68.203.98 with SMTP id kp2mr22324454pbc.132.1342885932640;
        Sat, 21 Jul 2012 08:52:12 -0700 (PDT)
Received: from localhost.localdomain ([123.116.228.123])
        by mx.google.com with ESMTPS id nj4sm6241849pbc.5.2012.07.21.08.52.06
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:52:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342884458.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201818>

The obsolete LONG_USAGE variable has the following message in it:

    A'\''--B'\''--C'\''

And such complex LONG_USAGE message will breaks xgettext when extract
l10n messages. But if remove single quotes from the message, xgettext
works fine on 'git-rebase.sh'.

Since there is a mordern OPTIONS_SPEC variable in use in this script,
it's safe to remove the obsolte USAGE and LONG_USAGE variables.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 git-rebase.sh | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 640af..02c63 100755
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
1.7.11.2.259.g37fc0e1
