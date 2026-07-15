Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9353AFCEA
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131943; cv=none; b=pWSzZ9VtbU56wBbwVsNAyWQLt2el/TvZAsXDpB+eITr/CBVz2Wu88mmjJ8uBpskbhCkbduxHJ8gcJnyxhFYoyihgaups5dVnza0mHa8IT9a5M6cHN8nHUDhdjLq0S68XUOxdFmR6VUKGWIXcWObWVXFgj50vZueEjCBfE9x2gw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131943; c=relaxed/simple;
	bh=Wd1zxyubi9P0DQQod7IxFQFpehmHIl2lfbZeEHSz+w4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=NNu7/T0VmsGpe6P3Hi2IrmZgji1cebDJTjVKrFczO+1jO9zmmv4gLQQ2OZSoOigTplYEQ+mgHmGnp60X2ndRTGFuvMpYlHeUZAAYVy0hiNi2HkXBUiHcNVOA8S8qNNAeFPjZulAxMYF8YmGkZ3SjJyMMNTxF6+kmnTfO3L6KM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtcx8kzC; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtcx8kzC"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c0c68aa31so23460171cf.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784131934; x=1784736734; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RjRtMnK+grdOBysjyRjoeXY+d6gE313ckoGV4OHWeb4=;
        b=gtcx8kzCrJ207bfzgbV0q+YV8HhdFpSh9ShcSD6jecrqe/lHTjfGjwh5c9GnF7GPFW
         4uhYCd66hYlRq8sz3KhIEAFQaTjBUlIsfxrF2eahrsHdUJrMpNnQFPeRw19qSmn7x/gg
         yF8ZtSUSI1PxIeYsvRnT44LLNG5Ft/+tTP+MZzEOHjcI+804KKPyee2oXaItmL8PR8lf
         n7sOaXDIIlk8RGmhDk0/1uwwsi9ZaWmAUOEe5Ubx+TnlEU0xFuh+oSZsOQgeeJ8toW2p
         sgOF3+7eAUL1k8bkiYM49RN0edQIYEaywFOfMhnE6cPlQp5JrEuilCBCT4DGf6P5ecSJ
         H1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784131934; x=1784736734;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RjRtMnK+grdOBysjyRjoeXY+d6gE313ckoGV4OHWeb4=;
        b=MWI/01dYM7ujCMn3Jsijv7CPYku4OvCENb98WxjLNteDAZna0aHMZwLgeauSxlyX8u
         OvxRAAJFO6gh20zJ780cCzi/d1wTkp3TBKWVxg+gBfsWq8m/784deYw4aL7Gby+1aDJX
         W1KOx3fMg039W5K9b5RyK3Xqn4U58dHLqFaWWq4/VgIvpeRC1SqNDse0CULXtEsSV3TR
         cT9S3duaqyHxlopKP1Vtg2Hw+beDHrPQP7EQRAsVHP99K4suu/3GI5KAxZVCZBFpnpNy
         WNzKI7tpRGScCCqWLJNJGoYMxtTWncH5W9BLIwMIoupgdrlPNEuyop4farHqQeB+ppZI
         i7Dg==
X-Gm-Message-State: AOJu0YzD0iUuql2sI0xrMISB7q3ClMCn/M81Do2SFcFGNQgY940PgDvO
	sqjXm1lhlk2awSY/f16ptcWwDv1Rj6AaRYJkaMb76fyIaUjTOh8eJC2IoqOvZg==
X-Gm-Gg: AfdE7cmokfrr++fq3/E7srnNX8SB04IM4WEt431glpVntDwtZ5axB/W7Z/O7TvIDgNT
	pE3ihCN0YJptmtNDvoqqe+vW2S5cp8O5HrUYNo4yp6enGZis5FyVTAJ07blVC1bBvaHZWjKhniv
	aV1MPESKNr4po513h7885vXfWQ66fRByjvvZhsUjVrZvREWX7fjUhjzmtukPHcaDnb6SQw9blvf
	s60IIFYACZ0HRiEGxpA9JXQURFmzRPU3wdF8OTOwh1ZNLZXniev/AiHkXRkSxQIOd2nSjRTUaLE
	08dWp0zaRXVS7YlbMkpnhou5+ViQfKDwp1GpO7oTd3NPTSwX0SdZUvwsIQ51FIQYxCTIDUhf1tm
	/wrQ22Klxu0HboA9DmajSYjqWB/gDWEjG8DGappVYNQG8fdc9m0fL4H9wZks/3tk7PjMwztN6Tb
	EzqfCNHuZy2HsNI4KQtWvpbZcl4Q==
X-Received: by 2002:a05:622a:250b:b0:51c:a2ca:3fc0 with SMTP id d75a77b69052e-51cbf1ec189mr179297041cf.23.1784131933497;
        Wed, 15 Jul 2026 09:12:13 -0700 (PDT)
Received: from [127.0.0.1] ([52.150.29.105])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-903083910d1sm166460026d6.12.2026.07.15.09.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:12:12 -0700 (PDT)
Message-Id: <pull.2178.git.1784131932489.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 16:12:11 +0000
Subject: [PATCH] trace2: tolerate failed timestamp formatting
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

I could not determine the exact cause of why these errors started
occuring in a bunch. My best guess is that these users are dogfooding an
early operating system version that is more likely to fail in the
gettimeofday() function and thus leaves the structures uninitialized and
potentially violating the expected values.

However, for full defense-in-depth I made several modifications:

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

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    trace2: tolerate failed timestamp formatting
    
    As mentioned, this is based on real trace logs of failed commands users
    are seeing.
    
    I wish I had a better way to test this or to be 100% sure that the
    system call was failing. But users were seeing failures and these seemed
    like appropriate changes.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2178%2Fderrickstolee%2Ftrace2-dont-die-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2178/derrickstolee/trace2-dont-die-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2178

 trace2/tr2_tbuf.c | 49 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/trace2/tr2_tbuf.c b/trace2/tr2_tbuf.c
index c3b3822ed7..ef57376f3c 100644
--- a/trace2/tr2_tbuf.c
+++ b/trace2/tr2_tbuf.c
@@ -3,45 +3,64 @@
 
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

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
