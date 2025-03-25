Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D517E4
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889718; cv=none; b=EXtk2aZIgZIo2htHuL326NvZqAYZbWBDylzI/VXn7FDyvcRFMgyUVbyXtaQTz75LByhS25CA2pgEdUrIA+hXTNWvy6uy1HMd9IDTIvfO71UWqjzTCNB/TXQ27gF/VqdX/c6h20a/xIsb3VXptCKzHRvfwmzpud4D9B5HRqWDYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889718; c=relaxed/simple;
	bh=H5ojGuyLbeysMTn5tMufaDTs2YCx1qLL3cbl0V4NLV4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PWDIJNQCYWTVvFN8qdVk5O1hfa0pGJJ8jdVHFUnh4cTXBaLaCTK6qYSQ9JoKyGotOoDXy321N4nRrQOPvxyIy2AQXMRqS4iMurnEuJ35gjBwi4nNDvRHrQgX1sPqdm/Yxunt6ZsyHIKR7s1gZbsZ6Bqj8xQ/jX/bgZ/M/gzdSJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IA8vtkt7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA8vtkt7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-391342fc148so3615272f8f.2
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742889714; x=1743494514; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3LiDKkGvAuPUaK3qRtabUoEjnMEPh6hRImpdNOl86c=;
        b=IA8vtkt7vutCS8//l4WVkF8Og84ZCfk3WQ+r57nR5XJQg7K/Ll9PFAv8BG/5w3bKDZ
         4xRRY5xRfl7CiHfqzvATXD9CPRVC1rojtAdM0g4AxHy7KEtd+EkD17ypF7Caz0aWwweu
         ZQXry36Gt/RNqDVPTdQ9uDEDxJTnSYL4fS72gFnkJ7GDmiKC5bqvB7h9SLiPJ5DGH5KP
         uYScocKVpHWSdZDYAKgI+1kzErRH6JsrqWu0UHb7C//qvqXTvTMGBdqz/3CZsY7jCiGg
         WyN3cFa+IitifyI1VyXfUPgjj73JMEgOsqzRD0Q0/APmN43pKJW0ozzIJd3Oi0dd4qIy
         jLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889714; x=1743494514;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3LiDKkGvAuPUaK3qRtabUoEjnMEPh6hRImpdNOl86c=;
        b=WVTFi3z7CWuJw8JL5+0U2Y1JPjEjysr+OHc5pFDPn4rc5y6M9RR8TspTCXCOB1bcsT
         Tc62FA8D4G+tx1lWlL4RHXWJq8Or08nOSGEWUf/Ak8tpx9O405QEafiBi0j/7Byi1RPx
         lJq2EZRGWwn4mXAhlKzmm1HgR3ECuAK3P1+Qy25SLRrX9gwYsig78YvU8BjMkbD/+uXu
         1aXZ+u2O+wne+XXLZEFHVu0pMZusazZOb/WYlFpq3MjpiHk73XDUDlZC7GpiRzBieh1M
         /UXVzpVMSqbBGHo32iq1KSULo3AuHQNRxfctBk59g4AxgvGMk+ixc6fxLs1e/GAXpJrv
         gBJw==
X-Gm-Message-State: AOJu0YyWii/v0dCCUbBcLONikcwO8Q+VEN69E4m8nj0lVeaflUqXZ1IH
	hjIoMoTgM2pPvS2FzKUYdnsgP8IAmoicB0UPKLLCfjBemUAZ+3xcAsAffQ==
X-Gm-Gg: ASbGncsJTCg3SglSQeo0SpwXcQLHrOEj/JUMUhLoE648T/iJ2DHrP9IeAttsqYKX1Hx
	4yEDlggLR9vdEfVbQ8J0xJnI7fzbPWqYN2p1LSFc/tMD2vgBy+YsbS2ce6AP8V7k6xhbZIzqo4+
	IRfikT9XEXYsy0kbrqgOzpvzjEMej9xF4j+9RKuyGR9VA6MjxO60GAm4GE/7GahgkGCsvkNT7T2
	F3wLg7ysq7QRA2RvgWpkVW9p4XBtbxiFse5D1yGqt4EcZWbLjEQmKii/eNsolLqJwb16cuqiFvL
	CC09WMbQ7bnOJN6fToghRUReJq8CVXtQ+gK3X5NdFXw3UQ==
X-Google-Smtp-Source: AGHT+IGIuobW32L5CtGpWh61rc+IALrliOC3lTuGqnI12iZjTRH/NXTrc4RIpEL2G3825ylXacsxLA==
X-Received: by 2002:a05:6000:4108:b0:397:3900:ef8c with SMTP id ffacd0b85a97d-3997f9330cemr14799964f8f.35.1742889713967;
        Tue, 25 Mar 2025 01:01:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3c7fsm13206601f8f.34.2025.03.25.01.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:01:53 -0700 (PDT)
Message-Id: <e3069fd4564bac68bdaf2079151b9b921867e277.1742889711.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 08:01:49 +0000
Subject: [PATCH 1/2] remote-curl: avoid using the comma operator unnecessarily
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

The comma operator is a somewhat obscure C feature that is often used by
mistake and can even cause unintentional code flow. Better use a
semicolon instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1273507a96c..57b515b37e7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1401,7 +1401,7 @@ static int push_git(struct discovery *heads, int nr_spec, const char **specs)
 	packet_buf_flush(&preamble);
 
 	memset(&rpc, 0, sizeof(rpc));
-	rpc.service_name = "git-receive-pack",
+	rpc.service_name = "git-receive-pack";
 
 	err = rpc_service(&rpc, heads, args.v, &preamble, &rpc_result);
 	if (rpc_result.len)
-- 
gitgitgadget

