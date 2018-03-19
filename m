Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FE91F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933301AbeCSNeA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:34:00 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53171 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933356AbeCSNcu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:50 -0400
Received: by mail-wm0-f54.google.com with SMTP id l9so6071933wmh.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G1xKdIHlmnyFDOrtMyfv1nPxMux8eUqwaI1vrillpYw=;
        b=ALFGvY50dPMsVM8SWJG7dXIK0ISM1QHGMAVrT6AFW8GZByVU6ki1oINlDlBPdcFlKn
         JLSyTQmlfjthmTqy+LR5z7WDxZ7a+vjqUaADxOoT3CGo0H0hCNWzQTydUaRriQsGidVY
         NnsECNupL0bXzL6/AT0sVwPdUZZ5q5RTnpq1ht2O6G83I5Zvam9WvENcogppukLG+sV6
         cqO46Xky37yS1xvecDCG675k8NrEQvwvRKZKY80TT1QIwmSJxuvWJpSkt94rk3DCayDL
         8+cWeoVoKVWI1PuheMZwBjED9vr2SxQfFKnmrggZixzDbCkiFZLB3fFo3VBXl8m+0I/v
         qntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G1xKdIHlmnyFDOrtMyfv1nPxMux8eUqwaI1vrillpYw=;
        b=WJCkfmUQdT0BnI1VNZ7U8gjzgIKOpSDM39GeoSjaLZnzg5rDPvteQttQVg897yw8IX
         hOmN9KLmTEt/dIMwb1tuRlnG/bw4Le1m2eOrCqcl+yopx7GMt8x+8sgU50jBrzrCat0r
         iNw02de3YIQWwE2mHSLH+F2qzMeqkBYGfRTBUZRStVM9aUlBXiA5c7ohfj4R8dwNpDXz
         lueahe2fr2ov+uCaCsXkif+CgmjBLxS5NiAXwKVTPO7eqWszBDaMSOXsNDB7fzY02kOs
         ArhD9gHCbA9WgknUUhyfdp39vxvRIIMNT3J5HcQmx8orAmRKWMSyWcFulQfGBQT+rwGG
         kWNQ==
X-Gm-Message-State: AElRT7ExEmAYw00aTMD0lXdXHHROjagBlCvK8GxQtYfnVi3yvoqQxHPb
        Ys7B3vSK+nQca94xpFrDVR8eRCkU
X-Google-Smtp-Source: AG47ELsCUZZCYlpDAWvoV9+4KXhkZHTv1zrt+uocJAdAIfpROeRvJFaRjS1R59rqbReiu6aAHxRtLg==
X-Received: by 10.28.220.130 with SMTP id t124mr9173013wmg.60.1521466368829;
        Mon, 19 Mar 2018 06:32:48 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:48 -0700 (PDT)
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
Subject: [PATCH v2 29/36] Add t0550 to test 'get_direct' mechanism
Date:   Mon, 19 Mar 2018 14:31:40 +0100
Message-Id: <20180319133147.15413-30-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Peart <benpeart@microsoft.com>

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0550-read-object.sh | 28 +++++++++++++++++
 t/t0550/read-object    | 68 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100755 t/t0550-read-object.sh
 create mode 100755 t/t0550/read-object

diff --git a/t/t0550-read-object.sh b/t/t0550-read-object.sh
new file mode 100755
index 0000000000..93c8eea3f9
--- /dev/null
+++ b/t/t0550-read-object.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='tests for long running read-object process'
+
+. ./test-lib.sh
+
+PATH="$PATH:$TEST_DIRECTORY/t0550"
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
diff --git a/t/t0550/read-object b/t/t0550/read-object
new file mode 100755
index 0000000000..004e9368c9
--- /dev/null
+++ b/t/t0550/read-object
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
2.17.0.rc0.37.g8f476fabe9

