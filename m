Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B08191F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933339AbeCSNcl (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34820 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeCSNch (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:37 -0400
Received: by mail-wr0-f196.google.com with SMTP id n12so18640319wra.2
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tuI5d5cjt59fpRCAP2Qo0NYLS6L9tp28bIoZxlopHyU=;
        b=umfvt+XqtpXtJ5npVwzEkCmzd2sUODXJJswPdNy+OcoW/NkP8Sg0nmcyrQszVjIakB
         HBw+xeLuucZEo7w6uDQOL8kM+YDNMYymsdpzpG9cmEWtILvmqmcKUjFfRgb+PWe+sH0s
         UxN+T96zGUSqObykj6ZR+7RgGUV4kmfegN6o4fIOyAWrPPMRPNkUnXNalQLXrOCdmGr4
         OmmMHAXCvAw9N8brEzybb6PB3WIFoRBtKeLbfTWEWFTyGLO1je93VRjqKZtf4pXa224+
         hrUj6i2DWcbewje7khlsUHACVMu/xa348H7/Lnf+vAfVN1j3nxuIWscKHIMLylG3ztk7
         Xxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tuI5d5cjt59fpRCAP2Qo0NYLS6L9tp28bIoZxlopHyU=;
        b=gq4/Q+ZXjSn+W/PNUdjjJfXKDmZ/X3kczMyWjODFD2Bbp1AxZEFQlcF65ScXpDLAt7
         3Lew4NLZvqHvnpT68+8b3eKuRF5pyt7jk6yTIoYnFIx0usNItBBO0ARdKpzjbIsdTuBy
         4npncc09TbblQA0maCMahJMJH50vSEwyLFsBw0XhTGTkS3XAjjBPIMVa5vjwFC8Lyx83
         Bs3zv+aBzQduHZNzowMNd5EmUKtVuu5wQ9/4tMzlVsd8LxEPDlEDI5ahTt6sElvu14uV
         KKzG8xsMOnNFc14y/0wfhQqQiFDDwEGTlle/zx5BcpdY8TyXiI83i/ONzzswVn2iaLeJ
         f80A==
X-Gm-Message-State: AElRT7G4zY4O16Q4h9jis0y5S8++ptdtn86YsW/mTaJ5It98vTyzCZ0k
        QK8n0pwC+h2SMzP8Ks93lJhv5CeI
X-Google-Smtp-Source: AG47ELu2ijYfhZZ5FVBstiU0oGBV1CZSK/fITjO2IX2chgfe+ipnvNZv06c59ESKcxAQFnByS0tMvQ==
X-Received: by 10.223.196.132 with SMTP id m4mr10384664wrf.9.1521466355987;
        Mon, 19 Mar 2018 06:32:35 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:35 -0700 (PDT)
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
Subject: [PATCH v2 20/36] Add t0510 to test external ODB transfer
Date:   Mon, 19 Mar 2018 14:31:31 +0100
Message-Id: <20180319133147.15413-21-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0510-transfer-e-odb.sh | 144 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100755 t/t0510-transfer-e-odb.sh

diff --git a/t/t0510-transfer-e-odb.sh b/t/t0510-transfer-e-odb.sh
new file mode 100755
index 0000000000..065ec7d759
--- /dev/null
+++ b/t/t0510-transfer-e-odb.sh
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
2.17.0.rc0.37.g8f476fabe9

