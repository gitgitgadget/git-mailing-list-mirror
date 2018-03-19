Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48F31FAE4
	for <e@80x24.org>; Mon, 19 Mar 2018 13:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933327AbeCSNcg (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:32:36 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39587 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeCSNcc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:32:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id f125so7351214wme.4
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6f7WPEJ3y2DebEEAMWDC21kaMcrKG+SpvlrLWg537NQ=;
        b=vGE5UmsR303L9ts5F9JEzLDH1J+wdd/OcWkt2u00TDukIN2EnbqZOUkbzORypSz6yw
         n/QSOSmVcNJfeA4YDFxdjx1NzwF85yhQAeWrpBxPeFJEu3bnQXQx9jBTT/WJVhzu870s
         7uMt12yn8UTcQHr5TbTGgmdQqAV/8Eju2y4WBVTmD297udmtpC8aIu6URtO+LlS0OszO
         qesWasXRKLj9iONXN8arwx/X0OXl/8c0bMXMwfq6lQA4AzhiIhV3ueHltiMx7v9O2BDV
         bGwvArwA9U8Qg629vSJRZQFQMPTVXrIlVyuvVvpmSlMqg4sP61Uwa1ELsBuKFvmTkCxk
         kP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6f7WPEJ3y2DebEEAMWDC21kaMcrKG+SpvlrLWg537NQ=;
        b=gkkg8uSr6DdoQlbFL+bPcqPomJTYn1TDOXHCLeBi62js2vsIMiBJhVoV0ggUOuO4N6
         T4+UIS5sTkb+pOCObPg3DEQcIgAPg+QIa7idqYLl1ktQQXWMxiuNPhSyq5SOKMi4t71X
         gNPvOhIm8skxTPUVXh1Gc8AVXUK/zw3UOHogSOsVK0b9WOP6WNjzJL9X40cmRXPl2yld
         RXIT6FWtq9SHXH4qFG0TOWFEzXUau4//iWe1VH2p+0rXAKOTEdIbaVi611dKHZcyGLCF
         8JeWSegtKWXD4Yf1z41pYzmENiORvfUOy7/s7ePVDmTmJbWUKMduT1Z64EyVMn85dauk
         AqNQ==
X-Gm-Message-State: AElRT7HFo5xuhP0xVGs7+8SxdSlkWJtHTLa7zRA3nGErxww556otCKmi
        iigfaz7tNQAVNKTm0YfIQ0+QnOqq
X-Google-Smtp-Source: AG47ELvupOn53731C94/yw5D/5LxfmKiuk5Kyo0ceNpi9kkGM2QBOZhMrk1RszgCKGRKZzxOvBfApQ==
X-Received: by 10.28.206.77 with SMTP id e74mr9339314wmg.41.1521466350516;
        Mon, 19 Mar 2018 06:32:30 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id p29sm539434wmf.3.2018.03.19.06.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 06:32:29 -0700 (PDT)
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
Subject: [PATCH v2 16/36] t0500: add 'put_raw_obj' instruction to odb-helper script
Date:   Mon, 19 Mar 2018 14:31:27 +0100
Message-Id: <20180319133147.15413-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.17.0.rc0.37.g8f476fabe9
In-Reply-To: <20180319133147.15413-1-chriscool@tuxfamily.org>
References: <20180319133147.15413-1-chriscool@tuxfamily.org>
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
 t/t0500-external-odb.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t0500-external-odb.sh b/t/t0500-external-odb.sh
index 977fea852d..4ccca1e965 100755
--- a/t/t0500-external-odb.sh
+++ b/t/t0500-external-odb.sh
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
2.17.0.rc0.37.g8f476fabe9

