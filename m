Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EAB820357
	for <e@80x24.org>; Mon, 17 Jul 2017 15:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdGQPZ3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 11:25:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34181 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdGQPYo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 11:24:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id o88so1833762pfk.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g5KcH4QkJAFYO5fslHhNRdkRJ71Pe6y2KoVrM9oepjo=;
        b=LDPERAVZUvHXtelP8RW5JdsPYDKq8WN30p1H/uHHTRVw5i8j62klup0EC0V1JcVD4d
         chg43irDxLT95SRBWPlrOEobrDjbDMcMvPkt2x3cWe7CXIa2SnnPf3LoYaZANw/Bce5D
         9j6LxHV4+9BTR4+WMpopTbxPDIvuuxfkQhoL6fGGtrx5WruhSaPJefOtodlY7CWBtI3f
         CYpcyNocC0XS8x3iY5j0AILwx/6D5EofAqb3gdCHW9IN253eEhTSxLVr8stebxUcJO+N
         ftqooYhZXtEes6VIfYKltcuB3joSQ/JigeS4wVaCLgVFCBtW9SCv8klNKsL7Lc6L0s2/
         q3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g5KcH4QkJAFYO5fslHhNRdkRJ71Pe6y2KoVrM9oepjo=;
        b=jIOYpptEo0zN/jTUxKF/tANlHEvftaAmXn5uS/NZfhQcDum4VDfgteGoArKFXa6BmE
         LCojb0ZBDyO4rEKJahPLROSIhL77srvTyAKJHHOO8tWjDKW5YYcWAwqZf8lGDFkLQsqP
         okwTXcfyWTeD/9yFhbifEiZ7waWLhpU3NGTDYmxdQoS/SlCOOj68J1yHU0cPArwe6eRv
         WOjeyHU9rRhW46O5xnFya+DGixdFs/9feYRg55gAoVUd4mjuvr9oSs/ZF7MCQ9/BltlC
         JlO9fP3gXX99WECmlUAkX1FoiWnprlHUFP8s1H3faVlQ4hCZgI/4d10f16BUtqlNdczX
         0xtg==
X-Gm-Message-State: AIVw110UARO815gbDfib6zztAXCGYb4Ggye3TNR3zmJESJ9bmB6qRS+6
        bLIAtZm2AvccgLS4EHpiCQ==
X-Received: by 10.98.24.202 with SMTP id 193mr19234726pfy.24.1500305083202;
        Mon, 17 Jul 2017 08:24:43 -0700 (PDT)
