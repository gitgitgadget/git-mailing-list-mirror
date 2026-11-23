Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472032;
	b=mkh4LgkRdg/QEWVMBTKLtRfUBWRKWCUZG76ncIYWCHU5khUMo2/IVVIcAk2tuZH+HRLa
	 uWiTZp6HmExNb9tkmrLx4z2G0tUgZklv4kxBNHppyNInVvqzoAjQu+c+1RaQ6SShiK8st
	 JG218I0VZ1NZPKnn6ehvBLPA4kn1vxzwbl9gJK1C+LfleSpYDoS3xiCjm1y2jgj77AAwZ
	 OYdkFkEhINhRbtxmBnHz/9uoQuKEws4wxmCrFgDjqK8EQjLnSyNdxTfDhrFFgzqpKWmyP
	 YdGn4bCPSiTmdGiAn/jnJmsdFG5ztduvwgDjNEuZhOB7CIuzwuAHF9gVwzLVwrK1JrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=jo8iT3idewXntN/w2Y681SSP68jw6fRMhcrUFohFeBU=;
	b=awkA0bKw4COrzxAkExcCs/vmRsTvrMrWMguVW1tGOC/vDVQi7QeD5PSZQ/g5azuv/TjX
	 MzIhJOr0AEUgiYO+TV+DHhCxx/ZNudiWlMCE4fycd0auoah8/mtuME/GhjafbbBA5sWch
	 rlTq1u+xE6Pmu4bva1iL9ZdyjQtpGNfBL2Z8aPecS/OK46XSu4mpsxIdigYtBWI5Xa01k
	 g61skbu5yTn0PLn55o7raiFHSu0jtnDRx+kBh4wSulH24zGN1dlmqVEI8AFxAAvIGlfN6
	 1agdXPwOTxDKwYXePa1SDSsWFa5x3qcteUxnjpGkN6RL0BBMXjcChwNU+uwpbO97Fmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAovKowc;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E49606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 22:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E49606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAovKowc
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-385d8a00598so5358566eec.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795472031; x=1796076831; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jo8iT3idewXntN/w2Y681SSP68jw6fRMhcrUFohFeBU=;
        b=aAovKowcrgWy3t915yGx4et9UCGubANhvY+rn1UpATRkhhIXlBnwHPZ6RnQqlpbepT
         ikoUq+uQSKvQUzKEvpGwvnmLvdlDzagYmqXM+d5xtlBwFnvpNdI8idzn9xicj4DdnJjx
         gDQdkmhUM8a+YZya4pkvCnqzBgkqKB3ziR1FpoBbyvFpAveji0EY4suiUM+hjHdqoG95
         o5DvTGisJq7WjB+1rcFI2dgQTR1EzbG/ku0G+h10I2+7rordUXVW1kldqzn5sw6mnrp0
         7tCO/wabVjn1lvKIArDyA7gJ7cOApQTM6wWFx5uTZ2Ur//yR2EXR1vuK+G5DIhz+xJqo
         LAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795472031; x=1796076831;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jo8iT3idewXntN/w2Y681SSP68jw6fRMhcrUFohFeBU=;
        b=oxmzTCVNsbYBjJH1khgycnoaxb5OQUxThR+/u0lb8+julWCKuGPfy6b1zr27ObjFt/
         /ViFC6IZd0d34P/uNdnlFjqZtckXF/gKRYGRjltrEvKHIGsXzUHrHtgVANbLuwZpdbNm
         I4KUHkHBSKa5pCH0PyTc1+b9TMuMTDnrPpC+h8D7Jm2samAYCcIHNdReXK3krd7tbbIb
         +bdMh+0rfvvfaDKpvG9vyysGJq+CpS8jCmGAjsHsEiFDFxdZEjLUUBel3//IWKvtU5/M
         eueBh/48tfZmZb3Lu5DC+qpPLmw6pMyXRirT9UC+OxtFQUVSLmTfazc8u44tfYkZD/RI
         Q1aQ==
