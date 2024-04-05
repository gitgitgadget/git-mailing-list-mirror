Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FEA16C858
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339114; cv=none; b=syP3lLjQBMLBUGXN4m2gFKJh/5vvkyschzZo6xhbUXc1lVKRfsfXkwANH5J9qGUOG6uuKq4EEG5sE6sKN9ETdWmOH9k1dEYn74HAOnXn1HYN3sDW3Ml5BRw7P2GDI/mg4vn8lPftpkiozArgfjqqrugeI+4/L7SeCvOBilBwFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339114; c=relaxed/simple;
	bh=jlWnl5oAL4RhEVgl6zMf+weCXZ0/BuGYqgaWTuhFlV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8ea0bi1vTIGLsTyfkA+tPGCzwp9ZKXCoOa4ifdGTneI0kP72TD28sz+uV+MdTUDu11tFevZtbCGYPfLJwCjJsLTSbolcpejfFyXRYY4fqMbzy3faPWm95eW4iPuOvLt3YRoLDvXD1hu5jNFbuV7tiz698WJmqB2NsbUgTBPW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ikwX1VB/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ikwX1VB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1712339100; x=1712943900; i=l.s.r@web.de;
	bh=7NFILzS8MZ7e25HGYALDD2SKoxZU35LrybOhTlk/eUY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ikwX1VB/C4VHtqwF2Y7e6+BeFFlDK4R1gyGVbYN1y80b38YppuuHd2sm2OnDMRuI
	 AB7fyqsUKMZW9resz1EDtM6Kva0Q9aQAxolswY4zZZ3AXgt771swG24DJfn4TElvQ
	 u3RqZnAc2RbWhW827GqrZPgf8h6BwavfA3wGNXBkEGCqwGyTdX86Zbx1HCRzOGTdJ
	 2g5DaVR1wlH0BLa0s2b9rJg5UqvxBE8ZciH/p4uUjlQcDoDQikbU3iFKdfoet2EgL
	 coVyc+ENCd55I/RTm923PFW5XXpF+kix9ZgVgATo//7NVfZgmIeL9pTi6r5tW0wV7
	 MsWe6klrwRhE/xOZQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.225]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB07-1sF5jh291V-00UrpZ; Fri, 05
 Apr 2024 19:45:00 +0200
Message-ID: <c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>
Date: Fri, 5 Apr 2024 19:44:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>,
 Chandra Pratap <chandrapratap3519@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
 <20240402204153.GE875182@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20240402204153.GE875182@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z+Pl7SavLcGakAAvs2E/+TyfxLcQmuPw08SZUWWY/2qSUp4zgpa
 r3zQDGG0lzK8ZLmawmyLVHjWquNegPh3SVtVXgc2G4sBtWLMNoY89M+WcZM2h6O10n1PoHe
 K+cWOxTXtgMThi+l8qlW79Q07zVLfoGYvshhjLhjoLIwH0YEunM2rQONyyvqfwJOQvKlwQB
 T1KAgBk9QCUNNhnGc7ogQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a1EgUuE/DVI=;z7nAGXY99oi9oabJGAYKUoBFDvc
 qci3fZnxJ3sKpXqF+htLpfRPULvPtcT+ACND18xYMXb2JhXpFEjaGpBIopt0ylfYJZQQIR1+X
 5akC936TAGrs29kt6OOlPMPsmV1KpxaQHvVfRYQecNrZvlVVaewB+4+9jEK1qZfDDlGcIZhW2
 v+DP/SrAB3QhV7Hfwi9gXDQkv3qePtvL0Ncjmmsq84m4tt7vkj8N+lJohWdwuy8FmukSOwS6k
 Hsh7EO0NNe31nOj58QzYS7QgO0hc8FDyejlpteFxVfN7l5aOHR+tgGBBUzC7MJVojqGpXE94X
 4EvN1wqPLMg0b7CaoNzYdqUuAHPuPpyB7yoGtOGfC1jIwTOhgUK99DPcZ7ZV/kQHfjPh3arGL
 3jgBKaCrVgA3TRVIMH9zipi6P39t7eTUJFnBQHfGsCjczTRvmsSarhPBlmkt7l9W/pC6tFflc
 hHJp1NxHIWIyRVYOZcYAoQ8ubUK4bYlFTcjr28PqIVCXQn3gD4fLCPg329HkX/GKt7MRqE4JB
 lb7Lzbphz7LLVYk1XW6rWZQiQsyTdudaP26NVolRvFGlPsl9pt6M1/9UhABgM+VWQQKyGUvwP
 yVMlyLm9pzTa9XDipfC3Mexo6HAZ9OAfApEi8QcbQ/b581zJ9jBqVjLc+HeRWuT59imFej0PO
 OiebmlJr+NxKPEBXO5NTV3Imb215QTY5p+QCYt1mNkagTTdxOMKYnlHFlwex86FvT9EWR6bE5
 Qw74ChSBhwmf2dWGRn6aUWUNDEp1UvPlML4Pm1F6eE4hU8nCsOmXMtQ2cPsrAHIh2zrkTvp62
 4hfYV0+PAOc8Djz4RQ8xRlGN5MLwOV+dUAznpl6Lgdi0k=

