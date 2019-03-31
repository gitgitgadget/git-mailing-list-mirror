Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1AC20248
	for <e@80x24.org>; Sun, 31 Mar 2019 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbfCaNra (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 09:47:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36056 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfCaNra (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 09:47:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so8442754wrd.3
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFk4hnCK550dt86hBGUy/4SxtO34aJvku0xxR2dpxD8=;
        b=IP58Tu8lMnKHg+F6P9qQ3ZDZGu136ZjPocROB18x3mImIfJnO0KYaoWzVyyvqNGcFH
         Uke69weIgRvFVN+uamocGqxuWaxNopeoUprYfNzvyRyU37Vv/te4oq480vtWQD5qIkmF
         ODP1ZDMrpZIL01iYfwt337jZeArCDpCWt2QsNfxhUB/Bo6L+JsaESiND5X6i8bnHmBYq
         oJw7EBQTDL68eowwSJE9gtFiEgzKS5bFDhF9LQAp5TvvlFR87gp3mbCHv6dN8wz+5v+m
         q9oz0cqEQwIwirnCn3Sjj+eLhNsGXupRA/J8ZwuvF+9cbsAP//9l5fxFiwxh3+ciD1Ww
         qDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFk4hnCK550dt86hBGUy/4SxtO34aJvku0xxR2dpxD8=;
        b=N8p1kV/DXmwI8MntONF5fhakNGm1BqnoM18SIzJbwDcCBwc//mUw1ADs0Z+Rh0jY45
         7PWQKlNmPxa+OpEmdN3y1DVAZ/YAqsBFy/IfcEnFEki0JLFcDhZvizmKqSF7nKNRo1HJ
         TUe413/QmBKC4yES/g7M4sXMCppf/rjIjYdqYp/kgOJf4Qn785Wcuro5zIIHaqTvSNkA
         H1Jddq4F4L5AT3jKchjvMGQj0Zd+vojp+ftylXcevvb2+oOiZA61Zu1vdnXTrAdgPAzM
         8yVl8o9mcEtiJxWrwJe59zNGIPzLAGujjvTj/zgNrIvTL4R5E+HhBXqZRRersz+PkVTq
         EuLg==
X-Gm-Message-State: APjAAAW8SdHtEm315RtzbLQ/ymugPhIQpTIlXMY54pguC/CiT6Yd9Rrz
        6PBeulCRwxM/nd9D+VFPkXwiOL5B
X-Google-Smtp-Source: APXvYqxHwJr/jFPHFAL/83amYl17iD5q2c1RZn/nT1Nc95t4btCEooqlGZZAnSqUiA0hGhb2MCUjOQ==
X-Received: by 2002:adf:ef0c:: with SMTP id e12mr37264319wro.170.1554040048076;
        Sun, 31 Mar 2019 06:47:28 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:10ce:4d96:49c5:28f4:744c:fa99])
        by smtp.gmail.com with ESMTPSA id o10sm10290490wru.54.2019.03.31.06.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 06:47:27 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/4] replace: fix --graft when passing a tag as parent
Date:   Sun, 31 Mar 2019 15:46:58 +0200
Message-Id: <20190331134659.28808-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.69.g2d86a08d09
In-Reply-To: <20190331134659.28808-1-chriscool@tuxfamily.org>
References: <20190331134659.28808-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When passing a tag as a parent argument to `git replace --graft`,
it can be useful to accept it and use the underlying commit as a
parent.

This already works for lightweight tags, but unfortunately
for annotated tags we have been using the hash of the tag object
instead of the hash of the underlying commit as a parent in the
replacement object we create.

This created invalid objects, but the replace succeeded even if
it showed an error like:

error: object A is a tag, not a commit

This patch fixes that by using the hash of the underlying commit
when an annotated tag is passed.

While at it, let's also update an error message to make it
clearer.

Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/replace.c  |  9 ++++++---
 t/t6050-replace.sh | 11 +++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index f5701629a8..b0a9227f9a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -370,16 +370,19 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
 	/* prepare new parents */
 	for (i = 0; i < argc; i++) {
 		struct object_id oid;
+		struct commit *commit;
+
 		if (get_oid(argv[i], &oid) < 0) {
 			strbuf_release(&new_parents);
 			return error(_("not a valid object name: '%s'"),
 				     argv[i]);
 		}
-		if (!lookup_commit_reference(the_repository, &oid)) {
+		commit = lookup_commit_reference(the_repository, &oid);
+		if (!commit) {
 			strbuf_release(&new_parents);
-			return error(_("could not parse %s"), argv[i]);
+			return error(_("could not parse %s as a commit"), argv[i]);
 		}
-		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
+		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&commit->object.oid));
 	}
 
 	/* replace existing parents with new ones */
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 948d278482..2385a60f68 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -406,6 +406,17 @@ test_expect_success '--graft with and without already replaced object' '
 	git replace -d $HASH5
 '
 
+test_expect_success '--graft using a tag as the new parent' '
+	git tag new_parent $HASH5 &&
+	git replace --graft $HASH7 new_parent &&
+	commit_has_parents $HASH7 $HASH5 &&
+	git replace -d $HASH7 &&
+	git tag -a -m "annotated new parent tag" annotated_new_parent $HASH5 &&
+	git replace --graft $HASH7 annotated_new_parent &&
+	commit_has_parents $HASH7 $HASH5 &&
+	git replace -d $HASH7
+'
+
 test_expect_success GPG 'set up a signed commit' '
 	echo "line 17" >>hello &&
 	echo "line 18" >>hello &&
-- 
2.21.0.69.g2d86a08d09

