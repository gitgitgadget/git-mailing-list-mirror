Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC661F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeACQf1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:35:27 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:45271 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACQfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:35:25 -0500
Received: by mail-wm0-f42.google.com with SMTP id 9so3638523wme.4
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oPrS+bYdrqBOKYiYhU0mfyVu+YN0C+VX9bxFPzElHgM=;
        b=HmQxOwk18n8sQmEe5kKC24dnJwFSQByVConqK6SZEvNvMpYlHURdAt34dqk5jZbnG7
         W3L6dq5T2MiXPdhRmiB8nlD/OFh5QrFtUMoHkKRrjiIaQdrJF9Elbri5T26yNYbqpDh6
         dAzs2nsTIEzyKOig21pBrZYalH7eYVq1WvQp6WkPQ4xivmA6M+9Ab/JIQAqWtQV7Drsj
         5YpB+OPI+qFCKOziEPAFjCMG/Eg7rOybS4x/h1clCSnxy2DCWbQilMPYFpr/K2KX2LhQ
         h4LAait+uSgKVr19J34OSpQ+tSBBvbTREofajyHaxL0prg036vOqYlhA4j9oxByapNzI
         Fe7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oPrS+bYdrqBOKYiYhU0mfyVu+YN0C+VX9bxFPzElHgM=;
        b=OBG7j8I+PM4jz4JPFQoxSbrpldp104h1SdlicY9Yn1SfkK82ue5H06wKOKvuZ+qfIG
         RjJG9rv6GLeEXr7EXs4nkyHqu8k7M+XVw2qKa86LyxNoPJM+6apYVTEB5NCpYBBuylWK
         wHM70jb8bQ8maK22M7DJfkSrTCh0XADoWHlv9+VBO0grZdudexVvFHb/IgOL3jfTF6fo
         nGkIxMLX+FD2zgPhtmzB6MoD77ObAxeM0gnyCHfK5aaes6LOrMeuDWy0roXeeDZov/1T
         zi3MFXyY73ZrHagITes9npVZ7JX0SvaFLETWJ/oBSPfXsWiCAt8APp1UpuFtCWB3MZoX
         rKyw==
X-Gm-Message-State: AKGB3mJMFGF2tcuTJLrXS8rllvMr2pr1/PI64VrFNnEMWDb1kHdQ23Js
        YxErQe0xmn4OKOIYZb970qTCO+sh
X-Google-Smtp-Source: ACJfBosl1HfVkJHADS/p6L5ciRkltA6iR/Ks+aUo8uCxasQNUx89yEP9R6DvBs8KOTVoDsxCzyZeVw==
X-Received: by 10.28.140.206 with SMTP id o197mr1664827wmd.43.1514997323982;
        Wed, 03 Jan 2018 08:35:23 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:35:23 -0800 (PST)
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
Subject: [PATCH 38/40] Add t0480 to test "have" capability and raw objects
Date:   Wed,  3 Jan 2018 17:34:01 +0100
Message-Id: <20180103163403.11303-39-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0480-read-object-have-http-e-odb.sh | 109 +++++++++++++++++++++++++++++++++
 t/t0480/read-object-plain-have         | 103 +++++++++++++++++++++++++++++++
 2 files changed, 212 insertions(+)
 create mode 100755 t/t0480-read-object-have-http-e-odb.sh
 create mode 100755 t/t0480/read-object-plain-have

