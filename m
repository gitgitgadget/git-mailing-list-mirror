Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E4A1F42E
	for <e@80x24.org>; Wed,  3 Jan 2018 16:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751293AbeACQeu (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:34:50 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35107 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeACQep (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:34:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id a79so3644531wma.0
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92YaD7XgBH9VGvrfCYiiHXnp++zFnEyMQWJyc8HdyMk=;
        b=Et8nkaOr2PXyCf8109FlZUGwG6n+dVIcudGT7Hv7gfiMDIESR6LFZkmINKM6TO/xUV
         o2c7zZ10FdDjvNeMa93oqVouVbxoUdFi5nZsGJ9zBXjQj+u11z6zHgdZlrHii/rQi8Io
         bpq8OKpcEcV8k1MbB0TlU2641DlPZ8tGKeAIyH2CSNCUaoX9MfxwgbqXmuQCmv8MXVmY
         GrShymaBDKwMhc4Q0mrcoSP09PMsmQm0ng7SjVnTpjcgPMwkg16k9euVJyVdGyNfgZdz
         CRy11YjD6dd3e6y5pRgLWPbWT+VKAzhykOJDYT84III9vkUL3vZFqNiMQlX3fOvWgLMc
         raUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=92YaD7XgBH9VGvrfCYiiHXnp++zFnEyMQWJyc8HdyMk=;
        b=Mrk8l/zqAQgEiu5KAFwyXScG9Kby23EWYyqy1jtJq/DB67I4NXzhvvD2vf4nNB7Tte
         BwvyDmZGqwtlroOiub5QOZFu3ZdiF0ignCBs6PMre0ZySBC7r1mFTl1YhH8fJi8agNJr
         LR5I4cMHo+P7xpuLks+Im97xDwOnzBlPSz0G2/FtNbjU7hzT5y3ovvU5lNx+LRmp46Ho
         v80RVu/L4i0QPUPaMGMwlepd09QMzOsfiGGpLJqd/KjRhtm+6S69evWmJE2aXcN9D/6m
         hMErH011aZIw6cZlAnvRHzNgcZBUihs2x9iHGAGYcZc0eTUhWSPIAuAOQTbi5XFPSpXv
         dLIQ==
X-Gm-Message-State: AKGB3mIS6C1AmqScMQMZzBMkzbT3JqZubV2xswjQthBCYGolse2KFu1k
        elYDgPHjwRZTO+4kazoYV+R7BqRY
X-Google-Smtp-Source: ACJfBovkJUwF0SwHWQqsm+im3xsQQG273yoAtq9sB6hBAVZpBqwnnUR3ug8itecyiVuFk9UN6etRTA==
X-Received: by 10.28.45.193 with SMTP id t184mr1961832wmt.140.1514997284097;
        Wed, 03 Jan 2018 08:34:44 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id s11sm1356384wrb.30.2018.01.03.08.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jan 2018 08:34:43 -0800 (PST)
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
Subject: [PATCH 18/40] t0400: add 'put_raw_obj' instruction to odb-helper script
Date:   Wed,  3 Jan 2018 17:33:41 +0100
Message-Id: <20180103163403.11303-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.16.0.rc0.16.g82191dbc6c.dirty
In-Reply-To: <20180103163403.11303-1-chriscool@tuxfamily.org>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To properly test passing objects from Git to an external odb
we need an odb-helper script that supports a 'put'
capability/instruction.

For now we will support only sending raw blobs, so the
supported capability/instruction will be 'put_raw_obj'.

While at it let's add a test to check that our odb-helper
script works well.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0400-external-odb.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t0400-external-odb.sh b/t/t0400-external-odb.sh
index 977fea852d..4ccca1e965 100755
--- a/t/t0400-external-odb.sh
+++ b/t/t0400-external-odb.sh
@@ -7,10 +7,15 @@ test_description='basic tests for external object databases'
 ALT_SOURCE="$PWD/alt-repo/.git"
 export ALT_SOURCE
 write_script odb-helper <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
 GIT_DIR=$ALT_SOURCE; export GIT_DIR
 case "$1" in
 init)
 	echo "capability=get_git_obj"
+	echo "capability=put_raw_obj"
 	echo "capability=have"
 	;;
 have)
@@ -20,6 +25,16 @@ have)
 get_git_obj)
 	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
 	;;
+put_raw_obj)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	written=$(git hash-object -w -t "$kind" --stdin)
+	test "$written" = "$sha1" || die "bad sha1 passed '$sha1' vs written '$written'"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
 esac
 EOF
 HELPER="\"$PWD\"/odb-helper"
@@ -45,4 +60,13 @@ test_expect_success 'helper can retrieve alt objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'helper can add objects to alt repo' '
+	hash=$(echo "Hello odb!" | git hash-object -w -t blob --stdin) &&
+	test -f .git/objects/$(echo $hash | sed "s#..#&/#") &&
+	size=$(git cat-file -s "$hash") &&
+	git cat-file blob "$hash" | ./odb-helper put_raw_obj "$hash" "$size" blob &&
+	alt_size=$(git -C alt-repo cat-file -s "$hash") &&
+	test "$size" -eq "$alt_size"
+'
+
 test_done
-- 
2.16.0.rc0.16.g82191dbc6c.dirty

