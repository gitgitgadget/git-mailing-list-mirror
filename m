Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB9D393DF3
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498109; cv=none; b=hwddwXoN9hxnGd4AV0Tny5IeCexw6mfuJlgx7l4rOqWJ23sQ+oeBpLmCsSf/4xPi3t7t2450nS7YJDMaLKpprZpLl2oT8UciRHWU5Z2Mo23q0hdbgA7bPXA0xD96H8xPqCDL5QWqdo6RUzifO6ep5oRdmZP05gPMrdxiInqrCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498109; c=relaxed/simple;
	bh=bxwAjsX29DnuGrakQVUobpobvvNWpqENpdU8Sgbrc0o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pToT0mX+RSg8Fb0WaKpYWESK1G1TmlEqqXt5/iw2L1zPtsh+30ePdkExOxPPJKsNRk1Kwz8kQnIe9Kwy+wQ75x+9NC5f3qOb3eUdlzorl7FwpoCSK9vFJaer5rI1q8LAmeTXm4AS2HJOWMHS7o84Wc23HIopP0+5UgerJ25R14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJtiSouR; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJtiSouR"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2cd339aeab4so2694678eec.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775498107; x=1776102907; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=SJtiSouRiTDQnLHI89alTISL40v5XBPM5NWNFFtrR/lr2m5pUBVmx4IgyQMKvaoQTT
         pojkNZdUPWcK/zEsMgQ2eIFslBm2IdbthAB2jRuTcZaOsSVPnd5F0ShVHacGOLPr4bLx
         SfesXlB3EFfkE8NP2Eb9PYUz7mxzS6cxAzwjYocZvj7KhS5VaOS9JbXibnGIC0Z8uOtr
         iYAfx1gQfUE0lbaGPW3spzKnuF5nL4SPKSS7rNEC7uDnesKGgCKJamjnf3/oIbebzSdu
         grQI0iU5n6YmB7LvH7alTWrZZUWS8lLQSXoolI9WwMET2+u6NKSUvh6OOSMU1+pxvvtx
         AVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498107; x=1776102907;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jDND2JG26mR2BXpb7lJQM40f5eaB12kTc8+AZM6go+8=;
        b=nuAlbvwNbCIigniN2Hp88qN0xROQS8d0cQrhOTV3b0YiT9b0l3unuOXzE3o3t7wTl2
         QmLkA0/AXq+Ul1p43HZKedNsTqtt8nwabHjKN7RK+Pf7dFFBbjhLV/lQ9jKdGs+N9rfN
         XucBXCJYoi+n8NAbbcGd5tIS/uDcMtIZ/FyG/hCukBuX2HOtr+qPbqlbsEp0oCGRUiol
         LPdyBQgFYleXNlG4o8wllLeKwg4KlVwaKvuf0binhiUg/3tjLVLA7mnGGDRMI3v4jztN
         pRgOrVWpHkqIzasJVQzhwd6maTGpSQqxleKGb7+HQNiDq+ubw0y96iMR+cVG5MM9Egbj
         z62w==
X-Gm-Message-State: AOJu0YxvB2lqT8Zme8xE30+b8xGTqCvT2tzIPc8ql347d/Ocr9Qg7w2o
	kgi7jus4ERD1skuzkKXqcaeLfmKDFwkkwnhSv+vb/BkJVMv8chL60HlZfn9yBg==
X-Gm-Gg: AeBDieuNPXbQ+y05K7Lfy0VZSpDbWXh6SXI1Pr+Z26gLcw8jtDlZvjouuNvSuXkD12i
	cpaFOyVeNmWHYjm8y5NKx6oMWDlKKTOcuZaTm45tJIrgiAr9RrArx+9N1B9/v6ne2yDovxj8C47
	F/ic/VCkNaS2krRJuHNCxU+3JjZY2qFybCJPLjbSkzCpYwOJ5DXlA4+Dn8JuKvV1zPCJ21ZkWpv
	66xmHPLjvGLALFyPkLJR1lG6Uz2zbfIXsZNu55GNNMwWR4BCIq5FTfElTuVaJe3sa2ZZccwYaGs
	2bG5c4Nxw8X0BjS/PlBOfUtkJUcFVqjZzg9FCb0NtRSCuDTyJjLRvec7kUQU4mqFH5T8lZKqkRo
	LdNIKRb7S235CYHH3SR+0pKoduPkubgAGs89dQV/xexv8ZJS71whqIxbplY5ob4GYCUkYaaWK8T
	kk5lE7Oa0b4hpSUj/dJCmnSMG8/ZU=
X-Received: by 2002:a05:693c:3018:b0:2c8:8ae4:962a with SMTP id 5a478bee46e88-2cbf9ee8dcemr5527833eec.2.1775498106954;
        Mon, 06 Apr 2026 10:55:06 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d11a96398asm730851eec.28.2026.04.06.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:55:06 -0700 (PDT)
Message-Id: <71effc4d47d56a2ec7909f589be4776882dd703e.1775498098.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
References: <pull.2147.v12.git.git.1774937958.gitgitgadget@gmail.com>
	<pull.2147.v13.git.git.1775498098.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Apr 2026 17:54:50 +0000
Subject: [PATCH v13 05/13] fsmonitor: use pthread_cond_timedwait for cookie
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

