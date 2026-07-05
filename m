Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA736EAAC
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239896; cv=none; b=tlEn6GcptgC3GkYmJVHb2gXYuuak+HkgrQM/PvSXx1Ls2SrqFZT7gknXCBV2+LCOkwoWGDjjCB+Tm/3fsx+hyyHtjRie24+LM3diWAJV7aC/W5NSYFBquUSqAaWYFyFFwtcuF6a0AR/yVsqdFg8hzXV/x/86TbZpXYT2i3h3oEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239896; c=relaxed/simple;
	bh=mrBcuP5uqIYjQ75rlD36u0b9wt/y08coG9Knk8FjDLo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hhrn6StEifP+ogNQpcvhsPp73TJQJ6FydNo7McZqhzc8byuZgjSGnDh6f3nfMQBeGs3eB7toI51Q0/TsxmK0ByPc4CSUUqlESoVzdtR+hcK74Ttha7mR4qUZAX1i1Hm6FfqPhFe2SOpWXQ4pHuypqWA/R4hqbLf5ML/yaYQHUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gACmVHWu; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gACmVHWu"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e663c828dso110223085a.0
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239894; x=1783844694; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDKq041CEXhPpuz8LfGlSSIJN7u8oShSF1f6hHy0Lfg=;
        b=gACmVHWurdPh+h+WK48iWb0FMDLBwHQmOX+AQCilimLfuWUmScsS4NCSO6dOaMAWUv
         YMFNK1iCUMsBgcwJIieLPLgTT7Ubn0m5EKI5q8owMSIzduB+u49eJAfMS7tndyJOzQlL
         MgR/PN8hA7qr+vdBX39SIMRcKcg143hkjqxQBTrT8rBM88D4HJlnnfNsvZAa9EqZi+oe
         veOevERLQlKvKhKkEtn0JvluDYvSOTE3YAHAWPYNTAkximxC6EilTrHraswxuSx4oxT5
         cMnFrm4rzlF8p+okoEer0dQayeet0inWg1D7kdWOpbm+r2lYm2fNW8ftHvw+sEV08xDi
         NbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239894; x=1783844694;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tDKq041CEXhPpuz8LfGlSSIJN7u8oShSF1f6hHy0Lfg=;
        b=DdAzUM+e5HWlXSf4uTs3PipaoVmyD2Yl1xdFMqn1oquhnEGT9q7/eDqd6fQjBm6zwS
         HM5QfzYUU+kXp0OsLGgD7mR/85+iUSeCU1hmCsZY5Sj98DCPL542Ntco1irDxjKyZuhq
         HD5OJBzP8TeiDlVydvVfZLUHkVHkUGXjnO/+fd2yWccknFDI5gqosxgP94bfov0TBvfy
         oOBxHIhqzw4y2u5b5GZ6Was8aC6fePZtZX2YoRLsh3bZFAoQGbaDxAXgTNjRxTEFmOX3
         Zp6zybJ2PDrJg406G33NGcOhksxLe9mFoCYlbXZldxBrlMSWXxMie4cfkD2OsQTWuBM5
         7+xg==
X-Gm-Message-State: AOJu0YwPLodpiyCYsRoAzf3w4cR3n5WGe1+3ScUob6vfHZsIssKKKg73
	ffH2cka+n0XnGnwtlAdfkOUvj9EBKWUlIAXCIfjIKalTQkhl7ywjXSeUtGi9CQ==
X-Gm-Gg: AfdE7cklGF+paUjCehRhM0xHpbXERN4PVIsdfLC1nz3p2lGufp5nBrEBxDpguKg8s8M
	BJPkIUizCKDQ81EHELwmGBwpAOYjRzVJjMDH8VhRWyxqZN6HCIfj9uWNNcQfyy5ZN7IkTTigKRP
	m7ZJgqbCcUtwf3uZUGPuJeZ6DtafZqeLTrp6tZN+WJrMkcKLptilJo1i5/0KhpFNvjOVT/R8tPT
	UA91lFr7Ov9AXNOWj+CHI+Hw2JXXTolAGj+ee+5akxxC0HwB5bOoQZdLFAClrzT97gIVAB78IWl
	wnC8RHkN6uutp4Wiy9mlkXiUgRHoxKSKF/2u5D9O61UoxZYKDm2WoKbO9jiw4O9CKuE2ICGXTE2
	UGbMUVnY+sBLR7x4NOvYj+AByClkJkus0rVYugAHMB4QRFXOVhuo5A1L3mwI2/cMYN+AHQ7/5L8
	K/NI9OMieKxCuPg3T49g==
X-Received: by 2002:a05:620a:468f:b0:92e:5232:91f8 with SMTP id af79cd13be357-92e8b5d2342mr1246348985a.43.1783239893662;
        Sun, 05 Jul 2026 01:24:53 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bb8629sm627933085a.19.2026.07.05.01.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:52 -0700 (PDT)
Message-Id: <97049d7cc3960937d822fb9403849d1dba063b78.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:28 +0000
Subject: [PATCH v2 11/12] fsmonitor: plug token-data leak on early
 daemon-startup failures
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`fsmonitor_run_daemon()` allocates `state.current_token_data`
before any subordinate setup step that may fail (alias resolution,
listener/health constructors, asynchronous IPC server init). On
the successful path the listener thread takes ownership and clears
the field during its teardown, so the `done:` cleanup block sees a
NULL pointer. On every early-error path, however, control jumps
straight to `done:` with the freshly allocated token data still
referenced, and it is never freed, as Coverity flagged.

Free it at the top of `done:` and clear the pointer. The success
path is a no-op (the pointer is already NULL there); the error
paths now drop the otherwise-leaked allocation.
`fsmonitor_free_token_data()` is NULL-safe and asserts
`client_ref_count == 0`, which holds trivially here because the
IPC server has not yet begun accepting clients when these failures
occur.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fsmonitor--daemon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index f920cf3a82..4161dd8282 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1418,6 +1418,8 @@ static int fsmonitor_run_daemon(void)
 	err = fsmonitor_run_daemon_1(&state);
 
 done:
+	fsmonitor_free_token_data(state.current_token_data);
+	state.current_token_data = NULL;
 	pthread_cond_destroy(&state.cookies_cond);
 	pthread_mutex_destroy(&state.main_lock);
 	{
-- 
gitgitgadget