Am 02.04.24 um 22:41 schrieb Jeff King:
>
> I don't have a
> strong opinion on compound literals in general, but if we did allow
> them, we could clean up the horrible non-reentrant DATE_MODE().

We can easily make them reentrant without compound literals.  It just
requires simple changes to lots of places.  Patch below.

=2D-- >8 ---
Subject: [PATCH] date: make DATE_MODE thread-safe

date_mode_from_type() modifies a static variable and returns a pointer
to it.  This is not thread-safe.  Most callers of date_mode_from_type()
use it via the macro DATE_MODE and pass its result on to functions like
show_date(), which take a const pointer and don't modify the struct.

Avoid the static storage by putting the variable on the stack and
returning the whole struct date_mode.  Change functions that take a
constant pointer to expect the whole struct instead.

Reduce the cost of passing struct date_mode around on 64-bit systems
by reordering its members to close the hole between the 32-bit wide
.type and the 64-bit aligned .strftime_fmt as well as the alignment
hole at the end.  sizeof reports 24 before and 16 with this change
on x64.  Keep .type at the top to still allow initialization without
designator -- though that's only done in a single location, in
builtin/blame.c.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/blame.c      |  4 ++--
 date.c               | 36 ++++++++++++++++++------------------
 date.h               |  6 +++---
 gpg-interface.c      |  2 +-
 log-tree.c           |  2 +-
 oss-fuzz/fuzz-date.c |  6 +++---
 pretty.c             | 18 +++++++++---------
 pretty.h             |  2 +-
 ref-filter.c         |  2 +-
 reflog-walk.c        |  4 ++--
 reflog-walk.h        |  4 ++--
 t/helper/test-date.c |  2 +-
 12 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index db1f56de61..9aa74680a3 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -316,7 +316,7 @@ static const char *format_time(timestamp_t time, const=
 char *tz_str,
 		size_t time_width;
 		int tz;
 		tz =3D atoi(tz_str);
-		time_str =3D show_date(time, tz, &blame_date_mode);
+		time_str =3D show_date(time, tz, blame_date_mode);
 		strbuf_addstr(&time_buf, time_str);
 		/*
 		 * Add space paddings to time_buf to display a fixed width
@@ -1029,7 +1029,7 @@ int cmd_blame(int argc, const char **argv, const cha=
r *prefix)
 		blame_date_width =3D sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
 	case DATE_STRFTIME:
-		blame_date_width =3D strlen(show_date(0, 0, &blame_date_mode)) + 1; /* =
add the null */
+		blame_date_width =3D strlen(show_date(0, 0, blame_date_mode)) + 1; /* a=
dd the null */
 		break;
 	}
 	blame_date_width -=3D 1; /* strip the null */
diff --git a/date.c b/date.c
index 44cf2221d8..7365a4ad24 100644
=2D-- a/date.c
+++ b/date.c
@@ -207,13 +207,13 @@ void show_date_relative(timestamp_t time, struct str=
buf *timebuf)
 		 (diff + 183) / 365);
 }

-struct date_mode *date_mode_from_type(enum date_mode_type type)
+struct date_mode date_mode_from_type(enum date_mode_type type)
 {
-	static struct date_mode mode =3D DATE_MODE_INIT;
+	struct date_mode mode =3D DATE_MODE_INIT;
 	if (type =3D=3D DATE_STRFTIME)
 		BUG("cannot create anonymous strftime date_mode struct");
 	mode.type =3D type;
-	return &mode;
+	return mode;
 }

 static void show_date_normal(struct strbuf *buf, timestamp_t time, struct=
 tm *tm, int tz, struct tm *human_tm, int human_tz, int local)
@@ -283,7 +283,7 @@ static void show_date_normal(struct strbuf *buf, times=
tamp_t time, struct tm *tm
 		strbuf_addf(buf, " %+05d", tz);
 }

