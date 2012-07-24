From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Tue, 24 Jul 2012 14:59:32 +0800
Message-ID: <e3481427da5efcb60053bb4cd5bcc7e4567100f0.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
 <b263c2bcc5dd6d611a1e3a4f6a87042d4cdb50aa.1343112786.git.worldhello.net@gmail.com>
 <441f0613d796c35b6865a1258f074d1ea91e605c.1343112786.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 09:00:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StZ6a-0001nG-Nu
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 09:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab2GXHAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 03:00:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59967 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab2GXHAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 03:00:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so12207178pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=1AwEdWk0jDwYVpv+k7BuHgrgAppqSejZirhtOvYctYc=;
        b=kMXCh1GNTrW/gW42HA1AlJgFpHaxNP4IigmNkK3jNNdoNb9TbOIbZWho0mI0LMDqHg
         qc2c5ZgQDJol6njBAFo7QNd+e9jOpAimPoxIIGoYsIuJk4TzXlBPGx7B/SAvdjlp+OEM
         QnQxwD/jzL3mJL6vQPSEct4//EGRSBqVaKc8ZyMy8p8nFpt5vuUR5UfBTTFzIlCkD5f8
         tG90ZlAucVbW9Dnp8KxqbkCrh3RTRKU7QbF7ZuQnkM0LPnYFeCU9laU1aOy/6q3UMF3e
         GdxM6FJzKafTMHugPS7YUHwJrMMJPWkUx3r9RWfqNbjcgVnrZ4RQNCho42P9ffPujP99
         hBGQ==
Received: by 10.68.224.36 with SMTP id qz4mr41869240pbc.161.1343113221383;
        Tue, 24 Jul 2012 00:00:21 -0700 (PDT)
Received: from jx.bj.ossxp.com.bj.ossxp.com ([123.116.228.123])
        by mx.google.com with ESMTPS id tj4sm11577579pbc.33.2012.07.24.00.00.15
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 00:00:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.17.gcb766d3
In-Reply-To: <441f0613d796c35b6865a1258f074d1ea91e605c.1343112786.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343112786.git.worldhello.net@gmail.com>
References: <cover.1343112786.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202013>

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
index 09a3..63485 100755
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
1.7.12.rc0.17.gcb766d3
