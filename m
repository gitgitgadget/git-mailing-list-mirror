Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767F220A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdIPIIj (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36036 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdIPIIa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id r136so4499217wmf.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nE4yJCuAB06oBscVmI5BTg1y3GBFevXLHqiIpT7Xy7A=;
        b=cDNuGR9QykOXVeAEnrkeM1hH+/O9ZTN3MW7hP0EZBXH9QCXQek8o8FjpOvsoq4yCEq
         iSR+UaSSbmjX1hnTO/7RQyuiJPTC8OOGibEAGxSmEE6X6tOy+bTIjjJoHScNyrOmlGf6
         Hkk8hAxnbx0FAD/Y17LJqtHEZpUT2qjTWVQb/4F+e7tJ1GoDJwUHSCKbiI3OqaK6WmD2
         uZSetw3VQAny7n2CrmlvdPFo1J1Tsrckj0l+8o0O+BAvm+tsGhP650ps0UC1rwCYpQ8/
         r6ab8qF/sygsoTDj5cIRvBaCNF4J4ItYBs9AtlL7hUOvsLrrFEQKT+bAc7/kYGUTylmf
         VxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nE4yJCuAB06oBscVmI5BTg1y3GBFevXLHqiIpT7Xy7A=;
        b=t7nfKpuFvVFT5nheISOZXtr5bdigzFm6U7jdwJcf+rvCmtRu9g2LFBny4hn/q/LI0W
         BdRVNiVmkdyfiKff+89MejraZNouKrG9OTB1JC7sVW8w6dGLGLGdJy0EoZl40rWysZEM
         omaDb/fN7eDexwwwogKiITmqYCFJdwW2+Q7B0E4jW7p/TCVXCYHw6pF9IEYCkNop3dkE
         vM7tJHVwRjeBsYduRjVpIn4tHssN1Ux1p7IH7ph9FIA8gzmWcjfwHLXPC4hWd1++TCtf
         9iTKrvYPFrsEdY2hibWW7NL44mbkeNda/1YOi9SakxAwR3WTOedbWTJTsZAHlFVvXaNB
         PzFg==
X-Gm-Message-State: AHPjjUgA6JWHj6+zxespZO+/cVjA8uDdeVBmKkglcXp/ok3Yq6x3KeG8
        dmMUZ+Ox0ziSZEXJ
X-Google-Smtp-Source: AOwi7QC1yWAn3PNvfRP4iIv1ORNiEaglK/0JdEcVRbKwuXlSkRbOIzCi4zVHQ3r/5mCN24+0Ismu5g==
X-Received: by 10.28.236.91 with SMTP id k88mr4620659wmh.95.1505549308933;
        Sat, 16 Sep 2017 01:08:28 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:28 -0700 (PDT)
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
Subject: [PATCH v6 32/40] Add t0480 to test "have" capability and raw objects
Date:   Sat, 16 Sep 2017 10:07:23 +0200
Message-Id: <20170916080731.13925-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
index 0000000000..d63e327f33
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
+packet_read_and_check_capabilities("get_raw_obj", "put_raw_obj", "have");
+packet_write_capabilities("get_raw_obj", "put_raw_obj", "have");
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
2.14.1.576.g3f707d88cd

