Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46F4AE13E
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197149; cv=none; b=oP8S2QlVMPy1GbEfCrbjpN1FJVZ2MOXqIGI7yv32iuh9i1vJq3uH3AFofEHEbfQGLLkH9oZGvfsPaqYEqadS1P0iQIFjl7mdHG5U6t4UTbOz3n0Sx9H3nAkzGgXcmIab1n1iqVycC81QFaJn9uC4r8x99IRSZLlnCPDcj1X1bvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197149; c=relaxed/simple;
	bh=U75lAqZrOjvo+vJMBJoj9M6AHTZFQ3sPaJJUPelqPwQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gZVuR3iA0/xObh7UBoPC1bPAAjErhzfQFmCFxHRhutP3G57wbjHlG/e38+nxiVDdcYfnWIsstUJAbdaNBPKQLGbiG3LSiO+3aFs4wAigYe96iGQIT4ttz2e/lI/cgicD6IbVzKhZXCqpROyr1bScHFI2ssfE9/hP6+cus/m4t18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pom8RIOy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pom8RIOy"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-517dc520840so40593871cf.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788197147; x=1788801947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DLgee7UWvR018u06GDY3rRiGLUcgR7P+2R1wUzEc6sQ=;
        b=Pom8RIOyR5n1PA1lpVdFK26NGlbJMMdjBejRfdc40chksVw0g75DwewMb2ZqrROq4A
         AOPjuTmAuqTPDl87pqnPeGpXgvgeXnvP0/LoZYXYCeOcu7pVScBkr886pNzEdODC+vVY
         FC8gX4oRK3EkTu9aeAWPe50rl3qUqq7nrO/8biiON9uCXcoyPL8dY3zZ7L/EOuJF1Uxd
         vxY0yqQo2eVlfJ7drB5MOF+SL1sf7NIyZt/rdZzs+euym3IGa0W+DayQZ8ZWiIz30CW+
         OtEhG5BCPFQIcP1aAiuGakb7vQS5x+7UXyGtXGJeV4WbcNRiqmwikybIh0IYuKEP0aMD
         ZkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788197147; x=1788801947;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DLgee7UWvR018u06GDY3rRiGLUcgR7P+2R1wUzEc6sQ=;
        b=isUN9sS+T1NhV53honl+lrP10phMayN9sN5Z6xKiov9xRKRYM0sUhmYws+P08kvJWu
         iDmROKJPc2dW8Suhpo3aIy1dE4kE5vHupgUtIPKdS3zcSS35ECIRelfl2Gj9wmMNRvrU
         yXtvTZhR9ItPUZGXIEVZ0RHHgTr/sgaNs2oY2ao6BYSwFwCAd6gCJYta4kXMGyqdkxEr
         QxEzWk4+EsLKvPko8bcLQVOfptprppWzZF3PuN1MDMhrPAswFYCoaNFvprmMj31FVUBO
         NCvyZtt95Mp5ypdW1Al1H9YcC0Q8sRd2x1+67psaQNY8wGOFK8deKEx/IM+JcwOPhzT4
         zWAw==
X-Gm-Message-State: AFuF++ne04gMMwmZ8hZl0YFCNkqIEzmvsyBrZTBMaIv8HRp/Lha+aWXg
	XHL5KMi2Ju0EA4BGuisP9/ag7SM3bcnESn/WesDXrK6xktpmtU1g+OFVEFoeax+s
