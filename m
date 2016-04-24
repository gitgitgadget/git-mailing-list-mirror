From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/3] githooks.txt: Improve the intro section
Date: Sun, 24 Apr 2016 20:20:27 +0000
Message-ID: <1461529229-15222-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:20:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auQWG-00077j-2Y
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 22:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753156AbcDXUUf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 16:20:35 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38455 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbcDXUUf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 16:20:35 -0400
Received: by mail-wm0-f41.google.com with SMTP id u206so98702250wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 13:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h/N03KQSM/shZgORJtJPaISSx0nYK6bGD5jh6wKm2Zk=;
        b=O3wTrct3eXkMc89aHzH5J8MGjN11peSG1oXMUCJUAGmC5NFSA4WsudW64XgYMH+SbX
         J0dA0S4brb0CPTZ7xAs81CdXngCBvBd8af3zg5D31gt9FjI/X68Br1QTmJsLXNMmFsTP
         8EMmQ17RBCrUFS+9OhFl9XWw+2MDN0namK/tk0KMKqZwkFSlxvdgC0BnKX1JKxmezC8K
         5qh5JBTE/wIRre7nDQ4nh43SgdvjP5w78wMRLYo1YuGYVJBWk7xQrB88Wdl1fpS+u/X/
         CvIz+pmG7kcMAvWlSvmpCkiIoCXnv4Q/3clj0Gr6Uk1kiyNsY6FBti6mEKMvH/uFycoL
         t6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h/N03KQSM/shZgORJtJPaISSx0nYK6bGD5jh6wKm2Zk=;
        b=mhJ82IJeIJH4xEoJqW673g6wYoFJNdqsJEEBEW3ylOnau4OCklWG7YJFdrj7mUNhoS
         hZD9EDW57sZuaqTEGoL2sLcsddeRWXhIcoNKDelfWXI1iWPYhWiL0fxNtQtLYNGrJGay
         kOaPWlliNCc/fU47qA4USmDWpQqY9KyjS84tEqeJl9o9rE/iMSrjB8AsHUYr7uVyTe+b
         VIygWgzHdP4BurGJoQsEoXq2o4HdbvABEaIVLW+19tYXRaqi7ZRKAuaQSHdUTMIFosYZ
         tgKMxnJ7/6vtzoGSSHd/Bcsl95zqXvnJzCmgFGs8054qc3LH/3idtTJet3hPogIL+1E/
         f9Iw==
X-Gm-Message-State: AOPr4FVi+mFRJgIkWcsuXkJLEdYpwHvOVGaCwvhgefSaN1QBqvynH7V4cTsAFy7e8v15fw==
X-Received: by 10.28.230.137 with SMTP id e9mr8884969wmi.0.1461529233475;
        Sun, 24 Apr 2016 13:20:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m20sm15233040wma.23.2016.04.24.13.20.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Apr 2016 13:20:32 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292439>

Change the documentation so that:

 * We don't talk about "little scripts". Hooks can be as big as you
   want, and don't have to be scripts, just call them "programs".

 * We note what happens with chdir() before a hook is called, nothing
   documented this explicitly, but the current behavior is
   predictable. It helps a lot to know what directory these hooks will
   be executed from.

 * We don't make claims about the example hooks which may not be true
   depending on the configuration of 'init.templateDir'. Clarify that
   we're talking about the default settings of git-init in those cases,
   and move some of this documentation into git-init's documentation
   about the default templates.

 * We briefly note in the intro that hooks can get their arguments in
   various different ways, and that how exactly is described below for
   each hook.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/git-init.txt |  6 +++++-
 Documentation/githooks.txt | 32 ++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 8174d27..cf37926 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -130,7 +130,11 @@ The template directory will be one of the followin=
g (in order):
  - the default template directory: `/usr/share/git-core/templates`.
=20
 The default template directory includes some directory structure, sugg=
ested
-"exclude patterns" (see linkgit:gitignore[5]), and sample hook files (=
see linkgit:githooks[5]).
+"exclude patterns" (see linkgit:gitignore[5]), and example hook files.
+
+The example are all disabled by default. To enable a hook, rename it
+by removing its `.sample` suffix. See linkgit:githooks[5] for more
+info on hook execution.
=20
 EXAMPLES
 --------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a2f59b1..2f3caf7 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -13,18 +13,26 @@ $GIT_DIR/hooks/*
 DESCRIPTION
 -----------
=20
-Hooks are little scripts you can place in `$GIT_DIR/hooks`
-directory to trigger action at certain points.  When
-'git init' is run, a handful of example hooks are copied into the
-`hooks` directory of the new repository, but by default they are
-all disabled.  To enable a hook, rename it by removing its `.sample`
-suffix.
-
-NOTE: It is also a requirement for a given hook to be executable.
-However - in a freshly initialized repository - the `.sample` files ar=
e
-executable by default.
-
-This document describes the currently defined hooks.
+Hooks are programs you can place in the `$GIT_DIR/hooks` directory to
+trigger action at certain points. Hooks that don't have the executable
+bit set are ignored.
+
+When a hook is called in a non-bare repository the working directory
+is guaranteed to be the root of the working tree, in a bare repository
+the working directory will be the path to the repository. I.e. hooks
+don't need to worry about the user's current working directory.
+
+Hooks can get their arguments via the environment, command-line
+arguments, and stdin. See the documentation for each below hook for
+details.
+
+When 'git init' is run it may depending on its configuration copy
+hooks to the new repository, see the the "TEMPLATE DIRECTORY" section
+in linkgit:git-init[1] for details. When the rest of this document
+refers to "default hooks" we're talking about the default template
+shipped with Git.
+
+The currently supported hooks are described below.
=20
 HOOKS
 -----
--=20
2.1.3
