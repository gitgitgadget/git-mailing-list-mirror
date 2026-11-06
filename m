Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969479;
	b=pZmtX668mVUNTdgg4x/hJt1jt+f+JK5Ef2gZ1ZStkbWA51RM0Q1jzLD/X4PBBwDFNczo
	 PmTOzD1SJneDyAiTq9qG6J/48m1DwMs+9wnBVxBAUEKd+DVvYrolco/WSPZmyUxvPwYtz
	 ewd9HkOaDSYu5751r9OMo+C7v0Jo/MZEax6hAVw47Yp9gAfUu42bAOMoASzO5+AYy17qZ
	 s8ddkUx4+B4lVECyqhoPmldPTxe1kBleGbSuz9b7MnTc+8792bIHvog+SltxXEI4n0U2+
	 6Ls6xq4yqmoaCwwN5MpgMMgkGHlc0iWbWFGVIbCk6fHB8WjVnIK0RF/IxoCVLo44h+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=2nYbfqCPZV8sh7oasyvGieVPZiqqy0MlRRyxEDZuIIA=;
	b=hvwD/sjWM2Jl949NpQJFWFuyXtLuiFTJsKZQ3KzdgzGG5epJB3dRpU/WrAr4ubC17W+z
	 MqA+fVk9TUK0lbjhEN55ljdBNU0kZaqP3Wc9QDC4i5MCmCgZqI13X3dU7TBFw63NeQ9F1
	 Z3Hz+YYIZg27BWoz2YbjWrjVprCyLf8IM/Bn+nEtMMw990AH2pwmoindJ+yH6LtEtvF4Q
	 vI9Nqe4QsH8YYnL1C8DWye1oCnUbhEd2K3/kGthyMvkjGE1WnGsuhSKa6oOXRdq5MXs4i
	 BrmQbINrzN+msGTaPDegSMi7cJlDGBeutFGF9NuTRzKHGO0vivwy47Zpwn0CIbjzcvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qjIPvaxr;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4224606A32E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 12:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4224606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qjIPvaxr
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f259cdc86so53950785a.3
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 04:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969477; x=1794574277; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2nYbfqCPZV8sh7oasyvGieVPZiqqy0MlRRyxEDZuIIA=;
        b=qjIPvaxr5TsMktGET7rNvwae3GGBx+ERf/j1GpiPy+BmXOibGZL/trYFxqlW/Uyb//
         Ren30A3xkl1XnwOSejJ5v6jSqMg+FrdS20uKI8PzFl1kmmgh8oZXbHcQRRjMkR27bJWG
         KRvGNVcWuowhUN+h8ZbSn8A9/QpbuclSdWm+D985D/Q/uLFIXfyYGTJuTqI8dSPDh1dd
         JoVvodPAV7omR5D5JYGYIswT6NjGA1KYSJ1nBDj7KI3Kubge3N/3J3E5O3s58rxUKO7O
         qiSf1rlyLsVg4/S5kzRblZwcC4aLUju/o3ygrcJ5DNcQI3jkRP1S3lkFWAnv/y4B9Gyp
         hlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969477; x=1794574277;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2nYbfqCPZV8sh7oasyvGieVPZiqqy0MlRRyxEDZuIIA=;
        b=xjNPUf3AFYcc64HBQjDMsQGzufPQU8hTStiz7dbWCzcEuVhCPjTTCXGzMpaKcen1hA
         dNy4o1Ag06FHgFE5x2rcB8BJ4aa3vWQEIwGPvdTRInA7rRjtNzf60I6qFziMFcQVdGnU
         6oIO84Q0r/nRq2DgcVu5OBYQxZsLgXGtzrM/0kICtPPEDZBvZ7JDuu9ccanOQl663NBQ
         LhL3Yc3EdYXtzwlibVtQ8amSOtjPsiJ8K4kOm7tT2f/09dVJqGe6Qr1/1JGu6Y9Ps4yk
         /ZVk5oNzPnIPwxZtwRcRYCF1x7+0NI/lODz0DNJl1MhMuvKrZDvqRh87iBS+zGbPTJTB
         35Vw==
X-Gm-Message-State: APuU4Z+d+dsocl1C6Bnjrs3e5Yo9Zd1lsHsTFBywNhF6gQjmtrw2a6yd
	pedm1Sisfk9X5taeodixxsInG4pxTb9cc418sr+Xy7uKahQymFlfA9cSvLKM/4s4
X-Gm-Gg: AYBFou1NTerNQ5cZQhw/ZWAX+o1zpMYIBVTGijW/81CJWxdurEhHS7jD7FKiSi5aPf+
	my2mutJF4ACtc7N0T/wOxdJ4PiEvsMb4e6es051hWTSjnl9z8pYCYJ0HA23tfViQuaGj9D9sobK
	GY0PTmfqgfH+PQJOpyVGAawoAh5s76+ljDkTuZi8HX9U4DEtyLM6VGNOUDK13PSMprnx05E7caE
	LN8dnHbFADC6fWIXKWuZ+WLAB+Km1F6MIMkidf1fdkcn/BsdKbYjsNoLo7H0HALft9Sdro4yDE3
	o+YFCOhTKrp7t7dxHXUq5TOkNNFQAdITtiaXQNN+0G8wTzM1EiPBCtK6PR829e7tL+9EI1gVBfy
	fOlsq4tmo75oAPJ1+nDEvHplBPRA+1pC9rG1VMPVaU/dzX+rIht93zlWIg6fnbnEV2VfGMwi5Ld
	zgJGo2g6qvwRMFXbUV9F2GEK7whjUKyCmRtIMpfkzDYpTEg3Fm/ftTLMSiw5w65luIDJWpFa0D5
	2z7I7/mQQZqL2pVrUK3Ji47mAqJa4QFznoNlH5J6YphDzxgeaH8hqoCAshFMIzCnrmD5axnayvH
	sAA0QFgOX1wBrzaY+O8VIwB5laCJG0o=
X-Received: by 2002:a05:620a:2694:b0:93e:fd69:9a93 with SMTP id af79cd13be357-945f3506c56mr322529985a.31.1793969477491;
        Fri, 06 Nov 2026 04:51:17 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f599bd5fsm137013385a.9.2026.11.06.04.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:51:16 -0800 (PST)
Message-Id: <pull.2299.git.1793969476.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Nov 2026 12:51:14 +0000
Subject: [PATCH 0/2] t5608: assert that the packs involved really are that large
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Kristofer Karlsson <krka@spotify.com>

I was looking at which tests take the most time in CI, and t5608 stood out
when (unscientifically) spot-checking a single run. Profiling its setup
showed that it does not actually create the >2GB pack that the test's name
promises. While adding assertions for that, it turned out that the
unpack-objects variant of the >4GB test never runs unpack-objects either.

Once it does, it fails on Windows, because unpack-objects narrows the size
of a streamed blob to "unsigned long" on its way to the object writer. The
first patch fixes that.

Kristofer Karlsson (2):
  unpack-objects: pass the size of a streamed blob as size_t
  t5608: assert that the packs involved really are that large

 builtin/unpack-objects.c |  2 +-
 t/t5608-clone-2gb.sh     | 54 ++++++++++++++++++++++++++++++----------
 2 files changed, 42 insertions(+), 14 deletions(-)


base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2299%2Fspkrka%2Ft5608-real-2gb-pack-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2299/spkrka/t5608-real-2gb-pack-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2299
-- 
gitgitgadget
