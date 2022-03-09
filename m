Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B1C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 16:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiCIQD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiCIQDA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 11:03:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71F417AED0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 08:02:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e24so3748146wrc.10
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hdWHJKUC6IBcvDLdZTYSt1g97GEbtJoKDnx+sfvbRiU=;
        b=i8BZ/3KlyNg1JJuQB4n96R/k1PT3DVsSoZM8jXKZD68NdPsjKDJus8N8q5UgNx/u9W
         /OGIcd/W6JMxubgLEhnEaLUEHr22DcRpouYtcQRoM+dykeu7oZC5lt8rSkMaCEuCegvI
         4gpKJPL+imURWXshLwlsOl0j566QYNAfYd/hABJiEIKmCcmnlQksUEi/8jf/Ac8qPdjl
         v3VHOSMrG+WLRzULh+HSV1M0XLZ7rbecpAldoqCjaQCrwZUW+qiysc6QREnbcf9PEMSy
         K0jSeCY8v36RpucIl2tJtuJ1eUuZuwFindwUGvVXWHr5xY8sXUQJpWOrjgB04cazX/2O
         WBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hdWHJKUC6IBcvDLdZTYSt1g97GEbtJoKDnx+sfvbRiU=;
        b=eSGL4MC6cX9Y9D+CNPAx37qSg/lY19zSD1XQiRvYeZ1MPp+YH7x6YFzIGC/FlRWeuK
         1/+YSL3Np3eKsC//524IKNBRSCU4vyr2X3K2d0gR40RM5bL8lEuZftdFUtJzct/TDhBi
         dLoX+Khlw9o6bexlG00aLupGjG/dAaGGav9YEI1iJ1wJEiYpUzlZj4k5i8Ujuzj2hJ2w
         DRkQpdRaCGddZLC+g6ZfIdafIzvGWuevV2oOcyWq1OMCtCyX1DYGJiJRpFW632UNkI+F
         QftegKTHo5b3ETEt/YVOG0tR7+3F6YPUgFc+0StCfVr3C3x4q9fcWbeGgQtAToSPYXqE
         /r9Q==
X-Gm-Message-State: AOAM533Tl6Mb83cfr18xfihTl0Br/V1zTcJlRa3pxeNin8mEuFoWstAN
        oZgzFpWiEzzheWlTtzKDx+dGvraWXqE=
X-Google-Smtp-Source: ABdhPJy1QNjuHrK9eTaUilfDEOJG4QXzbf4ZjeKRMJoT6Qw1uZ43wsIJ7D/CcE1H71ztBjYOtma2iw==
X-Received: by 2002:adf:bc09:0:b0:1f0:2483:48b with SMTP id s9-20020adfbc09000000b001f02483048bmr267066wrg.118.1646841720097;
        Wed, 09 Mar 2022 08:02:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y4-20020adff144000000b001f022290737sm1962697wro.6.2022.03.09.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:01:59 -0800 (PST)
Message-Id: <de6a1a868d311c1b59bff457fe72ed127a0669bd.1646841704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
        <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Mar 2022 16:01:43 +0000
Subject: [PATCH v4 13/13] clone: fail gracefully when cloning filtered bundle
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Users can create a new repository using 'git clone <bundle-file>'. The
new "@filter" capability for bundles means that we can generate a bundle
that does not contain all reachable objects, even if the header has no
negative commit OIDs.

It is feasible to think that we could make a filtered bundle work with
the command

  git clone --filter=$filter --bare <bundle-file>

or possibly replacing --bare with --no-checkout. However, this requires
having some repository-global config that specifies the specified object
filter and notifies Git about the existence of promisor pack-files.
Without a remote, that is currently impossible.

As a stop-gap, parse the bundle header during 'git clone' and die() with
a helpful error message instead of the current behavior of failing due
to "missing objects".

Most of the existing logic for handling bundle clones actually happens
in fetch-pack.c, but that logic is the same as if the user specified
'git fetch <bundle>', so we want to avoid failing to fetch a filtered
bundle when in an existing repository that has the proper config set up
for at least one remote.

Carefully comment around the test that this is not the desired long-term
behavior of 'git clone' in this case, but instead that we need to do
more work before that is possible.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/clone.c        | 13 +++++++++++++
 t/t6020-bundle-misc.sh | 12 ++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 9c29093b352..e57504c2aa8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -33,6 +33,7 @@
 #include "packfile.h"
 #include "list-objects-filter-options.h"
 #include "hook.h"
+#include "bundle.h"
 
 /*
  * Overall FIXMEs:
@@ -1138,6 +1139,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		warning(_("--local is ignored"));
 	transport->cloning = 1;
 
+	if (is_bundle) {
+		struct bundle_header header = BUNDLE_HEADER_INIT;
+		int fd = read_bundle_header(path, &header);
+		int has_filter = header.filter.choice != LOFC_DISABLED;
+
+		if (fd > 0)
+			close(fd);
+		bundle_header_release(&header);
+		if (has_filter)
+			die(_("cannot clone from filtered bundle"));
+	}
+
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
 	if (reject_shallow)
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 7c6db670221..ed95d195427 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -537,4 +537,16 @@ do
 	'
 done
 
+# NEEDSWORK: 'git clone --bare' should be able to clone from a filtered
+# bundle, but that requires a change to promisor/filter config options.
+# For now, we fail gracefully with a helpful error. This behavior can be
+# changed in the future to succeed as much as possible.
+test_expect_success 'cloning from filtered bundle has useful error' '
+	git bundle create partial.bdl \
+		--all \
+		--filter=blob:none &&
+	test_must_fail git clone --bare partial.bdl partial 2>err &&
+	grep "cannot clone from filtered bundle" err
+'
+
 test_done
-- 
gitgitgadget
