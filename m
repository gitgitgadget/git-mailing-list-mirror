Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FA3A7F67
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776259682; cv=none; b=Izp3dp8xTye/ZLtenEG9z86/itP46zNEROELFCyhnDcrP56ScfWGHbZl+JQovoxlj9J7baGlUGviiRZqn2YT5wCr4TUxKAkksuqR3uwf5+lN1qR43OLqfdtepb6srz5jH9NI2nMRNegueRXtDmKbE4ipGgfZXUUhQnLJ8S6TqAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776259682; c=relaxed/simple;
	bh=wW4L5f2UPz5JB2XuHq37kfldUvOK8IUq2BxlaQwTYkw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UhAopKbKfJmI5elkDoNR/mrcTXD+x7q+x2lwPmJwWTBEhMH3jdexqeYoNdcq2relE6mIHgDkdDWVxI2V6BmWMRNkyHX+I0XLtAsd/hszXqzAoqHcvk7IX+FZyDlMmJk8I586yRetygeSqpu+A3lvtP/60atMBJ1Lbd+gbwqz1oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxF20FKF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxF20FKF"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506aa68065eso52123911cf.1
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776259679; x=1776864479; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=RxF20FKFH66usR12X1+tlNLlOHMxe3K3No1XkV58wgIxf/yKOGogq7g5neMAtfglZa
         74JSSlYj1VJg8c4qPPuJVMXPZenkHGF93CMdEpBxxIZCnEcXh9B1q6J/iOGwJfwNFLxH
         NUJVr4mUKgTtt734AURST7wfuOV8nMAf0HBaBeSp9bSfpe+/dBJAPalwY963DzWZMqAg
         KKAbhpJLRxOTV3Coe8CXepWMmAbze6IrB6sUrxmlQCl5Y+cWhgjRHoc0/lwV/4tqpuKl
         l7IBKGDzYldExBI8STl6yhfJmnTMfmPwqpzmMh5AqJ1qVi2s5oph6nok3AqluXBLGXyp
         A4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776259679; x=1776864479;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C83czoS95l3vv2klvVyic5XtiDMyrhb+y+/EC4Hbov4=;
        b=JWfUBp0b6hn8Qo4e4ZgU3jygo/5c//HKIUfDoOJ25AGCfkFNvKNP8FKs8OZXOAknY3
         sG8tiqMJziRtibypD4vgdCPjk3zprsaxUOoUIrzY8BGk9LoPIE/+sPW1yuvQpXMSjmMy
         mh0Aqpy97GH6E1PRW7BvEFX+tm7Hqtz84tRmHsU9ip3D6+3/grM6IpeLQA85BD5EmYw5
         lBQg8vWXDyETkmjWJZv3/uAf8Tg6Vs7nNThRqllO4++IivXJURz+ajy+YtOgsLwRgKrE
         celQwoTTPO+Ve2IVu2cnc8F9PzDmh6Oo/MM3Oz4NPYqaWnQEH0ovix9neGH9JoFfgmkb
         9zEw==
X-Gm-Message-State: AOJu0YxPsQ1yHSo8ZQ81cmZI+mT4szRLYUgIqNetXQfp9mqxpAI989XL
	jjKtMF6ou9ViM2bBaCFuCgXQeRotlyS+P38aT0qw54nP88BDolfn49hAaAtwYg==
X-Gm-Gg: AeBDiesCKVCPFwb7kalyRn7DmXijBZUOhz03w4Tk0e0gMP1l0Q33wnEjGO7+EMBXcw7
	n8GQsrU2NXiXnKzk7NpmMMHbh0lZdICE+v3ByraGs96yHt7JDbHEg36BtUB4EiqDWa3UrHVTvY4
	bxAS+JIQquAA7i4FBAldSnMm0CCHjwi419uMgU2O8Sn2MIcVnMSAMgrsr1R3PAVk9ivdqut/muh
	yZb34N4OVDEUyBTWlE0cwVGA41LI6SQ1E6D2cE0GxVVrEW/x10SkkCGeHaSpPScSOdEkNDTm9a6
	WLg3uWwjwwcFVe9ofKMWnmuqLcymwLMnAILk+mOA2GI53ABMbhFs0rGrBk5OtHFS+VRlKZ3xOnc
	UyW0KcaZweyXDdRbFGMg+pzdmCf/9vJyj1tFBpmuZPQfNF0C3xzyYkLGXsq60dICNTtmX0SSiMy
	wP6FZ+aGeFkVoNjwLD7nWos0WK1w==
X-Received: by 2002:a05:622a:550d:b0:50b:2876:586 with SMTP id d75a77b69052e-50dd5ad112emr323297971cf.5.1776259679225;
        Wed, 15 Apr 2026 06:27:59 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1ad95796sm13565011cf.5.2026.04.15.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:27:57 -0700 (PDT)
Message-Id: <fd6bdc8c55cc1acc07586815f09925e4ad6796c3.1776259657.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
References: <pull.2147.v14.git.git.1775710775.gitgitgadget@gmail.com>
	<pull.2147.v15.git.git.1776259657.gitgitgadget@gmail.com>
From: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 13:27:35 +0000
Subject: [PATCH v15 11/13] fsmonitor: add timeout to daemon stop command
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

The "fsmonitor--daemon stop" command polls in a loop waiting for the
daemon to exit after sending a "quit" command over IPC.  If the daemon
fails to shut down (e.g. it is stuck or wedged), this loop spins
forever.

Add a 30-second timeout so the stop command returns an error instead
of blocking indefinitely.

Signed-off-by: Paul Tarjan <github@paulisageek.com>
---
 builtin/fsmonitor--daemon.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index b2a816dc3f..53d8ad1f0d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -86,6 +86,8 @@ static int do_as_client__send_stop(void)
 {
 	struct strbuf answer = STRBUF_INIT;
 	int ret;
+	int max_wait_ms = 30000;
+	int elapsed_ms = 0;
 
 	ret = fsmonitor_ipc__send_command("quit", &answer);
 
@@ -96,8 +98,16 @@ static int do_as_client__send_stop(void)
 		return ret;
 
 	trace2_region_enter("fsm_client", "polling-for-daemon-exit", NULL);
-	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING) {
+		if (elapsed_ms >= max_wait_ms) {
+			trace2_region_leave("fsm_client",
+					    "polling-for-daemon-exit", NULL);
+			return error(_("daemon did not stop within %d seconds"),
+				     max_wait_ms / 1000);
+		}
 		sleep_millisec(50);
+		elapsed_ms += 50;
+	}
 	trace2_region_leave("fsm_client", "polling-for-daemon-exit", NULL);
 
 	return 0;
-- 
gitgitgadget

