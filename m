Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1F8215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756478AbeEASk4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:40:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45000 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756461AbeEASky (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id o15-v6so11558844wro.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rc26LlTNujJXMiWS/LtsPzLqYXrFkNqx4+jqPF47P00=;
        b=j2RrnN5QIBV3yeer3/qCvfi8VrBwp7vhUjCJ8v7IFiTJywMgcNHvxjGYIpu68jdlvQ
         HloQ32MHvL9iI7rCBbv0oDXWcUfEn5Dd0B0QnktZet8PsIYSXvRuNR3nqOEmlMWy6AYV
         XpQWtyROzv9s4Lbjp+slIOAxuInRtzQSbFnlZoolBXv5ljFTn3Z0gGwqqs7xYeQTSCV2
         dXHM1kxKVyOEUqJJBjM/WHVNWIMODj3P8nHGDkr/MpVk7EhiCZ6y2VLwyJ0THOUk62EW
         s2lyq1QmzG7NLalva09Y81BAFquP9TZPvXyFZ7c10uc/UoEAqGFdv0RQ7t8YOmZ97+eI
         h3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rc26LlTNujJXMiWS/LtsPzLqYXrFkNqx4+jqPF47P00=;
        b=Z85FImUdZr8iTW/SKkgP8S/MqacZPJnhghSz8Tlu1JS/tVIHM+AD6BllCwtaZFq9Z6
         esezGuZE2C5ADZOG0hFkZhvws1RiNW94gx7L7hnzqfikqW+jdkQ3XuDKKyLtSAWZG4lj
         kQKPrsBrasnSmxzvyPalHK8TwGcnLbFjB7wj1Tsc/PEChZxoWYlmk5sWezixfbzpo3IU
         aAyki+t1m51pMKtO3t4WuoNHUs0WlJfVLiBPsjg3Jp1DjD70hiNHYA8zvmgk46b/ddvF
         tGwsWA1t3XjJdaec2C1dY7R/7Vxro6MUcKbIwrZOOrYKYZ0vEdwQvHm7HLt1W0frQUx+
         zB+Q==
X-Gm-Message-State: ALQs6tCaQ/ylEk0Xa3lJ8jRUHxCWhXGk/xbJ/H31N/W0hwHbMgHrjRG/
        d3NTbi9sU9dwDM28ii2Hilgcay2s
X-Google-Smtp-Source: AB8JxZo0u1AfZFjGDnptzB4TAze+9xQk2+yi/wsj6S5VoHNtss5vJX1a2QmYLei1SWxh4XWYIq1xWg==
X-Received: by 2002:adf:9893:: with SMTP id w19-v6mr13314424wrb.34.1525200052293;
        Tue, 01 May 2018 11:40:52 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/12] get_short_oid / peel_onion: ^{tree} should be tree, not treeish
Date:   Tue,  1 May 2018 18:40:13 +0000
Message-Id: <20180501184016.15061-10-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
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

Now "$sha1:" can be used as before to mean treeish:

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
index 9ce9cc3bc3..81076449a2 100755
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
 
 test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first, then hash order' '
-- 
2.17.0.290.gded63e768a

