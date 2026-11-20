Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795201374;
	b=n1MqzjAgkrgaU+IoTHod2JYcbnK+hTLR5rqV+4fmHEslGbUM+rtkfOY+4UZsaLsp7Rdl
	 R8+lkhQ/SBZcdx40+PisjVqdmmQ+tQo+h7YUb4BRHtG2gSSs/NL4aPG+HX+bpNZA4xeoD
	 LFt7B1Y5ZQ/4YCFISgQNtvvFEF9dh3PgCMr7raqIeauqPdR8fNw0T/pfHGXz11um6d7VA
	 nkkCi5L5Y8oym7r3cW7x85k7aIQZE1zBHCutdRqp093avMU45oAYIztLNME+NvBX2RU+r
	 H17hml/j1vYxrPijPBAtTjLS/OOxUr/8YqJfrzsFnMJj0vktEHv1YnDHz0fSwhNE7OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795201374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WEENBKeuJDD8LJ/+dVq1XN5zecyhShKP8eMH3nWMsyQ=;
	b=yRHstH+4aqE5DIyRZq4k3kAF0arTzf3oWTOU5Ywl1LMFCkBjqKxYA8xRuOHHUwNwSRZS
	 AqKcxxeiS4IjyUGmeHvEhklSkOgStKO7f5x7g9qNRDQOCRaiifiv0vPZIirB2TlIf0V4O
	 oLt+UBDEsb76bnMKN2vOyOT/pKtEGxn692X3Nsksv5kGiVzYx5LhO/LyyMGW7QwpPn7Ve
	 xClFEzoOqpHIDaAJassxKeUr1jacp4mX65mRQY4SAm3ZWYONnjz2BGUFnuiGfodjMBTif
	 bCIo0lKulWHRwiaTJx6q3U99i1+awUBMpqvxRdfU7uwkGgkqFHNw9X3vzpVOLmliuhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0EXjV8bt;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723F60A2620
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C723F60A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0EXjV8bt
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb2893531bso742738a12.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795201372; x=1795806172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WEENBKeuJDD8LJ/+dVq1XN5zecyhShKP8eMH3nWMsyQ=;
        b=0EXjV8btMt3qUnv4bH1KAg5Jhp1+8+emKbSIbZddPDKXJ5PJJUCbZlZyGF8h6I/QMW
         8jhXcEjm/Q/mz4rTb1Kv6rBPj+PVXs3XnVw501hvT2ZFXQrAEhNLikICdlQ1yEEhnnJL
         +LoAk5SoBRz9UBKCY7mSTfe50ysVxr8xsPh0Fm7KmzMCFHtSlsNLq3dZA+/awW1Jy/GE
         rYo7J1idCo6NsKHeR743xw3plZ75Ni5j5SfM8EYu73g1GKw8EobgswiL8KPFoLHgA30F
         Hs8KT654iN+QU+dF4X6W2lZAcZeXW5HP2/JXRd5vJ4V7X3n0tdmke2Zcq9SpJeZt6Veo
         PnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795201372; x=1795806172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WEENBKeuJDD8LJ/+dVq1XN5zecyhShKP8eMH3nWMsyQ=;
        b=zED2aahdDW3Fneqm2+T/TWPVYCZlkJaW/hkwiLjDXkW2XuE4lB+BStwaBeCCj66aAx
         wppTeLGZ591ToV8Rb9Z0vbUnOX/GkhyJTL3xwyQfu4Unv70D5+4DHmlww+OWwMrg7L+d
         IpaBJMthgII+fFMkyVmBKMQDIaXFZIJw8qEnLt44myoDUf2aD2OrsBZ2O5j37BfxDdK/
         9M8VIByI4l5IVk03puS6WUTfvrFwtWaJDI/rFxM5WADeTjZN0rjL+8knn6who6dvVi0Z
         mmcglim6RiyIMSnGcD0V7WJcnlhTdSNHETJ1hXLytJhaQw+BDRNx219EUKKPRQwH45op
         4iQg==
X-Gm-Message-State: APuU4Z+nRwC+WxNNR0hKt7foKp019AYUyJiB/L8zCfgoRWcZthI+ChoD
	u8pAIfoMRedMOaUjDhL6n1TDR5+IUdPWTXe3oTTw9zHHGRbfqvfjTrGRT3oYuEbecII=
X-Gm-Gg: AZFdTZd07tEgWOp3dijyS4EFo/klkV/MNQgs5GtqMOPOdsnpwJLjv/F97jB9RVeVhMe
	1JbIh7NOASZUpP1RxVYuQMCgLSqyZcmtXdnEaspx9p7pcskM6TuHDqLMn9I//prdPS/uoFblM8W
	+/caZhVO0UN9swly1X+0qwBGfsieqZ4bEKn+zjsy00R1MgZ1MFPR5eaHXg2ffUnAvbloTJRFLbB
	UcdjqXSFrHspyoAABE81v8Vy5Uf8vv4gQZEz+p9zRhiGxguiL66NUNPf/bfqi0uFTbN/c8HdUtq
	Y8jfkLz/Siel/2cRqw/99cMu+GYN0yadNUF651nTfM6frQh84nXvGiY79wqUz4IV78OwBQsQRPy
	3NKuL5BVeQLeFAQ4554txcfJPCPu4HFr1H8SHFL0qZpNZ/qHKpV19GKlB4cwBjLkyVqIHsMnImd
	BGbKm7d5xXUoadmVZIQpVjJ28mR5jFbp5Sps8C1mv2tM8GiI67VsBYGJOm7v75UqgZb28YiH8aQ
	onO7FKDPXgn5r1zOkI1KY/hNZL1O5gZVfBWD7XYKJnNjLR9Pi2vsYlBFGrnn7aR4lv3xmm3M/3+
	MyMInln30uByX5fNO+eDvuXJ35NvSFIJd8/9+iq0yKOhIDiJZEdFADgLNK4Gu7Cu8FIKkahAHvK
	dBRR2+Qb1mdFJGxTyXxL6G6BfbFcFh0NTa/4Hu1eHzQ==
X-Received: by 2002:a17:90b:498c:b0:3ab:be66:ddbe with SMTP id 98e67ed59e1d1-3b41c902f3emr3684713a91.28.1795201371924;
        Fri, 20 Nov 2026 11:02:51 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b75f2a4sm168216a91.2.2026.11.20.11.02.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 11:02:51 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: haraldnordgren@gmail.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] status: say when the push branch was rebased cleanly
Date: Sat, 21 Nov 2026 00:32:46 +0530
Message-ID: <20261120190246.79249-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <dc0efefa0ef02a04f211cf7e24a8b6855f36e12f.1791270504.git.gitgitgadget@gmail.com>
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com> <dc0efefa0ef02a04f211cf7e24a8b6855f36e12f.1791270504.git.gitgitgadget@gmail.com>
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

Hi Harald,

Thanks for working on this.

> +	if (num_same)
> +		strvec_push(&argv, "--cherry-mark");

This makes git status slower when the branches have diverged as every
commit on both sides now needs a patch id. With status.compareBranches =
@{upstream} @{push} and 3000 commits on both side the status goes from
25ms to 150ms. With 10000, it goes from 60ms to 500ms. And with only
@{upstream} it stays the same.

Would it make sense to count without --cherry-mark first and only run
the patch id pass when the two counts are small?
