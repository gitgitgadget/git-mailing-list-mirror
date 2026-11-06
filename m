Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983843;
	b=rK2RzFmZRtLw8NnHE5n2SrdDr0Hli9x1SRnRanQteGBOv8zegO34blOXk3JbwVI9BP2l
	 FlTOOtXJQn1kNNBSXZd7JtvsXZZo6YcWKH/jkXtdPu3Msi75Z48G65kG1G0KmF/Zq5BvR
	 12VXCmoK1ZhviuEedj6pNJV0GLqXETfo1+TKGlF3/hl73r+ItI6bujelvm95CevWQzXz/
	 d6wxNSdxIqZ0lR6Kng82imvWYGU9iJ7ukEZpS27d+uL8MfXl3fs5r45R28DOqTFUHmUtp
	 d11U6qWt8YYdV0LJ9li9rT5XjCzIOOpqrtOEmN+UHH6hz/sQSawYpiUDiXoFNpzUj9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=iyM4srfhoU/9+Z/rbkQp4qqxvEABReup3nOqpQKqid8=;
	b=l3vQImG5th0NcAAbsciaudnXVgpy22CpvfoEeug19zDGJF8jGCVIYQmymcINZHHPmMQL
	 f83IyOcrF+gH/3cfjJEg7VZZfDGKS1UkMU81QKQzuMTPhpeADwjbgGKyAUfZA1iQorfbB
	 +dKPkBPtAFkKW/r3UfXxhHGsfuhswZMk5Q2j4som4TW8f7kOBkqlBbY9xHe+eHWJVbwX7
	 Am9RZVg1/IYARPVz4jUEjBDqwvpVgySRxHC+gIIHHApXplzlSpUxQn1esCmL3fnH5OOVQ
	 cpIKvzd8LltR+RcqkE11UzHvVWunDVzcmoDAErKyjPJtfFnPkWedJOhlUvU9x+qlRdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dinwoodie.org;
	spf=pass smtp.mailfrom=dinwoodie.org;
	dkim=pass header.d=dinwoodie.org header.i=@dinwoodie.org header.a=rsa-sha256 header.s=google header.b=VvkPeDKH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A7606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 16:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F4A7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dinwoodie.org header.i=@dinwoodie.org header.a=rsa-sha256 header.s=google header.b=VvkPeDKH
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b6e7a05225so943533a12.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 08:50:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793983840; cv=none;
        d=google.com; s=arc-20260327;
        b=rBRQT3+LTFA46W3lSO8tYGm/Fgn1GbX7YaRumxv98Z1fcLjZC4dy0Wusxl/LGI7SDI
         NtSO+NtdaxNHqyUnPj/ysm5M/5yMvZ2xSX1g2Oq93uWO2IWqWZkUz4UmW6tE57BpH0At
         9bNDB+T6K+/wbe7U26f0aAKkY7LSDyCN7GscMnmdeCvFdG1K1ydV1mBIsaMMuDaQDJbC
         KynUXTh9cS/pqJNW9iLP/4IX/uJAAOsPFERyouXCTLN0Wh5Cvp/IUkpPZv/QNJbzJ7Ra
         cVXQNjHDz0ffG6DnG4e3woEQo1MvqOpQ2rbZARyJDFIvurbeTEu3dNaV7OPbOB+rBXJn
         QFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iyM4srfhoU/9+Z/rbkQp4qqxvEABReup3nOqpQKqid8=;
        fh=BuW9i8pcHqMLkQXv+ndvaIANn5EyFbPqLAWkY6rS8cQ=;
        b=pq7pcqwM9ejsBMx6qyUp/miqa8TZVWCDJcrX3O3DpkeQWSL1jcOzEHppz4Qcs0SmCG
         nvVpf02q77Vs1H5kFoUc2OpUywgPOdnIGhswA4PqKff00L2xZB8/qxsDWh2hW/p03Ig+
         t1hHEC5U5XhryciNJPXU8ED4JjIsr2/OUO5xkv3O+Pc3uwt96ybP67dgvphX4GeCVk2y
         tJn1aiXLRMabfAZ2F8cBY+ZrGRW13VFtoE/c29MXRk+obJymMbqzynNsgPc/YQ8lqetT
         SlYI0Lrp3pMzdsdRM5DzLiOb5J5WNWfTT7psbZuCAWmVSacKeS0OrCEZCD7HCWqgHPTd
         5FPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google; t=1793983840; x=1794588640; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iyM4srfhoU/9+Z/rbkQp4qqxvEABReup3nOqpQKqid8=;
        b=VvkPeDKHtpkxWNSS1fjMAxAUccI5lzJtWO5bcVIZqT4hpeoM6S6h1WtvkD5rF6kSS2
         65RjNYlzRuVq6I4vZgCc3/RW1LJ1s9QIXXyez7FDKeSlzr1SVDVQ6eMfRLHMQ5H7TJJl
         g35l/RbSQv9sGjDmaSwF3jnQJIVt4DS8oNI8upJovOoiW0N2YARLrDX5wJ30ojCuAzqK
         1ylekqPofnd0kUjsZ91IF46XfdYibJx4cBB9wYOd19O8Anut4eWCLZT3bgjl2n8SAnW8
         IQP3smDTvqg2D3rTuAZLMjfvBek24ZTp1Y5PMxkY5NZruDrZ3t16NDbkuJBBovr929HQ
         yehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983840; x=1794588640;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyM4srfhoU/9+Z/rbkQp4qqxvEABReup3nOqpQKqid8=;
        b=KWPyuOgvnTVfs++tMgmFfnko/oSyWgqxYuLFephpvtzBw7ydv4AzruXDMeu+AvhtP+
         FZ9lZiLzF65Qr/UhHMv+p1gma9LFh7AcTYmRP277v5Fmr886VofWZfL+uy3aijqD8s0c
         tE7Klfq52D7PfKymuGaQ7+PjqGYiPajWWo+eHG9AV36lKYuqSfgAUhlVeHYLfpeJp0TT
         M1ZAaH8iwXThUINFe9QRBrxTGkXUFeAQozM4mP//VE+8dgxg+xYWJz2aRuPo21Q64nNU
         kbdIs7+8WZ1DJEF2TNAiVYXu++XpFAYKOV+XnBre2DWmUMYYyo/MG0ghv4YLchRGxpYF
         9zgw==
