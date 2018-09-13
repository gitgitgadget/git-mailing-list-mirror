Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A02751F42B
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeIMXNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:13:01 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42127 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbeIMXNB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:13:01 -0400
Received: by mail-pf1-f174.google.com with SMTP id l9-v6so3012497pff.9
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1tm27vDdr+OSR1KPv2/mxLVXxHkgJHvoYoKzG0Da0dk=;
        b=pPUve9i5Nd2SxcKym7pnKv58k0d9ng6+MB3+JArXHnjwh9acfKrqUNsZW5ihLlpz7M
         m5IUXKCSkJ40euoOfFMHBAJ5Uf9ad68u6zcrz9B8sG6+wF0wYS2w0HtjRBdz3ctCMGhp
         DtEsbWrQ3gdROvOMndDYixtRyDBwabzl9ZPVX8369oOnPOZMBVxrgaEmoFg0O6MhAhkF
         9EpWFSO79AW9qErF289LUUoUTuXrai3eWf5ztXDl+oALqD8qxUN27GJkfp3OU47bf1Q4
         e/1PFjO9jlaP2uWNwbWrZuZWo/n1PQoHNHEl3SYySz4H+UFwiKIDt/Z3Zwupt4h8+HHQ
         jqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1tm27vDdr+OSR1KPv2/mxLVXxHkgJHvoYoKzG0Da0dk=;
        b=EMXUertTDluCcgdYDKPXvwdX4S8ugfDEOCUIbH7e946KDPBb3OdnuES0rR++70SCK7
         RK9bthZeyAY8S6aMzkYGpA+mZ28MddZnCorNT2aV5YzSGvB9QJsveIUa3DCutSz2ywDz
         aLKdhpcDIf3BVVjiNpfNbSjiCZyVVtpBlk8gKEHQzQdkys0JjEMOpEGi9wLbAPFJnkNW
         BfAj5EL6+ImJqkR71uvWRMPXsfCzNMr9TGb0Fn9TzJ9c5q82daFNL+5ifwlxQzasTOfp
         mOyKZ40jsrTXMrDj2UGm3DY+wo8ddReksSvxb/B5lGOaNhgzzpO7OvoPYKsS0XxGy6qr
         7xRg==
X-Gm-Message-State: APzg51CnXdqsN6NUPBSQCFBLErfAYvf4ze3JLfuwa8NSOAdv/6g7tiLR
        F+J9hiUHp2pWGV13wKxLe0KqVg1h
X-Google-Smtp-Source: ANB0VdbU6r7k9hR3OWV9JvpkoNmENo6A5Fsx4Ezvfrj22wcpDE9MSeuk3W9OsfWjqcfS2XvlLY3AvQ==
X-Received: by 2002:a62:23c2:: with SMTP id q63-v6mr8526257pfj.116.1536861745945;
        Thu, 13 Sep 2018 11:02:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id b64-v6sm5964267pfg.66.2018.09.13.11.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:25 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:25 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:08 GMT
Message-Id: <ef20193d59bd33a4c56e8c059ea7ddefbb6a8e72.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/11] multi-pack-index: verify object offsets
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git multi-pack-index verify' command must verify the object
offsets stored in the multi-pack-index are correct. There are two
ways the offset chunk can be incorrect: the pack-int-id and the
object offset.

Replace the BUG() statement with a die() statement, now that we
may hit a bad pack-int-id during a 'verify' command on a corrupt
multi-pack-index, and it is covered by a test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 29 ++++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 80094c02a7..47e7e6113a 100644
--- a/midx.c
+++ b/midx.c
@@ -197,7 +197,8 @@ int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
 	struct strbuf pack_name = STRBUF_INIT;
 
 	if (pack_int_id >= m->num_packs)
-		BUG("bad pack-int-id");
+		die(_("bad pack-int-id: %u (%u total packs"),
+		    pack_int_id, m->num_packs);
 
 	if (m->packs[pack_int_id])
 		return 0;
@@ -970,5 +971,31 @@ int verify_midx_file(const char *object_dir)
 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
 	}
 
