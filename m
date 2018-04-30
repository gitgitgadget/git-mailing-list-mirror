Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B2E215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755055AbeD3WIH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:08:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45963 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754504AbeD3WIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:08:05 -0400
Received: by mail-wr0-f194.google.com with SMTP id p5-v6so9370538wre.12
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4P2zn2iOG7zMS/VYesEufuPvTkYaENuL7OMGFnP4hKs=;
        b=QrCs8/7mAySoYJRWZu/rIbEThbBWOzFm/ixPZrZPY18j5kOnWQaK+iJPvjINTUxUSX
         NL64cU+OQvU0cqOLNPGVDAmZgjaDi0ha/pPbXvSXcrtYSWBfwfGH8XzeUUR08AyrIgNI
         NOKsNfQhPDZgh77WWy3s8Nb5MiH7vrkclL9Yth0fK2gZ/zccorNKbl8gpld/peMB5KyU
         VYj/rd2s+MIwH2Pnqv1RGVcokGmc2KhDEVkI8nEMjr9bXWpTYDHrwn0AjE8IyhB05nTx
         Qws7oIAkTW/mLwt/lzTbRIoGvXORH8Bdns453YKyBP5xrzMpTxdLbBpI8HodFyaRWT+n
         WtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4P2zn2iOG7zMS/VYesEufuPvTkYaENuL7OMGFnP4hKs=;
        b=KwbmLd1Yhp5oEVt6yPcivZw9fjSO4Fa0/vhflZWB+hy0n5C3LH4wavh7INx+jfVklo
         tLFuTIs0UIlxJijH0zqn8KIuEhFFhRxtx3dMPK/IEpFHKHZSav+1l3Ahw41/oRHF2Ppa
         UykxFRrIDIcgFu4cQcYDgdTc6nOzjAAXVl+KyUFVzk5SD1p05cRHpSsAO2uozIf/hjDb
         a5bFwztd8BxrNkJzFm7rj5jQ6R7Qem76rgMilG4mc9bjizXgekrS609tEPdDtmjgUQuA
         LKwxkJRBFj1tjP9BTBFIV1tvdZZo7q/1FPp0v1fRbMpsB+L16ACZaZQN6wv1KBxui424
         Rh8w==
X-Gm-Message-State: ALQs6tC+PWNRl1zCsHTYVDfiJEDUIyXlKVIoCG4wKjjVKxjWXAnEyEB3
        FRCK7KKGKJhmKpv6Dd+BioTv7HBY
X-Google-Smtp-Source: AB8JxZqrBv+hJVqBagTiaSRXdbWDy2iIVhzfTz1oy7m21m4qHG9YsQpj1ZMKYqSENNvO91uFLDmB1w==
X-Received: by 2002:adf:ac4f:: with SMTP id v73-v6mr9580073wrc.5.1525126083647;
        Mon, 30 Apr 2018 15:08:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:08:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/9] get_short_oid / peel_onion: ^{tree} should mean tree, not treeish
Date:   Mon, 30 Apr 2018 22:07:32 +0000
Message-Id: <20180430220734.30133-8-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the recent series of patches ^{tag} and ^{blob} now work to get
just the tags and blobs, but ^{tree} will still list any
tree-ish (commits, tags and trees).

The previous behavior was added in ed1ca6025f ("peel_onion:
disambiguate to favor tree-ish when we know we want a tree-ish",
2013-03-31). I may have missed some special-case but this makes more
sense to me.

Now "$sha1:" can be used as before to mean treeish

    $ git rev-parse e8f2:
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f2650052 tag v2.17.0
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2093055 tree
    hint:   e8f25a3a50 tree
    hint:   e8f28d537c tree
    hint:   e8f2cf6ec0 tree
    [...]

But ^{tree} shows just the trees, but would previously be equivalent
to the above:

    $ git rev-parse e8f2^{tree}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f2093055 tree
    hint:   e8f25a3a50 tree
    hint:   e8f28d537c tree
    hint:   e8f2cf6ec0 tree
    [...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c                         |  2 +-
 t/t1512-rev-parse-disambiguation.sh | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 023f9471a8..b61c0558d9 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -970,7 +970,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	else if (expected_type == OBJ_TAG)
 		lookup_flags |= GET_OID_TAG;
 	else if (expected_type == OBJ_TREE)
-		lookup_flags |= GET_OID_TREEISH;
+		lookup_flags |= GET_OID_TREE;
 	else if (expected_type == OBJ_BLOB)
 		lookup_flags |= GET_OID_BLOB;
 
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 08ae73e2a5..2acf564714 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -159,9 +159,13 @@ test_expect_failure 'two semi-ambiguous commit-ish' '
 	git log 0000000000...
 '
 
-test_expect_failure 'three semi-ambiguous tree-ish' '
+test_expect_success 'three semi-ambiguous tree-ish' '
 	# Likewise for tree-ish.  HEAD, v1.0.0 and HEAD^{tree} share
 	# the prefix but peeling them to tree yields the same thing
+	test_must_fail git rev-parse --verify 0000000000: &&
+
+	# For ^{tree} we can disambiguate because HEAD and v1.0.0 will
+	# be excluded.
 	git rev-parse --verify 0000000000^{tree}
 '
 
@@ -267,8 +271,12 @@ test_expect_success 'ambiguous commit-ish' '
 # There are three objects with this prefix: a blob, a tree, and a tag. We know
 # the blob will not pass as a treeish, but the tree and tag should (and thus
 # cause an error).
-test_expect_success 'ambiguous tags peel to treeish' '
-	test_must_fail git rev-parse 0000000000f^{tree}
+test_expect_success 'ambiguous tags peel to treeish or tree' '
+	test_must_fail git rev-parse 0000000000f: &&
+	git rev-parse 0000000000f^{tree} >stdout &&
+	test_line_count = 1 stdout &&
+	grep -q ^0000000000fd8bcc56 stdout
+
 '
 
 test_expect_success 'rev-parse --disambiguate' '
@@ -365,7 +373,9 @@ test_expect_success 'core.disambiguate config can prefer types' '
 test_expect_success 'core.disambiguate does not override context' '
 	# treeish ambiguous between tag and tree
 	test_must_fail \
-		git -c core.disambiguate=committish rev-parse $sha1^{tree}
+		git -c core.disambiguate=committish rev-parse $sha1: &&
+	# tree not ambiguous between tag and tree
+	git -c core.disambiguate=committish rev-parse $sha1^{tree}
 '
 
 test_done
-- 
2.17.0.290.gded63e768a

