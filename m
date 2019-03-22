Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A5F20248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfCVJcX (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:32:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45893 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfCVJcX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:32:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so1103420pgk.12
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CW/wzZj4Cv+1o9Ob6MVdLJO3us7qmcKRkvd/yHLh5G8=;
        b=Tq8eOZg2cNyQv0TqDwPBHvEGk+V7Y/EzQJuUviao/eiIh3F5bahimcNwUxBDQguqHd
         KW3xixLXFQ5g/uB0liMRg1YlXhuN+v5+uuoTV7O4SiBfHNwYt0WMuwsWEunMiA4oV/p4
         nRSWU6WyHiV1eaox+Yj1tWQeMmEcwfOeeM8OAD7zG1D74tlCo35C1BlFaNAaU/PZdNWL
         rvsA9syAZQeI2VsoobTmCoozI50VO+plHIv4O/HXHoUNG/ZZOAcsDtR4IcuNd/kFxRZz
         0Rid4uvtvE/NLX+DHmDo0t1X+0a2LSv4hy69Ol/BOGL3UdqeI419dhakXqo5uXlI6GvS
         y/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CW/wzZj4Cv+1o9Ob6MVdLJO3us7qmcKRkvd/yHLh5G8=;
        b=hB/ZQZUKQPSKR/hMhU6PNdD+Y9b6YTNQV4tVkK+bovRWK+yK/PfSX6fT1vPAHI22mk
         JklO3S6a9kFV4RTzS7vfn1XODGaNGOgOcoKVsMjVmI8LY+LbjWPSwi2WDIm9lJnOn5Ox
         NbTjf1HdtAeYtikXOp1xOVXol4B6RVQIUObprlvFIFoN4LcnflCC1G4nd1ii/BzP5TrM
         DUa58clff/vAb1po5LeGBD1LylTJdx61V/iGrPjUetjbWHJMc5Rb1LlF+wFn08x2ql5g
         UFkxPZ56zikQXysmK27AiRmqW8qtl5fsEmDWPfrtqKoH0pbUectJpxXt99y9NXkAMu89
         dzaQ==
X-Gm-Message-State: APjAAAWFkz466RRDFmt1+TloSyc7Ky1HmBX1H/iB51H+PmWUyiqdTFTC
        ztafdP3nI0/PGw4FYODmpn6avYka51c=
X-Google-Smtp-Source: APXvYqyWsPUXwP6idtnAp613ew+izcyLo47PyDlIdtRaoC/NOEnYlMhTSwVpeIsZavOypLIzhVNghw==
X-Received: by 2002:aa7:910e:: with SMTP id 14mr8177614pfh.68.1553247142603;
        Fri, 22 Mar 2019 02:32:22 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id n65sm22444666pfb.160.2019.03.22.02.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 02:32:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 22 Mar 2019 16:32:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/4] read-tree: add --quiet
Date:   Fri, 22 Mar 2019 16:31:37 +0700
Message-Id: <20190322093138.13765-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190322093138.13765-1-pclouds@gmail.com>
References: <20190322093138.13765-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read-tree is basically the front end of unpack-trees code and shoud
expose all of its functionality (unless it's designed for internal
use). This "opts.quiet" (formerly "opts.gently") was added for
builtin/checkout.c but there is no reason why other read-tree users
won't find this useful.

The test that is updated to run 'read-tree --quiet' was added because
unpack-trees was accidentally not being quiet [1] in 6a143aa2b2
(checkout -m: attempt merge when deletion of path was staged -
2014-08-12). Because checkout is the only "opts.quiet" user, there was
no other way to test quiet behavior. But we can now test it directly.

6a143aa2b2 was manually reverted to verify that read-tree --quiet
works correctly (i.e. test_must_be_empty fails).

[1] the commit message there say "errors out instead of performing a
    merge" but I'm pretty sure the "performing a merge" happens anyway
    even before that commit. That line should say "errors out
    _in addition to_ performing a merge"

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-read-tree.txt | 4 ++++
 builtin/read-tree.c             | 1 +
 t/t7201-co.sh                   | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5c70bc2878..1e81f9c4e6 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -128,6 +128,10 @@ OPTIONS
 	Instead of reading tree object(s) into the index, just empty
 	it.
 
+-q::
+--quiet::
+	Quiet, suppress feedback messages.
+
 <tree-ish#>::
 	The id of the tree object(s) to be read/merged.
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9083dcfa28..5c9c082595 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -154,6 +154,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
+		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
 		OPT_END()
 	};
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 72b9b375ba..f165582019 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -223,6 +223,9 @@ test_expect_success 'switch to another branch while carrying a deletion' '
 	test_must_fail git checkout simple 2>errs &&
 	test_i18ngrep overwritten errs &&
 
+	test_must_fail git read-tree --quiet -m -u HEAD simple 2>errs &&
+	test_must_be_empty errs &&
+
 	git checkout --merge simple 2>errs &&
 	test_i18ngrep ! overwritten errs &&
 	git ls-files -u &&
-- 
2.21.0.548.gd3c7d92dc2

