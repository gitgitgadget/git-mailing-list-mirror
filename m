Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD5631F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751106AbeACQgO (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:36:14 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39764 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeACQew (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:52 -0500
Received: by mail-wr0-f195.google.com with SMTP id o101so2142793wrb.6
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mr+lW/I4s0QI0dJiOA0h4kVV/uqYnxHxGd2AmD5vh1c=;
        b=Gir9Sl9iJ+ySh0V7u+7VBrUHCpSgstDxwXZeO6oJ7DQdXO5NUewelY4RT14M7jBpku
         65slC6m6sUu8vU8CIgw7w5RbmdSNeTMfR542ao7hImeV52FZUaCRVmOsGTDdTSI10f/X
         a2Ag13eyVWUrZFAB+fN3tkUORY2Uqjza7RlUAkX7ylMZFRL3c4f5Moujopip6Rf+VHxH
         DkeVGFhu99Aq9DvmdrIFFzepP6ohXfsEzSXoD+mfwKqxgK739s3P3zZmDAyUq+ahSGRs
         2Kjp56pI5+6H2N/+VwH3XEyXVoEfwL/ZZkpnm47ipBtN6QezkNM0tp2ed8lhh01rczRr
         lI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mr+lW/I4s0QI0dJiOA0h4kVV/uqYnxHxGd2AmD5vh1c=;
        b=hGCdvBGbjDCyfW8r/gWJ61wmtg7AbpbifyB2Wop2HCEeczvczM0LfVlRO01xJEWtxw
         4cfN0TQkuRWwGiIvUxszarJrhXZv9WnGQvsd25m7/D2Xn22UC5Y6BtyRyON1t/ZomZTE
         4Xvo5zUVSDQ5tcU3RguQWgx0k0Yfh7E6qZBPA9JNxP30i45R4Nz4j/y5EK/I7K03JQAo
         7nSdtRdZHuY30iIIMbQ64ZOAqChwHMTPScKOVwNTRs3bxDZkUY46D4KTC40KAUiUzw5/
         JPJTMJHlLiM8nczpEUm00HgW9Zk0dTKH61B8bL5qfpOLLb3rQPe6GFQDbYSQl7T880u8
         No1A==
X-Gm-Message-State: AKGB3mK8GhsBdIdJ9qkjX8cYHBr1cvsg8g912Cw8pmm2+wvcnSKFVgdU
        DTIlEP38EvTpuWZhVVNIKLBur5+j
X-Google-Smtp-Source: ACJfBotqHkMCW/hfudwJ45q6wZHFBkaibH9bhbMZEeobpdxAjnZa7WnNLj9efA1Aud+zYaFv3WoJ7A==
X-Received: by 10.223.135.82 with SMTP id 18mr2100688wrz.111.1514997290215;
        Wed, 03 Jan 2018 08:34:50 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:49 -0800 (PST)
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
Subject: [PATCH 22/40] Add t0410 to test external ODB transfer
Date:   Wed,  3 Jan 2018 17:33:45 +0100
Message-Id: <20180103163403.11303-23-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-transfer-e-odb.sh | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100755 t/t0410-transfer-e-odb.sh

diff --git a/t/t0410-transfer-e-odb.sh b/t/t0410-transfer-e-odb.sh
new file mode 100755
index 0000000000..065ec7d759
--- /dev/null
+++ b/t/t0410-transfer-e-odb.sh
@@ -0,0 +1,144 @@
+#!/bin/sh
+
+test_description='basic tests for transfering external ODBs'
+
+. ./test-lib.sh
+
+ORIG_SOURCE="$PWD/.git"
+export ORIG_SOURCE
+
+ALT_SOURCE1="$PWD/alt-repo1/.git"
+export ALT_SOURCE1
+write_script odb-helper1 <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
+GIT_DIR=$ALT_SOURCE1; export GIT_DIR
+case "$1" in
+init)
+	echo "capability=get_git_obj"
+	echo "capability=have"
+	;;
+have)
+	git cat-file --batch-check --batch-all-objects |
+	awk '{print $1 " " $3 " " $2}'
+	;;
+get_git_obj)
+	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
+	;;
+put_raw_obj)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	writen=$(git hash-object -w -t "$kind" --stdin)
+	test "$writen" = "$sha1" || die "bad sha1 passed '$sha1' vs writen '$writen'"
+	ref_hash=$(echo "$sha1 $size $kind" | GIT_DIR=$ORIG_SOURCE GIT_NO_EXTERNAL_ODB=1 git hash-object -w -t blob --stdin) || exit
+	GIT_DIR=$ORIG_SOURCE git update-ref refs/odbs/magic/"$sha1" "$ref_hash"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
+esac
+EOF
+HELPER1="\"$PWD\"/odb-helper1"
+
+OTHER_SOURCE="$PWD/.git"
+export OTHER_SOURCE
+
+ALT_SOURCE2="$PWD/alt-repo2/.git"
+export ALT_SOURCE2
+write_script odb-helper2 <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
+GIT_DIR=$ALT_SOURCE2; export GIT_DIR
+case "$1" in
+init)
+	echo "capability=get_git_obj"
+	echo "capability=have"
+	;;
+have)
+	GIT_DIR=$OTHER_SOURCE git for-each-ref --format='%(objectname)' refs/odbs/magic/ | GIT_DIR=$OTHER_SOURCE xargs git show
+	;;
+get_git_obj)
+	OBJ_FILE="$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
+	if ! test -f "$OBJ_FILE"
+	then
+		# "Download" the missing object by copying it from alt-repo1
+		OBJ_DIR=$(echo $2 | sed 's/\(..\).*/\1/')
+		OBJ_BASE=$(basename "$OBJ_FILE")
+		ALT_OBJ_DIR1="$ALT_SOURCE1/objects/$OBJ_DIR"
+		ALT_OBJ_DIR2="$ALT_SOURCE2/objects/$OBJ_DIR"
+		mkdir -p "$ALT_OBJ_DIR2" || die "Could not mkdir '$ALT_OBJ_DIR2'"
+		OBJ_SRC="$ALT_OBJ_DIR1/$OBJ_BASE"
+		cp "$OBJ_SRC" "$ALT_OBJ_DIR2" ||
+		die "Could not cp '$OBJ_SRC' into '$ALT_OBJ_DIR2'"
+	fi
+	cat "$OBJ_FILE" || die "Could not cat '$OBJ_FILE'"
+	;;
+put_raw_obj)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	writen=$(git hash-object -w -t "$kind" --stdin)
+	test "$writen" = "$sha1" || die "bad sha1 passed '$sha1' vs writen '$writen'"
+	ref_hash=$(echo "$sha1 $size $kind" | GIT_DIR=$OTHER_SOURCE GIT_NO_EXTERNAL_ODB=1 git hash-object -w -t blob --stdin) || exit
+	GIT_DIR=$OTHER_SOURCE git update-ref refs/odbs/magic/"$sha1" "$ref_hash"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
+esac
+EOF
+HELPER2="\"$PWD\"/odb-helper2"
+
+test_expect_success 'setup first alternate repo' '
+	git init alt-repo1 &&
+	test_commit zero &&
+	git config odb.magic.scriptCommand "$HELPER1"
+'
+
+test_expect_success 'setup other repo and its alternate repo' '
+	git init other-repo &&
+	git init alt-repo2 &&
+	(cd other-repo &&
+	 git remote add origin .. &&
+	 git pull origin master &&
+	 git checkout master &&
+	 git log)
+'
+
+test_expect_success 'new blobs are put in first object store' '
+	test_commit one &&
+	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo1 && git show "$hash1") &&
+	test "$content" = "one" &&
+	test_commit two &&
+	hash2=$(git ls-tree HEAD | grep two.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo1 && git show "$hash2") &&
+	test "$content" = "two"
+'
+
+test_expect_success 'other repo gets the blobs from object store' '
+	(cd other-repo &&
+	 git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*" &&
+	 test_must_fail git cat-file blob "$hash1" &&
+	 test_must_fail git cat-file blob "$hash2" &&
+	 git config odb.magic.scriptCommand "$HELPER2" &&
+	 git cat-file blob "$hash1" &&
+	 git cat-file blob "$hash2"
+	)
+'
+
+test_expect_success 'other repo gets everything else' '
+	(cd other-repo &&
+	 git fetch origin &&
+	 content=$(git show "$hash1") &&
+	 test "$content" = "one" &&
+	 content=$(git show "$hash2") &&
+	 test "$content" = "two")
+'
+
+test_done
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

