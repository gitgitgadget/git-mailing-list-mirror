Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098696;
	b=i23VsjUpOQ+bgBt8acjzOhASHbsWJqOGltpKPUcgMX1yKgO4VPduccnMQv57eurW+5z8
	 LEvmmUAZNmrZrXU9CZSYkyT4/w6U3e27Yi53WsZRexWQmDNc2oYTxyEh4EMuABpsBqRSc
	 uQZnwKiBL19UQWwjK0Ejrk4SMOd3k0edDa93ejrPV2RRAuX/xSJ4Vj97V+M6jSSToLQlh
	 jD3I1DkaO48eDW0W+wLWfpWzLDByQ/oEXIul7NZlxNLX0F42ewhOFAVxbi1gbHiDvrX4l
	 hRAsLJKzr/YjzDpGOjf5cmENRdy9CaAU3vMMa6PN30uxEuTLAMV37+UOGydWR0mkjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ANcdWTXM1V9ZhsBRiMm+ndqUWTWLxfEIysp12WNbotA=;
	b=D81l+dNzyD6YKvvBUGX7WL/nIzK4jNdelUpE6wZ8a0RF1DoCtBv5OEuTF4hUJ4hoSP0L
	 Sd4ermLsmfWoWfv7bVyQnh/ZS2Oi217SuRSLJrpamY1vBrNXc6dcKBVaRfowNNG8wVrzF
	 WWwV7QkLzTZZxrxabON0kVNsYbeNtLA8EUtbd/ARq24mJFWEu1dQofG83A76jyyzUJg16
	 UoUoPc7phnWnOaBO3kzIHmNxSCoytee8fsQlilbu/SfS/UWhIEFmD+Lom3IXgARU0rlz+
	 85pAwUWJwB3VxLsG2iNR8GSIoxO0FZydyTtIG9SZCQupsLonUUQykT4Qo3IVGuWeXdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmRHgWOv;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D63606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7D63606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bmRHgWOv
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a208d93758so45704605e9.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098694; x=1793703494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ANcdWTXM1V9ZhsBRiMm+ndqUWTWLxfEIysp12WNbotA=;
        b=bmRHgWOvUh/tT1a+TWIaCvNQFUfeODg65o0bWrybgKh3XDTQcpMrn7VhCGnTdjgQ4v
         GFzB9kSJmqXJaU9AxOWKn5q+IMBTwhkcNBCXtt6HhAKtxAW09r1/5uOLFJr8NiDUhik+
         pmC1jgr01JPVA517kVP+NufYP/+mJf+EO+DHZmjWEZiWPVfE7tIn3J/yqD0fLBfAJdsu
         k7q7ZZ4ZXODlUJyKb7kLvTQcEeDMZjP13QlsdeRF1wwEot4XBLaXSCl9QA0ViHtFj8E4
         Pc94A1tnFDJvP70VU6xWi4WBn436W5MxCdn6WtrcQRIwNvO6J0mMZNlynmhA6Ha0Orqu
         ekKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098694; x=1793703494;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ANcdWTXM1V9ZhsBRiMm+ndqUWTWLxfEIysp12WNbotA=;
        b=f63S5kgF44qYYPQYBZQKPV5J6YBfHbRLAR5537/J2/1fnG3Q0ri30zpRwIpA5JuZHt
         sCvFgyZXw9jknl/qB72S8h1XqJ95NyGQxFgp5gUHKpISQzYmRecyg5B2HHtLD7ytX5Ag
         ynxEt5bZbC1nXdf2W7igpf90fmlg983ZkSXda749Z+agu/V/7c9IgqjA8vrYlNPddsPn
         vQSeHhTOSodkKbdnqd34NiubgcAnjB45oW9QBAHrcO627wC3Mu5emA2ly8stJmyCnrpf
         XxGXDENgufikn+n5zx6CG1xatUthPhs1p7d5cgcV2VDShmFdB5QIPCdqur6STdOe0sZh
         LClA==
X-Gm-Message-State: AFq9FYIkAhYfmzM35xxaBJpZs5m/uLoR9HLsF6hCsFCGUQEPyWHQY05n
	Yw2ZfDt4tZq7awaYCvBlVVFDijFW4wcsrVTF+ryfAAbnlcUJNAd+C5VnvzLFRg==
X-Gm-Gg: AYBFou13rMMQSjo+Tec84Ib/T7wsavN7QmRnjxREb2610A9mrC/Bt+nn2nz9zjm0Rxq
	3U20Mv8QRzD75GeI6w3TrkLLAKEmlA+6o/QvBvmToXVjDKYIs4iTnVUvg8whX9TSa3dp/kXvju/
	+k/x/l0xAQGq/2pBWtnYmjBbBhOlyqto27TvYQubNCP6HLMRicb1c3P+jOuo4js78kgZyRauUAh
	jnizzdkM75XEXnVCd7a+SE6+nouSP/rXCIPrjj/vR/s3xj5Ne6h2bKF/xLl26KHGUcvsItvTlhO
	0MjTC/JJmeGcjh+eo/6/Kit+34jMTC4X/QRb3kdavaIwaZI1suG/QvQTJK1omPRD57AigadlQlD
	3j2My6HyUaZQ2+2M7OkCLqL4kWU0xxy/EICAHxBRZ8fegBtUwLoZwS5ZHINegg9hyq+osc2S1WE
	rG3Xb8Nz1rAHwKo3PuitAwvfyG0F8f9ZZZ1+wulT58LySUck15T5Hre61ncrkIvFZTXxZKth80y
	dSB0t5a8GDI7ldkTvL1ojFQMDdyPB9n+zB5YYYu2cwxDqPU+j0c/GZtMoOBGcVDY2Qvz9mZhjhd
	g5L1
X-Received: by 2002:a05:600c:4f89:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4a7462c6bafmr71970405e9.32.1793098693913;
        Tue, 27 Oct 2026 03:58:13 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm321638925e9.4.2026.10.27.03.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:58:13 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Long 76 <long76.git@mail.ru>,
	Matt Hunter <m@lfurio.us>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 0/3] sequencer: fix cleanup of REBASE_HEAD and AUTO_MERGE
Date: Tue, 27 Oct 2026 10:57:54 +0000
Message-ID: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.336.g97505d19352
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had an error report [1] that REBASE_HEAD was still present after
a rebase had finished. While looking at that I noticed the same could
happen to AUTO_MERGE. These patches ensure those refs are removed by
"git rebase --continue" so that they are not left behind after the
rebase has finished.

Thanks to Long for the bug report and Matt for the confirmation

[1] https://lore.kernel.org/git/edfc868b-6be6-4871-a539-e70791db216d@mail.ru

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fsequencer-delete-REBASE_HEAD%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/7e34d8174...2fcb42a08
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/sequencer-delete-REBASE_HEAD/v1


Phillip Wood (3):
  test_ref_missing(): improve error message
  sequencer: remove REBASE_HEAD at the end of a rebase
  sequencer: remove AUTO_MERGE at the end of a rebase

 sequencer.c                | 13 ++++++++-----
 t/t3403-rebase-skip.sh     |  6 +++++-
 t/t3407-rebase-abort.sh    |  4 ++++
 t/t3418-rebase-continue.sh | 10 ++++++++--
 t/test-lib-functions.sh    |  6 ++++--
 5 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.56.0.336.g97505d19352

