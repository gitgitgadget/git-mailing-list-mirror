Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794407609;
	b=S2g00GoRXYsVrTMq0heUMg3tuUwVArtkttW+5k6cGz2HKdq6qln94JzUxHUrDRiv171W
	 k7UDcLmFUMLNnNgm5MVFYvcULzHu6cJZ3/avgYfVKGXnbs1PEWn4cSpk0GuHgyWqZKl8w
	 jrfeiU6mrpRL7Q9KpOS1GkQ12TKBie7wIFcB+zRKk768DbXF1YytnSABiFzcVqVFTHuia
	 bxynwR9zzFth9Hl2Sxf/j68oDch0FVlRyZ9VTOeY4WqdQnI8Rd3HsC1wq3bb1kl51sc/T
	 HbffpQL3dypryuXAIoA9qRYBrbng31fN53mX0z1UX1IM054JN5/5l/8Lqc/rlfXRThA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Content-Type;
	bh=kHkmznRNy+k1+ZKSRaDXv3H6JUOjRtP+smibNO40ex4=;
	b=EfjnLv4ICXAjBrBeaFVda3rH3+WX5BmwnJh41k/1VQnfT0nov7+pyg7y43QpfvIS55Ca
	 Pm6bE0UMteGg/6yk6p1uIaRrgB+RdSmE9MU+SdfX9HUEkAGRXZ2/DjAW3kUetr0buiXUw
	 ZOJb6X/gZhPNp+xtyF0aIohHQmxM3s2fhXse9WQDsUxTJTYu+ApFsFm+jRd5qExZpCKJd
	 zP6gbn+ZD3bTsKd7fxnBS3ftPWkJDoA+EutL+S5wlMEoS6jrY7qID0Tcxg61Bu/q7iRji
	 Wi/5B7duqG+ARRHnJ7Q0+2gYYKAGu3sPsEPQiM1W7ou+OAuRswsYGYc1Sq6Q56M0aNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPLH3qbA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CDC60A262B
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CDC60A262B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPLH3qbA
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d2c8141dc6so1760580137.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:33:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794407608; cv=none;
        d=google.com; s=arc-20260327;
        b=p4uoMqgeyYwD+5h6T1/2CgZTdAltgvePZYCCP+lb4gE+K4Bp/Xpuv5+z9DxaoyEVzt
         9QL5sYUuFqwHz4eLct7nsLQUlUfDoxYaOLlElBLujw7RpvFJ22XEhaxqw22Qzy4ALb8q
         aZHxeWjsYviS4UM/cdjIKIrX3peD3AjzlNAX2DCRoklkR+9S31j8sT/7OLSoipNLTrB4
         54/X2OoLc5qlc/IrhoUnrbKDf1mWlCSFnTJhcZ+phSmJO/832QFd+4vMJO0tIlMRQOun
         iGTKYbP0puxH2DHJZsZBw0GwIf4hqp5j3YNxNYwOIC31QBZ7s6oJ0oHmjlBquvfXHl9M
         IMmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=kHkmznRNy+k1+ZKSRaDXv3H6JUOjRtP+smibNO40ex4=;
        fh=Ww9vamoLL6pT3GAWZbQB53yyTLtjq+6uMQvyEtKBMio=;
        b=sv8D+Ef1iKcKTF7kNwT7S22A2keycMaEqGU4snIreMj6GEZ3bWVfN4mpBIFAunkuo7
         HMP4VSAGdtcaQ2CW4/3qi+c/PipJs5SHTtQBg7YZub5jrKAx2NYL60x2jtquOVMoYzdH
         YqzVhSz4q1cGYkPjUPInFMo1DJAB3jYtNLog1z8lMS/ArAM2/QgppCAFm8srBQGYKp6z
         8CP66n4fm8yY6IDMmmBdCYRm3Sqo9Kwyf2a5AKCkXRxGzzDTSboHrvdBnfaUBNHuRb1Z
         WHHmUoGL1ZphsUc4TflPl8dvxDxOZBVCI2zQ7cWBRV5J1F7WhSUpJrBvEO9X+qheWMvK
         /Jgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794407608; x=1795012408; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHkmznRNy+k1+ZKSRaDXv3H6JUOjRtP+smibNO40ex4=;
        b=zPLH3qbADjtm+ec9TauPV8DjuBgqc52dRVo0zEJM9wfNWl7tm9v/Fo+eqah3ek92cK
         i4wvlD/1TXADZlytM3RGO9hqrev01dzQYDIh24+C4o76t2bDmcPDWwh2PBZvxXEXkhkD
         1kwVcgfCmpQBouqfIZPVTOf1F/dGO0xcXefcgCYj7hZx+i299SAeVTAUMKwOerjpTTsd
         iiTLoLVo+J14IgyduaEG9OY6emUCFSEk9DtfwNeeCzQAR1Q7wG5JBBQtS8B5YU6bO1Ru
         LdznLGYD4hJbAJ6g/H56MY4UuBXOuLNJf2BHunpdUxcg7wmQz7xY8F9VH/jgNUcrhCVY
         1tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407608; x=1795012408;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHkmznRNy+k1+ZKSRaDXv3H6JUOjRtP+smibNO40ex4=;
        b=qLjVJCYnnrkJh1qDV6CU5rvz/ywiYpb1cjiL3ch8Cq0rTK9iBWMsOPCWbQNZp4cP4Q
         291cZ3uYcWaJkwliaeiovm+KhU8MuGgcqIssQrUKnoL6l8BWcRQOzlOQzDYfmB74ts5B
         SajtymfP0wGP8Drq+NBTm83a20XE41G9CK389CGF6p9yDDpilRd0ui7wexMdCx/WYocd
         YvShyKwSbOWclGlZb7Lbiub06nfj/cRySL2LWAJNrLTzqkCUYoVwxxcUm6TUxo2UYUYz
         tXit2IuEoSDKcJYuA+Yn+vZzAwIm494i3L0pz/m+3tkd7oHbyOzwgnb4wNbe7u8fLQen
         B63Q==
