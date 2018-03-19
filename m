Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1DCA1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933106AbeCSNdw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:33:52 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55064 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933369AbeCSNcy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:54 -0400
Received: by mail-wm0-f53.google.com with SMTP id h76so15214071wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NYkWWSXTAM9R8LRbThEqClX+ULF7E/ieuiW8ajisx6A=;
        b=L2yCD5lBwGSQ2JAz9geEMJZMuXCM/pP3/d3jbI28LbmhXw/mzp2C2uF5Hl8RqLh27B
         f6DnfMeSux8yJFXibUcGV/2JnmOg0G6YbE02SOIiaHlvaWFJ9PY4951Itc6Yk6M1Z8h5
         3LZzeZJljkwivw03S70FZ1i4dxXlqdevoJqCXKALx3U70Q/O4gT8MbVf0gabGAkQeCnw
         Awj7k4r18lFXeEuypRlNA3gMUoReAjH4mK+DwlQvyr+Xj2aqrfTl0yQVLyCr8xsaNt08
         lJzz5tc2HiWiawXR5rkN1SFBPcn3+eI6BI5pInnMB+v9plIBjTli1Gm1i9qETHDHPAzl
         YV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NYkWWSXTAM9R8LRbThEqClX+ULF7E/ieuiW8ajisx6A=;
        b=J8g1lk9Jhj6TIuH2WVmEMGytbCD0eP6ju0S3YXQEU9k9PLhd3ezKlFTjfUbsfrHEcd
         ClOFltEfXpI7NMmOb+GrjlRmQH6yzkKKJmGhgfyQusIBUp7SoPSpmCXdDHVpvJk1XkpY
         tEzmePZaigN/dB195amFzF9x4e6+LxbyKjpopBXgJW6o8exfCkYzOI8neILujQDTOeLJ
         2xcB3BHXgKVbxhSJhLCN8iSEz0veo6zQ8leogL1Tho6nbbNL0s6qWf3C87m5sQDvm5hy
         5JgFDN37Qt86ZlwLBhjuT1SOYcB3apGdbTUVzkZLtqKIY9GDuzGjRhtWgO2Jcr88KkBn
         Rr7Q==
X-Gm-Message-State: AElRT7GiYtY7CsZiOIb+B1oCskUi2To5pvu0S12RevP3QWn5aKc3Bk+4
        x48S3DffvxOjBGynCF2buZIYQovj
X-Google-Smtp-Source: AG47ELuFKkDhhtO95CDHqMbGnToLbZTVFxCzxGGo4bT3JkOYnu6RrpdE9zcz6ejxyoZjOVGxyZ4REg==
X-Received: by 10.28.172.196 with SMTP id v187mr9127464wme.69.1521466372737;
        Mon, 19 Mar 2018 06:32:52 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:52 -0700 (PDT)
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
Subject: [PATCH v2 32/36] Add t0570 to test passing raw objects
Date:   Mon, 19 Mar 2018 14:31:43 +0100
Message-Id: <20180319133147.15413-33-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0570-read-object-http-e-odb.sh | 109 ++++++++++++++++++++++++++++++
 t/t0570/read-object-plain         |  83 +++++++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100755 t/t0570-read-object-http-e-odb.sh
 create mode 100755 t/t0570/read-object-plain

diff --git a/t/t0570-read-object-http-e-odb.sh b/t/t0570-read-object-http-e-odb.sh
new file mode 100755
index 0000000000..1b2205e273
--- /dev/null
+++ b/t/t0570-read-object-http-e-odb.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+test_description='tests for read-object process passing plain objects to an HTTPD server'
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
+PATH="$PATH:$TEST_DIRECTORY/t0570"
+
+# odb helper script must see this
+export HTTPD_URL
+
+HELPER="read-object-plain"
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
+	 git config odb.magic.subprocesscommand "$HELPER" &&
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
diff --git a/t/t0570/read-object-plain b/t/t0570/read-object-plain
new file mode 100755
index 0000000000..0766e16032
--- /dev/null
+++ b/t/t0570/read-object-plain
@@ -0,0 +1,83 @@
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
+my %remote_caps = packet_read_and_check_capabilities("get_raw_obj", "put_raw_obj");
+packet_check_and_write_capabilities(\%remote_caps, "get_raw_obj", "put_raw_obj");
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
+		    packet_txt_write("size=0");
+		    packet_txt_write("kind=none");	    
+		    packet_txt_write("status=notfound");
+		} else {
+		    packet_txt_write("size=" . length($response->content));
+		    packet_txt_write("kind=blob");
+		    packet_bin_write($response->content);
+		    packet_flush();
+		    packet_txt_write("status=success");
+		}
+
+		packet_flush();
+	} elsif ( $command eq "put_raw_obj" ) {
+		my ($sha1) = packet_txt_read() =~ /^sha1=([0-9a-f]{40})$/;
+		my ($size) = packet_txt_read() =~ /^size=([0-9]+)$/;
+		my ($kind) = packet_txt_read() =~ /^kind=(\w+)$/;
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
2.17.0.rc0.37.g8f476fabe9

