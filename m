Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47891F597
	for <e@80x24.org>; Fri, 27 Jul 2018 15:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbeG0RFP (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:05:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44827 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731160AbeG0RFP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:05:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so4794777ljq.11
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VB3UZSd/7dn6R2TbwXsxFw4OpTpWhfdY58/YCv/FCFQ=;
        b=rRR4z8nPysZDqZn6GbrnUoTB0aHgGLMRvJdVSFGLwnZubMvo/4uascblvY8sLxkwzU
         hIcszfGSaS6F7CjOLRXzOLOQlhO7LKw7DJdAy2oG4hVK79hQqGtbBgyLr6GVhkfqQ859
         1AeW3nUSGhUMFWEmFFpc3myFaQ5n8qoAzqjtGs/aHweHXmDssjMQojZ3KGMB45/L3gRL
         0oBjC+zvCdgBb5eU8p8ZvWPBp0/KImzMpfzjF40n2Ca44S2RhWKMJMfp4oBgAvnBBth7
         lT84NP6GWs/sMU2pvOeAhd6QY5c69xbUmLC6cJ/zv6on3wgAzL/ilFdLQUBpX051AfPz
         UGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VB3UZSd/7dn6R2TbwXsxFw4OpTpWhfdY58/YCv/FCFQ=;
        b=Ospw8CcDRyojKf0d+15muVaqG0DACWGMRd3B/FbwiZg2TzeBCJL1O58yUBImJAK7UU
         Db5IwRFh5xQLweVMuubKO9F8A+NQlMYzPWSeCIHD+qUrRBa7mzC65W8fFBG75EUp+ROB
         1GztF7hzEAp2PpUJhKELAM0xmsXWE8HvKpME9gkdTxNdv8g2eQk6D9aCUHoztzNr2ecx
         i4C3U690AWBBkJ3D4gU+YKqIcXLbKSl5R3oHaIcQhtKyIeOiSlP0l1MC0AFAGOv/Nqbp
         XSasQPrIBpnMxRKdv/IZfb2w5z5Wa+WJUo9zStVK3AweTraD2ZZM3PxgK6Ak5v8YxAAt
         5C6w==
X-Gm-Message-State: AOUpUlHY5nZPB5CY4+Z8A9aGp861j7pGA67OcmhjHacL/F6/i6isTYLJ
        hQKtUZHaD7liAqaokm1+TB4=
X-Google-Smtp-Source: AAOMgpfoVFMCKgV/8Ip/CiEBnNCv+wcRPZ/5XGqROdNBuFUAZzNG+XTs53Zqt2Xfz9hNkjPwwIXnCQ==
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr5185532lje.70.1532706165052;
        Fri, 27 Jul 2018 08:42:45 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x65-v6sm576089lfa.77.2018.07.27.08.42.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 08:42:43 -0700 (PDT)
Date:   Fri, 27 Jul 2018 17:42:41 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Ben Peart <peartben@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
Message-ID: <20180727154241.GA21288@duynguyen.home>
References: <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
 <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
 <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
 <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
 <20180726163049.GA15572@duynguyen.home>
 <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 26, 2018 at 12:40:05PM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > I'm excited so I decided to try out anyway. This is what I've come up
> > with. Switching trees on git.git shows it could skip plenty entries,
> > so promising. It's ugly and it fails at t6020 though, there's still
> > work ahead. But I think it'll stop here.
> 
> We are extremely shallow compared to projects like the kernel and
> stuff from java land, so that is quite an interesting find.
> 

Yeah. I've got a more or less complete patch now with full test suite
passed and even with linux.git, the numbers look pretty good.

Ben, is it possible for you to try this one out? I don't suppose it
will be that good on a real big repo. But I'm curious how much faster
could this patch does.

I'm quite happy that I don't have to make specific code for twoway
merge, which means this patch would also help real merges (3way)
too. Interestingly this also helps reduce traverse_trees() when
diff_index_cached optimization is on. I have no idea how but
well.. can't complain.

-- 8< --
Subject: [PATCH] unpack-trees: optimize walking same trees with cache-tree

In order to merge one or many trees with the index, unpack-trees code
walk multiple trees in parallel with the index and perform n-way
merge. If we find out at start of a directory that all trees are the
same (by comparing OID) and cache-tree happens to be available for
that directory as well, we could avoid walking the trees.

One nice attribute of cache-tree (and the index) is that the tree is
only flattened (and it's called "the index") and we know how many
files that directory has. With this information, we could avoid
accessing object database to walk tree objects and just take the
entries from the index instead.

The upside is of course a lot less I/O since we can potentially skip
lots of trees (think subtrees). We also save CPU because we don't have
to inflate and the apply deltas. The downside is of course more
fragile code since the logic in some functions are now duplicated
elsewhere.

WIth this patch, switching between two trees on linux.git where
there's only one file changed (toplevel Makefile) seems sped up pretty
good. Total checkout time goes down from 0.543 to 0.352 (35%).
traverse_trees() one twoway merge (the big one in unpack_trees()) goes
from 0.157s to 0.036 (70%).

Note that compared to diff_index_cached optimization (which is very
similar to this) we do more work here. This is because diff_index_cached
only cares about side effect, it does not modify the index, so we can
quickly jump through a big chunk of cache entries. For n-way merge, we
need to add entries and verify stuff, so more CPU cycles.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 66741130ae..9c791b55b2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -642,6 +642,110 @@ static inline int are_same_oid(struct name_entry *name_j, struct name_entry *nam
 	return name_j->oid && name_k->oid && !oidcmp(name_j->oid, name_k->oid);
 }
 
+static int all_trees_same_as_cache_tree(int n, unsigned long dirmask,
+					struct name_entry *names,
+					struct traverse_info *info)
+{
+	struct unpack_trees_options *o = info->data;
+	int i;
+
+	if (dirmask != ((1 << n) - 1) || !S_ISDIR(names->mode) || !o->merge)
+		return 0;
+
+	for (i = 1; i < n; i++)
+		if (!are_same_oid(names, names + i))
+			return 0;
+
+	return cache_tree_matches_traversal(o->src_index->cache_tree, names, info);
+}
+
+/*
+ * Fast path if we detect that all trees are the same as cache-tree at this
+ * path. We'll walk these trees recursively using cache-tree/index instead of
+ * ODB since already know what these trees contain.
+ */
+static int traverse_by_cache_tree(int pos, int nr_entries, int nr_names,
+				  struct name_entry *names,
+				  struct traverse_info *info)
+{
+	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
+	struct unpack_trees_options *o = info->data;
+	int i, d;
+
+	/*
+	 * Do what unpack_callback() and unpack_nondirectories() normally
+	 * do. But we do it in one function call (for even nested trees)
+	 * instead.
+	 *
+	 * D/F conflicts and staged entries are not a concern because cache-tree
+	 * would be invalidated and we would never get here in the first place.
+	 */
+	for (i = 0; i < nr_entries; i++) {
+		struct cache_entry *tree_ce;
+		int len, rc;
+
+		src[0] = o->src_index->cache[pos + i];
+
+		/* Do what unpack_nondirectories() normally does */
+		len = ce_namelen(src[0]);
+		tree_ce = xcalloc(1, cache_entry_size(len));
+
+		tree_ce->ce_mode = src[0]->ce_mode;
+		tree_ce->ce_flags = create_ce_flags(0);
+		tree_ce->ce_namelen = len;
+		oidcpy(&tree_ce->oid, &src[0]->oid);
+		memcpy(tree_ce->name, src[0]->name, len + 1);
+
+		for (d = 1; d <= nr_names; d++)
+			src[d] = tree_ce;
+
+		rc = call_unpack_fn((const struct cache_entry * const *)src, o);
+		free(tree_ce);
+		if (rc < 0)
+			return rc;
+
+		mark_ce_used(src[0], o);
+	}
+	trace_printf("Quick traverse over %d entries from %s to %s\n",
+		     nr_entries,
+		     o->src_index->cache[pos]->name,
+		     o->src_index->cache[pos + nr_entries - 1]->name);
+	return 0;
+}
+
+static int index_pos_by_traverse_info(struct name_entry *names,
+				      struct traverse_info *info)
+{
+	struct unpack_trees_options *o = info->data;
+	int len = traverse_path_len(info, names);
+	char *name = xmalloc(len + 1);
+	int pos;
+
+	make_traverse_path(name, info, names);
+	pos = index_name_pos(o->src_index, name, len);
+	if (pos >= 0)
+		BUG("This is so wrong. This is a directory and should not exist in index");
+	pos = -pos - 1;
+	/*
+	 * There's no guarantee that pos points to the first entry of the
+	 * directory. If the directory name is "letters" and there's another
+	 * file named "letters.txt" in the index, pos will point to that file
+	 * instead.
+	 */
+	while (pos < o->src_index->cache_nr) {
+		const struct cache_entry *ce = o->src_index->cache[pos];
+		if (ce_namelen(ce) > len &&
+		    ce->name[len] == '/' &&
+		    !memcmp(ce->name, name, len))
+			break;
+		pos++;
+	}
+	if (pos == o->src_index->cache_nr)
+		BUG("This is still wrong");
+	free(name);
+	return pos;
+}
+
 static int traverse_trees_recursive(int n, unsigned long dirmask,
 				    unsigned long df_conflicts,
 				    struct name_entry *names,
@@ -653,6 +757,17 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	void *buf[MAX_UNPACK_TREES];
 	struct traverse_info newinfo;
 	struct name_entry *p;
+	int nr_entries;
+
+	nr_entries = all_trees_same_as_cache_tree(n, dirmask, names, info);
+	if (nr_entries > 0) {
+		struct unpack_trees_options *o = info->data;
+		int pos = index_pos_by_traverse_info(names, info);
+
+		if (!o->merge || df_conflicts)
+			BUG("Wrong condition to get here buddy");
+		return traverse_by_cache_tree(pos, nr_entries, n, names, info);
+	}
 
 	p = names;
 	while (!p->mode)
@@ -812,6 +927,11 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info, con
 	return ce;
 }
 
+/*
+ * Note that traverse_by_cache_tree() duplicates some logic in this funciton
+ * without actually calling it. If you change the logic here you may need to
+ * check and change there as well.
+ */
 static int unpack_nondirectories(int n, unsigned long mask,
 				 unsigned long dirmask,
 				 struct cache_entry **src,
@@ -996,6 +1116,11 @@ static void debug_unpack_callback(int n,
 		debug_name_entry(i, names + i);
 }
 
+/*
+ * Note that traverse_by_cache_tree() duplicates some logic in this funciton
+ * without actually calling it. If you change the logic here you may need to
+ * check and change there as well.
+ */
 static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, struct name_entry *names, struct traverse_info *info)
 {
 	struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
-- 
2.18.0.656.gda699b98b3

-- 8< --
--
Duy
