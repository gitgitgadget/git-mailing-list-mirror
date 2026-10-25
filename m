Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792969011;
	b=d7pcpB3lGCjmdFqDUbs1JIjJ6qUs6CHJQo9vINR8qiLEUcCXY3dut03Lco1jNx14+iHD
	 NSjENOrqUYE3mPMBkWntuxpBOzMmwH71mFAqKuzogu2ZIAKTtRlTzU2QIcgNFRPU3ZJzX
	 pqdbz5ysOs4odumHX6otQ2+gM43TsX4a7ASjNl9hM+R0n/5cb7Poxhsbj1R84JIFNqOYa
	 DsFjlyHv6oOX8UEOeqUY6LXQLaYuRgcBG99VkDLX0Ku3vTx71+7dGPO051VaHZ7l1C8aP
	 uCVDTsohpbV1QsjbrynJYlYdpbdPbidhbwx8wsXvCYJtdiH8mweD5IEov+LnQ6EkLfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792969011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=aYXu+a0lfEfbdKNkyxdeI7Jxv2eckT4Slwwql2CrCF8=;
	b=eiTED8W504SqRiDA2JfaFh/c2OKNBp6EHiqrsvjrrLk3iKTWfUtSTW2EagrRSm9eNR2x
	 6Ia4XAVwq4IM03hb3zc1/U5GvZyHOJ/XDYRP4eXt9fSTDVCE3Fqvh7xf/tW6Q5m65tpoq
	 RnT8ejxMdJkxJPIt2ltytBYwekod0EwPkBXwPHmZRjRenT59TnhY42ECMLgi9Qd1frmHr
	 7vFlSOiPIwsRkWD6EaeMTisONC8pQx1NUBMnBZ0VRtVBXgEkm6OsGCTSChmcSle1L/4vH
	 ByoVhNLQh+EFeF3nAXkddYpDaX3MQUb2gAOrLAa7byagj4j1ZnNCT5qM9lYcMpGzmmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="K7/X3I/x";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C0606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 22:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 626C0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K7/X3I/x
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4877837890fso1230778fac.2
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 15:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792969010; cv=none;
        d=google.com; s=arc-20260327;
        b=XzKM1Kr95joeT4P6MuDdagMaqQFDA2bqX+WiLuVsDt6H34OiRWoYu+lt96M9IpXj9T
         hDMPZqDGoG7lotcjBeOOdDhxer4OY4lcCbe5I0AZON/HqG6/MHNTvULmpSZEg1S4f87t
         Po7ndKZmOKCEn0Zw13l6YIPaevS4P33Qxnt4Hq7uyR3T1UKhmUJXV+zlv/ksLi8+M0X/
         F15omQ/nwFTdfxVmRdBdK5Z/IIhk8Y1Spe5bMDwBC+uO0PcTdore6OF7Qzmw4c1WlnuJ
         6BMESMu3O9AXmE4sDRia7KT80Wvs541PZFdTZlAGUablZyzEB6dgAi7GkIo6RMKgme4+
         V4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=aYXu+a0lfEfbdKNkyxdeI7Jxv2eckT4Slwwql2CrCF8=;
        fh=718jjMaBNu77HJfntiQbbbz2uy/dGZCSZUSzxoWykEs=;
        b=ZVy3d0LoZa7cUCGHqFo3IlT8ovaaNY8HwyC0tLWM6PNBmbFhB+97bRB2NqxbqD3MfY
         EfIkCRnwfKi5FKDPrDGKI25BdSOgP9+4G9hQjD4zZfhW2unjhBKQ5JovdQICJ6QDCXNe
         KOopC0kqRdIUOzP3M/WYnMibPs1vtTHzkCeeD0FpO9jYQhUgk2pIaPBPNRECR0bT9ohh
         Sgfi5vS0Y9bKSjilalKZx7Exdg0FtvHY9hyYeeVpfkFfCcLWXLRzR/PUcXTInFEkza/z
         4e2iLsQZW7IgVJaSTpxiJVz0VyC29ncaeuOk77qX/rCDLJ0YdOhEAy5ynIztIMfvjKXE
         w2gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792969010; x=1793573810; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYXu+a0lfEfbdKNkyxdeI7Jxv2eckT4Slwwql2CrCF8=;
        b=K7/X3I/xGSaL9pW288IAybYCn5emkXqdUA1GRg84FJlK2aVRhheztGS26Sb41EVldX
         nB5TGFS0bvWxx8wH071MmTyzfeKmQbszJFa7dGaBlWeViRSuFU78K5bqbV5SI/uoxoAr
         Oz34wSb5kfbN3f/HSNOnhn7E6eqQYuansbVK3pz/kVTqANlVfUDY3yI41RdnkhvjuKu7
         qZDNZp+Mi49H2npPq3Jvt+YlVBnUigRZewRch5OmUujctxrNbQY+GVQXYWPpNRXgu9Sx
         vitUAasDP7v3t5z4X/UUSO6h76y9/s5Hvg4KIm6dHM2bV2XYsYXNOLZF34UgISzmCgXq
         rI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792969010; x=1793573810;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYXu+a0lfEfbdKNkyxdeI7Jxv2eckT4Slwwql2CrCF8=;
        b=07kxcNM4/iAZlVbKb2kM0AlO35MOnUwCt1Fky8Kb1GaHxiHPDASpqq98wf1qafPCAN
         JESeG8+/H2u8yLEiVKBMB78JNjKD8QmHQoiiQJtcud1UvgeX0SsWxA8JVL5xpDsYPOW0
         jtcsDN/kl3kg0xGq1CCmVobI03DTU0yD8ROU4syPTVJotmVETY6oLyiU3xY5X2WqZuC6
         29UrM+HTQZdjR7E1xQW97Qa+VTAKDjJdtkQjA6m04G/JLFvqA/wD6Y1CtPeTX0ThYTC/
         QhkWqw9LdNsKUqSiVhLu6rJMfxTPxw0iGC6H/ov2wZ/m7FwmN0iieV/A/RipL19SHHPT
         jkcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzh6FBnj5sU+B3/4LdyzxS2dePeRwvN/nmCVIRi51pq++j/Z6D+p/vOGTGpE1YXlwpcvzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5oxdjMUP3Xi7bfKcQAORgRDib2/zFc6wwNQecotjrhnTbgftm
	EdNsytKmRBefOlBBYUm7MxD9iRmeubUQy848cZF+y8JQ3pPpm8B+2wMXfyKwRbHhu6n7uBsd4Uq
	fT56sPV9eqW2sHVUP7neBqVHKO6sZOsUUZ+R2