X-Forwarded-Encrypted: i=1; AL+hErGzCK/IaN0DTM8fQenK4ydTBi76kEDVWdOw0f4i7H+Cqxy/6XyrKfJkiudpwCm8MAFARmY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8i/5zrMLTyRVsSHuW2nhTcpkJYFAEjiycuacrhN5x0dfb2HjiF
	S+a1gxdr/OMWWghHXU1AtiMhmHobyA2K99o58e1lAtrjiVaYyNvFTBZ09ylr1HeGmpX5zb6/8BU
	ZTtAd0UW+AfZmzNcgkZ45zpX/fBSL+7E=
X-Gm-Gg: AYBFou3xsUViyh5Hg6JhCleiDg7GGSeLKKtGFfdp1doORB4t37iv7+yIF/D4STdrjFd
	ck5+Qt9i/x865uq+sYwhpFjAoFpiCGxnaS+Rt6VEP90eFF6pzhUIhM6/7/pzCB51OyoGcWcL2Yp
	WD2iD7f+c1yUXxj2uHbITenp247x6sXJvGoFL/bv2XBNTv1iBQdbgdcZpI/hPimibu68nEr+aiU
	0mAB2sughgDteHpEx6QsX4r1apQvqdZKQsZV1MqyXAOp6vKuK4WqQDiXTN7JOnt90/HUPxvr3C8
	ALqVL2IgKQDhuSoTiKYA0wDiYrIPLiszLjpx2ome7AsBPv8hAL5RJveJHWkIRBTKboLIQqkUhH/
	kx4hZGETU7bPqKSUnNgjVpyWj7H6A007yB/Aye9Cjo20PRThSFr6G9z+yf+bTrktz8M6v1AMN6w
	+7NGIbWIhdVkUGja94n0FQe/9eSw==
X-Received: by 2002:a05:6102:5092:b0:7d2:d873:d59e with SMTP id
 ada2fe7eead31-7d50619787amr806137137.23.1794407608467; Wed, 11 Nov 2026
 06:33:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Nov 2026 09:33:26 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261110002251.2007617-1-jltobler@gmail.com>
References: <20261110002251.2007617-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 11 Nov 2026 09:33:26 -0500
X-Gm-Features: AclHuK9BkCM344MjWwIX2dnrUR0Xx5qsZPHgd4jPUheIT3akNab1oeTFkveD33M
Message-ID: <CAOLa=ZTDxY6dJL0ctDtexJpkGE6YxEPo6SEa55aPrF+2VZg1VQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] object-file: eagerly create ODB transaction temporary directory
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000015e95c06600114f5"

--00000000000015e95c06600114f5
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> Greetings,
>
> This series continues work for the "files" ODB transactions and makes it
> so the underlying transaction temporary directory is created eagerly.

Without knowing enough, my first question would be 'why'. Over the top,
'lazily' seems to be a good way to go about this. Hopefully the
individual commits explain this.

> Previously, by default, it would wait for the first object write to
> lazily create the temporary object directory. Furthermore, this series
> also ensures that objects are written to the temporary directory for all
> transactional object writes, not just when batched fsync is configured.
>
> The first three patches consist of some minor preparatory refactors. The
> final patch swaps to creating the temporary directory eagerly and drops
> the lazy setup.
>
> This series is based on 3c60ef1e38 (The 17th batch, 2026-11-08) with
> jt/tmp-objdir-loose-idx-merge merged into it.
>
> Thanks,
> -Justin

--00000000000015e95c06600114f5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a61b432ebed4cdea_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yMGZMSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOFdGQy80anhRYldWdThmLzNCUG1Kb2RrNGtwQ1NmTgo4dGRFMnUreVNZ
b0xyQ1hEQis0T29ueXBXNXUxYVptZTV1eWhZSnZVM3hWOWVQSC9XdFgveWMweFVNWWg0TDhPCllw
ZFAvNDU2d3dOYnI2Sm1ZeVp2Z1ViWjV0SElLYXUxbHR5RE5pNHBxamx3TDJjQzlZbjhCZ0VpTDVs
NzB6T2wKYnkvVEx5MXFYMzFiTldJTGNlb1RuODhoZ2NYb2R3YUo2WFJYeWJiVVBHbGVoL3NGalMz
WGp0K2NYSHFTbXA4QwozR0NPZGtFaHNJbUpobnQ5V2luTTVkU3ByUThyTmdpYVhzREtZZUQ2b24w
cFpabGhyaVIvWTE1VEh5U0ZEb2pwCklGdkprSEk0MVIrVFc4VUNidDRKM3B2aUtYb3hiL0tSdTcv
NmtiWlZXRTZWQjNKNE9WKzJPeFJnSDJOMWN2NXQKamN4K0JSQUJKUytNZHhGeUJZZEJRYmVrM1Ur
cVNDSktBRFlaTUdZaTdKRWtPUGg0SUw3L01xMU43RWhHcVQxMQpMSXErTXNobFZJSE4wUnp3dUow
R1VrUlo5THBNTnkwYVo2ekFxUitaVEhHeVF5bGVNU1BPVWR1cXFqTTYvODZSCjVZRWxQVTc4TzNT
bFZpZmRnQUxlL3Z4a3E1SloyRjYvYXVGdzVObz0KPVMxVXcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000015e95c06600114f5--
