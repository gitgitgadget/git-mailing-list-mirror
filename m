From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 1/2] symlinks: remove PATH_MAX limitation
Date: Sat, 05 Jul 2014 00:41:46 +0200
Message-ID: <53B72DAA.5050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBKG33SOQKGQEWEPAFXQ@googlegroups.com Sat Jul 05 00:41:46 2014
Return-path: <msysgit+bncBCH3XYXLXQDBBKG33SOQKGQEWEPAFXQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f192.google.com ([209.85.212.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBKG33SOQKGQEWEPAFXQ@googlegroups.com>)
	id 1X3CAs-00056A-0W
	for gcvm-msysgit@m.gmane.org; Sat, 05 Jul 2014 00:41:46 +0200
Received: by mail-wi0-f192.google.com with SMTP id n3sf413911wiv.19
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Jul 2014 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=MHpbThGfozXhmRIfscTKlMQDGqbs4HbvaSrPR3RsyqQ=;
        b=QrvEn83OHH06zvl3XSf8CpZaSFnM9Vb0j4fFhO8bqUJUn0U5rWLK+Qdsy20p71MJge
         iYru58pB/6eBnrCMI2LmG/Uvs8QzTZIkwvnpzWFRtniqWKMZUWF7hVIsyKc0L4llA6Wp
         mZWK6zVEYy/C2QSq5h5D4b0S5YbW6a5dzmV8i6J9fpfNQaZ7rJXOjpVHkfG/xliXHV/u
         czn7agG6BfupE0qEDs6OXzyyAB/3TYJukaT4EaiTAR2iDbuBeFYZ87kLNSFzzW+BELUm
         BVmtzo8XN3vC1CtdWMJ6NQeNh9R2CEDCBwt6DLi/9Y5yy+DMLWU+jtaaNfMW7J/ls+7X
         xTKw==
X-Received: by 10.180.87.9 with SMTP id t9mr13070wiz.7.1404513705599;
        Fri, 04 Jul 2014 15:41:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.76.198 with SMTP id m6ls377722wiw.34.gmail; Fri, 04 Jul
 2014 15:41:44 -0700 (PDT)
X-Received: by 10.180.185.70 with SMTP id fa6mr2223567wic.3.1404513704541;
        Fri, 04 Jul 2014 15:41:44 -0700 (PDT)
Received: from mail-we0-x22d.google.com (mail-we0-x22d.google.com [2a00:1450:400c:c03::22d])
        by gmr-mx.google.com with ESMTPS id gc5si1433960wic.1.2014.07.04.15.41.44
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 15:41:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22d as permitted sender) client-ip=2a00:1450:400c:c03::22d;
Received: by mail-we0-f173.google.com with SMTP id t60so2165762wes.18
        for <msysgit@googlegroups.com>; Fri, 04 Jul 2014 15:41:44 -0700 (PDT)
X-Received: by 10.194.82.198 with SMTP id k6mr15245902wjy.10.1404513704419;
        Fri, 04 Jul 2014 15:41:44 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id i4sm84002413wib.21.2014.07.04.15.41.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 04 Jul 2014 15:41:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c03::22d
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252904>

'git checkout' fails if a directory is longer than PATH_MAX, because the
lstat_cache in symlinks.c checks if the leading directory exists using
PATH_MAX-bounded string operations.

Remove the limitation by using strbuf instead.

Signed-off-by: Karsten Blees <blees@dcon.de>
---

This fixes a bug on Windows with long paths [1].

[1] https://github.com/msysgit/msysgit/issues/227

 cache.h         |  8 ++++++--
 preload-index.c |  4 ++--
 symlinks.c      | 63 +++++++++++++++++++++++++--------------------------------
 3 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/cache.h b/cache.h
index df65231..44aa439 100644
--- a/cache.h
+++ b/cache.h
@@ -1090,12 +1090,16 @@ struct checkout {
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 
 struct cache_def {
-	char path[PATH_MAX + 1];
-	int len;
+	struct strbuf path;
 	int flags;
 	int track_flags;
 	int prefix_len_stat_func;
 };
+#define CACHE_DEF_INIT { STRBUF_INIT, 0, 0, 0 }
+static inline void cache_def_free(struct cache_def *cache)
+{
+	strbuf_release(&cache->path);
+}
 
 extern int has_symlink_leading_path(const char *name, int len);
 extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
diff --git a/preload-index.c b/preload-index.c
index 968ee25..79ce8a9 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -37,9 +37,8 @@ static void *preload_thread(void *_data)
 	struct thread_data *p = _data;
 	struct index_state *index = p->index;
 	struct cache_entry **cep = index->cache + p->offset;
-	struct cache_def cache;
+	struct cache_def cache = CACHE_DEF_INIT;
 
-	memset(&cache, 0, sizeof(cache));
 	nr = p->nr;
 	if (nr + p->offset > index->cache_nr)
 		nr = index->cache_nr - p->offset;
@@ -64,6 +63,7 @@ static void *preload_thread(void *_data)
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
+	cache_def_free(&cache);
 	return NULL;
 }
 
diff --git a/symlinks.c b/symlinks.c
index c2b41a8..5261e8c 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -35,12 +35,11 @@ static int longest_path_match(const char *name_a, int len_a,
 	return match_len;
 }
 