Received: from localhost.localdomain (li1208-253.members.linode.com. [45.79.109.253])
        by smtp.googlemail.com with ESMTPSA id f15sm8106692pfj.127.2017.07.17.08.24.22
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 08:24:42 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] PRItime: wrap PRItime for better l10n compatibility
Date:   Mon, 17 Jul 2017 23:23:43 +0800
Message-Id: <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0.1.g3ccfa2fb49
In-Reply-To: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit cb71f8bdb5 ("PRItime: introduce a new "printf format" for
timestamps", 2017-04-21) does not play well with i18n framework. The
static string concatenation cannot be correctly interpreted by
gettext utilities, such as xgettext.

Wrap PRItime in format_raw_time() function, so that we can extract
correct l10n messages into "po/git.pot".

Reported-by: Jean-Noël Avila <jn.avila@free.fr>
Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 archive-zip.c          |  4 ++--
 builtin/blame.c        |  4 ++--
 builtin/fsck.c         |  3 ++-
 builtin/log.c          |  4 ++--
 builtin/receive-pack.c |  4 ++--
 builtin/rev-parse.c    |  2 +-
 cache.h                |  1 +
 date.c                 | 63 ++++++++++++++++++++++++++++++++------------------
 fetch-pack.c           |  2 +-
 refs/files-backend.c   |  6 ++---
 upload-pack.c          |  2 +-
 vcs-svn/fast_export.c  |  8 ++++---
 12 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index e8913e5a26..92df24815e 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -600,8 +600,8 @@ static void dos_time(timestamp_t *timestamp, int *dos_date, int *dos_time)
 	struct tm *t;
 
 	if (date_overflows(*timestamp))
-		die("timestamp too large for this system: %"PRItime,
-		    *timestamp);
+		die("timestamp too large for this system: %s",
+		    format_raw_time(*timestamp));
 	time = (time_t)*timestamp;
 	t = localtime(&time);
 	*timestamp = time;
diff --git a/builtin/blame.c b/builtin/blame.c
index bda1a78726..97bd99dd51 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -245,11 +245,11 @@ static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
 	get_commit_info(suspect->commit, &ci, 1);
 	printf("author %s\n", ci.author.buf);
 	printf("author-mail %s\n", ci.author_mail.buf);
-	printf("author-time %"PRItime"\n", ci.author_time);
+	printf("author-time %s\n", format_raw_time(ci.author_time));
 	printf("author-tz %s\n", ci.author_tz.buf);
 	printf("committer %s\n", ci.committer.buf);
 	printf("committer-mail %s\n", ci.committer_mail.buf);
-	printf("committer-time %"PRItime"\n", ci.committer_time);
+	printf("committer-time %s\n", format_raw_time(ci.committer_time));
 	printf("committer-tz %s\n", ci.committer_tz.buf);
 	printf("summary %s\n", ci.summary.buf);
 	if (suspect->commit->object.flags & UNINTERESTING)
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 99dea7adf6..1f6fc674c3 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -407,7 +407,8 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 			if (timestamp && name_objects)
 				add_decoration(fsck_walk_options.object_names,
 					obj,
-					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
+					xstrfmt("%s@{%s}", refname,
+						format_raw_time(timestamp)));
 			obj->used = 1;
 			mark_object_reachable(obj);
 		} else {
diff --git a/builtin/log.c b/builtin/log.c
index c6362cf92e..83b303f8af 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -920,8 +920,8 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 static void gen_message_id(struct rev_info *info, char *base)
 {
 	struct strbuf buf = STRBUF_INIT;
-	strbuf_addf(&buf, "%s.%"PRItime".git.%s", base,
-		    (timestamp_t) time(NULL),
+	strbuf_addf(&buf, "%s.%s.git.%s", base,
+		    format_raw_time((timestamp_t) time(NULL)),
 		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE|IDENT_STRICT));
 	info->message_id = strbuf_detach(&buf, NULL);
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cabdc55e09..75f26a1bc5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -460,12 +460,12 @@ static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
 
-	strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
+	strbuf_addf(&buf, "%s:%s", path, format_raw_time(stamp));
 	hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));;
 	strbuf_release(&buf);
 
 	/* RFC 2104 5. HMAC-SHA1-80 */
-	strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, 20, sha1_to_hex(sha1));
+	strbuf_addf(&buf, "%s-%.*s", format_raw_time(stamp), 20, sha1_to_hex(sha1));
 	return strbuf_detach(&buf, NULL);
 }
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index c78b7b33d6..c55872196f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -219,7 +219,7 @@ static void show_datestring(const char *flag, const char *datestr)
 	/* date handling requires both flags and revs */
 	if ((filter & (DO_FLAGS | DO_REVS)) != (DO_FLAGS | DO_REVS))
 		return;
-	buffer = xstrfmt("%s%"PRItime, flag, approxidate(datestr));
+	buffer = xstrfmt("%s%s", flag, format_raw_time(approxidate(datestr)));
 	show(buffer);
 	free(buffer);
 }
