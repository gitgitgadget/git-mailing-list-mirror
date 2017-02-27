Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97C11F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 21:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbdB0Vd6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 16:33:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:57458 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdB0VdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 16:33:19 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M0cs6-1cSRNS2u46-00urYY; Mon, 27
 Feb 2017 22:31:33 +0100
Date:   Mon, 27 Feb 2017 22:31:31 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] Introduce a new "printf format" for timestamps
In-Reply-To: <cover.1488231002.git.johannes.schindelin@gmx.de>
Message-ID: <f4ff525dda1964dd0e7cef1d0507e1f2403469e1.1488231002.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AC41PpngrvV5f2hzJnMAbg4rss9K1xDoTVw4XaFShX4Hi/m6UEe
 1/rE6mIxR8g+DxKOIA6tDAaQfqYRIZgopCO7O5RDIkVs8l5dkKIKdQB7rXGLdQ1/vHL21t0
 2TWw82keF5KQX6NsSDOf7PzTDmSkfjXTUzzjTr3fhPzLlfrf+yvWHd7q5MZXaIFw7+H/Ln1
 je59/D4jKYIk1nBO16m3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eds6zDCB8E4=:X/px6nN1Cmvn5N4az2ESLj
 ENoWahRDrOMq9UAyXE15933tJZDl0YafTCbDNbRz+wtzAAWw6T8CI2GDOIy22ImLHsLUyYROh
 8QQ9dcISnL/2JP7a+UajN4seXIk4y3EYDNHFJlbqgCvu8C/NWt+IrUR0pq52RIyhTHbBkNU0W
 0JMR3wO7zzh8Xkzla1eHtD3AIudIB/+8TcDyn/pBD4bOnsDfnHS/1UbpcYYWcvuIVOkcSc9Xa
 cZU/ixyPLiE31JziwN5HieMV3jlXLIs9b0fVY4MhYkR2bL9IhNysh3X0ml8S/WMO/QTTUM8aZ
 l0ubUaAUcr8vHsjTU/JB6v0b+OGoXlBtqKmZJ/Ezu63vsKGTx+rqR6D3i70h5lNn5TePcfmGT
 XNxLoBKCOi21R3Pcg/nnkv0r5d436W+u+WE2Jxd23/iVedL2/Kl5JIHQ862zXr4uAUg+933IG
 J7Tel3ZoGB3KR+z6MPoutwSWUkPR6yAZqA8+ZFrODcQ37/2F/nsSp+NREp2tcFK7DGfPvPtQ/
 j3lENwbxwWXxdHNb3mAuH00T/hf2YvfggGF7BrOUlMfqh8RxdZVX0OgmfUTPKsyYUct5Y7gba
 aN1fnKLpGpEN1xh5XFBqiEybvl/+qlu0hlX3gTIUBI6b8xJflyb8tBj+930fM4xnj/kYXS9T7
 sCX7XnlZ2oG1JGYI5ii+FxH6xkpdr4KzLztenL0wDVAdeZx5wSwP1NYev6zvJ6M4WflwAqkKg
 SoYpl3B0yTyOMUcKpfzXpIfVXeOyQdwdOTCxmKFzisJ1jox+TWqyYf5/6nagbNnzb7Xwkun6y
 fUwShyUY00NrKp5Xnhr0rI8gu7RJXIUdOqsKjcDkrrrcpNsL7aqC5wGVXxQYmKrZr3ePusYmS
 9Z5navNzOkssXGmVhvI9WVE3CW6/44+rHJBOjvDe7QCNnxBv1sT/4ryyFcbGT0Y5KJcmYcQI9
 /OhPtSq14xuSlXMEJvPqmAF+7CC2ew2+IycXT3fwnU8Gkqb2MCOcgI6I2LHhj+x1pxvr2r8eD
 aGdj9FLsq3BM4ujxvDMJDa1u1XeNzULpMuoemxeW+v5aCC8PQMapn8xETGzBe5RqNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git's source code treats all timestamps as if they were
unsigned longs. Therefore, it is okay to write "%lu" when printing them.

There is a substantial problem with that, though: at least on Windows,
time_t is *larger* than unsigned long, and hence we will want to switch
to using time_t instead.

So let's introduce the pseudo format "PRItime" (currently simply being
"lu") so that it is easy later on to change the data type to time_t.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/blame.c               |  6 +++---
 builtin/fsck.c                |  2 +-
 builtin/log.c                 |  2 +-
 builtin/receive-pack.c        |  4 ++--
 date.c                        | 26 +++++++++++++-------------
 fetch-pack.c                  |  2 +-
 git-compat-util.h             |  1 +
 t/helper/test-date.c          |  2 +-
 t/helper/test-parse-options.c |  2 +-
 upload-pack.c                 |  2 +-
 vcs-svn/fast_export.c         |  4 ++--
 11 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index cffc6265408..c9486dd580b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1736,11 +1736,11 @@ static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 	get_commit_info(suspect->commit, &ci, 1);
 	printf("author %s\n", ci.author.buf);
 	printf("author-mail %s\n", ci.author_mail.buf);
