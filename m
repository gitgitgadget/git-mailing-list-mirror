Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798B01F42F
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeACQfR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:17 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39813 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeACQfN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:13 -0500
Received: by mail-wm0-f43.google.com with SMTP id i11so3638175wmf.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e1xbCn8GEvUhzmf/SyfGKU3eJDD+OUHryNpzZlM8f7U=;
        b=FURfDPcpzo+cKq5vOo0DP3/nhpaD8xjx3/nzBOuDTU4QBC7Fry1EpW0xR+9PVrbKrb
         nOZMJHqyGIkMQVcKEbm/4jjckx1wcnnx/4wbDtxM3m7xG2t4y6gJK5wvLAGtYTaWiKQP
         T1reu6v2K87hyOB8vCym3juiy7PgbTcKBP+smWTdDwKgol2NIBoQl7Tm6USiQIM/S9A5
         Mj9HbTsorBqEk9QIh1DZTLWQW281fwWOZ23hJJJFXneyHE93KqXoA5VjPm2DwU4Nqxwh
         gqrlTYT2zRZ6B8FFboCqerjhhistutSVnytcFiBknv5PdsXTfrEFqCuCVLaWndMDN1KS
         Ic5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e1xbCn8GEvUhzmf/SyfGKU3eJDD+OUHryNpzZlM8f7U=;
        b=P1I5uRfO2RO391AfrUO5+zNgMnU9HnkkrTSoXbonIZuV4QQVhEReFSE7++V4rVS8Ua
         OPxFzssBLm8fNWQo5J8HBy3HmU2B+WfxrYA8NTc9vW26sg7PLrvfdm95hyhBumy2SPnA
         G5/BtcFzGZ28EMXXfViEUQsu0Jf89mlJfQCXCsya3jvAijTDX0rzEhuuWRHP26MKXN2Q
         Mu8Fuf3YMJQOzfNlQyWw/xNYj+sSGphIqdEiJGGiZPKLCvvxu5uxScCW4a6JCAuhW8vj
         lcf0yhq/WGFICVMoOXNZ3HWBSYNWjUl6o8u+BnSfSqKuW7J0D92eP65aU1mOEeiGKhbO
         JOeg==
X-Gm-Message-State: AKGB3mLiijQap2XI1u7DK9jHCHFlXlhNTsvW6W1igGmnAdnZt6wh/Rvi
        Ff05FyVlq44cIU85gkwvrtKVCeq+
X-Google-Smtp-Source: ACJfBovckbHWrFKCo4QAGv1E59SAvmLG0UJuf6yPMMRfA/GklKxhvL/sxViw2DxDkPkoaOwZARvr+w==
X-Received: by 10.28.116.19 with SMTP id p19mr1686490wmc.152.1514997311537;
        Wed, 03 Jan 2018 08:35:11 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:11 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH 33/40] Add t0450 to test 'get_direct' mechanism
Date:   Wed,  3 Jan 2018 17:33:56 +0100
Message-Id: <20180103163403.11303-34-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0450-read-object.sh | 28 +++++++++++++++++++++
 t/t0450/read-object    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100755 t/t0450-read-object.sh
 create mode 100755 t/t0450/read-object

diff --git a/t/t0450-read-object.sh b/t/t0450-read-object.sh
new file mode 100755
index 0000000000..6b97305452
--- /dev/null
+++ b/t/t0450-read-object.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='tests for long running read-object process'
+
+. ./test-lib.sh
+
+PATH="$PATH:$TEST_DIRECTORY/t0450"
+
+test_expect_success 'setup host repo with a root commit' '
+	test_commit zero &&
+	hash1=$(git ls-tree HEAD | grep zero.t | cut -f1 | cut -d\  -f3)
+'
+
+HELPER="read-object"
+
+test_expect_success 'blobs can be retrieved from the host repo' '
+	git init guest-repo &&
+	(cd guest-repo &&
+	 git config odb.magic.subprocessCommand "$HELPER" &&
+	 git cat-file blob "$hash1" >/dev/null)
+'
+
+test_expect_success 'invalid blobs generate errors' '
+	cd guest-repo &&
+	test_must_fail git cat-file blob "invalid"
+'
+
+test_done
diff --git a/t/t0450/read-object b/t/t0450/read-object
new file mode 100755
index 0000000000..004e9368c9
--- /dev/null
+++ b/t/t0450/read-object
@@ -0,0 +1,68 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git read-object protocol version 1
+# See Documentation/technical/read-object-protocol.txt
+#
+# Allows you to test the ability for blobs to be pulled from a host git repo
+# "on demand."  Called when git needs a blob it couldn't find locally due to
+# a lazy clone that only cloned the commits and trees.
+#
+# A lazy clone can be simulated via the following commands from the host repo
+# you wish to create a lazy clone of:
+#
+# cd /host_repo
+# git rev-parse HEAD
+# git init /guest_repo
+# git cat-file --batch-check --batch-all-objects | grep -v 'blob' |
+#	cut -d' ' -f1 | git pack-objects /e/guest_repo/.git/objects/pack/noblobs
+# cd /guest_repo
+# git config core.virtualizeobjects true
+# git reset --hard <sha from rev-parse call above>
+#
+# Please note, this sample is a minimal skeleton. No proper error handling 
+# was implemented.
+#
+
+use 5.008;
+use lib (split(/:/, $ENV{GITPERLLIB}));
+use strict;
+use warnings;
+use Git::Packet;
+
+#
+# Point $DIR to the folder where your host git repo is located so we can pull
+# missing objects from it
+#
+my $DIR = "../.git/";
+
+packet_initialize("git-read-object", 1);
+
+my %remote_caps = packet_read_and_check_capabilities("get_direct");
+packet_check_and_write_capabilities(\%remote_caps, "get_direct");
+
+while (1) {
+	my ($res, $command) = packet_txt_read();
+
+	if ( $res == -1 ) {
+		exit 0;
+	}
+
+	$command =~ s/^command=//;
+
+	if ( $command eq "init" ) {
+		packet_bin_read();
+
+		packet_txt_write("status=success");
+		packet_flush();
+	} elsif ( $command eq "get_direct" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		system ('git --git-dir="' . $DIR . '" cat-file blob ' . $sha1 . ' | GIT_NO_EXTERNAL_ODB=1 git hash-object -w --stdin >/dev/null 2>&1');
+
+		packet_txt_write(($?) ? "status=error" : "status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