X-Gm-Gg: AR+sD12AKJflgwm9/q3ctvnXbi3yXXM65iLIHKt1FsaG/2zpBWaKq3hnIa3wVmeYtaA
	lo7WH2SAEUZBCvgBvN/v6P2WmstR++e0w5yDFbOwhrxpaRS3O1/RKWgMZmM/CdlPvUjPID94Osj
	elqgLogf25D22p9mBe7Iq/3y2ycmDuktKL0mx8pnTNGib2D5u0Rkf9lXvu6CYcHDwTAYEF2uRce
	4mclakTzlV+58DCTsuwBdvmFRenw8zr2UZLsJZB9zr/6qspgr4PnSV92z4SYd7TEkC6jlTBLSVu
	sy61mcvc2oaXBH2pDnSy8yYX+K/XMncGV87v5dqivdJFBEXQhLFdKAh6g+G35zc9m2Ckn3quKNr
	+5u77puZa+lXF1N0321lZ8Ti4ieV33lKmOzw/xCvvKa8RxKOym0vp417oRdc6vBXNCWdAqdUt25
	v7xHxWsQ/hIAlS4+aw8FwUmGZO2QWoxUfiPUQ1pv9HOoBj0Ul6s/7E2aSxgo/a8AewohIK4tLdw
	g0=
X-Received: by 2002:ac8:5750:0:b0:52f:9e5c:33ff with SMTP id d75a77b69052e-52fb93edd51mr339167961cf.13.1788197146781;
        Mon, 31 Aug 2026 10:25:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52fbe87941bsm79156401cf.30.2026.08.31.10.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 10:25:45 -0700 (PDT)
Message-Id: <754fffb74e05e8562321d94d17de51d4affab24f.1788197143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
References: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
	<pull.2178.v3.git.1788197143.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Aug 2026 17:25:38 +0000
Subject: [PATCH v3 2/7] trace2: tolerate failed timestamp formatting
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    Taylor Blau <ttaylorr@openai.com>,
    Elijah Newren <newren@gmail.com>,
    Jeff King <peff@peff.net>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Some users reported issues of repeated messages:

  fatal: recursion detected in die handler

This wasn't happening every time, but we eventually captured a
GIT_TRACE2_PERF log file with this issue and revealed an interesting
internal detail, failing with this message:

  unable to format message: %4d-%02d-%02dT%02d:%02d:%02d.%06ldZ

This specific format string tracks to tr2_tbuf_utc_datetime_extended()
in trace2/tr2_tbuf.c. This logic began as tr2_tbuf_utc_time() in
ee4512ed481 (trace2: create new combined trace facility, 2019-02-22) but
was later split in bad229aef23 (trace2: clarify UTC datetime formatting,
2019-04-15).

This use of xsnprintf() is writing a very specific datetime format into a
32-character buffer. The format requires that the input data will not
overflow the format digits or the buffer will not hold the result. Since
we are using xsnprintf() here, those failures turn into die() events.

This method and its siblings, tr2_tbuf_local_time() and
tr2_tbuf_utc_datetime(), are used in the tracing library. The extended
form is used only for the 'event' format, which these users were using
via a config setting for use in client-side telemetry. The non-extended
form is used to help generate the 'SID' that defines the process in the
traces.

Not only are these inappropriate times for a failure, but the extended
method is called specifially during the 'atexit' event, which was
triggering this problem in a loop as the 'atexit' event would be
retriggered by the die().

Based on other symptoms impacting users on the version reporting these
failures, it is most likely that this is actually a failure to allocate
memory, which is a specific symptom in Git for Windows. That fork uses a
different library for its implementation of vsprintf() which allocates
an array when seven or more positional arguments exist in the formatting
string, such as this one.

Ultimately, the trace2 machinery is so low-level that it should not rely on
any helper functions that perform error handling with die(), as that can
trigger issues that would then be traced, causing this kind of recursive
loop.

These changes help remove any use of die() within this file:

1. Both 'tv' and 'tm' structs are initialized with zero values, allowing
   an erroring gettimeofday() or gmtime_r() method to leave them
   zero-valued. A zero-valued date is better than a die() here.

2. Replace the use of xsnprintf() with snprintf() to avoid the
   possibility of calling die() here. Instead, check the response to see
   if there was a failure. On failure, put a blank value into the buffer
   instead of possibly allowing a value that would not format correctly
   for a trace2 consumer. This value should be seen as obviously wrong
   and therefore signals a problem.

