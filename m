Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52EFC433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B847F611C0
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhKFSwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:44 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:1852 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234856AbhKFSwj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:39 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 2C81819F5A8;
        Sat,  6 Nov 2021 19:49:54 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/10] doc: git-init: clarify file modes in octal.
Date:   Sat,  6 Nov 2021 19:48:57 +0100
Message-Id: <20211106184858.11500-10-jn.avila@free.fr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211106184858.11500-1-jn.avila@free.fr>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
 <20211106184858.11500-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous explanation was mixing the format with the identity of
the field.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-init.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index fdb7b3f367..af0d2ee182 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -79,7 +79,7 @@ repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
 
---shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
+--shared[=(false|true|umask|group|all|world|everybody|<umask>)]::
 
 Specify that the Git repository is to be shared amongst several users.  This
 allows users belonging to the same group to push into that
@@ -110,13 +110,15 @@ the repository permissions.
 
 Same as 'group', but make the repository readable by all users.
 
-'0xxx'::
+'<umask>'::
 
-'0xxx' is an octal number and each file will have mode '0xxx'. '0xxx' will
-override users' umask(2) value (and not only loosen permissions as 'group' and
-'all' does). '0640' will create a repository which is group-readable, but not
-group-writable or accessible to others. '0660' will create a repo that is
-readable and writable to the current user and group, but inaccessible to others.
+'<umask>' is an 3-digit octal number prefixed with `0` and each file
+will have mode '<umask>'. '<umask>' will override users' umask(2)
+value (and not only loosen permissions as 'group' and 'all'
+does). '0640' will create a repository which is group-readable, but
+not group-writable or accessible to others. '0660' will create a repo
+that is readable and writable to the current user and group, but
+inaccessible to others.
 --
 
 By default, the configuration flag `receive.denyNonFastForwards` is enabled
-- 
2.33.1