X-Gm-Message-State: APuU4Z+Kf95RdeNZIjQNZrz+6Au8ZI0Y5J0jvGwfs1ar1oNjdWZBO/lo
	9rIv5tgKS4gu2iwSlv3MWX+fnPGRc3L9yycd0CXstoEhSZuJY5PtxjaBayaeGVnRcUL8T4BOLyl
	elrwpGlM2Gn04AXBFs979VodEEZVhthwLHqwqugsH7Hcb90OJf3xVbQ1n
X-Gm-Gg: AYBFou3/q9WCcNth/FA9bmEbwMzttrfvedjPR+K0CMlXrN6hY2kcJp2nWyPyNnV7EbZ
	S5K01HfkGMPG86KuH7hwzLCf2OOxKfbTLEH4SCDwTVMWxKv/zcFGocSUCwEnzfStRT8k6MXzku5
	E3JrUsFnqGBS1ztrG8DojaUJJMDD89d7SOrMp0Atqiv8ovvcbTlfX3HTOGx9WkxFl8KqzCQwsRE
	FzRWSjbMpZqRN/z1+XzC0/MhnSHjJY9u7VviDefB8S+n9qLTGaA38xVp3OrDqttAJB5tabyeDlO
	xRSHvdvSsbOFs2JWMS/boO/ArQ4fmdq1zSn8VdBzqzpGnCOJQDTjFQhPUjeG/b5HI2AtyMuPEr+
	8nUplXZUh5i5n/HNOzqZjTCw9mLNsZyfiklQToPvksTLcJ40Z0hd4CGO1tVOt7MKk7d+e6k4XUZ
	mzGWuaLo91u5+S9FUaNsMnspFVTFExnhOYvMrAZ2WH0Hl84ekmUW/vUhz2s7OiQGiJdoo+aeqjG
	VkiaokcnqqJ8YlvZkT5r1yHqN+uMwQfT+qTtBl4GSUU4C6WSaojk70UbQdQH1bcxX6rMCnDGWUM
	FSa9WYDRv+ELSmHHYZnO6Fe4DAtvdOv1Mqz+SVzR/S0=
