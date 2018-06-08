Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06121F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbeFHWmB (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:01 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35666 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeFHWl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:41:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so14783256wrn.2
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XGhTEgk+XQ2Dzz6XoZfAmbq2YgYRW9LXphsPkpdDWiE=;
        b=puW6bQYbi+MHnmdJ0Jih0ig3hNcitukxhmxhsID1kN4889na09qel1BmgA0WslAPLp
         +W6kEHGM9IoViTkEn2qA7cl/13oJ4fE+Ary+clKkOQRrdKtC2pzZR3wR97hoBhH6Rxu5
         IxTEnFa7XRORofsC3axRCZIIm1msAmAoSZWtYPyfbot3GmFvmk/jjTURJWoVx4SBWTIk
         bHiDk2pkweL+UohtYBLkVi+WHa7IMqy1x8L+iQFuhFca54GGoDLNmHZvtgV4j7sf9Uua
         qx2eUb+NrSvT+5OLouzxnAx8zow7L2pIpEkS4q7RSNtPzwgEPle57TqvhZz9uozTHYEt
         qGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XGhTEgk+XQ2Dzz6XoZfAmbq2YgYRW9LXphsPkpdDWiE=;
        b=LgzbJChRuULQthNQ6euIZdjE8taGNRhrDgZFpGBA2ckdAW7iJRrlH9BtqAl7GEzpHl
         JIOKacdBAonrJQHQVy2qGcED+uYAJU6kqOa40oucJZkypsw9i9tQkWhq/VgIpdI1du37
         NT+9zBDyEtl4VOKrmBEFhTnbiMAfOOaMo5CTsCZTzHlacHYkhzYUdd0sNTxRvGX15GCB
         YhVBgsteb/WnDtUlUCQyNZ+8q+dhrHi9i0ZoYn1d7py3n6LBIhDnw6FQCU0nAAJ0mSCE
         P/VFZ2cDASjZ+MjJ+jM0DDLs8VGFf5Epgg6sybCw0BS7Lq09nu6zTUJ9Dsu8aevCgTFV
         prWw==
X-Gm-Message-State: APt69E1hW9NqmKj6VH0XzKnb30kuLujJmAxjFG3ieAIJbvq2GlFVq1NT
        LbZyHjgsnbkrQDG89tnVD15snXnV
X-Google-Smtp-Source: ADUXVKJE+I24T5aZlsWQGir6U/TjCxJdYsyPo9M64fYPASylacTx0BsmsvS5B/GRuBw9jRJdoB30yg==
X-Received: by 2002:a5d:44ca:: with SMTP id z10-v6mr6628623wrr.210.1528497716072;
        Fri, 08 Jun 2018 15:41:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/20] abbrev tests: add tests for core.abbrev and --abbrev
Date:   Fri,  8 Jun 2018 22:41:20 +0000
Message-Id: <20180608224136.20220-5-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How hashes are abbreviated is a core feature of git, and should have
its own t0*.sh tests. There's a few tests for core.abbrev and --abbrev
already, but none of those stress the feature itself and its edge
cases much. We should have tests for those in one place.

I don't like some of this behavior of --abbrev being looser about
input values that core.abbrev, But let's start by asserting the
current behavior we have before we change any of it.

