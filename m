Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 883E71F406
	for <e@80x24.org>; Mon, 14 May 2018 16:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932082AbeENQHo (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 12:07:44 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:41044 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753557AbeENQHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 12:07:42 -0400
Received: by mail-lf0-f48.google.com with SMTP id m17-v6so13687617lfj.8
        for <git@vger.kernel.org>; Mon, 14 May 2018 09:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ke4VTUkCuvpFMToh+GVsreO6Li44rc6lxx/CcS5AHn8=;
        b=pAQqsxfxvNC+Eyv4REvob/tm+ZQgd8wQu2FoPTdajrQGSmZymE8lozmpOKhaivtHxi
         WSW2AN9qX0qGJCL7a9Kiwfv8lm6kCLyQYCc4pWEpe4z2wefM7HInp1XX9g/Bh+YPL89j
         zMQa+Hy8j2CEbvma80CAwJtNtgIiQScOyoWuIUXQI7eKMMMwuu+kUmTBVH5pgzgE/UHU
         Ysec/7iz24hYxFhP25POGVJF5v72doIbgW7Ch6pS9g+sKo21/Mv1MR8vP/PhAFKRWh4E
         su862gT1qw6Neg0cKe+zxlo7YXT8B8mHN4BxEEmTwZcMfGQiwwCRcdVdlByd6TpuR8Fe
         yfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ke4VTUkCuvpFMToh+GVsreO6Li44rc6lxx/CcS5AHn8=;
        b=WImCM8VrsX7p106iRURDNTpU5Hwpzibw4FUCc3mcgpJ7bDoEsOKVxlgGe5foA0+Vyh
         VWBIcG5d+LOeOpSBDXmVrj2h43jU4Y+WH46p8sOfWUr2oKL3m3Cre4Okth8E5FqwTBYS
         NauO+/97JfY+I6qfUdBXc1f6efytt634zI3P4Hqkb94/m4D5mBsYuqPbHdpyO71Ng8Q3
         U3giPzoz2fbrJeN5wm+4eWX6sbRfqAkSjfCpRhAeATu31YxUuH64ix8Ap1vM7e4HF4VU
         H9nXsnJpPPffS0mTP8WoEReE+9gEBl9Sw/4LqpTYnWkD9eehxPD18CFU7N5Wz2EC1TtN
         +Drg==
X-Gm-Message-State: ALKqPwea6X4r/9lcoLEsaZsDsCz5oXunOn9a4Fr7RvUv4gSlessRFDz3
        jjq7W0IkaRSAosAZbOJh/Pw=
X-Google-Smtp-Source: AB8JxZqWyHn/3iHwsYhE79l9kd5Hfkg+MHBWDIUmcMq4+2G5VgiaOt8dty4QmEe8VMHyYwC31olEmQ==
X-Received: by 2002:a19:a30c:: with SMTP id m12-v6mr5801894lfe.35.1526314061107;
        Mon, 14 May 2018 09:07:41 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u21-v6sm1575958lfi.29.2018.05.14.09.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 09:07:40 -0700 (PDT)
Date:   Mon, 14 May 2018 18:07:38 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 14/14] commit.h: delete 'util' field in struct commit
Message-ID: <20180514160738.GA19821@duynguyen.home>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
 <20180513055208.17952-15-pclouds@gmail.com>
 <xmqqy3gmbrnm.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy3gmbrnm.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 04:52:29PM +0900, Junio C Hamano wrote:
> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
> 
> > diff --git a/commit.h b/commit.h
> > index 838f6a6b26..70371e111e 100644
> > --- a/commit.h
> > +++ b/commit.h
> > @@ -18,12 +18,16 @@ struct commit_list {
> >  
> >  struct commit {
> >  	struct object object;
> > -	void *util;
> >  	unsigned int index;
> >  	timestamp_t date;
> >  	struct commit_list *parents;
> >  	struct tree *tree;
> >  	uint32_t graph_pos;
> > +	/*
> > +	 * Do not add more fields here unless it's _very_ often
> > +	 * used. Use commit-slab to associate more data with a commit
> > +	 * instead.
> > +	 */
> >  };
> 
> That's a logical consequence and a natural endgame of this
> pleasent-to-read series.  THanks.
> 
> Unfortunately we are gaining more and more stuff in "struct commit"
> with recent topics, and we may want to see if we can evict some of
> them out to shrink it again.

Sigh.. ds/lazy-load-trees already enters 'next' so a fixup patch is
something like this.

Derrick, do you want to finish up this patch? I could do that by
myself, but I guess this could be good for you to get familiar with
commit-slab because ds/generation-numbers on 'pu' also adds a new
field in struct commit.

We should avoid adding more stuff in struct commit to reduce overhead
when these fields are not used (and I'm not sure how often generation
numbers are used to justify its place here). One clean way to do it is
with commit-slab, as demonstrated here for 'maybe_tree' field.

Anyway the patch is like this

-- 8< --
diff --git a/commit-graph.c b/commit-graph.c
index 70fa1b25fd..9d084f6200 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -9,6 +9,7 @@
 #include "revision.h"
 #include "sha1-lookup.h"
 #include "commit-graph.h"
+#include "commit-slab.h"
 
 #define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
 #define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
@@ -38,6 +39,26 @@
 #define GRAPH_MIN_SIZE (5 * GRAPH_CHUNKLOOKUP_WIDTH + GRAPH_FANOUT_SIZE + \
 			GRAPH_OID_LEN + 8)
 