diff --git a/cache.h b/cache.h
index 71fe092644..ff0d9c77a7 100644
--- a/cache.h
+++ b/cache.h
@@ -1428,6 +1428,7 @@ struct date_mode {
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
+const char *format_raw_time(timestamp_t time);
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
 void show_date_relative(timestamp_t time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
diff --git a/date.c b/date.c
index c3e673fd04..161489903c 100644
--- a/date.c
+++ b/date.c
@@ -49,13 +49,15 @@ static time_t gm_time_t(timestamp_t time, int tz)
 
 	if (minutes > 0) {
 		if (unsigned_add_overflows(time, minutes * 60))
-			die("Timestamp+tz too large: %"PRItime" +%04d",
-			    time, tz);
+			die("Timestamp+tz too large: %s +%04d",
+			    format_raw_time(time), tz);
 	} else if (time < -minutes * 60)
-		die("Timestamp before Unix epoch: %"PRItime" %04d", time, tz);
+		die("Timestamp before Unix epoch: %s %04d",
+		    format_raw_time(time), tz);
 	time += minutes * 60;
 	if (date_overflows(time))
-		die("Timestamp too large for this system: %"PRItime, time);
+		die("Timestamp too large for this system: %s",
+		    format_raw_time(time));
 	return (time_t)time;
 }
 
@@ -87,7 +89,8 @@ static int local_tzoffset(timestamp_t time)
 	int offset, eastwest;
 
 	if (date_overflows(time))
-		die("Timestamp too large for this system: %"PRItime, time);
+		die("Timestamp too large for this system: %s",
+		    format_raw_time(time));
 
 	t = (time_t)time;
 	localtime_r(&t, &tm);
@@ -119,42 +122,46 @@ void show_date_relative(timestamp_t time, int tz,
 	diff = now->tv_sec - time;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
-			 Q_("%"PRItime" second ago", "%"PRItime" seconds ago", diff), diff);
+			 Q_("%s second ago", "%s seconds ago", diff),
+			 format_raw_time(diff));
 		return;
 	}
 	/* Turn it into minutes */
 	diff = (diff + 30) / 60;
 	if (diff < 90) {
 		strbuf_addf(timebuf,
-			 Q_("%"PRItime" minute ago", "%"PRItime" minutes ago", diff), diff);
+			 Q_("%s minute ago", "%s minutes ago", diff),
+			 format_raw_time(diff));
 		return;
 	}
 	/* Turn it into hours */
 	diff = (diff + 30) / 60;
 	if (diff < 36) {
 		strbuf_addf(timebuf,
-			 Q_("%"PRItime" hour ago", "%"PRItime" hours ago", diff), diff);
+			 Q_("%s hour ago", "%s hours ago", diff),
+			 format_raw_time(diff));
 		return;
 	}
 	/* We deal with number of days from here on */
 	diff = (diff + 12) / 24;
 	if (diff < 14) {
 		strbuf_addf(timebuf,
-			 Q_("%"PRItime" day ago", "%"PRItime" days ago", diff), diff);
+			 Q_("%s day ago", "%s days ago", diff),
+			 format_raw_time(diff));
 		return;
 	}
 	/* Say weeks for the past 10 weeks or so */
 	if (diff < 70) {
 		strbuf_addf(timebuf,
-			 Q_("%"PRItime" week ago", "%"PRItime" weeks ago", (diff + 3) / 7),
-			 (diff + 3) / 7);
+			 Q_("%s week ago", "%s weeks ago", (diff + 3) / 7),
+			 format_raw_time((diff + 3) / 7));
 		return;
 	}
 	/* Say months for the past 12 months or so */
 	if (diff < 365) {
 		strbuf_addf(timebuf,
-			 Q_("%"PRItime" month ago", "%"PRItime" months ago", (diff + 15) / 30),
-			 (diff + 15) / 30);
+			 Q_("%s month ago", "%s months ago", (diff + 15) / 30),
+			 format_raw_time((diff + 15) / 30));
 		return;
 	}
 	/* Give years and months for 5 years or so */
@@ -164,21 +171,23 @@ void show_date_relative(timestamp_t time, int tz,
 		timestamp_t months = totalmonths % 12;
 		if (months) {
 			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, Q_("%"PRItime" year", "%"PRItime" years", years), years);
+			strbuf_addf(&sb, Q_("%s year", "%s years", years),
+				format_raw_time(years));
 			strbuf_addf(timebuf,
 				 /* TRANSLATORS: "%s" is "<n> years" */
-				 Q_("%s, %"PRItime" month ago", "%s, %"PRItime" months ago", months),
-				 sb.buf, months);
+				 Q_("%s, %s month ago", "%s, %s months ago", months),
+				 sb.buf, format_raw_time(months));
 			strbuf_release(&sb);
 		} else
 			strbuf_addf(timebuf,
-				 Q_("%"PRItime" year ago", "%"PRItime" years ago", years), years);
+				 Q_("%s year ago", "%s years ago", years),
+				 format_raw_time(years));
 		return;
 	}
 	/* Otherwise, just years. Centuries is probably overkill. */
 	strbuf_addf(timebuf,
-		 Q_("%"PRItime" year ago", "%"PRItime" years ago", (diff + 183) / 365),
-		 (diff + 183) / 365);
+		 Q_("%s year ago", "%s years ago", (diff + 183) / 365),
+		 format_raw_time((diff + 183) / 365));
 }
 
 struct date_mode *date_mode_from_type(enum date_mode_type type)
@@ -191,6 +200,15 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	return &mode;
 }
 
