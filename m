Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5AA207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947013AbdDTU6d (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:58:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:63152 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943457AbdDTU6c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:58:32 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvVYZ-1c2A350goV-010eHy; Thu, 20
 Apr 2017 22:58:28 +0200
Date:   Thu, 20 Apr 2017 22:58:26 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 4/8] Specify explicitly where we parse timestamps
In-Reply-To: <cover.1492721487.git.johannes.schindelin@gmx.de>
Message-ID: <403936fa1df1b1c6d8daade2bfe853579b97bad3.1492721487.git.johannes.schindelin@gmx.de>
References: <cover.1491159939.git.johannes.schindelin@gmx.de> <cover.1492721487.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:X6B3YRdYZkd/U77vxUp9webVBANN3WnKetxLK++ICaSNbLIJmX5
 YayhtJ5kFF/14/rakri8LzoAEItqcYKwU3Q2kqKLiH1ZCcUWEC8hMaUd8LvrUsxvR988VlU
 fC28g3F7w0zWDao4Vl2HbH6frXZTnNJ3tOIk92O2x8xPpNas6wvXJcnqo/p5SuWfHT/TqXr
 MJH7KY7TjiVqzJOTbi31g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bpkC90jveZs=:OSzpqgp7ER32Ii/ThdcIdD
 mP5LizwU44lsUreyAfYQKELqsC4itfPFngXnLVyFJ0dLSo7/1mjB93s6Ka1E1J+og7/KX4A0x
 uXndumc1+KdEXm1nQ70I/1eweUPdsV/Yuk0tmLg5tHxeQM4AakYqa6ghYCWHOgKko1W+CWeXX
 eUb3lrkhk9YuDibzhEPnOdLciUwJ3YVPhi9LRV5s37cO5DsNhAph5MuqmiY+NzoateC7aVBPH
 TmQV4fx/ykw1wr1dRbgeswIBc12tIyEJOqeuZYmOqGKz2faSgao1fGQKwNzlFGrWA0C6s81zE
 TRSGsToaw5XV16q6T/jpJie80kMnUsJsg4AeIgDyloF5DObGfe7sfUuu0OwMEo6B4qqjaEOP5
 dZJOVdu3cpxi7MdL+01MFR5jB51S14Fae7BiiDbtB5X+Yb5fIYDbmFDNaGEWRcZbk9UWNf2aV
 Pti+1jw8mauaLTuoRoUNFC0DAfTj1HDAytxMLriPNrvIcTLDq2ZEsBWubaGMMAoe1lpntRiYc
 6G2PETWBnDZLd4qq8r0RHQQAdyRYsPlpOWuZRXTWiwU1hfkcbEBbg4AXHBFFaCi6IAMIaQ6Cy
 6tm3oKY59HGBHWUNnO8xA65j8VEEx8qi7Zv0/6ixrfUVaCL9iJ6dpgqyPidtbPlhG7Bvfb/Ub
 48+RHeffhf3woru+MzTZZMZa8r/YYaV1KAqE8DCVDEY3GSKcBOJDtTegyyNll4dG1DoGZASyK
 zmLXC3IGhjX6pp88Ga0s13UN8oREpZRQ9IwIh4JWbGxjDkfvrE1RTBfN+OdHMZVzatJ8v6J2z
 g4XJkFd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, Git's source code represents all timestamps as `unsigned
