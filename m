Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED11120195
	for <e@80x24.org>; Sat, 16 Jul 2016 06:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbcGPGX1 (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 02:23:27 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34151 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcGPGXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 02:23:25 -0400
Received: by mail-lf0-f42.google.com with SMTP id l69so44312675lfg.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 23:23:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6k61T87t+2RpdVP93sWIcQ7sSHMq0k8+BL7cbAIvzlA=;
        b=QM3+nyKUGg53MOiTKNAgO0FUK7QMZ28YdF715tnsy1d6buR2lIgMLV1J4sFuqVvWvq
         5mUrAA5pOwQ8kRsVQAE9sRF9PcLBZGLbp+UhXVz53GUQ4H7H6Qo3Nj8qWaBeRxv6RvGJ
         DDeWZIYjmkp5t6cyJCgqkv01fjrt2pFOcHUq1UmCLpCeDpWZKob0CSTSAbEHT+X5gF97
         crk3QLy3qy7Gg95qvHL1Lt2zpC2Uub8DIIlH7dPR3kJ8SnkUIXU88KVyRntqxYwxLKfo
         8QGqDWdKgS6sn8BM2viP9m6Hueo3TLweG1Qo6QPomT2stplbnd1iY0FThH7gXQU7WrUF
         cRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6k61T87t+2RpdVP93sWIcQ7sSHMq0k8+BL7cbAIvzlA=;
        b=hXSfd63N3DNqYyZxmdi4E0MrjaH0HfBMTXTZhR/4xyCpj59bRYbcJaU152am7Na2XR
         BTZNp6ujwix5aMicNnEf6nB0c712wYksRlw16Ymn7nQVAQvLva9EZ4ZSRIdK8EP+GBVS
         GCFsFWaZ3jRJTut24eWA3xpWj1I4pDP0K482IQ5FOCQtHui9oNmkuC+0oO41T8SlfrSH
         BeAkRRT6lDBBpPFhY5X3BIJud+xZgVoOPMerKNyQdlVSzH/pvLEHacFN0aK8x6IMtRMc
         CQIHRu9pw2L+TqPvB/xHl3A79cWzyeRs9QyTL9NtLS9HoY5kZSAzAZjzvJt149gYtat+
         Kvyw==
X-Gm-Message-State: ALyK8tIop0bU8VZQGLAZmuqd4Nx/ueIDNuy4Hrbzp0WSDm5tknntpvSuQDvYOvbBSwO2YQ==
X-Received: by 10.25.209.21 with SMTP id i21mr7321644lfg.5.1468650203684;
        Fri, 15 Jul 2016 23:23:23 -0700 (PDT)
Received: from duynguyen (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id f69sm2517171lji.19.2016.07.15.23.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2016 23:23:22 -0700 (PDT)
Date:	Sat, 16 Jul 2016 08:23:20 +0200
From:	Duy Nguyen <pclouds@gmail.com>
To:	Ben Peart <peartben@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Cc:	David Turner <novalis@novalis.org>
Subject: Re: Bug in index-helper/watchman?
Message-ID: <20160716062320.GA14007@duynguyen>
References: <009701d1dd53$72777330$57665990$@gmail.com>
 <CACsJy8D9b1U9kP4FfBerWh-q_3fEO5a3aHzSJm9V+2mW5w6YGQ@mail.gmail.com>
 <CACsJy8AiER_=5aJ65r+GPCE_nXbrPTAMKJi=FuJgT8zzV2-NFw@mail.gmail.com>
 <CACsJy8BEp2is3JEr=zj5L9uWOG2emkadxOLrZbJemjxvnzYU=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BEp2is3JEr=zj5L9uWOG2emkadxOLrZbJemjxvnzYU=g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 16, 2016 at 08:10:15AM +0200, Duy Nguyen wrote:
> But you did spot a problem. What if UC extension is loaded _after_
> watchman one? Then index->untracked_cache would have nothing in there
> and invalidation is no-op when we do it (at watchmain ext loading
> time). We can't control extension loading order (technically we can,
> but other git implementations may do it differently). So, maybe we
> should do the invalidation after _all_ index extensions have been
> loaded.
> 
> Maybe we can do it in validate_untracked_cache? We already store the
> path list in the_index.untracked->invalid_untracked.
> validate_untracked_cache has all info it needs.

The squash for "index-helper: use watchman to avoid refreshing index
with lstat()" looks something like this. I did not test it at all though.

-- 8< --
diff --git a/dir.c b/dir.c
index 024b13c..04bd87c 100644
--- a/dir.c
+++ b/dir.c
@@ -1902,6 +1902,43 @@ void remove_untracked_cache(struct index_state *istate)
 	}
 }
 