-	printf("author-time %lu\n", ci.author_time);
+	printf("author-time %"PRItime"\n", ci.author_time);
 	printf("author-tz %s\n", ci.author_tz.buf);
 	printf("committer %s\n", ci.committer.buf);
 	printf("committer-mail %s\n", ci.committer_mail.buf);
-	printf("committer-time %lu\n", ci.committer_time);
+	printf("committer-time %"PRItime"\n", ci.committer_time);
 	printf("committer-tz %s\n", ci.committer_tz.buf);
 	printf("summary %s\n", ci.summary.buf);
 	if (suspect->commit->object.flags & UNINTERESTING)
@@ -1853,7 +1853,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 
 	strbuf_reset(&time_buf);
 	if (show_raw_time) {
-		strbuf_addf(&time_buf, "%lu %s", time, tz_str);
+		strbuf_addf(&time_buf, "%"PRItime" %s", time, tz_str);
 	}
 	else {
 		const char *time_str;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1a5caccd0f5..5413c76e7a6 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -407,7 +407,7 @@ static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1,
 			if (timestamp && name_objects)
 				add_decoration(fsck_walk_options.object_names,
 					obj,
-					xstrfmt("%s@{%ld}", refname, timestamp));
+					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
 			obj->used = 1;
 			mark_object_reachable(obj);
 		} else {
diff --git a/builtin/log.c b/builtin/log.c
index 55d20cc2d88..24612c2299a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -903,7 +903,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 static void gen_message_id(struct rev_info *info, char *base)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addf(&buf, "%s.%lu.git.%s", base,
+	strbuf_addf(&buf, "%s.%"PRItime".git.%s", base,
 		    (unsigned long) time(NULL),
 		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE|IDENT_STRICT));
 	info->message_id = strbuf_detach(&buf, NULL);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 1dbb8a06922..4a878645847 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -456,12 +456,12 @@ static char *prepare_push_cert_nonce(const char *path, unsigned long stamp)
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
 
-	strbuf_addf(&buf, "%s:%lu", path, stamp);
+	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
 	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));;
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-	strbuf_addf(&buf, "%lu-%.*s", stamp, 20, sha1_to_hex(sha1));
+	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, 20, sha1_to_hex(sha1));
 	return strbuf_detach(&buf, NULL);
 }
 
diff --git a/date.c b/date.c
index a8848f6e141..97ab5fcc349 100644
--- a/date.c
+++ b/date.c
@@ -100,41 +100,41 @@ void show_date_relative(unsigned long time, int tz,
 	diff = now->tv_sec - time;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
-			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
+			 Q_("%"PRItime" second ago", "%"PRItime" seconds ago", diff), diff);
 		return;
 	}
 	/* Turn it into minutes */
 	diff = (diff + 30) / 60;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
-			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
+			 Q_("%"PRItime" minute ago", "%"PRItime" minutes ago", diff), diff);
 		return;
 	}
 	/* Turn it into hours */
 	diff = (diff + 30) / 60;
 	if (diff < 36) {
 		strbuf_addf(timebuf,
-			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
+			 Q_("%"PRItime" hour ago", "%"PRItime" hours ago", diff), diff);
 		return;
 	}
 	/* We deal with number of days from here on */
 	diff = (diff + 12) / 24;
 	if (diff < 14) {
 		strbuf_addf(timebuf,
-			 Q_("%lu day ago", "%lu days ago", diff), diff);
+			 Q_("%"PRItime" day ago", "%"PRItime" days ago", diff), diff);
 		return;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
 		strbuf_addf(timebuf,
-			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
+			 Q_("%"PRItime" week ago", "%"PRItime" weeks ago", (diff + 3) / 7),
 			 (diff + 3) / 7);
 		return;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
 		strbuf_addf(timebuf,
-			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
+			 Q_("%"PRItime" month ago", "%"PRItime" months ago", (diff + 15) / 30),
 			 (diff + 15) / 30);
 		return;
 	}
