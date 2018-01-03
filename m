Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA07B1F42F
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeACQfY (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:24 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36815 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACQfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:20 -0500
Received: by mail-wm0-f43.google.com with SMTP id b76so3689103wmg.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mi/9j31gnh9XhyDMV19qhxUc4/lrpHcuTbdsrv9sC8w=;
        b=s+K2d4y28WJQ+WJF2tDFnofuwuqIArT3GYm5cbBFG4zM+c5VIZLQHfPCdlIO3ahmYx
         DTQlJV/XVDdNJNSIiAazkAwCiEF5TSnXzOmQp5GqjGU8XfvBpQvyyPb/03r/B7kpAH9L
         8o+EwDpaU+SnyqlC58G6AHn8qv3AnYHBb/4HeOEWFQ0M5GtBG6MNldxvjcZ448SGl9dg
         7H64lQNmRIHGVDxr9oTFu7HT/iIbOMvhZIfAWXa03j3s4hTh/PLjlnwkm9LDpCzEXQAR
         eJuNFB7cQJMif5Jqz87A2nh/TRepgoA39p8LDUAtf89j1zcOKG8aLAVO3Os785MawbQQ
         oLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mi/9j31gnh9XhyDMV19qhxUc4/lrpHcuTbdsrv9sC8w=;
        b=Hi1WlK0MjCY+TbrVzzEdcvEbXfNMx0TwtVuVJHjRvrL0QYkj5acAY9sYxWS3jmHvHu
         VO8kFEpfilhSyAIWZmavGJYuCm/FwPVrad/z5Tc1tLlAkiVP4Sl9dhQ2t2FaCRr+sSso
         AUz5brSlL+Jlbrvn+eGkyONRRldx5Xj3jbXO9/4mMCVtvOyFx/zYsqJjAOFSWcLoafC3
         6IjL5TyKvGEephXKzmCubUxwmKrx8j/WJPgAa5ypFwbtcMZFpLd42VvDskiqJwztF5Ip
         dKNlfdJzcTkqeqxbf/9lf6HuebiC4LvL1x6asjx5oAvWXlXC2usal22wdsyqIxICfBdR
         xEUg==
X-Gm-Message-State: AKGB3mLMQho12TcDmqaDRZxPMOsRf1NqXK+H+8NeBd94J7vNBMrgmUSM
        HktO/KJR53dzOpIcnzggp+kByfDW
X-Google-Smtp-Source: ACJfBouWUMEzuAgAolxTpu9vEOsNsyI3lfzif6MSKdG5nyjhI/EJYl/8gSWW26aq4kHQ7SKBX/GjfQ==
X-Received: by 10.28.141.11 with SMTP id p11mr1944454wmd.149.1514997312849;
        Wed, 03 Jan 2018 08:35:12 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:12 -0800 (PST)
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
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 34/40] Add t0460 to test passing git objects
Date:   Wed,  3 Jan 2018 17:33:57 +0100
Message-Id: <20180103163403.11303-35-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
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
index 0000000000..4b3ca0948b
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
+my %remote_caps = packet_read_and_check_capabilities("get_git_obj");
+packet_check_and_write_capabilities(\%remote_caps, "get_git_obj");
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
2.16.0.rc0.16.g82191dbc6c.dirty

