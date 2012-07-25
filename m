From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Wed, 25 Jul 2012 11:53:45 +0800
Message-ID: <aea1284d5d0d441c8c85af3961d8c9062c2412e0.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
 <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343188013.git.worldhello.net@gmail.com>
 <915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
 <79fe36e1c66cec02eb54c48390d59bb1714c4736.1343188013.git.worldhello.net@gmail.com>
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
	id 1StsgS-0000GU-B8
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300Ab2GYDyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:54:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52643 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763Ab2GYDyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:54:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so705020pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=lH1osKITRIOQWi6bOPXclYrdIKf+HLsOzM0EJf5Ok5s=;
        b=EVoGiR5V7ASZQxVe3CZSUW5Au3eXAHnWU9nRSUoSDvG9TPWspiKX/7DuUBCetLY5LN
         b6c7SXuWjx2njlP+UTTlA+KN7QBLRiQYVnjqfJ3MwiRubgpsywCKliLiwnXI2p+qTpkT
         a8pXnkmM7Tsx51liWFgjDKzjP2B+2PQrx62OPPV4vdtM8xFOReOPOdtUv32HCA9jK9aE
         a7+Y+XZitp+TAF0b43ePVpOFmQNQvIwsoZpph6+bwgOnqudTzSZpULK+TKU2S9lAY/PF
         2+5epkpeIVGblkKUiOHKZHtQp7JsmmDaoItAYGnKpX6jsPYRgTXKjqHzDWk49gmuS6MM
         b+iw==
Received: by 10.68.202.136 with SMTP id ki8mr49671831pbc.65.1343188473138;
        Tue, 24 Jul 2012 20:54:33 -0700 (PDT)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id rg10sm13463345pbc.54.2012.07.24.20.54.29
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:54:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <79fe36e1c66cec02eb54c48390d59bb1714c4736.1343188013.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202113>

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