X-Received: by 2002:a05:6402:550d:b0:6b4:1916:965c with SMTP id
 4fb4d7f45d1cf-6b5977d332emr2224927a12.18.1793983840283; Fri, 06 Nov 2026
 08:50:40 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Adam Dinwoodie <adam@dinwoodie.org>
Date: Fri, 6 Nov 2026 16:50:03 +0000
X-Gm-Features: AclHuK8OEEeRZ9hHQOhEFdq28lU7m-Zi-4sjoBFwoDvdxdU3_dBrDPPnAf5vlsE
Message-ID: <CA+kUOampvjU3=VK3VGhYw2L5-E+LBsk=Q0UrAxhhR7hC5SUdJg@mail.gmail.com>
Subject: Default object format for new repositories in Git v3
To: Git Mailing List <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000088b7c7065f9e691f"

--00000000000088b7c7065f9e691f
Content-Type: text/plain; charset="UTF-8"

Hi folks,

As part of preparing for Git v3, in particular for Nixpkgs, I've been
running a bunch of tests using Git built with
`WITH_BREAKING_CHANGES=1`. Somewhat to my surprise, `git init` seems
to still be creating new repositories using sha1 rather than sha256.
Is this expected?

For reference, I've attached the test script I've produced as a repro
that can be run from the root of a Git checkout, although it does
require Nix. I've confirmed the behaviour at v2.56.0, next
(972d6e3ab651d838b30a8d5d70d8ef6ced05a986) and main
(0ffa3e35c7c82ab8d0de226149fb03b3f7674d05).

For a simpler repro that doesn't require Nix, build Git with
`WITH_BREAKING_CHANGES=1`, then run:

```
git init tmpdir
git -C tmpdir rev-parse --show-object-format
```

This will print "sha1", when I'd expect "sha256".

--00000000000088b7c7065f9e691f
Content-Type: text/x-sh; charset="US-ASCII"; name="test.sh"
Content-Disposition: attachment; filename="test.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mw57m6jw0>
X-Attachment-Id: f_mw57m6jw0

