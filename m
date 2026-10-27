Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071016;
	b=5UcfV4wfeItA2vnt9xG2HGUCqupM03XOS5U3LmbQHd8xaLOdtFdi8gN+VDoTxOPVUL87
	 A6JbPyAKB+1XN/nW3IB0LF2Dx/kbMLf5Dl+PCdaOCfmF/g3Tb054Srr+wuu9IzoQ+CvAh
	 IaIgBQUbCGm4Me/E+keYx7+9BASYhSGJ3l77XBg7Mx4lMsTjz02380SCYwwbsh/20EfNx
	 nt4yO4vuu/bC2lPkaZVDjH7xkW7hnSMTvVP2iGSjDyhqknCMkA9lq5T3AvtpEp1QjhYul
	 PbF9DxmdF5C+UE320RjL1VkVheBCq6Wqc9aw7P2SlgRAycL4UjIPR+MHL8eyIgkO5IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=MpqOywcOvPdKZm7A4Y0GKYBlcAZwR3qovYBSzlCpeJc=;
	b=W00//5saDemKimgPFL0c5SbWkT+50rn5aVe2zr1Lq3TEn8OcYO5hHnbrPr3B0nkHyzws
	 zdQMj+q6a0fa1/0e7sywGu2xezDaMnkdzMjcFta5DOjIvAKM7Je/prO2pcE6TVcd3xKca
	 uXsKCU3mBmvPK3Ub228ntEVMWgowjOBdrNqx3nHoN6iYTN0dhyi/9yNui+zvIlCPaOOAT
	 bMHduWK8ubwWt9H9vAw/lW3tfgOZCm6scl935FbrX/4yuzEIGyMMdVeovcwQDInfOW4uY
	 y/KkQHGe44U6nE24soMUvhownLGZWOAlfT24WNw624i5WIvlmlEmi/FFjPTCLIHZuLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="KApqcDa/";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76440606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76440606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KApqcDa/
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso2170383f8f.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793071015; x=1793675815; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MpqOywcOvPdKZm7A4Y0GKYBlcAZwR3qovYBSzlCpeJc=;
        b=KApqcDa/8UoQ+2r0r5juJvNRPfL5qMvDTieVsTkGecl+EUKV/oioW3v995rTK4XUeZ
         YTa95s8IU0SMSpEdJBWCVTgDmmSYGnCxYdW0fgg3F8ckKWCiYCJTEXL2j1z3Yw3h5Hjl
         5YKw4HumtyGLdcCidczOB1H4z7dbpv/fNyNESej+QAZjITISdBychIbHYA5WoeyQ/XUV
         8WZpGqUGBikXcIwmvjCLu2E9Q6t7DmSUM9OJ4KBecl5Lm3cQIx0v3wmUlI1NckXutPLU
         vtYLE+bhuxOQh2fUfw7jESbLGheL5EZJ+qyRkNK7CKTNiGl8HjHu9NrrHp0KZrmEUUwW
         ZF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071015; x=1793675815;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MpqOywcOvPdKZm7A4Y0GKYBlcAZwR3qovYBSzlCpeJc=;
        b=ifRmvXME1urjEFVd1AmqgOc1QcyO2KFnWhW12F5G8rW2dF7pDt2HbFlf21CuDoeKqM
         StAU1PtsqmL9u68E3dmyanshNnE4LzPu8Ek3KfanWBPxyW2lG+6xsRHMSDYUrKXuNsYc
         ku13C9VTB9TAeRI/c1D5UW4jka9yF1vq7SGHj2w3XWiJRO4ysiBK1fqqrlH9eaDW1HQS
         kvUZ5T9YLFhKPnu5liKl2qEQA/gsQnirQk3WktcjSwuJPR7RsxAZeWJ5+CqxFrTTD1+L
         Eq4v8VgNZm8yVnc591McQAswCBq/Apvmk5po+G8GV3wey21Rl26qYaI5CUGEf6lf8l8L
         uXDA==
X-Gm-Message-State: AFq9FYK93chWxNTyLgUXz/trkEAjv8dzNWO/aOWe3KA4SGIPwGWm6/pk
	OMj/o0/puwLQb43se6o+oJ2h6Jz7NfUSdxCjDbCguNTp06Riocrup92W6yLMc44d
