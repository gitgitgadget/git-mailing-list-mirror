Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E0720A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdIPIJS (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:18 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38271 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdIPIIY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id x17so4481302wmd.5
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+q6woJZzCbf+F0edr7gI8RSy9jT1UNYwTGjfVjfdp3E=;
        b=ppR/IdvslMgyYcFqtUmFayGEWhZt8HfsMn8CY2qiB3IUQGXNsGKncuz6U9AbHNtYEc
         HqVe5f9mnaMRLpvNuDa38HGM8p+BsLvfVy4amIZPLzAl43lPlJt+8OkkHsvr3fcRNwYK
         nuGtqwdt2w+W9C1WGtJY6jMNptDHO8oakY7x5hkPHfNbVgmXVaCghebc03OG9tNnjRrC
         Y8zrDh4scH3LSfKwJL/0Ri+8nd9ldPXzjOxhHQeTTCxQzTvyiHYZHDQZ2MYFN7zg8tMP
         beQ+sR/LvaVZb0rjxCSN/VwaFHcqzwyk08FVu0KPVBwNsnEMdP25NY9OMFuqPuXlPXLP
         gP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+q6woJZzCbf+F0edr7gI8RSy9jT1UNYwTGjfVjfdp3E=;
        b=mCmlnDhESTBSOvwsqvzkxHgiWqgi6OWP4l1KXa2i6nL6oZN5CWk2YZKhGvZ+uhjm8l
         dcUh85rPi82qFOjIXgNqM99+I1jfhYfBAFR5QL08AgPX1NiubW+Da7JkAxJO/0QB4XHd
         x+1PwGajCe4zPs+swDprCszdDCodrYScQs1kf8FQiDmpwwAuxHZv4MdJTjojwAMR0KAV
         IQJsLFhD8xscEKuf+6lrZ3LuxNptae/D6TA7NFL4MabYeRPqoFQ59Z3Gr5a2ffKtHREn
         OIbO2rQvt3dtJMVsRSg+1TTT590E4h0OhPQYrj0SDZaQ9usX5NuKCYWg1roBelAC6dke
         vuUw==
X-Gm-Message-State: AHPjjUgeUxXpPLJPlPrRCYmx1KtM4uFEL3l6K8FemW0rGPS9fwB4BEAm
        A6dwPFqNGCuajHnBWiQBSjS7nQ==
X-Google-Smtp-Source: AOwi7QDCwaTqjzBa69jqkXM5cD94BG9d9jenbalTwR1d37nIil+BwmReR4SRvJcOwu87pmBIyBJtoQ==
X-Received: by 10.28.22.82 with SMTP id 79mr5096145wmw.70.1505549303255;
        Sat, 16 Sep 2017 01:08:23 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:22 -0700 (PDT)
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
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 28/40] Add t0460 to test passing git objects
Date:   Sat, 16 Sep 2017 10:07:19 +0200
Message-Id: <20170916080731.13925-29-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0460-read-object-git.sh | 28 +++++++++++++++++
 t/t0460/read-object-git    | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100755 t/t0460-read-object-git.sh
 create mode 100755 t/t0460/read-object-git

diff --git a/t/t0460-read-object-git.sh b/t/t0460-read-object-git.sh
new file mode 100755
index 0000000000..2873b445f3
--- /dev/null
+++ b/t/t0460-read-object-git.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='tests for long running read-object process passing git objects'
+
+. ./test-lib.sh
+
+PATH="$PATH:$TEST_DIRECTORY/t0460"
+
+test_expect_success 'setup host repo with a root commit' '
+	test_commit zero &&
+	hash1=$(git ls-tree HEAD | grep zero.t | cut -f1 | cut -d\  -f3)
+'
+
+HELPER="read-object-git"
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
diff --git a/t/t0460/read-object-git b/t/t0460/read-object-git
new file mode 100755
index 0000000000..38529e622e
--- /dev/null
+++ b/t/t0460/read-object-git
@@ -0,0 +1,78 @@
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
+packet_read_and_check_capabilities("get_git_obj");
+packet_write_capabilities("get_git_obj");
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
+	} elsif ( $command eq "get_git_obj" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		my $path = $sha1;
+		$path =~ s{..}{$&/};
+		$path = $DIR . "/objects/" . $path;
+
+		my $contents = do {
+		    local $/;
+		    open my $fh, $path or die "Can't open '$path': $!";
+		    <$fh>
+		};
+
+		packet_bin_write($contents);
+		packet_flush();
+		packet_txt_write("status=success");
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.14.1.576.g3f707d88cd