That difference in behavior wasn't intentional. The code that does the
command-line parsing was initially added in 0ce865b134 ("Add shortcuts
for very often used options.", 2007-10-14), and it wasn't until much
later in dce9648916 ("Make the default abbrev length configurable",
2010-10-28) when core.abbrev was added with stricter parsing.

That's also only most of the command-line parsing. The diff and log
family of commands have their own parsing for it in diff.c and
revision.c, respectively. Those were added earlier in
47dd0d595d ("diff: --abbrev option", 2005-12-13) and 508d9e372e ("Fix
"--abbrev=xyz" for revision listing", 2006-05-27), although note that
sometimes diff goes via the revision.c path.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0014-abbrev.sh | 118 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100755 t/t0014-abbrev.sh

diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
new file mode 100755
index 0000000000..1c60f5ff93
--- /dev/null
+++ b/t/t0014-abbrev.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+
+test_description='test core.abbrev and related features'
+
+. ./test-lib.sh
+
+tr_d_n() {
+	tr -d '\n'
+}
+
+cut_tr_d_n_field_n() {
+	cut -d " " -f $1 | tr_d_n
+}
+
+test_expect_success 'setup' '
+	test_commit A &&
+	git tag -a -mannotated A.annotated &&
+	test_commit B &&
+	test_commit C &&
+	mkdir X Y &&
+	touch X/file1 Y/file2
+'
+
+test_expect_success 'the FALLBACK_DEFAULT_ABBREV is 7' '
+	git log -1 --pretty=format:%h >log &&
+	test_byte_count = 7 log
+'
+
+test_expect_success 'abbrev empty value handling differs ' '
+	test_must_fail git -c core.abbrev= log -1 --pretty=format:%h 2>stderr &&
+	test_i18ngrep "bad numeric config value.*invalid unit" stderr &&
+
+	git branch -v --abbrev= | cut_tr_d_n_field_n 3 >branch &&
+	test_byte_count = 40 branch &&
+
+	git log --abbrev= -1 --pretty=format:%h >log &&
+	test_byte_count = 4 log &&
+
+	git diff --raw --abbrev= HEAD~ >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 4 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 4 diff.4 &&
+
+	test_must_fail git diff --raw --abbrev= --no-index X Y >diff &&
+	cut_tr_d_n_field_n 3 <diff >diff.3 &&
+	test_byte_count = 4 diff.3 &&
+	cut_tr_d_n_field_n 4 <diff >diff.4 &&
+	test_byte_count = 4 diff.4
+'
+
+test_expect_success 'abbrev non-integer value handling differs ' '
+	test_must_fail git -c core.abbrev=XYZ log -1 --pretty=format:%h 2>stderr &&
+	test_i18ngrep "bad numeric config value.*invalid unit" stderr &&
+
+	test_must_fail git branch -v --abbrev=XYZ 2>stderr &&
+	test_i18ngrep "expects a numerical value" stderr &&
+
+	git log --abbrev=XYZ -1 --pretty=format:%h 2>stderr &&
+	! test -s stderr &&
+
+	git diff --raw --abbrev=XYZ HEAD~ 2>stderr &&
+	! test -s stderr &&
+
+	test_must_fail git diff --raw --abbrev=XYZ --no-index X Y 2>stderr &&
+	! test -s stderr
+'
+
+for i in -41 -20 -10 -1 0 1 2 3 41
+do
+	test_expect_success "core.abbrev value $i out of range errors out" "
+		test_must_fail git -c core.abbrev=$i log -1 --pretty=format:%h 2>stderr &&
+		test_i18ngrep 'abbrev length out of range' stderr
+	"
+done
+
+for i in -41 -20 -10 -1
+do
+	test_expect_success "negative --abbrev=$i value out of range means --abbrev=40" "
+		git log --abbrev=$i -1 --pretty=format:%h >log &&
+		test_byte_count = 40 log
+	"
+done
+
+for i in 0 1 2 3 4
+do
+	test_expect_success "non-negative --abbrev=$i value <MINIMUM_ABBREV falls back on MINIMUM_ABBREV" "
+		git log --abbrev=$i -1 --pretty=format:%h >log &&
+		test_byte_count = 4 log
+	"
+done
+
+for i in 41 9001
+do
+	test_expect_success "non-negative --abbrev=$i value >MINIMUM_ABBREV falls back on 40" "
+		git log --abbrev=$i -1 --pretty=format:%h >log &&
+		test_byte_count = 40 log
+	"
+done
+
+for i in $(test_seq 4 40)
+do
+	test_expect_success "core.abbrev=$i and --abbrev=$i in combination within the valid range" "
+		# Both core.abbrev=X and --abbrev=X do the same thing
+		# in isolation
+		git -c core.abbrev=$i log -1 --pretty=format:%h >log &&
+		test_byte_count = $i log &&
+		git log --abbrev=$i -1 --pretty=format:%h >log &&
+		test_byte_count = $i log &&
+
+		# The --abbrev option should take priority over
+		# core.abbrev
+		git -c core.abbrev=20 log --abbrev=$i -1 --pretty=format:%h >log &&
+		test_byte_count = $i log
+	"
+done
+
+test_done
-- 
2.17.0.290.gded63e768a