-static struct cache_def default_cache;
+static struct cache_def default_cache = CACHE_DEF_INIT;
 
 static inline void reset_lstat_cache(struct cache_def *cache)
 {
-	cache->path[0] = '\0';
-	cache->len = 0;
+	strbuf_reset(&cache->path);
 	cache->flags = 0;
 	/*
 	 * The track_flags and prefix_len_stat_func members is only
@@ -73,7 +72,7 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 				int prefix_len_stat_func)
 {
 	int match_len, last_slash, last_slash_dir, previous_slash;
-	int save_flags, max_len, ret;
+	int save_flags, ret;
 	struct stat st;
 
 	if (cache->track_flags != track_flags ||
@@ -93,14 +92,14 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 		 * the 2 "excluding" path types.
 		 */
 		match_len = last_slash =
-			longest_path_match(name, len, cache->path, cache->len,
-					   &previous_slash);
+			longest_path_match(name, len, cache->path.buf,
+					   cache->path.len, &previous_slash);
 		*ret_flags = cache->flags & track_flags & (FL_NOENT|FL_SYMLINK);
 
 		if (!(track_flags & FL_FULLPATH) && match_len == len)
 			match_len = last_slash = previous_slash;
 
-		if (*ret_flags && match_len == cache->len)
+		if (*ret_flags && match_len == cache->path.len)
 			return match_len;
 		/*
 		 * If we now have match_len > 0, we would know that
@@ -121,21 +120,22 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 	 */
 	*ret_flags = FL_DIR;
 	last_slash_dir = last_slash;
-	max_len = len < PATH_MAX ? len : PATH_MAX;
-	while (match_len < max_len) {
+	if (len > cache->path.len)
+		strbuf_grow(&cache->path, len - cache->path.len);
+	while (match_len < len) {
 		do {
-			cache->path[match_len] = name[match_len];
+			cache->path.buf[match_len] = name[match_len];
 			match_len++;
-		} while (match_len < max_len && name[match_len] != '/');
-		if (match_len >= max_len && !(track_flags & FL_FULLPATH))
+		} while (match_len < len && name[match_len] != '/');
+		if (match_len >= len && !(track_flags & FL_FULLPATH))
 			break;
 		last_slash = match_len;
-		cache->path[last_slash] = '\0';
+		cache->path.buf[last_slash] = '\0';
 
 		if (last_slash <= prefix_len_stat_func)
-			ret = stat(cache->path, &st);
+			ret = stat(cache->path.buf, &st);
 		else
-			ret = lstat(cache->path, &st);
+			ret = lstat(cache->path.buf, &st);
 
 		if (ret) {
 			*ret_flags = FL_LSTATERR;
@@ -158,12 +158,11 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 	 * for the moment!
 	 */
 	save_flags = *ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
-	if (save_flags && last_slash > 0 && last_slash <= PATH_MAX) {
-		cache->path[last_slash] = '\0';
-		cache->len = last_slash;
+	if (save_flags && last_slash > 0) {
+		cache->path.buf[last_slash] = '\0';
+		cache->path.len = last_slash;
 		cache->flags = save_flags;
-	} else if ((track_flags & FL_DIR) &&
-		   last_slash_dir > 0 && last_slash_dir <= PATH_MAX) {
+	} else if ((track_flags & FL_DIR) && last_slash_dir > 0) {
 		/*
 		 * We have a separate test for the directory case,
 		 * since it could be that we have found a symlink or a
@@ -175,8 +174,8 @@ static int lstat_cache_matchlen(struct cache_def *cache,
 		 * can still cache the path components before the last
 		 * one (the found symlink or non-existing component).
 		 */
-		cache->path[last_slash_dir] = '\0';
-		cache->len = last_slash_dir;
+		cache->path.buf[last_slash_dir] = '\0';
+		cache->path.len = last_slash_dir;
 		cache->flags = FL_DIR;
 	} else {
 		reset_lstat_cache(cache);
@@ -273,21 +272,18 @@ static int threaded_has_dirs_only_path(struct cache_def *cache, const char *name
 		FL_DIR;
 }
 
-static struct removal_def {
-	char path[PATH_MAX];
-	int len;
-} removal;
+static struct strbuf removal = STRBUF_INIT;
 
 static void do_remove_scheduled_dirs(int new_len)
 {
 	while (removal.len > new_len) {
-		removal.path[removal.len] = '\0';
-		if (rmdir(removal.path))
+		removal.buf[removal.len] = '\0';
+		if (rmdir(removal.buf))
 			break;
 		do {
 			removal.len--;
 		} while (removal.len > new_len &&
-			 removal.path[removal.len] != '/');
+			 removal.buf[removal.len] != '/');
 	}
 	removal.len = new_len;
 }
@@ -297,7 +293,7 @@ void schedule_dir_for_removal(const char *name, int len)
 	int match_len, last_slash, i, previous_slash;
 
 	match_len = last_slash = i =
-		longest_path_match(name, len, removal.path, removal.len,
+		longest_path_match(name, len, removal.buf, removal.len,
 				   &previous_slash);
 	/* Find last slash inside 'name' */
 	while (i < len) {
@@ -317,11 +313,8 @@ void schedule_dir_for_removal(const char *name, int len)
 	 * If we go deeper down the directory tree, we only need to
 	 * save the new path components as we go down.
 	 */
-	if (match_len < last_slash) {
-		memcpy(&removal.path[match_len], &name[match_len],
-		       last_slash - match_len);
-		removal.len = last_slash;
-	}
+	if (match_len < last_slash)
+		strbuf_add(&removal, &name[match_len], last_slash - match_len);
 }
 
 void remove_scheduled_dirs(void)
-- 
1.9.4.msysgit.0.5.g1471ac1

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