-const char *show_date(timestamp_t time, int tz, const struct date_mode *m=
ode)
+const char *show_date(timestamp_t time, int tz, struct date_mode mode)
 {
 	struct tm *tm;
 	struct tm tmbuf =3D { 0 };
@@ -291,13 +291,13 @@ const char *show_date(timestamp_t time, int tz, cons=
t struct date_mode *mode)
 	int human_tz =3D -1;
 	static struct strbuf timebuf =3D STRBUF_INIT;

-	if (mode->type =3D=3D DATE_UNIX) {
+	if (mode.type =3D=3D DATE_UNIX) {
 		strbuf_reset(&timebuf);
 		strbuf_addf(&timebuf, "%"PRItime, time);
 		return timebuf.buf;
 	}

-	if (mode->type =3D=3D DATE_HUMAN) {
+	if (mode.type =3D=3D DATE_HUMAN) {
 		struct timeval now;

 		get_time(&now);
@@ -306,22 +306,22 @@ const char *show_date(timestamp_t time, int tz, cons=
t struct date_mode *mode)
 		human_tz =3D local_time_tzoffset(now.tv_sec, &human_tm);
 	}

-	if (mode->local)
+	if (mode.local)
 		tz =3D local_tzoffset(time);

-	if (mode->type =3D=3D DATE_RAW) {
+	if (mode.type =3D=3D DATE_RAW) {
 		strbuf_reset(&timebuf);
 		strbuf_addf(&timebuf, "%"PRItime" %+05d", time, tz);
 		return timebuf.buf;
 	}

-	if (mode->type =3D=3D DATE_RELATIVE) {
+	if (mode.type =3D=3D DATE_RELATIVE) {
 		strbuf_reset(&timebuf);
 		show_date_relative(time, &timebuf);
 		return timebuf.buf;
 	}

-	if (mode->local)
+	if (mode.local)
 		tm =3D time_to_tm_local(time, &tmbuf);
 	else
 		tm =3D time_to_tm(time, tz, &tmbuf);
@@ -331,17 +331,17 @@ const char *show_date(timestamp_t time, int tz, cons=
t struct date_mode *mode)
 	}

 	strbuf_reset(&timebuf);
-	if (mode->type =3D=3D DATE_SHORT)
+	if (mode.type =3D=3D DATE_SHORT)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
-	else if (mode->type =3D=3D DATE_ISO8601)
+	else if (mode.type =3D=3D DATE_ISO8601)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
-	else if (mode->type =3D=3D DATE_ISO8601_STRICT) {
+	else if (mode.type =3D=3D DATE_ISO8601_STRICT) {
 		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
@@ -354,16 +354,16 @@ const char *show_date(timestamp_t time, int tz, cons=
t struct date_mode *mode)
 			tz =3D abs(tz);
 			strbuf_addf(&timebuf, "%02d:%02d", tz / 100, tz % 100);
 		}
-	} else if (mode->type =3D=3D DATE_RFC2822)
+	} else if (mode.type =3D=3D DATE_RFC2822)
 		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
-	else if (mode->type =3D=3D DATE_STRFTIME)
-		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
-				!mode->local);
+	else if (mode.type =3D=3D DATE_STRFTIME)
+		strbuf_addftime(&timebuf, mode.strftime_fmt, tm, tz,
+				!mode.local);
 	else
-		show_date_normal(&timebuf, time, tm, tz, &human_tm, human_tz, mode->loc=
al);
+		show_date_normal(&timebuf, time, tm, tz, &human_tm, human_tz, mode.loca=
l);
 	return timebuf.buf;
 }

diff --git a/date.h b/date.h
index 6136212a19..0747864fd7 100644
=2D-- a/date.h
+++ b/date.h
@@ -22,8 +22,8 @@ enum date_mode_type {

 struct date_mode {
 	enum date_mode_type type;
-	const char *strftime_fmt;
 	int local;
+	const char *strftime_fmt;
 };

 #define DATE_MODE_INIT { \
@@ -36,14 +36,14 @@ struct date_mode {
  *   show_date(t, tz, DATE_MODE(NORMAL));
  */
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
-struct date_mode *date_mode_from_type(enum date_mode_type type);
+struct date_mode date_mode_from_type(enum date_mode_type type);

 /**
  * Format <'time', 'timezone'> into static memory according to 'mode'
  * and return it. The mode is an initialized "struct date_mode"
  * (usually from the DATE_MODE() macro).
  */
-const char *show_date(timestamp_t time, int timezone, const struct date_m=
ode *mode);
+const char *show_date(timestamp_t time, int timezone, struct date_mode mo=
de);

 /**
  * Parse a date format for later use with show_date().
diff --git a/gpg-interface.c b/gpg-interface.c
index 95e764acb1..1ee2c94a3b 100644
=2D-- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -483,7 +483,7 @@ static int verify_ssh_signed_buffer(struct signature_c=
heck *sigc,

 	if (sigc->payload_timestamp)
 		strbuf_addf(&verify_time, "-Overify-time=3D%s",
-			show_date(sigc->payload_timestamp, 0, &verify_date_mode));
+			show_date(sigc->payload_timestamp, 0, verify_date_mode));

 	/* Find the principal from the signers */
 	strvec_pushl(&ssh_keygen.args, fmt->program,
diff --git a/log-tree.c b/log-tree.c
index 59eeaef1f7..16031b44e7 100644
=2D-- a/log-tree.c
+++ b/log-tree.c
@@ -773,7 +773,7 @@ void show_log(struct rev_info *opt)
 			 */
 			show_reflog_message(opt->reflog_info,
 					    opt->commit_format =3D=3D CMIT_FMT_ONELINE,
-					    &opt->date_mode,
+					    opt->date_mode,
 					    opt->date_mode_explicit);
 			if (opt->commit_format =3D=3D CMIT_FMT_ONELINE)
 				return;
diff --git a/oss-fuzz/fuzz-date.c b/oss-fuzz/fuzz-date.c
index 036378b946..9619dae40e 100644
=2D-- a/oss-fuzz/fuzz-date.c
+++ b/oss-fuzz/fuzz-date.c
@@ -11,7 +11,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t s=
ize)
 	int16_t tz;
 	timestamp_t ts;
 	enum date_mode_type dmtype;
-	struct date_mode *dm;
+	struct date_mode dm;

 	if (size <=3D 4)
 		/*
@@ -40,10 +40,10 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t=
 size)
 	free(str);

 	dm =3D date_mode_from_type(dmtype);
-	dm->local =3D local;
+	dm.local =3D local;
 	show_date(ts, (int)tz, dm);

-	date_mode_release(dm);
+	date_mode_release(&dm);

 	return 0;
 }
diff --git a/pretty.c b/pretty.c
index 2faf651d3e..7ead078998 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -428,7 +428,7 @@ static void add_rfc2047(struct strbuf *sb, const char =
*line, size_t len,
 }

 const char *show_ident_date(const struct ident_split *ident,
-			    const struct date_mode *mode)
+			    struct date_mode mode)
 {
 	timestamp_t date =3D 0;
 	long tz =3D 0;
@@ -592,7 +592,7 @@ void pp_user_info(struct pretty_print_context *pp,
 	switch (pp->fmt) {
 	case CMIT_FMT_MEDIUM:
 		strbuf_addf(sb, "Date:   %s\n",
-			    show_ident_date(&ident, &pp->date_mode));
+			    show_ident_date(&ident, pp->date_mode));
 		break;
 	case CMIT_FMT_EMAIL:
 	case CMIT_FMT_MBOXRD:
@@ -601,7 +601,7 @@ void pp_user_info(struct pretty_print_context *pp,
 		break;
 	case CMIT_FMT_FULLER:
 		strbuf_addf(sb, "%sDate: %s\n", what,
-			    show_ident_date(&ident, &pp->date_mode));
+			    show_ident_date(&ident, pp->date_mode));
 		break;
 	default:
 		/* notin' */
@@ -775,7 +775,7 @@ static int mailmap_name(const char **email, size_t *em=
ail_len,

 static size_t format_person_part(struct strbuf *sb, char part,
 				 const char *msg, int len,
-				 const struct date_mode *dmode)
+				 struct date_mode dmode)
 {
 	/* currently all placeholders have same length */
 	const int placeholder_len =3D 2;
@@ -1034,7 +1034,7 @@ static void rewrap_message_tail(struct strbuf *sb,
 static int format_reflog_person(struct strbuf *sb,
 				char part,
 				struct reflog_walk_info *log,
-				const struct date_mode *dmode)
+				struct date_mode dmode)
 {
 	const char *ident;

@@ -1602,7 +1602,7 @@ static size_t format_commit_one(struct strbuf *sb, /=
* in UTF-8 */
 			if (c->pretty_ctx->reflog_info)
 				get_reflog_selector(sb,
 						    c->pretty_ctx->reflog_info,
-						    &c->pretty_ctx->date_mode,
+						    c->pretty_ctx->date_mode,
 						    c->pretty_ctx->date_mode_explicit,
 						    (placeholder[1] =3D=3D 'd'));
 			return 2;
@@ -1617,7 +1617,7 @@ static size_t format_commit_one(struct strbuf *sb, /=
* in UTF-8 */
 			return format_reflog_person(sb,
 						    placeholder[1],
 						    c->pretty_ctx->reflog_info,
-						    &c->pretty_ctx->date_mode);
+						    c->pretty_ctx->date_mode);
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
@@ -1712,11 +1712,11 @@ static size_t format_commit_one(struct strbuf *sb,=
 /* in UTF-8 */
 	case 'a':	/* author ... */
 		return format_person_part(sb, placeholder[1],
 				   msg + c->author.off, c->author.len,
-				   &c->pretty_ctx->date_mode);
+				   c->pretty_ctx->date_mode);
 	case 'c':	/* committer ... */
 		return format_person_part(sb, placeholder[1],
 				   msg + c->committer.off, c->committer.len,
-				   &c->pretty_ctx->date_mode);
+				   c->pretty_ctx->date_mode);
 	case 'e':	/* encoding */
 		if (c->commit_encoding)
 			strbuf_addstr(sb, c->commit_encoding);
diff --git a/pretty.h b/pretty.h
index 9cc9e5d42b..df267afe4a 100644
=2D-- a/pretty.h
+++ b/pretty.h
@@ -167,7 +167,7 @@ int format_set_trailers_options(struct process_trailer=
_options *opts,
  * a well-known sentinel date if they appear bogus.
  */
 const char *show_ident_date(const struct ident_split *id,
-			    const struct date_mode *mode);
+			    struct date_mode mode);


 #endif /* PRETTY_H */
diff --git a/ref-filter.c b/ref-filter.c
index 03542d0236..59ad6f54dd 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -1627,7 +1627,7 @@ static void grab_date(const char *buf, struct atom_v=
alue *v, const char *atomnam
 	tz =3D strtol(zone, NULL, 10);
 	if ((tz =3D=3D LONG_MIN || tz =3D=3D LONG_MAX) && errno =3D=3D ERANGE)
 		goto bad;
-	v->s =3D xstrdup(show_date(timestamp, tz, &date_mode));
+	v->s =3D xstrdup(show_date(timestamp, tz, date_mode));
 	v->value =3D timestamp;
 	date_mode_release(&date_mode);
 	return;
diff --git a/reflog-walk.c b/reflog-walk.c
index d216f6f966..66484f4f32 100644
=2D-- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -223,7 +223,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,

 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
-			 const struct date_mode *dmode, int force_date,
+			 struct date_mode dmode, int force_date,
 			 int shorten)
 {
 	struct commit_reflog *commit_reflog =3D reflog_info->last_commit_reflog;
@@ -297,7 +297,7 @@ timestamp_t get_reflog_timestamp(struct reflog_walk_in=
fo *reflog_info)
 }

 void show_reflog_message(struct reflog_walk_info *reflog_info, int onelin=
e,
-			 const struct date_mode *dmode, int force_date)
+			 struct date_mode dmode, int force_date)
 {
 	if (reflog_info && reflog_info->last_commit_reflog) {
 		struct commit_reflog *commit_reflog =3D reflog_info->last_commit_reflog=
;
diff --git a/reflog-walk.h b/reflog-walk.h
index 4d93a26957..989583dc55 100644
=2D-- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -10,14 +10,14 @@ void reflog_walk_info_release(struct reflog_walk_info =
*info);
 int add_reflog_for_walk(struct reflog_walk_info *info,
 			struct commit *commit, const char *name);
 void show_reflog_message(struct reflog_walk_info *info, int,
-			 const struct date_mode *, int force_date);
+			 struct date_mode, int force_date);
 void get_reflog_message(struct strbuf *sb,
 			struct reflog_walk_info *reflog_info);
 const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
 timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
 void get_reflog_selector(struct strbuf *sb,
 			 struct reflog_walk_info *reflog_info,
-			 const struct date_mode *dmode, int force_date,
+			 struct date_mode dmode, int force_date,
 			 int shorten);

 int reflog_walk_empty(struct reflog_walk_info *walk);
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 0683d46574..f25512de9a 100644
=2D-- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -52,7 +52,7 @@ static void show_dates(const char **argv, const char *fo=
rmat)
 			arg++;
 		tz =3D atoi(arg);

-		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
+		printf("%s -> %s\n", *argv, show_date(t, tz, mode));
 	}

 	date_mode_release(&mode);
=2D-
2.44.0