+	for (i = 0; i < m->num_objects; i++) {
+		struct object_id oid;
+		struct pack_entry e;
+		off_t m_offset, p_offset;
+
+		nth_midxed_object_oid(&oid, m, i);
+		if (!fill_midx_entry(&oid, &e, m)) {
+			midx_report(_("failed to load pack entry for oid[%d] = %s"),
+				    i, oid_to_hex(&oid));
+			continue;
+		}
+
+		if (open_pack_index(e.p)) {
+			midx_report(_("failed to load pack-index for packfile %s"),
+				    e.p->pack_name);
+			break;
+		}
+
+		m_offset = e.offset;
+		p_offset = find_pack_entry_one(oid.hash, e.p);
+
+		if (m_offset != p_offset)
+			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
+				    i, oid_to_hex(&oid), m_offset, p_offset);
+	}
+
 	return verify_midx_error;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index a968b9a959..828c240389 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -176,6 +176,7 @@ test_expect_success 'verify bad signature' '
 '
 
 HASH_LEN=20
+NUM_OBJECTS=74
 MIDX_BYTE_VERSION=4
 MIDX_BYTE_OID_VERSION=5
 MIDX_BYTE_CHUNK_COUNT=6
@@ -192,6 +193,10 @@ MIDX_OID_FANOUT_WIDTH=4
 MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + 1))
 MIDX_OFFSET_OID_LOOKUP=$(($MIDX_OFFSET_OID_FANOUT + 256 * $MIDX_OID_FANOUT_WIDTH))
 MIDX_BYTE_OID_LOOKUP=$(($MIDX_OFFSET_OID_LOOKUP + 16 * $HASH_LEN))
+MIDX_OFFSET_OBJECT_OFFSETS=$(($MIDX_OFFSET_OID_LOOKUP + $NUM_OBJECTS * $HASH_LEN))
+MIDX_OFFSET_WIDTH=8
+MIDX_BYTE_PACK_INT_ID=$(($MIDX_OFFSET_OBJECT_OFFSETS + 16 * $MIDX_OFFSET_WIDTH + 2))
+MIDX_BYTE_OFFSET=$(($MIDX_OFFSET_OBJECT_OFFSETS + 16 * $MIDX_OFFSET_WIDTH + 6))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -243,6 +248,16 @@ test_expect_success 'verify oid lookup out of order' '
 		"oid lookup out of order"
 '
 
+test_expect_success 'verify incorrect pack-int-id' '
+	corrupt_midx_and_verify $MIDX_BYTE_PACK_INT_ID "\07" $objdir \
+		"bad pack-int-id"
+'
+
+test_expect_success 'verify incorrect offset' '
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\07" $objdir \
+		"incorrect object offset"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
@@ -310,4 +325,16 @@ test_expect_success 'verify multi-pack-index with 64-bit offsets' '
 	git multi-pack-index verify --object-dir=objects64
 '
 
+NUM_OBJECTS=63
+MIDX_OFFSET_OID_FANOUT=$((MIDX_OFFSET_PACKNAMES + 54))
+MIDX_OFFSET_OID_LOOKUP=$((MIDX_OFFSET_OID_FANOUT + 256 * $MIDX_OID_FANOUT_WIDTH))
+MIDX_OFFSET_OBJECT_OFFSETS=$(($MIDX_OFFSET_OID_LOOKUP + $NUM_OBJECTS * $HASH_LEN))
+MIDX_OFFSET_LARGE_OFFSETS=$(($MIDX_OFFSET_OBJECT_OFFSETS + $NUM_OBJECTS * $MIDX_OFFSET_WIDTH))
+MIDX_BYTE_LARGE_OFFSET=$(($MIDX_OFFSET_LARGE_OFFSETS + 3))
+
+test_expect_success 'verify incorrect 64-bit offset' '
+	corrupt_midx_and_verify $MIDX_BYTE_LARGE_OFFSET "\07" objects64 \
+		"incorrect object offset"
+'
+
 test_done
-- 
gitgitgadget

