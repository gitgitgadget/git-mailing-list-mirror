Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CCB20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdIPIJY (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37746 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbdIPIIX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so4505836wmh.4
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhPeLkZGHbbUGdaPDYPmAhnuTQt1RLLbMFSU4X6wOc8=;
        b=pBqctGM4PMqDn8BrHQr8uA8zTGq1cPHSd/oeUJ0PpppjxUGwo+II7A0Zb9bcixf0uN
         iNj2fmcNTwKN2JFr8iPeIfEgY9Wepj83zdz4ntWoceOjp/FbyCTqSEWXjt3J0/qN5c9D
         mFq0e/OM3lMge42SZo3WHQYnOIgJcmiDcb9XWybQm/XGXS+tb83HG/dYZd6LJmR8ad5i
         c4qwnwqN5Os2AsWjhT8ix4YfKNLj4WSBZf3DHHxvS4H2InlngWwG0785N7KOxiyl+8VR
         aNcbw9AbHRgwp1OOzpim4/8tGIk4rihrcq79s2dQGI719iV1CaDGKoxRou9QjdcQbBOz
         eWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhPeLkZGHbbUGdaPDYPmAhnuTQt1RLLbMFSU4X6wOc8=;
        b=kWMqt8mQzAST2v2tidrUsWKMjSl0xD8x16963LWLU3ddnUcKuNucJOP/Qh3+eFzpAM
         YLoRhOlZMxHZMnsJLzUa3vfS5DWITo2IdRmwH2sRF2M4MWhnmkHZsrl+uq0lNrn9fLcW
         2HzdhoF2GC0syIpCGU+V5xbrjwZ3kRKnAyvfv4rdHlEVVJ1u6ut/oG6tAsChtynBEEMs
         z3okCMclKJYN56HT4zC21u6EO3YpRp7dPOz8yDOGYsXAPVkHPEAllJ4wUaP2wUf5gbSU
         ncr34/JO6t0T+uY4VM8jBkDk4WgboirLvHZwHwOuGstTGm6bUb58MiQfd7vOlAIz4uhK
         Wo1g==
X-Gm-Message-State: AHPjjUh/5lbzC/IDF1Je4zQTy3R+mWGSA8gZv9k2Cntp/Xxx/H2e/Ugm
        bulCKIqbohqW/bCO
X-Google-Smtp-Source: AOwi7QAZ+wNyVn6QNifkSCdySSpBKCK8dEiwfV4uZSSORxxb0i9yReTvaPAd6r96kz2vBwla7IJWmQ==
X-Received: by 10.28.129.23 with SMTP id c23mr4992683wmd.27.1505549301840;
        Sat, 16 Sep 2017 01:08:21 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:21 -0700 (PDT)
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
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH v6 27/40] Add t0450 to test 'get_direct' mechanism
Date:   Sat, 16 Sep 2017 10:07:18 +0200
Message-Id: <20170916080731.13925-28-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
index 0000000000..cf22e2f581
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
+packet_read_and_check_capabilities("get_direct");
+packet_write_capabilities("get_direct");
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
2.14.1.576.g3f707d88cd

