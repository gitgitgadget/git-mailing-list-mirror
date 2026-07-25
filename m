Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6832DCF74
	for <git@vger.kernel.org>; Sat, 25 Jul 2026 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784980534; cv=none; b=YMR9M8XdlsSKKjNLQHIRRwlJBpnvHDjuERHkjWsVRdhRWr/P2hzsAGosxm6PQhfGWnhR5GKmY763h83q5qziZnCUec5yVRO4xrzGrIiUedyBdLKAGtRLG70qXq+d47e7MQ8+NnBRqDv0tL2VlmYsrMZaQLK79j+wl+VIpt0UoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784980534; c=relaxed/simple;
	bh=u3Oa3fAi5hrApQmcVitQ74VnlWV8FgdztixPqalF+bw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D/84avehsCFeEJoSgu71u8yd80Qh84IQXR9m5JCQ3SUEazYz2opXjyVtAck1RPGg3bzCX+9LUXGoN2T2sEtXDCjDd8cLcmA40lUQyQvv9E/zxApXz1Yx9mIdYEZrRIPU+fxCvJFMzk1gCUoXrdGIUTKy0K2YcvN/KX9oikmoZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQqaSITY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQqaSITY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4955de8797cso8093485e9.3
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784980531; x=1785585331; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gNggWn3/6A0NevJG7d7Xwd3hLyi/jUliZCWLDQNjop8=;
        b=pQqaSITYCvk0OIf77rxswgSYclFQV58owhDTzcFZQ5a1gsdqFv5eIUmsa9LEugxxf4
         mOqjls2NqkdHY1mJzZyvtaun7nry/bdari+v9YDrgQhgkWmlg96Vv61Y6WLNU3KiUR1A
         6WfqSbXkmNxiHYUy9ErbkOjV6UL+sdOZe2rfhQnkJu81vie8Z6JwBxBaPNLE8yZQc0SF
         /hAS7o3uhKoWEExcDemIDqP2esE55SPORd2C80kNbT1fBV81LLrMBaw+ZZFXw385vrFk
         v/ESuLyzDIpt7RrIhws9y6lVUkN7QicDo2oBMmfxkyF1QGXOJ5zWIew7py4KUh2idpZA
         MU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784980531; x=1785585331;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gNggWn3/6A0NevJG7d7Xwd3hLyi/jUliZCWLDQNjop8=;
        b=qxMCdAlRvRZoG660ABrY14ubW7mckg0dhtUPClCpqisPpe3cbHa7oFMkFraqGfvmPd
         YAsdMrGjEu9g54qSTrJzCHTwEi9ow7zXIgT1sdaYrCycBlzaKcVpqWRbtp1hdVzQ9iXI
         Fsk4mzR8L3xmoxSNZNlhsbOwSBBG4oRy52pVCBv9fyZ51RTJvoWtgOyQHN1ipRFmukyw
         OGXFAQubF4dPXrAWD8UHdM5VUDj6yJi1QQ1Rt+ttFZkj0rRoPwPFo99843HJ+bYzn4yu
         Eb2wNa/DTvaglxE9fhqp7GUH7Tomcp3xWJNcNKqVw1qTtqLUTrwEgG4lYbI2ZKBkroNv
         T6MQ==
X-Gm-Message-State: AOJu0Yy7FCEJwTMzMAXZU8z+PJw192fvZy29O3Aj4Jr+8wY8+POKcNLH
	GQtrVvpad3LHGWYl6T/Zdl0Ik0YDE0zaCHmuZfQK5cWuEttlZd3d8X6S