X-Gm-Message-State: APuU4Z/JdE7FJat7YEFOBUt25c+vxyeYGQCR8TFMpaRP18EsbsmFBORI
	RLQkNcXFx5Hjb0TUdVYPsdcl+h5M9/DYMQoQdAKCFNn58PBHuUT8Wmb3lUg107Zx
X-Gm-Gg: AZFdTZdfKDCpct2cOyH2QdZ00tSOW5NUq96idWq1dYQAiVBpVGtQmI060unfdUu3hiI
	qVE/7enWHLpJ5tNELtwLO2/Hb/g8OmNAySg10gT+xtvJr/arpxtRJc8EjyttNob+Bd0n+soOpmi
	KzKgTA/5s49nsi2aTZ6c4KMVGqBOEF56VDDLGwoKXnSxfntVqsLyRcMzO18kclpPNQotdVYh1MK
	+du15cNiIVc7USzZc8Zkc/FjZHeXvL2g1nWAIeF4qH8Z9gP9twUYxfxzNR/9Abx/Z6xZzubV6Uc
	4VdPnKgIYJWKziGe/WP90ry+xrYJKa7Cim9eEqB9FWn38VMCmlp5sEEd1PaDhcqDd7PB3vTob+L
	kUnVXbiv+79tAYv46PepUsm+Ev/yAlwBBRFK7ErckLSo8aP8A1+ziSn7P5H4ynKRuaN8AoSMlWW
	B9Kx3WGuuL3L58VJOO9TcCY88IUCBzgPdStCWHkmCbaYYO8GfW+DQ3WRgbKI6/mTxPlzbmd7PtN
	BTboB7f8vYmuOe83wkdMAv58U48IpPiC05Wxy3V0xAqIv5+Rc27AYJhDR87BbmsJ6CVbg2HBvso
	Uy+vA5IeMiZJUKoWHBa9id7yioGhTQ==
X-Received: by 2002:a05:693c:414d:20b0:386:9f89:aa80 with SMTP id 5a478bee46e88-3869f89aee3mr8458127eec.0.1795472030631;
        Mon, 23 Nov 2026 14:13:50 -0800 (PST)
Received: from [127.0.0.1] ([51.57.82.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3856456e6c6sm34878040eec.2.2026.11.23.14.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:13:50 -0800 (PST)
Message-Id: <38cc1dec532ff56a2d3de5ea85f80077823bbb19.1795472027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
	<pull.2253.v2.git.1795472027.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Nov 2026 22:13:43 +0000
Subject: [PATCH v2 2/5] http: use `size_t` for byte position in
 fwrite_sha1_file
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Simon Richter <Simon.Richter@hogyros.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `fwrite_sha1_file()` function tracks the number of bytes written via
an `int` variable, but the total size to write is of type `size_t`. When
the HTTP response body exceeds INT_MAX (~2GB), this causes an overflow
and a heap under-read, then writes that data to the local object file.

The hash check afterward would reject the corrupt object (so no bad data
enters the object store), but the under-read itself could leak adjacent
heap contents to the temporary file. In practice this is unlikely
because curl delivers data in small chunks (typically 16KB per callback
invocation), so in practice, the total size is far below INT_MAX in a
single call. However, the function interface accepts arbitrary sizes,
and the accumulation across the loop means that the `int` variable grows
across calls within a single invocation, not across callbacks.

Change the type from `int` to `size_t` to match the type of the total
size. This is a hardening fix: the attack surface (a malicious HTTP
server triggering a >2GB single-callback delivery) is theoretical under
normal curl configurations, but the type mismatch is a genuine defect.

Pointed out by Coverity.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: Junio C Hamano <gitster@pobox.com>
Assisted-by: Claude Opus 4.6 and GPT-6.1 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/http.c b/http.c
index d79678d01f..2879eb3874 100644
--- a/http.c
+++ b/http.c
@@ -2848,7 +2848,7 @@ static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 {
 	unsigned char expn[4096];
 	size_t size = eltsize * nmemb;
-	int posn = 0;
+	size_t posn = 0;
 	struct http_object_request *freq = data;
 	struct active_request_slot *slot = freq->slot;
 
-- 
gitgitgadget