@@ -145,20 +145,20 @@ void show_date_relative(unsigned long time, int tz,
 		unsigned long months = totalmonths % 12;
 		if (months) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
+			strbuf_addf(&sb, Q_("%"PRItime" year", "%"PRItime" years", years), years);
 			strbuf_addf(timebuf,
 				 /* TRANSLATORS: "%s" is "<n> years" */
-				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
+				 Q_("%s, %"PRItime" month ago", "%s, %"PRItime" months ago", months),
 				 sb.buf, months);
 			strbuf_release(&sb);
 		} else
 			strbuf_addf(timebuf,
-				 Q_("%lu year ago", "%lu years ago", years), years);
+				 Q_("%"PRItime" year ago", "%"PRItime" years ago", years), years);
 		return;
 	}
 	/* Otherwise, just years. Centuries is probably overkill. */
 	strbuf_addf(timebuf,
-		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
+		 Q_("%"PRItime" year ago", "%"PRItime" years ago", (diff + 183) / 365),
 		 (diff + 183) / 365);
 }
 
@@ -179,7 +179,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 
 	if (mode->type == DATE_UNIX) {
 		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%lu", time);
+		strbuf_addf(&timebuf, "%"PRItime, time);
 		return timebuf.buf;
 	}
 
@@ -188,7 +188,7 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
 
 	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
+		strbuf_addf(&timebuf, "%"PRItime" %+05d", time, tz);
 		return timebuf.buf;
 	}
 
@@ -643,7 +643,7 @@ static void date_string(unsigned long date, int offset, struct strbuf *buf)
 		offset = -offset;
 		sign = '-';
 	}
-	strbuf_addf(buf, "%lu %c%02d%02d", date, sign, offset / 60, offset % 60);
+	strbuf_addf(buf, "%"PRItime" %c%02d%02d", date, sign, offset / 60, offset % 60);
 }
 
 /*
diff --git a/fetch-pack.c b/fetch-pack.c
index 601f0779a19..54fb35e39c5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -357,7 +357,7 @@ static int find_common(struct fetch_pack_args *args,
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
 	if (args->deepen_since) {
 		unsigned long max_age = approxidate(args->deepen_since);
-		packet_buf_write(&req_buf, "deepen-since %lu", max_age);
+		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
 	}
 	if (args->deepen_not) {
 		int i;
diff --git a/git-compat-util.h b/git-compat-util.h
index 5eff97bea2e..4365012c536 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,6 +319,7 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
+#define PRItime "lu"
 #define parse_timestamp strtoul
 
 #ifndef PATH_SEP
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 98637053760..ba309ec1760 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -52,7 +52,7 @@ static void parse_dates(const char **argv, struct timeval *now)
 
 		strbuf_reset(&result);
 		parse_date(*argv, &result);
-		if (sscanf(result.buf, "%lu %d", &t, &tz) == 2)
+		if (sscanf(result.buf, "%"PRItime" %d", &t, &tz) == 2)
 			printf("%s -> %s\n",
 			       *argv, show_date(t, tz, DATE_MODE(ISO8601)));
 		else
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index a01430c24bd..7d93627e454 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -161,7 +161,7 @@ int cmd_main(int argc, const char **argv)
 	show(&expect, &ret, "boolean: %d", boolean);
 	show(&expect, &ret, "integer: %d", integer);
 	show(&expect, &ret, "magnitude: %lu", magnitude);
-	show(&expect, &ret, "timestamp: %lu", timestamp);
+	show(&expect, &ret, "timestamp: %"PRItime, timestamp);
 	show(&expect, &ret, "string: %s", string ? string : "(not set)");
 	show(&expect, &ret, "abbrev: %d", abbrev);
 	show(&expect, &ret, "verbose: %d", verbose);
diff --git a/upload-pack.c b/upload-pack.c
index 8c47dc1707a..c2be661f6d4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -859,7 +859,7 @@ static void receive_needs(void)
 
 		argv_array_push(&av, "rev-list");
 		if (deepen_since)
-			argv_array_pushf(&av, "--max-age=%lu", deepen_since);
+			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
 		if (deepen_not.nr) {
 			argv_array_push(&av, "--not");
 			for (i = 0; i < deepen_not.nr; i++) {
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 97cba39cdf5..6c9f2866d8b 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -73,7 +73,7 @@ void fast_export_begin_note(uint32_t revision, const char *author,
 	static int firstnote = 1;
 	size_t loglen = strlen(log);
 	printf("commit %s\n", note_ref);
-	printf("committer %s <%s@%s> %lu +0000\n", author, author, "local", timestamp);
+	printf("committer %s <%s@%s> %"PRItime" +0000\n", author, author, "local", timestamp);
 	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
 	fwrite(log, loglen, 1, stdout);
 	if (firstnote) {
@@ -107,7 +107,7 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 	}
 	printf("commit %s\n", local_ref);
 	printf("mark :%"PRIu32"\n", revision);
-	printf("committer %s <%s@%s> %lu +0000\n",
+	printf("committer %s <%s@%s> %"PRItime" +0000\n",
 		   *author ? author : "nobody",
 		   *author ? author : "nobody",
 		   *uuid ? uuid : "local", timestamp);
-- 
2.11.1.windows.1.379.g44ae0bc


