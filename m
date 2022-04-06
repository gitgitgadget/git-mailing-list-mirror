Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0EDC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 20:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiDFUZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbiDFUYu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 16:24:50 -0400
X-Greylist: delayed 192 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 11:44:39 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F07245050
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 11:44:39 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F328912C920;
        Wed,  6 Apr 2022 14:41:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=0ZM4DjC1jipNI0BEJ66VU7K7lQBZRYnXCGO/CvWpJ3o=; b=j4dQ
        WjiOXC6ULTVaNzmrvgMqh6w5p8hELPlIj2hnusVkTMokIb2KZuNUK68XEDX5vPvg
        eOlqd3dK5JvKDy8BsgC8kuAmCxyqlpsAwfDHLHW5EU6Moopj+G2QSfrjCHfGqUnu
        cwbqmPLu3l2SQsYiunZ9niMm6sOT1ae5qTD/qeY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D53F412C91F;
        Wed,  6 Apr 2022 14:41:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.117.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 019EE12C91E;
        Wed,  6 Apr 2022 14:41:25 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH] doc: replace "--" with {litdd} in credential-cache/fsmonitor
Date:   Wed,  6 Apr 2022 14:41:22 -0400
Message-Id: <20220406184122.4126898-1-tmz@pobox.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Pobox-Relay-ID: 2A267B3E-B5D9-11EC-9D4E-CB998F0A682E-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Asciidoc renders `--` as em-dash.  This is not appropriate for command
names.  It also breaks linkgit links to these commands.

Fix git-credential-cache--daemon and git-fsmonitor--daemon.  The latter
was added 3248486920 (fsmonitor: document builtin fsmonitor, 2022-03-25)
and included several links.  A check for broken links in the HTML docs
turned this up.

Manually inspecting the other Documentation/git-*--*.txt files turned up
the issue in git-credential-cache--daemon.

While here, quote `git credential-cache--daemon` in the synopsis to
match the vast majority of our other documentation.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Documentation/config/core.txt                  |  2 +-
 Documentation/git-credential-cache--daemon.txt |  6 +++---
 Documentation/git-fsmonitor--daemon.txt        | 12 ++++++------
 Documentation/git-update-index.txt             |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
index 889522956e..e67392cc83 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -63,7 +63,7 @@ core.protectNTFS::
=20
 core.fsmonitor::
 	If set to true, enable the built-in file system monitor
-	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
+	daemon for this working directory (linkgit:git-fsmonitor{litdd}daemon[1=
]).
 +
 Like hook-based file system monitors, the built-in file system monitor
 can speed up Git commands that need to refresh the Git index
diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentati=
on/git-credential-cache--daemon.txt
index 7051c6bdf8..01e1c214dd 100644
--- a/Documentation/git-credential-cache--daemon.txt
+++ b/Documentation/git-credential-cache--daemon.txt
@@ -1,5 +1,5 @@
-git-credential-cache--daemon(1)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+git-credential-cache{litdd}daemon(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 NAME
 ----
@@ -8,7 +8,7 @@ git-credential-cache--daemon - Temporarily store user cre=
dentials in memory
 SYNOPSIS
 --------
 [verse]
-git credential-cache--daemon [--debug] <socket>
+'git credential-cache{litdd}daemon' [--debug] <socket>
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/git-=
fsmonitor--daemon.txt
index 0fedf5a456..cc142fb861 100644
--- a/Documentation/git-fsmonitor--daemon.txt
+++ b/Documentation/git-fsmonitor--daemon.txt
@@ -1,5 +1,5 @@
-git-fsmonitor--daemon(1)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+git-fsmonitor{litdd}daemon(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
 NAME
 ----
@@ -8,10 +8,10 @@ git-fsmonitor--daemon - A Built-in File System Monitor
 SYNOPSIS
 --------
 [verse]
-'git fsmonitor--daemon' start
-'git fsmonitor--daemon' run
-'git fsmonitor--daemon' stop
-'git fsmonitor--daemon' status
+'git fsmonitor{litdd}daemon' start
+'git fsmonitor{litdd}daemon' run
+'git fsmonitor{litdd}daemon' stop
+'git fsmonitor{litdd}daemon' status
=20
 DESCRIPTION
 -----------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-updat=
e-index.txt
index 64315e2e8c..5ea2f2c60e 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -528,7 +528,7 @@ This feature is intended to speed up git operations f=
or repos that have
 large working directories.
=20
 It enables git to work together with a file system monitor (see
-linkgit:git-fsmonitor--daemon[1]
+linkgit:git-fsmonitor{litdd}daemon[1]
 and the
 "fsmonitor-watchman" section of linkgit:githooks[5]) that can
 inform it as to what files have been modified. This enables git to avoid
