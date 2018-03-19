Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5BE01F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933378AbeCSNdI (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:33:08 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:50266 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933363AbeCSNcw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:52 -0400
Received: by mail-wm0-f50.google.com with SMTP id f19so2598418wmc.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/dCTwmWSU+K99c/ey0vQtINw9kicKZpqgtlV6FmvTKA=;
        b=uOzJlDUOSAc9A6hob4PLqGRHr0ifCJDK/z8EX1r0RuPNz9XxJ3mQlcym+3yTFt4RzW
         cTCU8WK7F4oDrNkRX4ULWVo2dHmOjEf0HN1b3eqlK+4Y+9zWfWixjgOFGSM2sL52d7Qv
         eMw75nedx4WQGipyfOxNpwYW0q0afzyFTPlmcSI4qBtSpVrbrfNEzTg2OfraLOsyyEf8
         tSaHVrwMBBirMG+idOjHOTl5oS1fRNHHqq0eCupZ8m4ofvCEpUbqEycZWbicjJZ/1fJg
         R78DYbqbYRo+Qz4MODWA6tIJpCnOEBk20Qxfk3u5JHqI1KXGFkgDrVwwwdBdWCgBd3Yw
         ZwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/dCTwmWSU+K99c/ey0vQtINw9kicKZpqgtlV6FmvTKA=;
        b=gUPKvc5nQjAVayqTenbZjMG77weN9DtD6vcQsB/d1utPnLmqhkBvwnKGfC7VJO7cp8
         WQg6abj5rawrTVQHmA6+/ka3b5mNv7h4zPbf/FOcuuGmPJ906Q5LGJ+JqKFUYkAsolZs
         hJn/JAWJ3LhVD1Z+HuTPo8rtQt/ES7B2Csl1ApCRTkizp8o/enJSoYb2ts1QJsEqMzcH
         t4HXwBVU1Yfa7LqWgXtNt7/ZAsYUMf8X7+eOLvu4NeY9tDR0v0TjAcIf3QIPIoPaKjvq
         WskXyt9FrC8ZdG6JBPSLG+BGYzSFBq1XlC6HyvFX4nNTzf+R0eq2OOCddeq8y6ANeBUw
         nj3Q==
X-Gm-Message-State: AElRT7HLciK04u5exF7sJhjsxeEQ0Tp7CwcsdoNQfPCH4+3aI5AJ6Mh7
        NDBVpepoB+b7jGLCiAG9RqMPZMma
X-Google-Smtp-Source: AG47ELshSW8GbOiszA5/s6w/H85N89CiMnmrhAILbOaZXmDs3uADWF4sK0vehkcgJ7j18f95Kit8fQ==
X-Received: by 10.28.173.198 with SMTP id w189mr9265077wme.139.1521466370276;
        Mon, 19 Mar 2018 06:32:50 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:49 -0700 (PDT)
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
Subject: [PATCH v2 30/36] Add t0560 to test passing git objects
Date:   Mon, 19 Mar 2018 14:31:41 +0100
Message-Id: <20180319133147.15413-31-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0560-read-object-git.sh | 28 ++++++++++++++
 t/t0560/read-object-git    | 78 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100755 t/t0560-read-object-git.sh
 create mode 100755 t/t0560/read-object-git

diff --git a/t/t0560-read-object-git.sh b/t/t0560-read-object-git.sh
new file mode 100755
index 0000000000..4e8fc04dfd
--- /dev/null
+++ b/t/t0560-read-object-git.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='tests for long running read-object process passing git objects'
+
+. ./test-lib.sh
+
+PATH="$PATH:$TEST_DIRECTORY/t0560"
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
diff --git a/t/t0560/read-object-git b/t/t0560/read-object-git
new file mode 100755
index 0000000000..4b3ca0948b
--- /dev/null
+++ b/t/t0560/read-object-git
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
2.17.0.rc0.37.g8f476fabe9

