Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999AF1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeIMXMy (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:12:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41219 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeIMXMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so2944074plr.8
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YeLw3biOgOq52i3OgPpQIGpkbspl7dTR0sgQ8lB65nY=;
        b=RR2s1zY/uUh3JaUzQ+l9wrb8mHsNty28ag4jfOyEfhwnxkr/JHjyuK+9t+7We/tePA
         HUziFGxwFfvief/Se0nbaI0aoqrrr6pI/ftFxPVTPELuWd7jyG4fTMcbK2+fWwEd2syZ
         bV9qtVHZ5bYoDJK3P3l22402bNHhp0ywQY8/w7fwwuykDEQ28rUFSwPape/Cj7h7l9Xs
         dOUVVblTuc4MmIB7CeIDKCzymZWoaak11a2xbv1zCpTHwsnWDUvLdKypFpLdyErJVES7
         4Ez23TqEMzeNOySgwkF+OkDjFEVJ7VC1t2gf28R5c2nPx0IkA368hLCkq2nUnPprxW5p
         WUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YeLw3biOgOq52i3OgPpQIGpkbspl7dTR0sgQ8lB65nY=;
        b=W+vKXYOL8jwAK9DP05yjJFJyORzw0/kNaPUM1vONpdMr5BV8PIQot6oqjEgtJGiuhI
         9gA4c7PJA2VkW42lV3q01p+0Catv9eFn/onaPMuLnO5oCehXx7bCR0MRSbO+gRQPxcID
         dJ5fekt3+V4FBybZ2UfPMA3xNgLs6vbVij1oY6Tn1I6dV+1fyyfoWHnkRj3L6jumwDt0
         7pftrBeLjI/sfg5RO4yK+N8VrENsq3umouSVNMwooESs1iI4Afhi29szFS6lhIh/Wudy
         fVEXVAIpI690bjQLnkHKGjolA/qiZN3whllTsCqKMG8Unv+5cJtqUkZqekfhB/ZuuJxS
         k3AQ==
X-Gm-Message-State: APzg51B6Mgh7EpG0ng7tC1sPz9OUJyLFdknuQjCu3eN/DltiGyTKGt/C
        eOFyTd/5IqM3yxxv2mzK2LbypKWo
X-Google-Smtp-Source: ANB0VdYrbAYs9aMflpI4lAlFQZ2FlaNhJMAFCoXQlMY+ejVP7X3IXchTXvUDoPGeoB5HIYTk2vvKXQ==
X-Received: by 2002:a17:902:bccb:: with SMTP id o11-v6mr8268646pls.167.1536861738922;
        Thu, 13 Sep 2018 11:02:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 9-v6sm9366879pfc.20.2018.09.13.11.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:18 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:18 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:03 GMT
Message-Id: <947241bfdcc93223ea50a6721cbac2b435ca6b2e.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/11] multi-pack-index: verify packname order
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

The final check we make while loading a multi-pack-index is that
the packfile names are in lexicographical order. Make this error
be a die() instead.

In order to test this condition, we need multiple packfiles.
Earlier in t5319-multi-pack-index.sh, we tested the interaction with
'git repack' but this limits us to one packfile in our object dir.
Move these repack tests until after the 'verify' tests.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      |  6 ++----
 t/t5319-multi-pack-index.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 8b054b39ab..e655a15aed 100644
--- a/midx.c
+++ b/midx.c
@@ -157,12 +157,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 		cur_pack_name += strlen(cur_pack_name) + 1;
 
-		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0) {
-			error(_("multi-pack-index pack names out of order: '%s' before '%s'"),
+		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0)
+			die(_("multi-pack-index pack names out of order: '%s' before '%s'"),
 			      m->pack_names[i - 1],
 			      m->pack_names[i]);
-			goto cleanup_fail;
-		}
 	}
 
 	return m;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index c54b6e7188..01a3cd6b00 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -181,6 +181,11 @@ MIDX_BYTE_CHUNK_COUNT=6
 MIDX_HEADER_SIZE=12
 MIDX_BYTE_CHUNK_ID=$MIDX_HEADER_SIZE
 MIDX_BYTE_CHUNK_OFFSET=$(($MIDX_HEADER_SIZE + 4))
+MIDX_NUM_CHUNKS=5
+MIDX_CHUNK_LOOKUP_WIDTH=12
+MIDX_OFFSET_PACKNAMES=$(($MIDX_HEADER_SIZE + \
+			 $MIDX_NUM_CHUNKS * $MIDX_CHUNK_LOOKUP_WIDTH))
+MIDX_BYTE_PACKNAME_ORDER=$(($MIDX_OFFSET_PACKNAMES + 2))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -212,6 +217,11 @@ test_expect_success 'verify invalid chunk offset' '
 		"invalid chunk offset (too large)"
 '
 
+test_expect_success 'verify packnames out of order' '
+	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "z" $objdir \
+		"pack names out of order"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget

