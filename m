Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9BAE1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbeLQWlO (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:41:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46438 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731920AbeLQWlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 17:41:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so13915053wrt.13
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNQtb2+1vOQUssOcxR3mDSr6t61IJRJOxzP6axGU2yE=;
        b=uXJ5rcQsZnBk6jjemfpnVeY95scyOrgRykxhE1tTT4XyiUZTK/HYkavpEM2vjxbLHe
         M2f3GuWmwuaONnDHW8qKN3Ok7wzPzkDek2aoZGnGWwAK1UIcrL+06tTfukzYrbRNxXDE
         x3uP8gMEg8cToYMPSo7UU0AfCrROZSvwOqsLoMqtycy6Wokxi5aMD1Hes+tbJEh4/oFy
         J5MTo0KgJc5Gd463eQexQZ6RPXD51eOzyLTPFKkB5S/1No0+9LwSY1aDIl7cSVJY+D2C
         l5i2MfKIn5+ghX+CEEgOuMU9CNKrQ7FvCKkpafDRdcOsv5XqzWE2vzt4QqqHD7QeL7pU
         2Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNQtb2+1vOQUssOcxR3mDSr6t61IJRJOxzP6axGU2yE=;
        b=SA87BvOssBJqb/ml6Ju6kSeHpZPIJ4Bhl7Ra2R0lHwHo3IukLRVDmOjOTSWhO2mj4A
         AngT2tykGRS4LmE37SdLO43087fUEjwFAzW5Sfh4e3+iywWNmzlnj/nmhuyftPESFH6D
         5n+2vke3w7E9SuSlyzSB8MmOVuO9bzQawWY2M9ODLjxGlpfJk0cwRUAQtzk8JOB1nwN2
         oHyMCVzXQCqpvjjpEKtFGoS3eaCkaxOO5PB4V3epa7Kp8yKzi9s1zstVSHJHXmbFGzU8
         pninT7Qqo4T/54ew7pH6HSY67MVfCFSwZEvK+jKxulY7kfbzBOyWlka4c4hikrZxXb6F
         iezA==
X-Gm-Message-State: AA+aEWYvgxuRGPsKXY9ctU9bCAfcu0/m949oXooAOmJCey5RcVvbT4if
        kvdj3mtcO3QBgh213DS6CY55+E+bd/w=
X-Google-Smtp-Source: AFSGD/XMRmElDNn1aqZwAoaUYdu4ST6hbSVklSPQXCBRE/stynMGXsscEd6nPiU8IeTK0RqLbsTBKw==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr11770888wrv.287.1545086470178;
        Mon, 17 Dec 2018 14:41:10 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm2208199wre.64.2018.12.17.14.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 14:41:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] fetch-pack: support protocol version 2
Date:   Mon, 17 Dec 2018 23:40:54 +0100
Message-Id: <20181217224054.4376-5-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181213155817.27666-1-avarab@gmail.com>
References: <20181213155817.27666-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

When the scaffolding for protocol version 2 was initially added in
8f6982b4e1 ("protocol: introduce enum protocol_version value
protocol_v2", 2018-03-14). As seen in:

    git log -p -G'support for protocol v2 not implemented yet' --full-diff --reverse v2.17.0..v2.20.0

Many of those scaffolding "die" placeholders were removed, but we
hadn't gotten around to fetch-pack yet.

The test here for "fetch refs from cmdline" is very minimal. There's
much better coverage when running the entire test suite under the WIP
GIT_TEST_PROTOCOL_VERSION=2 mode[1], we should ideally have better
coverage without needing to invoke a special test mode.

1. https://public-inbox.org/git/20181213155817.27666-1-avarab@gmail.com/

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch-pack.c  |  9 ++++++---
 t/t5500-fetch-pack.sh | 22 +++++++++++++++-------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 63e69a58011..f6a513495ea 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -55,6 +55,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	struct packet_reader reader;
+	enum protocol_version version;
 
 	fetch_if_missing = 0;
 
@@ -219,9 +220,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
 
-	switch (discover_version(&reader)) {
+	version = discover_version(&reader);
+	switch (version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL);
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
@@ -231,7 +234,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
-			 &shallow, pack_lockfile_ptr, protocol_v0);
+			 &shallow, pack_lockfile_ptr, version);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 086f2c40f68..49c540b1e1d 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -439,15 +439,23 @@ test_expect_success 'setup tests for the --stdin parameter' '
 	) >input.dup
 '
 
-test_expect_success 'fetch refs from cmdline' '
-	(
-		cd client &&
-		git fetch-pack --no-progress .. $(cat ../input)
-	) >output &&
-	cut -d " " -f 2 <output | sort >actual &&
-	test_cmp expect actual
+test_expect_success 'setup fetch refs from cmdline v[12]' '
+	cp -r client client1 &&
+	cp -r client client2
 '
 
+for version in '' 1 2
+do
+	test_expect_success "protocol.version=$version fetch refs from cmdline" "
+		(
+			cd client$version &&
+			GIT_TEST_PROTOCOL_VERSION=$version git fetch-pack --no-progress .. \$(cat ../input)
+		) >output &&
+		cut -d ' ' -f 2 <output | sort >actual &&
+		test_cmp expect actual
+	"
+done
+
 test_expect_success 'fetch refs from stdin' '
 	(
 		cd client &&
-- 
2.20.0.405.gbc1bbc6f85