diff --git a/t/t0480-read-object-have-http-e-odb.sh b/t/t0480-read-object-have-http-e-odb.sh
new file mode 100755
index 0000000000..056a40f2bb
--- /dev/null
+++ b/t/t0480-read-object-have-http-e-odb.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+test_description='tests for read-object process with "have" cap and plain objects'
+
+. ./test-lib.sh
+
+# If we don't specify a port, the current test number will be used
+# which will not work as it is less than 1024, so it can only be used by root.
+LIB_HTTPD_PORT=$(expr ${this_test#t} + 12000)
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd apache-e-odb.conf
+
+PATH="$PATH:$TEST_DIRECTORY/t0480"
+
+# odb helper script must see this
+export HTTPD_URL
+
+HELPER="read-object-plain-have"
+
+test_expect_success 'setup repo with a root commit' '
+	test_commit zero
+'
+
+test_expect_success 'setup another repo from the first one' '
+	git init other-repo &&
+	(cd other-repo &&
+	 git remote add origin .. &&
+	 git pull origin master &&
+	 git checkout master &&
+	 git log)
+'
+
+test_expect_success 'setup the helper in the root repo' '
+	git config odb.magic.subprocessCommand "$HELPER"
+'
+
+UPLOADFILENAME="hello_apache_upload.txt"
+
+UPLOAD_URL="$HTTPD_URL/upload/?sha1=$UPLOADFILENAME&size=123&type=blob"
+
+test_expect_success 'can upload a file' '
+	echo "Hello Apache World!" >hello_to_send.txt &&
+	echo "How are you?" >>hello_to_send.txt &&
+	curl --data-binary @hello_to_send.txt --include "$UPLOAD_URL" >out_upload
+'
+
+LIST_URL="$HTTPD_URL/list/"
+
+test_expect_success 'can list uploaded files' '
+	curl --include "$LIST_URL" >out_list &&
+	grep "$UPLOADFILENAME" out_list
+'
+
+test_expect_success 'can delete uploaded files' '
+	curl --data "delete" --include "$UPLOAD_URL&delete=1" >out_delete &&
+	curl --include "$LIST_URL" >out_list2 &&
+	! grep "$UPLOADFILENAME" out_list2
+'
+
+FILES_DIR="httpd/www/files"
+
+test_expect_success 'new blobs are transfered to the http server' '
+	test_commit one &&
+	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
+	echo "$hash1-4-blob" >expected &&
+	ls "$FILES_DIR" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blobs can be retrieved from the http server' '
+	git cat-file blob "$hash1" &&
+	git log -p >expected
+'
+
+test_expect_success 'update other repo from the first one' '
+	(cd other-repo &&
+	 git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*" &&
+	 test_must_fail git cat-file blob "$hash1" &&
+	 git config odb.magic.subprocessCommand "$HELPER" &&
+	 git cat-file blob "$hash1" &&
+	 git pull origin master)
+'
+
+test_expect_success 'local clone from the first repo' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone .. . &&
+	 git cat-file blob "$hash1")
+'
+
+test_expect_success 'no-local clone from the first repo fails' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 test_must_fail git clone --no-local .. .) &&
+	rm -rf my-other-clone
+'
+
+test_expect_success 'no-local clone from the first repo with helper succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git clone -c odb.magic.subprocessCommand="$HELPER" --no-local .. .) &&
+	rm -rf my-other-clone
+'
+
+stop_httpd
+
+test_done
diff --git a/t/t0480/read-object-plain-have b/t/t0480/read-object-plain-have
new file mode 100755
index 0000000000..f230cbd5eb
--- /dev/null
+++ b/t/t0480/read-object-plain-have
@@ -0,0 +1,103 @@
+#!/usr/bin/perl
+#
+
+use 5.008;
+use lib (split(/:/, $ENV{GITPERLLIB}));
+use strict;
+use warnings;
+use Git::Packet;
+use LWP::UserAgent;
+use HTTP::Request::Common;
+
+packet_initialize("git-read-object", 1);
+
+my %remote_caps = packet_read_and_check_capabilities("get_raw_obj", "put_raw_obj", "have");
+packet_check_and_write_capabilities(\%remote_caps, "get_raw_obj", "put_raw_obj", "have");
+
+my $http_url = $ENV{HTTPD_URL};
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
+	} elsif ( $command eq "have" ) {
+		# read the flush after the command
+		packet_bin_read();
+
+		my $have_url = $http_url . "/list/";
+
+		my $userAgent = LWP::UserAgent->new();
+		my $response = $userAgent->get( $have_url );
+
+		if ($response->is_error) {
+			packet_bin_write("");
+			packet_flush();
+			packet_txt_write("status=failure");
+		} else {
+			packet_bin_write($response->content);
+			packet_flush();
+			packet_txt_write("status=success");
+		}
+		packet_flush();
+	} elsif ( $command eq "get_raw_obj" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		packet_bin_read();
+
+		my $get_url = $http_url . "/list/?sha1=" . $sha1;
+
+		my $userAgent = LWP::UserAgent->new();
+
+		my $response = $userAgent->get( $get_url );
+
+		if ($response->is_error) {
+			packet_txt_write("size=0");
+			packet_txt_write("kind=none");	    
+			packet_txt_write("status=notfound");
+		} else {
+			packet_txt_write("size=" . length($response->content));
+			packet_txt_write("kind=blob");
+			packet_bin_write($response->content);
+			packet_flush();
+			packet_txt_write("status=success");
+		}
+
+		packet_flush();
+	} elsif ( $command eq "put_raw_obj" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		my ($size) = packet_txt_read() =~ /^size=([0-9]+)$/;
+		my ($kind) = packet_txt_read() =~ /^kind=(\w+)$/;
+
+		packet_bin_read();
+
+		# We must read the content we are sent and send it to the right url
+		my ($res, $buf) = packet_bin_read();
+		die "bad packet_bin_read res ($res)" unless ($res eq 0);
+		( packet_bin_read() eq ( 1, "" ) ) || die "bad send end";		
+
+		my $upload_url = $http_url . "/upload/?sha1=" . $sha1 . "&size=" . $size . "&type=blob";
+
+		my $userAgent = LWP::UserAgent->new();
+		my $request = POST $upload_url, Content_Type => 'multipart/form-data', Content => $buf;
+
+		my $response = $userAgent->request($request);
+
+		if ($response->is_error) {
+			packet_txt_write("status=failure");
+		} else {
+			packet_txt_write("status=success");
+		}
+		packet_flush();
+	} else {
+		die "bad command '$command'";
+	}
+}
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