+static struct untracked_cache_dir *find_untracked_cache_dir(
+	struct untracked_cache *uc, struct untracked_cache_dir *ucd,
+	const char *name)
+{
+	int component_len;
+	const char *end;
+	struct untracked_cache_dir *dir;
+
+	if (!*name)
+		return ucd;
+
+	end = strchr(name, '/');
+	if (end)
+		component_len = end - name;
+	else
+		component_len = strlen(name);
+
+	dir = lookup_untracked(uc, ucd, name, component_len);
+	if (dir)
+		return find_untracked_cache_dir(uc, dir, name + component_len + 1);
+
+	return NULL;
+}
+
+static int mark_untracked_invalid(struct string_list_item *item, void *uc)
+{
+	struct untracked_cache *untracked = uc;
+	struct untracked_cache_dir *dir;
+
+	dir = find_untracked_cache_dir(untracked, untracked->root,
+				       item->string);
+	if (dir)
+		dir->valid = 0;
+
+	return 0;
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
@@ -1984,6 +2021,11 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/* Make sure this directory is not dropped out at saving phase */
 	root->recurse = 1;
+
+	if (dir->untracked->use_watchman) {
+		for_each_string_list(&dir->untracked->invalid_untracked,
+			 mark_untracked_invalid, dir->untracked);
+	}
 	return root;
 }
 
diff --git a/dir.h b/dir.h
index ed16746..896b64a 100644
--- a/dir.h
+++ b/dir.h
@@ -312,7 +312,4 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_cache(struct index_state *istate);
 void remove_untracked_cache(struct index_state *istate);
-struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
-					     struct untracked_cache_dir *dir,
-					     const char *name, int len);
 #endif
diff --git a/read-cache.c b/read-cache.c
index ee777c1..b90187c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1388,37 +1388,12 @@ static int verify_hdr(const struct cache_header *hdr, unsigned long size)
 	return 0;
 }
 
-static struct untracked_cache_dir *find_untracked_cache_dir(
-	struct untracked_cache *uc, struct untracked_cache_dir *ucd,
-	const char *name)
-{
-	int component_len;
-	const char *end;
-	struct untracked_cache_dir *dir;
-
-	if (!*name)
-		return ucd;
-
-	end = strchr(name, '/');
-	if (end)
-		component_len = end - name;
-	else
-		component_len = strlen(name);
-
-	dir = lookup_untracked(uc, ucd, name, component_len);
-	if (dir)
-		return find_untracked_cache_dir(uc, dir, name + component_len + 1);
-
-	return NULL;
-}
-
 static void mark_no_watchman(size_t pos, void *data)
 {
 	struct index_state *istate = data;
 	struct cache_entry *ce = istate->cache[pos];
 	struct strbuf sb = STRBUF_INIT;
 	char *c;
-	struct untracked_cache_dir *dir;
 
 	assert(pos < istate->cache_nr);
 	ce->ce_flags |= CE_WATCHMAN_DIRTY;
@@ -1438,27 +1413,11 @@ static void mark_no_watchman(size_t pos, void *data)
 	if (c == sb.buf)
 		strbuf_setlen(&sb, 0);
 
-	dir = find_untracked_cache_dir(istate->untracked,
-				       istate->untracked->root, sb.buf);
-	if (dir)
-		dir->valid = 0;
+	string_list_append(&istate->untracked->invalid_untracked, ce->name);
 
 	strbuf_release(&sb);
 }
 
-static int mark_untracked_invalid(struct string_list_item *item, void *uc)
-{
-	struct untracked_cache *untracked = uc;
-	struct untracked_cache_dir *dir;
-
-	dir = find_untracked_cache_dir(untracked, untracked->root,
-				       item->string);
-	if (dir)
-		dir->valid = 0;
-
-	return 0;
-}
-
 static int read_watchman_ext(struct index_state *istate, const void *data,
 			     unsigned long sz)
 {
@@ -1498,9 +1457,6 @@ static int read_watchman_ext(struct index_state *istate, const void *data,
 			untracked += len + 1;
 		}
 
-		for_each_string_list(&istate->untracked->invalid_untracked,
-			 mark_untracked_invalid, istate->untracked);
-
 		if (untracked_nr)
 			istate->cache_changed |= WATCHMAN_CHANGED;
 	}
-- 8< --
--
Duy