IyEvdXNyL2Jpbi9lbnYgbml4CiMhbml4IHNoZWxsCiMhbml4IC0tb3ZlcnJpZGUtZmxha2Ugbml4
cGtncyBodHRwczovL3JlbGVhc2VzLm5peG9zLm9yZy9uaXhvcy91bnN0YWJsZS9uaXhvcy0yNi4x
MXByZTExMDUwMzcuMWM4OTA4M2U0NTFlL25peGV4cHJzLnRhci56c3QKIyFuaXggLS1pZ25vcmUt
ZW52CiMhbml4IG5peHBrZ3MjYmFzaCBuaXhwa2dzI2NvcmV1dGlscyBuaXhwa2dzI25peCBuaXhw
a2dzI2ZpbmR1dGlscyBuaXhwa2dzI2dudXNlZCBuaXhwa2dzI2F1dG9jb25mIG5peHBrZ3MjZ251
bWFrZSBuaXhwa2dzI2djYyBuaXhwa2dzI2NhcmdvCiMhbml4IC0tY29tbWFuZCBiYXNoCgpzZXQg
LWV1byBwaXBlZmFpbAoKdG1wZGlyPSIkKG1rdGVtcCAtLWRpcikiCnRyYXAgJ3JtIC1yZiAtLSAi
JHRtcGRpciInIEVYSVQKCiMgR2V0IHRoZSBwYXRocyB3ZSBuZWVkIGZvciB6bGliLW5nCmV4cG9y
dCBOSVhfUEFUSD1uaXhwa2dzPWh0dHBzOi8vcmVsZWFzZXMubml4b3Mub3JnL25peG9zL3Vuc3Rh
YmxlL25peG9zLTI2LjExcHJlMTEwNTAzNy4xYzg5MDgzZTQ1MWUvbml4ZXhwcnMudGFyLnpzdApu
aXgtYnVpbGQgJzxuaXhwa2dzPicgLUEgemxpYi1uZyAtQSB6bGliLW5nLmRldiAtbyAiJHRtcGRp
ciIvemxpYi1uZwp6bGliX2xpYj0iJChyZWFscGF0aCAiJHRtcGRpciIvemxpYi1uZykiCnpsaWJf
ZGV2PSIkKHJlYWxwYXRoICIkdG1wZGlyIi96bGliLW5nLWRldikiCgojIFdvcmsgb3V0IGhvdyBt
dWNoIHRvIHBhcmFsbGVsaXNlIHRoZSBidWlsZHMKam9icz0iJChucHJvYykiCgojIE1ha2Ugc3Vy
ZSB0aGUgYnVpbGQgcHJvY2VzcyBjYW4gZmluZCB6bGliLW5nCmV4cG9ydCBDUFBGTEFHUz0iLWlz
eXN0ZW0gJHpsaWJfZGV2L2luY2x1ZGUiIExERkxBR1M9Ii1MJHpsaWJfbGliL2xpYiAtV2wsLXJw
YXRoLCR6bGliX2xpYiIKCiMgU2V0IG9wdGlvbnM6IGRpc2FibGUgZmVhdHVyZXMgd2UgZG9uJ3Qg
bmVlZCBmb3Igc3BlZWQgb2YgYnVpbGRpbmcsIHVzZQojIHpsaWItbmcsIGVuYWJsZSBicmVha2lu
ZyBjaGFuZ2VzLgpleHBvcnQgWkxJQl9ORz0xIFdJVEhfQlJFQUtJTkdfQ0hBTkdFUz0xIE5PX1RD
TFRLPTEgTk9fR0VUVEVYVD0xCgojIEJ1aWxkIGdpdAptYWtlIC1qIiRqb2JzIiBjb25maWd1cmUK
Li9jb25maWd1cmUKbWFrZSAtaiIkam9icyIKCiMgTWFrZSBzdXJlIEdpdCBjb25maWcgZG9lc24n
dCBoYXZlIGFueXRoaW5nIHVuZXhwZWN0ZWQKZXhwb3J0IEdJVF9DT05GSUdfR0xPQkFMPS9kZXYv
bnVsbApleHBvcnQgR0lUX0NPTkZJR19TWVNURU09L2Rldi9udWxsCmV4cG9ydCBHSVRfQ09ORklH
PS9kZXYvbnVsbApleHBvcnQgR0lUX0NPTkZJR19DT1VOVD0yCmV4cG9ydCBHSVRfQ09ORklHX0tF
WV8wPXVzZXIubmFtZSBHSVRfQ09ORklHX1ZBTFVFXzA9QWRhbQpleHBvcnQgR0lUX0NPTkZJR19L
RVlfMT11c2VyLmVtYWlsIEdJVF9DT05GSUdfVkFMVUVfMT1hZGFtQGxvY2FsaG9zdApleHBvcnQg
R0lUX1BBR0VSPWNhdAoKIyBNYWtlIHN1cmUgY2FsbGluZyBgZ2l0YCBnZXRzIHRoZSByaWdodCBl
eGVjdXRhYmxlCmV4cG9ydCBQQVRIPSIkUFdEIjoiJFBBVEgiCgojIFNldCB1cCBhIHNpbXBsZSBy
ZXBvc2l0b3J5IHdpdGggYSBzaW5nbGUgY29tbWl0CmdpdCBpbml0ICIkdG1wZGlyIi9yZXBvCmNk
ICIkdG1wZGlyIi9yZXBvCnRvdWNoIHRlc3QtZmlsZQpnaXQgYWRkIHRlc3QtZmlsZQpnaXQgY29t
bWl0IC1tICdkZW1vIGNvbW1pdCcKCiMgU2hvdyBldmVyeXRoaW5nJ3Mgc2hhMSByYXRoZXIgdGhh
biBzaGEyNTYKZ2l0IGxvZyAtLWZvcm1hdD1yYXcKZ2l0IHJldi1wYXJzZSAtLXNob3ctb2JqZWN0
LWZvcm1hdAo=
--00000000000088b7c7065f9e691f--
