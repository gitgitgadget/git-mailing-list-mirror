From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Wed, 25 Jul 2012 22:53:10 +0800
Message-ID: <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
 <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com>
 <051a48c40cd144e36c4cd5798376d56bdc4705bf.1343227806.git.worldhello.net@gmail.com>
 <0aa19c8238587fc04616b67bc6dfa9c926fcfb5f.1343227806.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:54:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su2yx-0007UJ-SU
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933383Ab2GYOyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:54:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40079 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933448Ab2GYOyC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:54:02 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1526654pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=n72kdASLzmnrlsYUW3btJ8gnTXTrM5AgiiVGFvaWUCs=;
        b=N2hAj5OxzHeY14UtuR1oNkCulrIP6W48sLYI1+dwf1DsXKpQTNgjeT6bABIhrFmE/6
         Tc1xPglnpr/SH7UD/z5h/A7P5Ph0RIK+NFnUs6Obun2H31eGba6bizbaww9cbREs9o/H
         UXYigfSPkou1seVUuZHAi0qxnZz09W06PT8WFLiBiEjNUeIArdd255EcKbGfttbF3ukC
         xiPA2n1LZu6gK8D4vxy5Xp7M3dVy3sX8df5hBTatHw6vOSnR6hReeXUuOh+P64jxmYtp
         RL2iWV9fRqrsE1z4CPZ9C7x7CEsYsm6ISFXKj6si4wtniqF1HIFv+2oDtRos21Gh1Uav
         Y6PA==
Received: by 10.68.212.138 with SMTP id nk10mr54612939pbc.93.1343228042237;
        Wed, 25 Jul 2012 07:54:02 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1886775pbb.49.2012.07.25.07.53.54
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:54:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <0aa19c8238587fc04616b67bc6dfa9c926fcfb5f.1343227806.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202162>

The obsolete LONG_USAGE variable has the following message in it:

    A'\''--B'\''--C'\''

And such complex LONG_USAGE message will break xgettext when
extracting l10n messages. But if single quotes are removed from
the message, xgettext works fine on 'git-rebase.sh'.

Since there is a modern OPTIONS_SPEC variable in use in this
script, it's safe to remove the obsolete USAGE and LONG_USAGE
variables.

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
