Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AFCC433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 21:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiCGVwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 16:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiCGVvt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 16:51:49 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDBD75C30
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 13:50:54 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b5so25499379wrr.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 13:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TVwkN544sv82j7JOsIATEa66ElwtGHw060RsRtxHm/A=;
        b=mvWDJo9v4B4y3CXWiVSZy9mlvEmgu+AyFihLJ+rWp39Rngc5iVdf6hYyf2SwJSlHHl
         VmveQiNVtfopN8xtUGZb/iqEubqFjuZIsvSraNoT/F5RUXVZTJlE1GXrcYF+5hP1Mh0Q
         dsF94SJbG+X04APr6IcXzN3qs5Lez9T0ROj9GIduI1nKaNlUgUvh/hNazleWUzhDr+Mf
         i7fOoLvhW0LiE8fLThyKGwBnc58Pe2BmySoE4c7cIHca9EJZRI3VvEIkJEh1lZbdDKwe
         DFaK8u3n4Fa8wfHSB58SJ8RJHCKouy6WXnTbGP/UUjVojAi0yBdIKO5nVe38ZxjZbY7M
         jQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TVwkN544sv82j7JOsIATEa66ElwtGHw060RsRtxHm/A=;
        b=yQIO3agJux06cmubZN88rNKYqRYo+gWaEgKYW118Qpg3+n+yqk6s5sYdOcWaik31NW
         s1Y3eeQH1Bo9Jm1aqUTOW7E/6YB4TwcQ3/MbKa+iH6Uq1dscez3U/cWrg0gFWAzWCCvY
         MjdWBdDzbVaGsnkCq7+kltjDrMquGJAI93XhL6yeuT8xcZYJfn+boulAqoLok/U2Ogfv
         uyXmqXg2h6Jov9ARybam6S4h9cn1ZNG8FJtV7ddXxMtS8SDF+nPg9+Rl15eI0SVQWoph
         O/Qdo0H3P7S4eW0nc0s+Fu6MIzXCzaEkJ0cps+nSz1GngnTQGYj9BfuaYjKI7n6XjZEb
         S6Tw==
X-Gm-Message-State: AOAM5309dVbd4PaQ+6hGDbEdPWju2cbKYNvu588kY+4rU3kKQu2/zCkq
        /6hzTTrTy5KKsuqz0IXbY+BUvsccrZw=
X-Google-Smtp-Source: ABdhPJwy2wsDmC2TuzoHPC4ZCId64Ex9r6346bf+0QxWgumxXNSy0iy84X0AWWKbxweQ8TEOg9ieOQ==
X-Received: by 2002:a5d:6e8e:0:b0:1e6:754b:47de with SMTP id k14-20020a5d6e8e000000b001e6754b47demr9791402wrz.208.1646689852817;
        Mon, 07 Mar 2022 13:50:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b0038167e239a2sm472387wmq.19.2022.03.07.13.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 13:50:52 -0800 (PST)
Message-Id: <382b9502f6b250784e42f996c6c1f8eca4d820bf.1646689840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Mar 2022 21:50:40 +0000
Subject: [PATCH v2 12/12] clone: fail gracefully when cloning filtered bundle
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
index 9c29093b352..1c4a3143802 100644
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
+		struct bundle_header header = { 0 };
+		int fd = read_bundle_header(path, &header);
+		int has_filter = !!header.filter;
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
index 42e8cf2eb29..5160cb0a75c 100755
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