+const char *format_raw_time(timestamp_t time)
+{
+	static struct strbuf time_buf = STRBUF_INIT;
+
+	strbuf_reset(&time_buf);
+	strbuf_addf(&time_buf, "%"PRItime, time);
+	return time_buf.buf;
+}
+
 const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
@@ -198,7 +216,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 
 	if (mode->type == DATE_UNIX) {
 		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%"PRItime, time);
+		strbuf_addstr(&timebuf, format_raw_time(time));
 		return timebuf.buf;
 	}
 
@@ -207,7 +225,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 
 	if (mode->type == DATE_RAW) {
 		strbuf_reset(&timebuf);
-		strbuf_addf(&timebuf, "%"PRItime" %+05d", time, tz);
+		strbuf_addf(&timebuf, "%s %+05d", format_raw_time(time), tz);
 		return timebuf.buf;
 	}
 
@@ -666,7 +684,8 @@ static void date_string(timestamp_t date, int offset, struct strbuf *buf)
 		offset = -offset;
 		sign = '-';
 	}
-	strbuf_addf(buf, "%"PRItime" %c%02d%02d", date, sign, offset / 60, offset % 60);
+	strbuf_addf(buf, "%s %c%02d%02d", format_raw_time(date), sign,
+		offset / 60, offset % 60);
 }
 
 /*
diff --git a/fetch-pack.c b/fetch-pack.c
index fbbc99c888..80c4ec27df 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -397,7 +397,7 @@ static int find_common(struct fetch_pack_args *args,
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
 	if (args->deepen_since) {
 		timestamp_t max_age = approxidate(args->deepen_since);
-		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
+		packet_buf_write(&req_buf, "deepen-since %s", format_raw_time(max_age));
 	}
 	if (args->deepen_not) {
 		int i;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0404f2c233..3872ef33e7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3236,9 +3236,9 @@ static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 			printf("prune %s", message);
 	} else {
 		if (cb->newlog) {
-			fprintf(cb->newlog, "%s %s %s %"PRItime" %+05d\t%s",
-				oid_to_hex(ooid), oid_to_hex(noid),
-				email, timestamp, tz, message);
+			fprintf(cb->newlog, "%s %s %s %s %+05d\t%s",
+				oid_to_hex(ooid), oid_to_hex(noid), email,
+				format_raw_time(timestamp), tz, message);
 			oidcpy(&cb->last_kept_oid, noid);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
diff --git a/upload-pack.c b/upload-pack.c
index 7efff2fbfd..cfcc79a9cd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -864,7 +864,7 @@ static void receive_needs(void)
 
 		argv_array_push(&av, "rev-list");
 		if (deepen_since)
-			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
+			argv_array_pushf(&av, "--max-age=%s", format_raw_time(deepen_since));
 		if (deepen_not.nr) {
 			argv_array_push(&av, "--not");
 			for (i = 0; i < deepen_not.nr; i++) {
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 5a89db30e3..291f294e30 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -73,7 +73,8 @@ void fast_export_begin_note(uint32_t revision, const char *author,
 	static int firstnote = 1;
 	size_t loglen = strlen(log);
 	printf("commit %s\n", note_ref);
-	printf("committer %s <%s@%s> %"PRItime" +0000\n", author, author, "local", timestamp);
+	printf("committer %s <%s@%s> %s +0000\n", author, author, "local",
+		format_raw_time(timestamp));
 	printf("data %"PRIuMAX"\n", (uintmax_t)loglen);
 	fwrite(log, loglen, 1, stdout);
 	if (firstnote) {
@@ -107,10 +108,11 @@ void fast_export_begin_commit(uint32_t revision, const char *author,
 	}
 	printf("commit %s\n", local_ref);
 	printf("mark :%"PRIu32"\n", revision);
-	printf("committer %s <%s@%s> %"PRItime" +0000\n",
+	printf("committer %s <%s@%s> %s +0000\n",
 		   *author ? author : "nobody",
 		   *author ? author : "nobody",
-		   *uuid ? uuid : "local", timestamp);
+		   *uuid ? uuid : "local",
+		   format_raw_time(timestamp));
 	printf("data %"PRIuMAX"\n",
 		(uintmax_t) (log->len + strlen(gitsvnline)));
 	fwrite(log->buf, log->len, 1, stdout);
-- 
2.14.0.rc0.1.g3ccfa2fb49