X-Gm-Gg: AYBFou23/Rbi5p9T42NK0qR2hqjGmH8qwPWkQ5+RndMCDUIbKXHMYwh+BpCEGYIywlD
	gzE/n5I88qci8lZ1zLzaMczVPggSSrhpE6BxSNn2u7QXs1RPLHAsKJ3jgHuc9iCsoDobSZFVuyv
	daiQB/OfpCbFGqdeN3GXdKdy+9SrI671JNxIquOTSHth+DFUbmVQIeXsolD6CwOHg0wS161T8nj
	yZ5feroR9+nnzqmXR6i2rNntnMf6trH2aeDP3P1BqAeeLCHM/fHgQPfowZjmE4IW0cB8uB2kYBs
	0xSUCNBapuQmKyiyE6mFygm6IpizCEIkCLP48UvjTABg9i/lL21hnQwpd5MTYDQppYPbHkQHWpZ
	P7t1uH3xvp8sF4vVdPN/bAgBfxtaRQGjCfWt5HhLeVWVIjhQBZU8tvgeAri71Eodoc87YAIua3C
	sz6vr6sK2P6qdhwSRkoAtAxO9Uz9Sde2wWEOTZ6JKbBoy6ypmetfuHg4d3
X-Received: by 2002:a05:6870:3c8e:b0:4a2:4c6c:c9d5 with SMTP id
 586e51a60fabf-4a83effb874mr2777488fac.7.1792969010247; Sun, 25 Oct 2026
 15:56:50 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CALdwsC1cMKZgRPZA+pBaJe4PPs9q9W0K9CQLmM2bgUCyysTB-w@mail.gmail.com>
 <20261024061017.100191-1-tangajoris@gmail.com> <CALdwsC11JHUBBTt3e_RFixLYSF0VU1C+mG7bQsO0vV=a68XHNw@mail.gmail.com>
In-Reply-To: <CALdwsC11JHUBBTt3e_RFixLYSF0VU1C+mG7bQsO0vV=a68XHNw@mail.gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Mon, 26 Oct 2026 01:56:14 +0300
X-Gm-Features: AclHuK-dpNcrvz3-VPZSYV0OAGdborlb4DlRKAh8wOlNgGUxf8skGFCUxI9uUyk
Message-ID: <CAKrRMNr=e2b0aYC_MPCUdY4Ln+Dtrb75V_o1UeHJRbRT29NLzQ@mail.gmail.com>
Subject: Re: Git crashed on `git apply --check`
To: Gingrspacecadet <jackrawlings2011@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding the list back

On Sat, 24 Oct 2026 at 20:08, Gingrspacecadet
<jackrawlings2011@gmail.com> wrote:
>
> hi,
>
> I've attached the patch that faulted.
>
> It was generated by an LLM.

Hello,

Thank you for sending the original patch file. The crash was caused
by a blank line after the diff --git line in the new-file section,
and it is reproducible on master. I am currently working on a fix.

Best,
Tanga