X-Gm-Gg: AYBFou0qa5BQY/YWtX29GPLpZIq+7rZ+n1ojuo6e64VQdHHpC7iQIr2pP4m3i0b9ZrK
	GNcfVoNQMKtO8oZBoZAOwW1tMV9sVsMe8sDbpKZ1G4To2Hsds+JKCodF/JJqd06VR12eHEjM3pv
	uSZbYlO0W+aVDpetS2QynVPny1QsVNPqlzbfTLx9lnRs4TwBA/nYfH/v30p0y6Ebe1V6fR9E3CW
	1DLnTk3vwOeFvVhcirDK9Nods0sCjzddXGhVJhZhXAOYDb+loakottNe6NJAzQXzvYqRqIYXnvK
	UfCr9KeKKmQztwp9LvL/eiGPuzY9rEIQgSft4g++rUzVrmv1BXk0Hbij9HTsUQ/58RvnVzpualc
	oeimxDYe/31lxfdbzwa8q16neoVLLos+zo4JhM3oMVY13PYb5pMVY3SOAvpZHCzWAo6TLnjaRJb
	64SJCH1VLdt0yzXRz7P8K72YX/xXUb+L52Mfr5TeiQFI9x5uGv6aygOlQSFCJRpyVdQA1CYH715
	ZkyS6GTQeRawIGUDeNa4TTC9oOEdoXxlAE4PfaG5BvWZVRFAd2bRtDglTvFwDmC2eMEMx4OmXfg
	gYQkuRfWvTCx0QmO4XM1wkYlLL0e9rQVyP2HI/wRiQVFC8STVzG0XeQKD32Wh7csl9xAL5D+Ym1
	xE/t8CgVZMoi36D00GAbZfT3/WSl/l4enOOehuIhFOUXd2BJy3T8s1+7gf5yqaIg4bsnYRen5zu
	VvSg==
X-Received: by 2002:a05:6000:2388:b0:48c:7386:af18 with SMTP id ffacd0b85a97d-48e3eb2cf0fmr16756059f8f.8.1793071014537;
        Mon, 26 Oct 2026 20:16:54 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:9b4:dea8:96dd:9a68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm21777960f8f.32.2026.10.26.20.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:16:54 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [PATCH RFC 0/3] cat-file: make remote-object-info request in
 batches
Date: Tue, 27 Oct 2026 03:16:50 +0000
Message-Id: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBQFr1Le2g9NJQXdFjyAW3GRpD/2C00ki
 SKU3t3YLmdgZkHmJJxxbhYk/kiWGCqoQwM3mfBgkrEyurbrVas0JZ5jYYr2ya6QBB/JmuImcr3
 26uitNieNmr8Se/lu6xuulwH3Xeb3lv6nWNcf0n+fjYEAAAA=
X-Change-ID: 20261015-remote-object-info-batch-c65f13fb5a95
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Currently the command remote-object-info of git cat-file has a hard
limit of 10k OIDs to query in the same command. So, if you want to query
100k objects for example you would have to run the command 10 times.

This seemed strange to me because git backfill for example has a
default limit of 50k objects and backfill fetches full objects, while
remote-object-info only requests metadata (size, type, both or none) so
it should be able to handle at least the same, if not more.

Even if we kept the 10k OID limit for remote-object-info, it is annoying
having to run the command multiple times, so I propose to allow as many
OIDs as wanted and batch them internally.

Regarding which number of objects should be the limit, I benchmarked
different batch sizes over a simulated 47ms RTT (details in patch 2):

+------------+---------------------+
|            | objects requested   |
| batch size |   100k   |   400k   |
+------------+----------+----------+
| 10k        |  1.691s  |  5.862s  |
| 50k        |  0.981s  |  2.397s  |
| 100k       |  0.915s  |  2.058s  |
| 200k       |  0.924s  |  1.889s  |
| 400k       |  0.908s  |  1.820s  |
+------------+----------+----------+

A noticeable difference can be seen from a 10k OID batch to a 50k batch.
After that the difference isn't as noticeable (the number of batches to
be requested isn't that big).

I propose 50k OIDs as the default number of OIDs for the
remote-object-info batches. Coincidentally, git backfill's default batch
size is 50k as well though it's unrelated.

I have barely done any benchmarking before, so I would appreciate
any feedback on the one in patch 2. Is there a better way to do it,
or other things I should take into account?

Should the server also check for a limit on the number of OIDs it
accepts in a single object-info request?

GitHub CI passed:
https://github.com/pabloosabaterr/git/actions/runs/40424912154

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (3):
      cat-file: extract the transport ownership from get_remote_info()
      cat-file: make remote-object-info request in batches
      cat-file: add --remote-max-batch option

 Documentation/git-cat-file.adoc        |  16 ++-
 builtin/cat-file.c                     | 174 +++++++++++++++++++--------------
 t/t1017-cat-file-remote-object-info.sh |  68 +++++++++++++
 transport-helper.c                     |  13 ++-
 transport-internal.h                   |   6 +-
 transport.c                            |  33 +++----
 transport.h                            |   6 +-
 7 files changed, 208 insertions(+), 108 deletions(-)


---
base-commit: 37b3475fb530c14109211faca33716a173db61ed
change-id: 20261015-remote-object-info-batch-c65f13fb5a95