+
+/*
+ * If the commit is loaded from the commit-graph file, then this
+ * member may be NULL. Only access it through get_commit_tree()
+ * or get_commit_tree_oid().
+ */
+define_commit_slab(maybe_tree, struct tree *);
+struct maybe_tree maybe_trees = COMMIT_SLAB_INIT(1, maybe_trees);
+
+struct tree *set_maybe_tree(const struct commit *commit, struct tree *tree)
+{
+	*maybe_tree_at(&maybe_trees, commit) = tree;
+	return tree;
+}
+
+struct tree *get_maybe_tree(const struct commit *commit)
+{
+	return *maybe_tree_at(&maybe_trees, commit);
+}
+
 char *get_commit_graph_filename(const char *obj_dir)
 {
 	return xstrfmt("%s/info/commit-graph", obj_dir);
@@ -256,7 +277,7 @@ static int fill_commit_in_graph(struct commit *item, struct commit_graph *g, uin
 	item->object.parsed = 1;
 	item->graph_pos = pos;
 
-	item->maybe_tree = NULL;
+	set_maybe_tree(item, NULL);
 
 	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
 	date_low = get_be32(commit_data + g->hash_len + 12);
@@ -322,15 +343,15 @@ static struct tree *load_tree_for_commit(struct commit_graph *g, struct commit *
 					   GRAPH_DATA_WIDTH * (c->graph_pos);
 
 	hashcpy(oid.hash, commit_data);
-	c->maybe_tree = lookup_tree(&oid);
-
-	return c->maybe_tree;
+	return set_maybe_tree(c, lookup_tree(&oid));
 }
 
 struct tree *get_commit_tree_in_graph(const struct commit *c)
 {
-	if (c->maybe_tree)
-		return c->maybe_tree;
+	struct tree *maybe_tree = get_maybe_tree(c);
+
+	if (maybe_tree)
+		return maybe_tree;
 	if (c->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("get_commit_tree_in_graph called from non-commit-graph commit");
 
diff --git a/commit-graph.h b/commit-graph.h
index 260a468e73..4a02e4b05e 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -45,4 +45,7 @@ void write_commit_graph(const char *obj_dir,
 			int nr_commits,
 			int append);
 
+struct tree *set_maybe_tree(const struct commit *commit, struct tree *tree);
+struct tree *get_maybe_tree(const struct commit *commit);
+
 #endif
diff --git a/commit.c b/commit.c
index 711f674c18..45521ab2de 100644
--- a/commit.c
+++ b/commit.c
@@ -298,8 +298,10 @@ void free_commit_buffer(struct commit *commit)
 
 struct tree *get_commit_tree(const struct commit *commit)
 {
-	if (commit->maybe_tree || !commit->object.parsed)
-		return commit->maybe_tree;
+	struct tree *maybe_tree = get_maybe_tree(commit);
+
+	if (maybe_tree || !commit->object.parsed)
+		return maybe_tree;
 
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("commit has NULL tree, but was not loaded from commit-graph");
@@ -351,7 +353,7 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (get_sha1_hex(bufptr + 5, parent.hash) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	item->maybe_tree = lookup_tree(&parent);
+	set_maybe_tree(item, lookup_tree(&parent));
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
diff --git a/commit.h b/commit.h
index 23a3f364ed..b7274ca365 100644
--- a/commit.h
+++ b/commit.h
@@ -22,13 +22,6 @@ struct commit {
 	unsigned int index;
 	timestamp_t date;
 	struct commit_list *parents;
-
-	/*
-	 * If the commit is loaded from the commit-graph file, then this
-	 * member may be NULL. Only access it through get_commit_tree()
-	 * or get_commit_tree_oid().
-	 */
-	struct tree *maybe_tree;
 	uint32_t graph_pos;
 };
 
diff --git a/merge-recursive.c b/merge-recursive.c
index 8de6e36527..a8b5f9ca39 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -23,6 +23,7 @@
 #include "merge-recursive.h"
 #include "dir.h"
 #include "submodule.h"
+#include "commit-graph.h"
 
 struct path_hashmap_entry {
 	struct hashmap_entry e;
@@ -101,7 +102,7 @@ static struct commit *make_virtual_commit(struct tree *tree, const char *comment
 	struct commit *commit = alloc_commit_node();
 
 	set_merge_remote_desc(commit, comment, (struct object *)commit);
-	commit->maybe_tree = tree;
+	set_maybe_tree(commit, tree);
 	commit->object.parsed = 1;
 	return commit;
 }
-- 8< --


