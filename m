Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481F220A26
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdIPIIF (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:08:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33522 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdIPIIA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so4514511wmn.0
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y4Om+eDT/AM8SkQ6iuHx2WzaVQpn4imhfgtm4jiuVJo=;
        b=efrRhqq/32TaaaBP9nG4v1l11oP3r6VcnK90ItCsAq3t/hVP82zzxpU+i+2HLchF0X
         ggjSROBsUUAoC4HqB8h4i9Z/JvzHBNRP9ojNkw3rA6qN0HjISLcLTxu2cMblgFiIGrgK
         dmMx9BCYaWvoj786gvyAYUtNE9GDMXk0vwec9CkBbLmYCGMOGM0zkuMjAzfRLFgSmGYQ
         8E7gcCkgGwYbrXivRXyj/CNbKCCL8yVv5z4C1Ex6tCol9Wty0V+dCG5g7fTbTuHk0fRE
         nvEQGetM1Xe56+kMOHT0UMM1ASHdnsy4+/1+3yIOmtZ3UCettNOyCddYDJlrGK0/duoV
         RjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y4Om+eDT/AM8SkQ6iuHx2WzaVQpn4imhfgtm4jiuVJo=;
        b=bwUj0rMW0ScGXNm7EH5jg25M94YcWChg6kpfXN7RzlwVTT7eJT234a4jqji1EYASwb
         TCqUYeELg0uz7x0xUmm0g0yW0Ubd7yHpSu9SwbA954c+HdCyRs5mQnhcn5WaUuDNW3oS
         438/nPKdQ2ji275fAGqz++gpNlAg30Knh27mgqPn70dt6z9gEiQ/R03yqv2dLuIruOVs
         e1JM7g34SSBqrT301UHbdHSCu2NOWdH5dazK8JAGdMx95Yy5hOfFGhEtk/UN0Iq2q57X
         6cFRspC2ad7EcniUyDAMfWFae1u7a9JvWtXjcy8sDX8Nq+YuNfLy3y2d2pccHZ2pCYHx
         ZYpA==
X-Gm-Message-State: AHPjjUg3Em0aSrC/2JQxhu7mf/6OIysB6Gk5Xnb8rP7kHpzG3V7crKK6
        BYua+CF11aHdFmwh
X-Google-Smtp-Source: AOwi7QCKnqqx7/F3kQwx74vCHkE/MbxxWpdObqODT8DUmZQ4kqxrSvc167TFI7TOxYJGdpb3/uPyyQ==
X-Received: by 10.28.217.134 with SMTP id q128mr4882091wmg.116.1505549278739;
        Sat, 16 Sep 2017 01:07:58 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:58 -0700 (PDT)
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
Subject: [PATCH v6 11/40] t0400: add 'put_raw_obj' instruction to odb-helper script
Date:   Sat, 16 Sep 2017 10:07:02 +0200
Message-Id: <20170916080731.13925-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
index ed89f3ab40..f9e6ea1015 100755
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
@@ -47,4 +62,13 @@ test_expect_success 'helper can retrieve alt objects' '
 	test_cmp expect actual
 '
 
+test_expect_success 'helper can add objects to alt repo' '
+	hash=$(echo "Hello odb!" | git hash-object -w -t blob --stdin) &&
+	test -f .git/objects/$(echo $hash | sed "s#..#&/#") &&
+	size=$(git cat-file -s "$hash") &&
+	git cat-file blob "$hash" | ./odb-helper put_raw_obj "$hash" "$size" blob &&
+	alt_size=$(cd alt-repo && git cat-file -s "$hash") &&
+	test "$size" -eq "$alt_size"
+'
+
 test_done
-- 
2.14.1.576.g3f707d88cd