long`. In preparation for using a more appropriate data type, let's
introduce a symbol `parse_timestamp` (currently being defined to
`strtoul`) where appropriate, so that we can later easily switch to,
say, use `strtoull()` instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c           | 2 +-
 builtin/receive-pack.c | 4 ++--
 bundle.c               | 2 +-
 commit.c               | 6 +++---
 date.c                 | 6 +++---
 fsck.c                 | 2 +-
 git-compat-util.h      | 2 ++
 pretty.c               | 2 +-
 ref-filter.c           | 2 +-
 refs/files-backend.c   | 2 +-
 t/helper/test-date.c   | 2 +-
 tag.c                  | 4 ++--
 upload-pack.c          | 2 +-
 13 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index f7a7a971fbe..2c93adc69c3 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -882,7 +882,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 			char *end;
 
 			errno = 0;
-			timestamp = strtoul(str, &end, 10);
+			timestamp = parse_timestamp(str, &end, 10);
 			if (errno)
 				return error(_("invalid timestamp"));
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 3cba3fd278f..9a4c2a7ade4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -534,7 +534,7 @@ static const char *check_nonce(const char *buf, size_t len)
 		retval = NONCE_BAD;
 		goto leave;
 	}
-	stamp = strtoul(nonce, &bohmac, 10);
+	stamp = parse_timestamp(nonce, &bohmac, 10);
 	if (bohmac == nonce || bohmac[0] != '-') {
 		retval = NONCE_BAD;
 		goto leave;
@@ -552,7 +552,7 @@ static const char *check_nonce(const char *buf, size_t len)
 	 * would mean it was issued by another server with its clock
 	 * skewed in the future.
 	 */
-	ostamp = strtoul(push_cert_nonce, NULL, 10);
+	ostamp = parse_timestamp(push_cert_nonce, NULL, 10);
 	nonce_stamp_slop = (long)ostamp - (long)stamp;
 
 	if (nonce_stamp_slop_limit &&
diff --git a/bundle.c b/bundle.c
index bbf4efa0a0a..f43bfcf5ff3 100644
--- a/bundle.c
+++ b/bundle.c
@@ -227,7 +227,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	line = memchr(line, '>', lineend ? lineend - line : buf + size - line);
 	if (!line++)
 		goto out;
-	date = strtoul(line, NULL, 10);
+	date = parse_timestamp(line, NULL, 10);
 	result = (revs->max_age == -1 || revs->max_age < date) &&
 		(revs->min_age == -1 || revs->min_age > date);
 out:
diff --git a/commit.c b/commit.c
index 73c78c2b80c..0d2d0fa1984 100644
--- a/commit.c
+++ b/commit.c
@@ -89,8 +89,8 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
 		/* nada */;
 	if (buf >= tail)
 		return 0;
-	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	return strtoul(dateptr, NULL, 10);
+	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
+	return parse_timestamp(dateptr, NULL, 10);
 }
 
 static struct commit_graft **commit_graft;
@@ -607,7 +607,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	    !ident.date_begin || !ident.date_end)
 		goto fail_exit; /* malformed "author" line */
 
-	date = strtoul(ident.date_begin, &date_end, 10);
+	date = parse_timestamp(ident.date_begin, &date_end, 10);
 	if (date_end != ident.date_end)
 		goto fail_exit; /* malformed date */
 	*(author_date_slab_at(author_date, commit)) = date;
diff --git a/date.c b/date.c
index a996331f5b3..495c207c64f 100644
--- a/date.c
+++ b/date.c
@@ -510,7 +510,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 	char *end;
 	unsigned long num;
 
-	num = strtoul(date, &end, 10);
+	num = parse_timestamp(date, &end, 10);
 
 	/*
 	 * Seconds since 1970? We trigger on that for any numbers with
@@ -658,7 +658,7 @@ static int match_object_header_date(const char *date, unsigned long *timestamp,
 
 	if (*date < '0' || '9' < *date)
 		return -1;
-	stamp = strtoul(date, &end, 10);
+	stamp = parse_timestamp(date, &end, 10);
 	if (*end != ' ' || stamp == ULONG_MAX || (end[1] != '+' && end[1] != '-'))
 		return -1;
 	date = end + 2;
@@ -1066,7 +1066,7 @@ static const char *approxidate_digit(const char *date, struct tm *tm, int *num,
 				     time_t now)
 {
 	char *end;
-	unsigned long number = strtoul(date, &end, 10);
+	unsigned long number = parse_timestamp(date, &end, 10);
 
 	switch (*end) {
 	case ':':
diff --git a/fsck.c b/fsck.c
index e6152e4e6d4..d589341cddf 100644
--- a/fsck.c
+++ b/fsck.c
@@ -691,7 +691,7 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	p++;
 	if (*p == '0' && p[1] != ' ')
 		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
-	if (date_overflows(strtoul(p, &end, 10)))
+	if (date_overflows(parse_timestamp(p, &end, 10)))
 		return report(options, obj, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if ((end == p || *end != ' '))
 		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e7b..fc1b5fe1a6c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,6 +319,8 @@ extern char *gitdirname(char *);
 #define PRIo32 "o"
 #endif
 
+#define parse_timestamp strtoul
+
 #ifndef PATH_SEP
 #define PATH_SEP ':'
 #endif
diff --git a/pretty.c b/pretty.c
index d0f86f5d85c..24fb0c79062 100644
--- a/pretty.c
+++ b/pretty.c
@@ -409,7 +409,7 @@ const char *show_ident_date(const struct ident_split *ident,
 	long tz = 0;
 
 	if (ident->date_begin && ident->date_end)
-		date = strtoul(ident->date_begin, NULL, 10);
+		date = parse_timestamp(ident->date_begin, NULL, 10);
 	if (date_overflows(date))
 		date = 0;
 	else {
diff --git a/ref-filter.c b/ref-filter.c
index 92871266001..c7836ae07bd 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -868,7 +868,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 
 	if (!eoemail)
 		goto bad;
-	timestamp = strtoul(eoemail + 2, &zone, 10);
+	timestamp = parse_timestamp(eoemail + 2, &zone, 10);
 	if (timestamp == ULONG_MAX)
 		goto bad;
 	tz = strtol(zone, NULL, 10);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4d705b4037e..dae0522673b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3247,7 +3247,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 	    parse_oid_hex(p, &noid, &p) || *p++ != ' ' ||
 	    !(email_end = strchr(p, '>')) ||
 	    email_end[1] != ' ' ||
-	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
+	    !(timestamp = parse_timestamp(email_end + 2, &message, 10)) ||
 	    !message || message[0] != ' ' ||
 	    (message[1] != '+' && message[1] != '-') ||
 	    !isdigit(message[2]) || !isdigit(message[3]) ||
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index ac7c66c733b..52d1fc34454 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -34,7 +34,7 @@ static void show_dates(const char **argv, const char *format)
 		 * Do not use our normal timestamp parsing here, as the point
 		 * is to test the formatting code in isolation.
 		 */
-		t = strtol(*argv, &arg, 10);
+		t = parse_timestamp(*argv, &arg, 10);
 		while (*arg == ' ')
 			arg++;
 		tz = atoi(arg);
diff --git a/tag.c b/tag.c
index 243d1fdbbcb..9b6725e02c9 100644
--- a/tag.c
+++ b/tag.c
@@ -110,8 +110,8 @@ static unsigned long parse_tag_date(const char *buf, const char *tail)
 		/* nada */;
 	if (buf >= tail)
 		return 0;
-	/* dateptr < buf && buf[-1] == '\n', so strtoul will stop at buf-1 */
-	return strtoul(dateptr, NULL, 10);
+	/* dateptr < buf && buf[-1] == '\n', so parsing will stop at buf-1 */
+	return parse_timestamp(dateptr, NULL, 10);
 }
 
 int parse_tag_buffer(struct tag *item, const void *data, unsigned long size)
diff --git a/upload-pack.c b/upload-pack.c
index ffb028d6231..f17f4dd1233 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -775,7 +775,7 @@ static void receive_needs(void)
 		}
 		if (skip_prefix(line, "deepen-since ", &arg)) {
 			char *end = NULL;
-			deepen_since = strtoul(arg, &end, 0);
+			deepen_since = parse_timestamp(arg, &end, 0);
 			if (!end || *end || !deepen_since ||
 			    /* revisions.c's max_age -1 is special */
 			    deepen_since == -1)
-- 
2.12.2.windows.2.406.gd14a8f8640f


