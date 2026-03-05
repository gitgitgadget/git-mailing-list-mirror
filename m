Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEFF1E531
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 00:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671932; cv=none; b=ul6XcHmA8TXOzxvjza0as2VpqSvuOdFIDfUWOZEhc6uBXgopxc0sSzQjvBppRGIOW2TMlxoUO3QevgKBqphRrIgWtpw+2JCGMFDQ4vpuEKRTDHQW6DjKGIqz4tlOIaBvO/J23Di76sF2oIws6iymVjcmYB6mkpSs2phUVPvhsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671932; c=relaxed/simple;
	bh=bxwAjsX29DnuGrakQVUobpobvvNWpqENpdU8Sgbrc0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YWvOMBfMdbmhmc6U9kYU1NAGgkQGOml4YhTNddn5dLQp/+HweVs6wRjkK5kCRwG95vdOig16jR9nWBBNpeQZLu0pstkJ7iyxfSlT7hZVv6XQ3IH1wDrtgx17BQX1fm0sggLzUGfEQevN42OkV+Wn0fngTF2S1ZmMH3nLrcx2lNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtvVi3vX; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtvVi3vX"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba895adfeaso6646420eec.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 16:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772671929; x=1773276729; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=TtvVi3vXlkIl0L46EydZwTmPW7+4+U3Bv7jtuwpY6v8XU5fKhHWGIMmmUQhaNihwWA
         tHOTWBZK/blxwmmyyRq+jE1FO9JcKGM28OZwAWvw3SI7PsQy9v20vnqHh13UFXyOXPOS
         RmiZfPTNUTb16eoEM0fFkXJwfPoIaQXCnW9oS0L1ZZ9QlAsu1g4eVaW+TgltxKzeebNu
         RvtzKlz2bqRkm+X0py6s8fbTvsxD9+bnWXrHHp//71W5/6MoCqgz1Ru6SBegSxDy9qAf
         MAIR+4RW3JHZi1PUVhCh4up/iEWMzwWJ/BoV4e5tcxqJjGAe582Dud9n6Xys6NqyPeha
         CxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772671929; x=1773276729;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=kPxiMgSqhBGy1tvhTcljIwFDHfFCNZ20MTOiHEbXR2jdCm5Cuvv8GwWsAASGXlMKq9
         F7yhf23ZcjtQjPKrH9oqVmdl+LpZwwWAddLk5I/EjL1kqqChz5wJyeofAmNoY5t89kOy
         EtXkoBIifs3Jlb4apW3BSLjhD2yCJhXTnFD/l8LaZNZWm48jVsxPNLWqyHVKg6BkTwTv
         isyVw9bg/QkgBW74OllxATjNwrMF5ryymxRir50EgR78+uzGXec7oUtyw0qPcbgKn4dp
         nN3kZ8jn9FtwLzAZifHzrCPtuVOtHmFZbQZWumHuWJlSSdoG20sURZqRowoZguWp9qNl
         kU+A==
X-Gm-Message-State: AOJu0Yyi1R2kn4XKmxCN3JBf/E5SAQKkWU0O4H6+EvjZ3iZK08lnt67/
	LdKrqNTiaAnbo6cchDoRWCacIbrGvnvAgzIMgYuvfpCIWKPhPBlZV0RE57T4bw==
X-Gm-Gg: ATEYQzwhV+v0/iPOsFCCIdPJ79BiBdyk/rStjiVAsLqW5tT76Qijo2lPewoD18rgVPv
	+SZZJ0i2iek2zhwAfRAUIdky8e5s03Ys8dbZZcmT8Dn8EYnbgMKrY31XX1MqWiM8h+bQ8Tx6kZZ
	LClACj6OXQ4IEKSXn3l6a3wKJrHEn2YAUeesWJR7kTDh64jpbGxwFs6q7s6r0YRLOnnkMxWlCAs
	KHzT/yrJtvztrapBD0W6GyqQakMSVP3Ox9bJFsdmtfVs1hMRpO+cb9HAKkrooDp2GCvShwPKL4N
	hzT1R/EIyq03NNML8/HuEY+BCVKMrXVfBRavvAbGbGZ28JNAh84bSAUg3P22q+SfN8GGHw5dC0i
	5GdSqBpYV++isqr+WM6td8OvQ1V8CZ8tJLUMU+GxIN5h+OcWV5zfQZt6gKitiugUYzp3I1DkAvH
	7MTZjE36kmacj3w+G66/9TT2h3ZmjEBIIAwXo=
