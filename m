From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Sun, 22 Jul 2012 09:26:08 +0800
Message-ID: <16d740e2d6e38e1ce8f3770f506623068b1cf309.1342920089.git.worldhello.net@gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
 <e488b5e8f40859a842f80855a3dd4861a4ced6d0.1342920089.git.worldhello.net@gmail.com>
 <724ca3989123159c9970b3276b4764dcbd5fd56e.1342920089.git.worldhello.net@gmail.com>
 <b3d82ce0b35597c90bf8280f38a5b336066cea18.1342920089.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 03:27:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SskxN-0000tS-Ct
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 03:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab2GVB1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 21:27:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52289 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab2GVB1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 21:27:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8575153pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 18:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=JTOM74HESWjsSRyxKVxzaE3QAi+cUFbjEEp4ucw/MbE=;
        b=TYVQxlsN3cWbTAFdKTsDQ5VjV6VGQz7lzGoW2twYfC2KUY2SxbiR8jrS+DFfrqv+io
         RLrFfPb48n9Y7mnn5WgbYkMA62T0DXo/a9VSKwDq0cC6zBib8mXuUrXqiago80y3cLyb
         bw8IskYoc/2IDGSiHBGphnH7KbjS3XuZn1didgnzm29YJ1Hl9Hq/pNUdLWsJz4xHOp65
         uTKWybFfeVfDhgVYfepicVJYVgT2NYYofg+FHlcqRhpQmw2vQG/oG+qoRCVW1h9PGOhy
         e758F+FGS4ue3N5B71hv1LwCrmUTDgW38nhhkYbdRYzAQS17ADOgQTttXrW8A95BYzTL
         Qcsg==
Received: by 10.66.76.130 with SMTP id k2mr21437666paw.19.1342920435175;
        Sat, 21 Jul 2012 18:27:15 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id rg10sm6946850pbc.54.2012.07.21.18.27.09
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 18:27:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <b3d82ce0b35597c90bf8280f38a5b336066cea18.1342920089.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342920089.git.worldhello.net@gmail.com>
References: <cover.1342920089.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201835>

The obsolete LONG_USAGE variable has the following message in it:

    A'\''--B'\''--C'\''

And such complex LONG_USAGE message will breaks xgettext when extracting
l10n messages. But if single quotes are removed from the message, xgettext
works fine on 'git-rebase.sh'.

Since there is a modern OPTIONS_SPEC variable in use in this script,
it's safe to remove the obsolete USAGE and LONG_USAGE variables.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
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