X-Gm-Gg: AR+sD10W+jh1acxSCt9IcNgx3scbLNYPpp1YfK2QBHNmOg6YEMuhxzEvTbloS2RrMh4
	deN1mO3ii/5zzdznFbGAXr5TLyDwNzeiDieqNstcXE1TgyKQ9zQwxnbVoT6bT1OZWu8DaDiHlkr
	aYqD3H2b2u96JZQ5WBvvMqAAsf+Cqioh2Hev4QZseP/28k++DZKnrX35GFt+3V3MQzjwWBmoGF5
	31JIYNQ2LL6jA3rMEfiOPReTrUI14DGX+Ng1fAAqn9p282pC9jHWXuctW8K4nVux8IIhb+KtXGq
	SN/6J/tAxyKSomauG94vqBl9FQ2hPs6FQsvdNRYWT2Fy8U4bgVyZE0NdgLhHLkNWmwCCk9AhosE
	A09MILR6AxC/gH7M7YOMgwHX4/fK0j3aCi5LzLcAUEfLzi1Xjo1BmMJTfpocpS2r5bRW/m0aynv
	trCZW/BPjxtfabZ2XRjVTvqxbjFRsXX/nyH7CWPfHZjFjJvJ3YdzoYjNuCeJsP5eHdo2YUSc6mu
	XE/lyLIaszYNrfODDB/uTV1+EtexvWL4RdgUh1qXNjs9aj2fXllgBsF73nb/1XdtTTrvpRxNi0Z
	LjHW0l4NU7eReHqXeXO44iTYgmW/W+sjRhED18ACVa73TaP8tqtqp2s//QppUrD5UO/CtoxaRlF
	kBC8JB3mPmRUaM2pck6ZYb/eJMtm28jawRcWUJRJ30CoPXg3JcX0ijvSHEWAglamH3qKgdUcxkQ
	==
X-Received: by 2002:a05:600c:3b25:b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-496b5719f24mr23791515e9.20.1784980531280;
        Sat, 25 Jul 2026 04:55:31 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (132.red-37-158-18.dynamicip.rima-tde.net. [37.158.18.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e86sm41700515e9.1.2026.07.25.04.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 04:55:30 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH GSoC 0/5] cat-file: extend remote-object-info to support
 %(objecttype)
Date: Sat, 25 Jul 2026 13:55:01 +0200
Message-Id: <20260725-objecttype-support-v1-0-2d4ca3bbabf1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMT3fykrNTkkpLKglTd4tKCgvyiEt3URMPUNDNLE8MUA3MloMaCotS
 0zAqwodFK7sH5zkqxENHiUrBmkHlQdUWphaVAO0sgimNrawGdf//CkQAAAA==
X-Change-ID: 20260724-objecttype-support-ea1ef6941d07
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

"%(objecttype)" is already known by the client's allow-list, but neither
the client nor the server knows how to handle type. This series continues
the work for git cat-file --batch-command extending remote-object-info
to support "%(objecttype)" end to end. It is based on its predecessor
series "cat-file: add remote-object-info to batch-command" [1].

Type is the last property that is identical on the server and on the
client once fetched.

Whether to support more metadata such as:

- objectsize:disk
- deltabase
- objectmode (needs context)

should be discussed, unlike size and type, the rest depend on how things
are packed on the server and on what the client already has, so they
cannot reliably match local once fetched. IMO they are not worth
supporting, I can't find a use case for them.

Adding new placeholders has become trivial.
To add a new placeholder, follow the steps in this series and add it to
the client's allow-list at 'builtin/cat-file.c'.

Based-on: <20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com>

Github CI: https://github.com/pabloosabaterr/git/actions/runs/30155586279

[1]: https://lore.kernel.org/git/20260724-ps-eric-work-rebase-v21-0-ba67f024fdff@gmail.com/

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (5):
      protocol-caps: add type support to object-info
      fetch-object-info: parse type from server response
      fetch-object-info: request all supported options dynamically
      serve: advertise type capability
      cat-file: unify default format

 Documentation/git-cat-file.adoc        | 17 +++-----
 Documentation/gitprotocol-v2.adoc      | 15 +++++--
 builtin/cat-file.c                     |  7 ---
 fetch-object-info.c                    | 23 +++++++---
 protocol-caps.c                        | 21 +++++++--
 serve.c                                |  4 +-
 t/t1017-cat-file-remote-object-info.sh | 80 +++++++++++++---------------------
 t/t5701-git-serve.sh                   | 27 ++++++++++++
 8 files changed, 113 insertions(+), 81 deletions(-)


---
base-commit: 71e19e8d2713f385c3fcef59cf6f29bcbd93d91f
change-id: 20260724-objecttype-support-ea1ef6941d07

