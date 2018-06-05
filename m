Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195D41F517
	for <e@80x24.org>; Tue,  5 Jun 2018 15:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeFEPnt (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 11:43:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35407 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeFEPnr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 11:43:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id y72-v6so4337513lfd.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOa45CIaA0qk2o07Rcd3kMsTAlRHFIokT0everD6Krg=;
        b=QqTeecXi8mdoVa7vYN0j50p4PsHpoxGNFVUrff/mAyKcXTYdw2VjFKkaTlhQon+Dc1
         YZIDWpV8IMXlg012TjXpnJ6lrEDBbQe4nrkVulI2hk9CXZDkBcpcRrJ9gT1Ru6F9Y6BP
         NU6HJ0de/+MV6yx544shcR0OK0ZFvNfS9d5iUIMD9TVVQqUnoNP6TJ9liOqVdcGNPm7C
         PvDY0G3U0W0clYWVAK54qbibbjmQERRWU4kC5Lpgl1uum0uRnVEWDaz6YFs4DXS8n31M
         +2D60SSAQyjOIGmzoV6zq5RPCkRt+KOqPNm6wAo9EcudwGG3N8F8wvxgAw+qDNdcfSb+
         Xing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOa45CIaA0qk2o07Rcd3kMsTAlRHFIokT0everD6Krg=;
        b=epjWf+iU0r3KKALIOKqWIW+ekeRmjaNMPnDuqj2CqD1p/MgT4TZTYtR6ccI/YeHg4s
         QlH2TDpRghcfjliIbJr3fq+R2VVE0XNHSLil5zhOeOzoRkaUrYTYPtaT2OGVcs2kdMXG
         7BmA8pEsXRK6seqUIpmG1HUJTzJVq1vRDgEBbSPdcmYHU8jUEkrRIjqGNOGnlQgJ1Bwg
         nnC/WRz4YJVrzzQVwHDu+114SaCl92hJEkyIYJOzlwRM1VUpMPiZn5zZaT5MqX3i3Pe5
         knTq8f7F8YkkCPnW6LNARC6AoWXc6AA3oHEi2pmiXA4Y5JLA4PqSwya3vsEyzGY0TuS6
         kOTA==
X-Gm-Message-State: APt69E0bm3Egf4Z8uIZdSVJI19bM2a2csg0V5sxhAUZqtCqzAUtzstYi
        QUkBXi+IamX024LVfCbSYfYCyg==
X-Google-Smtp-Source: ADUXVKKGw5DZvX2O0S0BbgnxB7FsriFtffUkkX+OyKRYT4EU9jDJ0WSMC6fwSNF1UMQCdfRuVoa+vA==
X-Received: by 2002:a19:d744:: with SMTP id o65-v6mr1943205lfg.124.1528213425441;
        Tue, 05 Jun 2018 08:43:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o9-v6sm5161054lfk.2.2018.06.05.08.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 08:43:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/6] unpack-tress: convert clear_ce_flags* to avoid the_index
Date:   Tue,  5 Jun 2018 17:43:32 +0200
Message-Id: <20180605154334.22613-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180605154334.22613-1-pclouds@gmail.com>
References: <20180601161153.15192-1-pclouds@gmail.com>
 <20180605154334.22613-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to fba92be8f7, this code implicitly (and incorrectly) assumes
the_index when running the exclude machinery. fba92be8f7 helps show
this problem clearer because unpack-trees operation is supposed to
work on whatever index the caller specifies... not specifically
the_index.

Update the code to use "istate" argument that's originally from
mark_new_skip_worktree(). From the call sites, both in unpack_trees(),
you can see that this function works on two separate indexes:
o->src_index and o->result. The second mark_new_skip_worktree() so far
has incorecctly applied exclude rules on o->src_index instead of
o->result. It's unclear what is the consequences of this, but it's
definitely wrong.

[1] fba92be8f7 (dir: convert is_excluded_from_list to take an index -
    2017-05-05)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 60d1138e08..5268de7af5 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1085,13 +1085,15 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	return mask;
 }
 
-static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+static int clear_ce_flags_1(struct index_state *istate,
+			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval);
 
 /* Whole directory matching */
-static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
+static int clear_ce_flags_dir(struct index_state *istate,
+			      struct cache_entry **cache, int nr,
 			      struct strbuf *prefix,
 			      char *basename,
 			      int select_mask, int clear_mask,
@@ -1100,7 +1102,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
 	int ret = is_excluded_from_list(prefix->buf, prefix->len,
-					basename, &dtype, el, &the_index);
+					basename, &dtype, el, istate);
 	int rc;
 
 	strbuf_addch(prefix, '/');
@@ -1122,7 +1124,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	 * calling clear_ce_flags_1(). That function will call
 	 * the expensive is_excluded_from_list() on every entry.
 	 */
-	rc = clear_ce_flags_1(cache, cache_end - cache,
+	rc = clear_ce_flags_1(istate, cache, cache_end - cache,
 			      prefix,
 			      select_mask, clear_mask,
 			      el, ret);
@@ -1145,7 +1147,8 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
  *   cache[0]->name[0..(prefix_len-1)]
  * Top level path has prefix_len zero.
  */
-static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+static int clear_ce_flags_1(struct index_state *istate,
+			    struct cache_entry **cache, int nr,
 			    struct strbuf *prefix,
 			    int select_mask, int clear_mask,
 			    struct exclude_list *el, int defval)
@@ -1179,7 +1182,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			len = slash - name;
 			strbuf_add(prefix, name, len);
 
-			processed = clear_ce_flags_dir(cache, cache_end - cache,
+			processed = clear_ce_flags_dir(istate, cache, cache_end - cache,
 						       prefix,
 						       prefix->buf + prefix->len - len,
 						       select_mask, clear_mask,
@@ -1193,7 +1196,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 			}
 
 			strbuf_addch(prefix, '/');
-			cache += clear_ce_flags_1(cache, cache_end - cache,
+			cache += clear_ce_flags_1(istate, cache, cache_end - cache,
 						  prefix,
 						  select_mask, clear_mask, el, defval);
 			strbuf_setlen(prefix, prefix->len - len - 1);
@@ -1203,7 +1206,7 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
 		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
-					    name, &dtype, el, &the_index);
+					    name, &dtype, el, istate);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
@@ -1213,15 +1216,17 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 	return nr - (cache_end - cache);
 }
 
-static int clear_ce_flags(struct cache_entry **cache, int nr,
-			    int select_mask, int clear_mask,
-			    struct exclude_list *el)
+static int clear_ce_flags(struct index_state *istate,
+			  int select_mask, int clear_mask,
+			  struct exclude_list *el)
 {
 	static struct strbuf prefix = STRBUF_INIT;
 
 	strbuf_reset(&prefix);
 
-	return clear_ce_flags_1(cache, nr,
+	return clear_ce_flags_1(istate,
+				istate->cache,
+				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				el, 0);
-- 
2.18.0.rc0.333.g22e6ee6cdf

