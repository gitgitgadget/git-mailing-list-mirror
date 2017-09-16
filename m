Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD7B20A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbdIPIIn (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:43 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36397 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdIPIIk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:40 -0400
Received: by mail-wr0-f193.google.com with SMTP id g50so2374632wra.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+lUw+dJXKtLgMM92VYUfheGw/olErz835JB9RuHnzhQ=;
        b=I5p1CmG2hpYAA7wu+kq24lTTK53VrEvKWJJhZ9nGg9gxzSV8D2C/T+b6bhfaf2RFs/
         eg34XZYckC3anvg7N5nsEUMY5cxS9oUpkQpAsvIXnBjjSHwrvxXHpFOyTO+eiTUTNIK6
         Duy9oA+37wDZQYifE5eX4qYiOBCefl6imAmRkuB3jCCC9kZgyA+yIzyCXUuZtRulFKnv
         jRq3li+ESwaQY/AuVujsEniSSYdhHC1OSJvhPCMMA0DDG4FMvu8bNXHu2bZ0SBxj3elW
         V9gdKb/rABttsg93DiFGA2vesq1nNuoIrRJ6X3F25LgdQMHCTnkBVC4kRCMpHXyr0WAD
         diAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+lUw+dJXKtLgMM92VYUfheGw/olErz835JB9RuHnzhQ=;
        b=gae2LXEX0JZMpqvKT2JXtMFlQEqBpQj5mha9fUGMc0YV5iaqzHBLFexQIuieVj0b8Y
         Eo0dPSUAxCCc+LxtmYg9lCQGMVEikHAeW+zZHiNQkaJ7g2k3RFFAY6LT1OCboRyZAy6c
         ckyqB2HdNnfacjby/RBM9EaxgbFtiyJFLvoYUgPrMS22UdzR74bTWEOvs+aza9c/+4Ss
         a4KOABedgyI7KvgUCfvHGyr/2p+t6ZcSR3SVRngR1nl0VJWXcOi3HYw/hd/khHYIm/y1
         99L/IHbFM88NeCzEP/fhfHvPshMSVUrwgL9c3p4RaFdoTo47Glk6Gv9A54tUGGnRvAIV
         0org==
X-Gm-Message-State: AHPjjUgrPAPt+UrIYnJGEc8rL57FUyVEJ3YJ3bTuSoh9cw0LPa3mLpj+
        7L3PaGnuuOMXJv9Q
X-Google-Smtp-Source: ADKCNb5oUi3ey8Vjrt7wBjGzp+gMI8VaByt3qxvOIl4g8+v30V2EgiCSmkHmXMJPgKLfwoR34Ux8qQ==
X-Received: by 10.223.174.201 with SMTP id y67mr25653796wrc.116.1505549318793;
        Sat, 16 Sep 2017 01:08:38 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:38 -0700 (PDT)
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
Subject: [PATCH v6 39/40] Add t0430 to test cloning using bundles
Date:   Sat, 16 Sep 2017 10:07:30 +0200
Message-Id: <20170916080731.13925-40-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0430-clone-bundle-e-odb.sh | 85 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 t/t0430-clone-bundle-e-odb.sh

diff --git a/t/t0430-clone-bundle-e-odb.sh b/t/t0430-clone-bundle-e-odb.sh
new file mode 100755
index 0000000000..ac38ae1be5
--- /dev/null
+++ b/t/t0430-clone-bundle-e-odb.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='tests for cloning using a bundle through e-odb'
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
+# odb helper script must see this
+export HTTPD_URL
+
+write_script odb-clone-bundle-helper <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
+echo >&2 "odb-clone-bundle-helper args:" "$@"
+case "$1" in
+init)
+	ref_hash=$(git rev-parse refs/odbs/magic/bundle) ||
+	die "couldn't find refs/odbs/magic/bundle"
+	GIT_NO_EXTERNAL_ODB=1 git cat-file blob "$ref_hash" >bundle_info ||
+	die "couldn't get blob $ref_hash"
+	bundle_url=$(sed -e 's/bundle url: //' bundle_info)
+	echo >&2 "bundle_url: '$bundle_url'"
+	curl "$bundle_url" -o bundle_file ||
+	die "curl '$bundle_url' failed"
+	GIT_NO_EXTERNAL_ODB=1 git bundle unbundle bundle_file >unbundling_info ||
+	die "unbundling 'bundle_file' failed"
+	;;
+get*)
+	die "odb-clone-bundle-helper '$1' called"
+	;;
+put*)
+	die "odb-clone-bundle-helper '$1' called"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
+esac
+EOF
+HELPER="\"$PWD\"/odb-clone-bundle-helper"
+
+
+test_expect_success 'setup repo with a few commits' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	test_commit four
+'
+
+BUNDLE_FILE="file.bundle"
+FILES_DIR="httpd/www/files"
+GET_URL="$HTTPD_URL/files/$BUNDLE_FILE"
+
+test_expect_success 'create a bundle for this repo and check that it can be downloaded' '
+	git bundle create "$BUNDLE_FILE" master &&
+	mkdir "$FILES_DIR" &&
+	cp "$BUNDLE_FILE" "$FILES_DIR/" &&
+	curl "$GET_URL" --output actual &&
+	test_cmp "$BUNDLE_FILE" actual
+'
+
+test_expect_success 'create an e-odb ref for this bundle' '
+	ref_hash=$(echo "bundle url: $GET_URL" | GIT_NO_EXTERNAL_ODB=1 git hash-object -w -t blob --stdin) &&
+	git update-ref refs/odbs/magic/bundle "$ref_hash"
+'
+
+test_expect_success 'clone using the e-odb helper to download and install the bundle' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone --no-local \
+		-c odb.magic.scriptCommand="$HELPER" \
+		--initial-refspec "refs/odbs/magic/*:refs/odbs/magic/*" .. .)
+'
+
+stop_httpd
+
+test_done
-- 
2.14.1.576.g3f707d88cd