As the core issue in this code seems to require a system method
returning an error, no test accompanies this change.

This change removes all uses of xsnprintf() from the trace2/ directory.
There are two uses of xstrdup() that could be considered for removal,
but they only die() on out-of-memory errors instead of formatting
issues. I chose to leave those in place for now.

Helped-by: Taylor Blau <ttaylorr@openai.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 banned-die.h      |  3 +++
 trace2/tr2_tbuf.c | 49 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 15 deletions(-)

diff --git a/banned-die.h b/banned-die.h
index 1cde4035c1..589e9cc2bd 100644
--- a/banned-die.h
+++ b/banned-die.h
@@ -11,4 +11,7 @@
 #undef die
 #define die BANNED(die)
 
+#undef xsnprintf
+#define xsnprintf(...) BANNED(xsnprintf)
+
 #endif /* BANNED_DIE_H */
diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index d623e55a81..9b9cdab025 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -5,45 +5,64 @@
 
 void tr2_tbuf_local_time(struct tr2_tbuf *tb)
 {
-	struct timeval tv;
-	struct tm tm;
+	struct timeval tv = { 0 };
+	struct tm tm = { 0 };
 	time_t secs;
+	int len;
 
 	gettimeofday(&tv, NULL);
 	secs = tv.tv_sec;
 	localtime_r(&secs, &tm);
 
-	xsnprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld", tm.tm_hour,
-		  tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+	len = snprintf(tb->buf, sizeof(tb->buf), "%02d:%02d:%02d.%06ld",
+		       tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+
+	if (len < 0 || (size_t)len >= sizeof(tb->buf)) {
+		const char *blank = "00:00:00.000000";
+		strlcpy(tb->buf, blank, sizeof(tb->buf));
+	}
 }
 
 void tr2_tbuf_utc_datetime_extended(struct tr2_tbuf *tb)
 {
-	struct timeval tv;
-	struct tm tm;
+	struct timeval tv = { 0 };
+	struct tm tm = { 0 };
 	time_t secs;
+	int len;
 
 	gettimeofday(&tv, NULL);
 	secs = tv.tv_sec;
 	gmtime_r(&secs, &tm);
 
-	xsnprintf(tb->buf, sizeof(tb->buf),
-		  "%4d-%02d-%02dT%02d:%02d:%02d.%06ldZ", tm.tm_year + 1900,
-		  tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec,
-		  (long)tv.tv_usec);
+	len = snprintf(tb->buf, sizeof(tb->buf),
+		       "%4d-%02d-%02dT%02d:%02d:%02d.%06ldZ",
+		       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		       tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+
+	if (len < 0 || (size_t)len >= sizeof(tb->buf)) {
+		const char *blank = "1900-00-00T00:00:00.000000Z";
+		strlcpy(tb->buf, blank, sizeof(tb->buf));
+	}
 }
 
 void tr2_tbuf_utc_datetime(struct tr2_tbuf *tb)
 {
-	struct timeval tv;
-	struct tm tm;
+	struct timeval tv = { 0 };
+	struct tm tm = { 0 };
 	time_t secs;
+	int len;
 
 	gettimeofday(&tv, NULL);
 	secs = tv.tv_sec;
 	gmtime_r(&secs, &tm);
 
-	xsnprintf(tb->buf, sizeof(tb->buf), "%4d%02d%02dT%02d%02d%02d.%06ldZ",
-		  tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday, tm.tm_hour,
-		  tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+	len = snprintf(tb->buf, sizeof(tb->buf),
+		       "%4d%02d%02dT%02d%02d%02d.%06ldZ",
+		       tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
+		       tm.tm_hour, tm.tm_min, tm.tm_sec, (long)tv.tv_usec);
+
+	if (len < 0 || (size_t)len >= sizeof(tb->buf)) {
+		const char *blank = "19000000T000000.000000Z";
+		strlcpy(tb->buf, blank, sizeof(tb->buf));
+	}
 }
-- 
gitgitgadget

