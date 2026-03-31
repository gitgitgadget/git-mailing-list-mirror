Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C64C27FD49
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937974; cv=none; b=NGwnxtNvel3mHSRmtehZGTNZSMrNbQVdO+eHY6xpGI7TmP2p8W2wYXUlgDi/NZ/zfR7LevhumzvjVeOSRftqYJCtqO8BPUxf6PHk0xYuhct00oXG06pBZrHCXhZr8+oe70pdfGnIUgTjQRyQoGnSnevjE/oXiwJoWIu6geczxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937974; c=relaxed/simple;
	bh=bxwAjsX29DnuGrakQVUobpobvvNWpqENpdU8Sgbrc0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m2vNyK4HrGOQ63CQ6g3xLdTH0M8obmshYdP3bxuEB/wTL+R+UvLeUYeQ/E0at3SdRhFZAEApaR4dTjcEyacpvC6EVMEntw807xKF46QiHbsSS1Hn1QODYX6lT+T5bn0mHG6STMx6rG7oEM43a4Le7nzFA/e7UV6KOs4iW7/gK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9SBDS4d; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9SBDS4d"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67c2b70124cso2928734eaf.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774937972; x=1775542772; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=X9SBDS4d/3b7ZZWvPxLeYV+ZTsUkCVjnyhO9ynCgs4il1r+w8m8GFUAaOhWrRsmcYE
         tjkVuCduAiiY2MTZ6vlcA1n2sxaCMVNrGM0BlJeQg/dsiZNmyaTAfuMVsn922uk2WWOi
         KVyEFN6CdRzEI9z9dyF+nce5ftHMw/0DwzemGxGl3h5RmDLNs+8+paqZLliWuBeEPjqx
         qgZlqmO47BKx+1e2OoQ5IUSOsgtlPBUMYqZ1bW2OzM++PDQo9j2O9yTN8EO0fLcEaZnu
         tfA0TjBiaCJWX+OFsZi7rqm8gyT9eU54QANprLadsWtlfUXR4il6sVcQXK5eKJNNOel9
         mWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774937972; x=1775542772;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=c8rd42hv+muEkcf9NOsdUSsOrkbpGjHeX3tO5m3OUHODucUnTfoTFJ5aXXyoeYM5eL
         GUDdh2skuI+RACcHeLPfV2vur+FZ9/whUnKcWkF/0eI7LCPAgY8PTDff7YeyPSEyD/TA
         pXv84yeqn65K6JXM3KggEQ0HTCrV0EMfuUz0ll/LVIHFAYF7lgSu15ROkFu7TE6NoR+s
         Ks1kFcJy+UXUnF2O+/JdzR7f9djSb8+zJwCL9a7r9dnTCJhGtg5WKXbXPaYd4MsrrDT0
         5758/THlx9mM00Oe02Jrf12XsfBzJL4MOWaomKMbYpZvu49NAV4dB3e63RNCRZEeRyI0
         xoXQ==
X-Gm-Message-State: AOJu0YxDeuH6GWiR3V0P7Na+BH2EuF8qDeNsx3IibH922xGEudoabMTd
	N/cnDetdfzOLDMOJyZnPA08RFbSk2CuTFqDfPPYlDkv1qYrG9MI5V3hYCBgNpKtJ
X-Gm-Gg: ATEYQzwamkt+WtSKtFuTEwgkD4+TGdG29eZVqJP1IgNOfIIjXRIWoBpTgcyYJ9rxHT2
	5yIo7M1c6A5UXu+fQtmHN0gcEuQNgw0HTmTpqANaeca6vC1bI5e4NC8lgJN+jvnCuy0bGRcEfEB
	er2q90ZxfOlovP27qnpxvVUQbvH2kGXlaZkxR5tGLa0za0WmQmXHxxh6MwXDyl+Cf9VdEJ3fHCO
	JLAcvYsW3xbh6lBV4tl9RIazmBa6Ppi/jYXk+uwn7SQUoa3tK8Bfbci+uydvPxIwIlg4OZZ2KX5
	5X1jMQunc40bzi8d/1b9sYczzACbJKiBB1eNGqA/RhW4+MJPKOt3pQk+OxWYRDrxgGryhhZ3C/c
	IAwindwIst0BuMU1TaLemBwEhgtup4kQ+zosytlYY9ECgEFrV+OGUPZHuwmwJ0ZqBJ4nYxAgkpK
	oVqceprszTSeYcNvTK9EzVh/u/b50R2Mmbj6PT9Q==
X-Received: by 2002:a4a:edcb:0:b0:67b:c368:1369 with SMTP id 006d021491bc7-67e18789a18mr8444359eaf.67.1774937971815;
        Mon, 30 Mar 2026 23:19:31 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d048e47cfsm5941101fac.3.2026.03.30.23.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:19:30 -0700 (PDT)
Message-Id: <b1081d1e1370bb9c9755d0635e7c7466c954f046.1774937958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
References: <pull.2147.v11.git.git.1772693712.gitgitgadget@gmail.com>
	<pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 06:19:09 +0000
Subject: [PATCH v12 04/13] fsmonitor: use pthread_cond_timedwait for cookie
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

