Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8A73A6EE8
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259670; cv=none; b=fvlt7iUODdUwzpRPYzDwf4nbELZ6RBvXwwh3RO2E3Ltn7Jjw2/05360uTsH56XeCleOQ2ctFHYG9FBbXLn8xujhz/HdsZQDaOqTGIrXwwtcjDK+2xhnCXxnydDQagC+NeYzMPnKZXvHaHlZx9pT+DkGBK2qiZdac2qTQpNGD9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259670; c=relaxed/simple;
	bh=bxwAjsX29DnuGrakQVUobpobvvNWpqENpdU8Sgbrc0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=R5dVN4275BICzj9K7L9WUJUUTKXgHGC25uQualrWBT8HMnGpOrIlLSEUX4P4Uu6c996BxKo9jL/1MGXl2FdNJoKZF1eeqqp7aNNhRUjoOyiFv1xGme9vqqwQcxMTqOaLMqS2gy+bJ7UyIcOacG4+yNNJt/pL8AwznhFOV7btVyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkalAlTk; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkalAlTk"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50baafd6c4aso70013161cf.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259667; x=1776864467; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=bkalAlTkPp0wRdSMSX39G9V43t/lBhKn/RFU1rQvxKxda3CkpILejf/qZOhHklwCFx
         IpVE9J50M5L+LFwAkLUHYmKF2AlGpjX7eV7r0VC1mW5EgZiT2PdRWRj9ZQ0JinYGbi9m
         98681Hna3xwiRHYQzcEVlyEKYiFqGmB60vA6SOqfjArHAW+ummNgMFA3gH4TR7j3iWx/
         0Gt6Z5f5Wss0N65WsK08vOK35h9dczpxs18by1VweWg65OqkGVBeG2qrkXxaV+nQvN4Q
         otq1PyvuNMPumI3SrblROVG8o1ZM81YauyXaMtyqgBFim558kx/JoBwZdfQytI13Va9h
         FsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259667; x=1776864467;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=GD2wNldfwWTF5AuxfKlYg3TK4FzVmrTl1m2ryKLxDcyJf7qmbeITX1fvX/YJSovWOM
         y9y4jFxGjft8a6kH4y6Tc5V2bwQzrSz9RFk5Z6uL8BXipe1+bKUGOVXrlzJqIa8mkgIw
         prdYn0xpCbfQUBibOtscEku5uumXUiH3MArExHcFeSiWlpkYZHSpd9RWmQQCbDFEcy2O
         3fnTZh3JhXpi4p4K1yfT7oBlwpefs9CdDR06MOlj7AI31AFv9RmwvVwYOKmY2KRtYlv2
         CJnkRV7PZ97aG4bFxXBEQlXmGSdgs9eDhnYeXTp9EfnC0ft9LyTOYp6Bhrn+Eo2JUBWU
         Emhg==
X-Gm-Message-State: AOJu0Yw/t+lG4JfRJQfIJ6mNwPeS1mdbVuDTw4wlxHHUHRBr+cofsXBk
	2cRRkxF3o6Q3qvKikvu17PigyXribPVuWVLJaAW5DK2frRC+Bx76ES3WFjDZSw==
X-Gm-Gg: AeBDieugpBbkv5r0gwLE7nQyhIkJlRdpCzsVi9AJVKA0WPPchscgz8p35o+xfZwo/S7
	32dlKJ6dmHa//n7gQYR4y8VJUIbaFfNq1AM7igzKBe87g6m6SbstC6heBkoGtkiv1hD3myfgS8h
	8AKL/5D2+o35wCqQ67CM3FBh/HW2YnrZm/ReAopew9cykhgKCj0n3JmLbSCcBlZ/OQ5iHvXHEPG
	Xdxntjg2ng3Jw5HCM5r3+6ZCJccyw/LjoSFAaCVSR++dF8EvzncqCF/wqWBTzW4P6B2NTEXDXMY
	4JiHD4Hc8MEO04QXh8xwfxZo1PVqvgyEaaCvKEFenPrgtdeqI6DPvIzHsfS297Kcu5fUn9rPfnL
	b8rIwrxfjNNd+NOaO/RJCnSb7JB3VYWQcTlOX/aVLvqgLBIZ8UeV+S8mLcMZE5/oRcMkOk7S4g6
	9setcA2ufx/c0EcH7rtRgXCzg5CeArFmdCwa2N
X-Received: by 2002:a05:622a:4886:b0:509:1579:7c38 with SMTP id d75a77b69052e-50dd5c3d999mr356297131cf.35.1776259667192;
        Wed, 15 Apr 2026 06:27:47 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f32f205dsm114728285a.46.2026.04.15.06.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:46 -0700 (PDT)
Message-Id: <7b62c95c44bf1981d576e19aca77d26ce77f57b5.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:29 +0000
Subject: [PATCH v15 05/13] fsmonitor: use pthread_cond_timedwait for cookie
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
    Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Jeff King <peff@peff.net>,
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

