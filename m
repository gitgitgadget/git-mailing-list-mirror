Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57FED20248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfCYMIr (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:08:47 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42297 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbfCYMIr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:08:47 -0400
Received: by mail-wr1-f53.google.com with SMTP id g3so6336737wrx.9
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TryJBwAkwQxDm1aGGzWLrQtjnpTYQFOtNncA80STXMk=;
        b=rbNu7yl/AD2PXbwqbLdE1vngRaXOm6SgNoGCkWom8JSd63kCzsb5RIGSkTVna6zKBO
         GG0zfjqWEN9T29lqlunu9MTABMRCsYi9XSGC8aLkknR7vQbI4XRzQEBoyqYfU255OGqh
         n5IXnXFb9yhLyKTml/8BQ1j5paTKdhXsU69pbltAyxNtCL8AeC5ETDxumLOCZ9vOc63o
         femUBd2Ft8lYAHUMpjZ+XFXJbWjgLyp8HCk4uY/kNCAeqJVE5G7HPTK0EpYjYfYPinUO
         RUsZPF2He6EWJLKXC3RlUyyFyL0f3DKHPqpkMZ2EDJwfiGRIdi0TsA6kQmhA6+OfOvpk
         /EkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TryJBwAkwQxDm1aGGzWLrQtjnpTYQFOtNncA80STXMk=;
        b=X5AAYLn8uE/M/TGDC0sHKO5y7PVylLbUFQt+DKxeUIoLeR8fYWbz8RrZ+2KsOR5Dsi
         3z+nzADFu75BBAHbR+FI63jUpF/N/OHe4wE70IJst++aTTbeQb8vPKRGWSFLFTWJ0o6C
         mV2iDWlm91Ykuhn/IKlOEFXZx+fqBDrJ3w09/EB3ERBbClPvPZXcJMecLASWTm/AAfDi
         jem/B+42d2khi/NxYB/wLFy+sEsYUOneOpMwkdt19p9u8TozLdL1x4+hXjmyyYGDK1oh
         JePp3dNMtHd7uA+F/Lim2gg9AUJ5woTibXI15bQEeKbFkPvhgNGJqN9hdV751il3UwOP
         jHmQ==
X-Gm-Message-State: APjAAAUGxNLDSrjVu+ZjFhutqQw+By7wPlyMSXQXzWBYiuf8/7C8JCZB
        ZgInvhd9IRKh0X6TbFTuQp038tE1
X-Google-Smtp-Source: APXvYqyJ1ml4IDZJpwfBDSLufX/tbQ66YFWf9xqG3u9YU4WRcCf3i9C3Cv3Gt5uCxHSNRuvEXp9wmg==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr15626936wrs.278.1553515725200;
        Mon, 25 Mar 2019 05:08:45 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n188sm15339464wme.13.2019.03.25.05.08.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 05:08:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/8] commit-graph tests: split up corrupt_graph_and_verify()
Date:   Mon, 25 Mar 2019 13:08:27 +0100
Message-Id: <20190325120834.15529-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314214740.23360-1-avarab@gmail.com>
References: <20190314214740.23360-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the corrupt_graph_and_verify() function added in
d9b9f8a6fd ("commit-graph: verify catches corrupt signature",
2018-06-27) into its logical components of setting up the test itself,
doing the corruption in a particular way with "dd", and then finally
testing that stderr is what we expect.

This allows for re-using everything except the now slimmer
corrupt_graph_and_verify() to corrupt the graph in a way that doesn't
involve inserting a given byte sequence at a given position,
e.g. truncating it entirely to a custom value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5318-commit-graph.sh | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 561796f280..56a616831e 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -366,6 +366,19 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
 GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
 GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
 
+corrupt_graph_setup() {
+	cd "$TRASH_DIRECTORY/full" &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	cp $objdir/info/commit-graph commit-graph-backup
+}
+
+corrupt_graph_verify() {
+	grepstr=$1
+	test_must_fail git commit-graph verify 2>test_err &&
+	grep -v "^+" test_err >err &&
+	test_i18ngrep "$grepstr" err
+}
+
 # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
 # Manipulates the commit-graph file at the position
 # by inserting the data, optionally zeroing the file
@@ -376,17 +389,14 @@ corrupt_graph_and_verify() {
 	pos=$1
 	data="${2:-\0}"
 	grepstr=$3
-	cd "$TRASH_DIRECTORY/full" &&
+	corrupt_graph_setup &&
 	orig_size=$(wc -c < $objdir/info/commit-graph) &&
 	zero_pos=${4:-${orig_size}} &&
-	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
-	cp $objdir/info/commit-graph commit-graph-backup &&
 	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
 	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
-	test_must_fail git commit-graph verify 2>test_err &&
-	grep -v "^+" test_err >err &&
-	test_i18ngrep "$grepstr" err
+	corrupt_graph_verify "$grepstr"
+
 }
 
 test_expect_success 'detect bad signature' '
-- 
2.21.0.360.g471c308f928

