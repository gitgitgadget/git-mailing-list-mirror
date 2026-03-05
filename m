Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455930F808
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693727; cv=none; b=EpRVCHBRkP9Ie+s4ANjByG6vxNgDe4A+o8CS5Z2lD99MlQG+Lqc8hdCi1QlmLArk/s8Ci7u3FcM3cM8beTEHVVuKpYA7oNh+I0KesdFXfRqhwjYbs6BkPJGO9xREJyXVn4wduo+k0blTKU1I5fbJbA+QrZEWHJ/O86obrzOsjrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693727; c=relaxed/simple;
	bh=bxwAjsX29DnuGrakQVUobpobvvNWpqENpdU8Sgbrc0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mU5mUc5VwA03rENthV3lczLOh1UFKbiUHUp1Wmv5frk0HXiyyORKOeXVpITl0JLwJPe5YFc0NBMRt4GGP3tuxlTQoUkfKSI/TA9lO9VVA+bqz3ugoS8mjnToI+6LCq6fHrS7SqDmItHydayUfdja8DZ9kSuhSFghG6PUQToQ8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zukkwe66; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zukkwe66"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1271257ae53so9332991c88.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 22:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772693725; x=1773298525; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=Zukkwe66z15GehuhRl6v6dwjoAc97MR3iG2BxKDYvR3dI7o3SMii2naaSm+aGgHSCZ
         I9XMdzLfDjA42yB23E6JyK5Lvb/yHyekhZOituBHk+qxDUJNu1xulVIoPgEXzZKEHbyx
         ++PiSdmnI1yJWnPenwKAyCgoKHyIGoMNxhr0aSL4cEqLOrO+ETw3rET/2OSO+seRi2Lh
         komwiGnGwiEuWVy+JNHjjsnCygeRiUs1T6GLpJ3o1Voqk6c3Q0SGRlDhwZJ5513SDSua
         Nh9vkCzLU96UOhA6VGpWzKf6NekaI1CKlaSv+9VQvN3s7leq/1kXCYdz0TO/IfcSH8iQ
         H0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772693725; x=1773298525;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=r7VdMstn1aNRwv/N7UJA2IpihQZs3CBWyYSa2hFabH10wex8YKy1T1/qV6EIb35Vg5
         SBz8GsCvSIW2+ZQqFQRAdMB1YlaIYANc4eyJ50kzyz4AsdeZBlH0PQui2onD9QmQJA9D
         EfyvLEv5CFMVBRnZP39hggbquXAwRupV5GqWYddzyS4gXJvH8D4GoLxFBawoJyxIXofm
         UkFphNSA6PUAI4mgkMQnX3m3vYAQ5wGEO3nmUt0Msudh0FQDf/NsPoQpwYISDCObT2qF
         WExIs3hnQ1oWypsms9C8cxX7WpXMHGKq82pjzUw1727wV+GsLWmTTWN4lKUJEWtncNSP
         plvg==
X-Gm-Message-State: AOJu0YxKpUu5/fvGO8kfvuS6zuZkaNbCZZIBrKkwpZfDLKvdr6aUsImg
	XRvbT2ADqKQptm26sEAr4UgRqOMI2+MIqgHdesVX82Ihia6U3viTTicZ0pDLzw==
X-Gm-Gg: ATEYQzz6A0s9Izt7EWLuA0QHZlgobj/OMQcf2bY4S6sPSQGm9E0GvL/ZszPcPZS/ger
	Tpb+Im/cNx6AsgqImLvqYoy4aI2C+DyO4RXhncsk3EQl2vBDJEerFquIoho0cVrKjvEQU2ZFmtR
	iK7xwweYmkLWS0ZRgUPGmVeJyYHB75tbMhesmgOgm08vX77WYRu70Q1P5qwkORF3dueU4sJ41jl
	P2Zlwo7eCNtP/lCVaZXvSKTvFXqa/22EkaQtjOoMpCJXwGtX5gv1xxrkDB0G0X6mq12q/UezKJE
	mCIbSehX8JdcH2Hs5uE8LEeYDp+A5elkxbQ3HnUURNSBdVLcEbVdxLTZtZZzgUmZQfhBpdukd6J
	1BY46JeJaDxFJnN7WWU3oCukjzGlrvgCynsJwcyvki/2yek5Tkv5W7DxEUnLAql4+Z8ImBlUnJu
	+UQyhKmt+D/SQ26eXQxaSX+nZWbQ==
X-Received: by 2002:a05:701b:4250:10b0:128:bac0:2ee3 with SMTP id a92af1059eb24-128bac02fcdmr746690c88.33.1772693724799;
        Wed, 04 Mar 2026 22:55:24 -0800 (PST)
Received: from [127.0.0.1] ([52.190.182.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128bac04455sm1559918c88.1.2026.03.04.22.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 22:55:24 -0800 (PST)
Message-Id: <b1081d1e1370bb9c9755d0635e7c7466c954f046.1772693712.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
References: <pull.2147.v10.git.git.1772673378.gitgitgadget@gmail.com>
	<pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Mar 2026 06:55:04 +0000
Subject: [PATCH v11 04/12] fsmonitor: use pthread_cond_timedwait for cookie
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