X-Received: by 2002:a05:7301:2f88:b0:2be:778:49aa with SMTP id 5a478bee46e88-2be3108f8d4mr1455959eec.27.1772671928602;
        Wed, 04 Mar 2026 16:52:08 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.148])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a43c12sm21414787c88.14.2026.03.04.16.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:52:08 -0800 (PST)
Message-Id: <b1081d1e1370bb9c9755d0635e7c7466c954f046.1772671920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
References: <pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<pull.2147.v9.git.git.1772671920.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 00:51:52 +0000
Subject: [PATCH v9 04/12] fsmonitor: use pthread_cond_timedwait for cookie
 wait
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Paul Tarjan <paul@paultarjan.com>,
    Paul Tarjan <github@paulisageek.com>,
    Paul Tarjan <github@paulisageek.com>

From: Paul Tarjan <github@paulisageek.com>

The cookie wait in with_lock__wait_for_cookie() uses an infinite
pthread_cond_wait() loop.  The existing comment notes the desire
to switch to pthread_cond_timedwait(), but the routine was not
available in git thread-utils.

On certain container or overlay filesystems, inotify watches may
succeed but events are never delivered.  In this case the daemon
would hang indefinitely waiting for the cookie event, which in
turn causes the client to hang.

Replace the infinite wait with a one-second timeout using
pthread_cond_timedwait().  If the timeout fires, report an
error and let the client proceed with a trivial (full-scan)
response rather than blocking forever.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index d8d32b01ef..c8ec7b722e 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -197,20 +197,31 @@ static enum fsmonitor_cookie_item_result with_lock__wait_for_cookie(
 	unlink(cookie_pathname.buf);
 
 	/*
-	 * Technically, this is an infinite wait (well, unless another
-	 * thread sends us an abort).  I'd like to change this to
-	 * use `pthread_cond_timedwait()` and return an error/timeout
-	 * and let the caller do the trivial response thing, but we
-	 * don't have that routine in our thread-utils.
-	 *
-	 * After extensive beta testing I'm not really worried about
-	 * this.  Also note that the above open() and unlink() calls
-	 * will cause at least two FS events on that path, so the odds
-	 * of getting stuck are pretty slim.
+	 * Wait for the listener thread to observe the cookie file.
+	 * Time out after a short interval so that the client
+	 * does not hang forever if the filesystem does not deliver
+	 * events (e.g., on certain container/overlay filesystems
+	 * where inotify watches succeed but events never arrive).
 	 */
-	while (cookie->result == FCIR_INIT)
-		pthread_cond_wait(&state->cookies_cond,
-				  &state->main_lock);
+	{
+		struct timeval now;
+		struct timespec ts;
+		int err = 0;
+
+		gettimeofday(&now, NULL);
+		ts.tv_sec = now.tv_sec + 1;
+		ts.tv_nsec = now.tv_usec * 1000;
+
+		while (cookie->result == FCIR_INIT && !err)
+			err = pthread_cond_timedwait(&state->cookies_cond,
+						     &state->main_lock,
+						     &ts);
+		if (err == ETIMEDOUT && cookie->result == FCIR_INIT) {
+			trace_printf_key(&trace_fsmonitor,
+					 "cookie_wait timed out");
+			cookie->result = FCIR_ERROR;
+		}
+	}
 
 done:
 	hashmap_remove(&state->cookies, &cookie->entry, NULL);
-- 
gitgitgadget

