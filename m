Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795434529;
	b=LiTvS5vWr0q1LjSWelAQv/2pmuEiNGMTCKdCuEdeFeUYR3XSAt8HYpl1ZiRMJtYyGumL
	 3xaOmDg+Hz1CIJV3tfXKHju7QYCXRhe46OMXAA+ANu4XMyWsXFeAX5U+JRKVK554rc3Pv
	 FEOQmSP3ZaNYVYC2FKQf+uWehLCpIPRv6koSoB9LsItNAWnNFPe1OHdJH82c5le0KuXei
	 VyJz2cTz1bVJjT+YGNgUJ8oQBFMYZco0ThobR+68BRnxe+nRljnsjWeE3iFAqeix2u0Jt
	 KqokRu7vYlT6kWb6gaYb5toKWVlpPB4WidnulsJUclUnMpxdN0E8nDv/EPXpITkR+xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=pgFOvVd3IoZ0Bw5a6YYo/0+dcAKVgR654AEmB5Aq8Os=;
	b=RDaRybnD/WwylMFkQ6c+pa12H9Sg7/AqZWK3M/yHICm5xRjTBXjjwZHGVLV2WhNgjF+p
	 2/3LG2S/TJI5kyRPIbul6aDfJ/+TIKDO5soDjSlM3PfrQfk7zACOuS2PTagSTbFC5qG/k
	 aivuy8DKxaCQZ4PuiuJeb+kk/VYbRFNcrUb2b5Ey7YD7sZzD1IBBXDr1YJSOHF6ouzBgN
	 0PU7FFa/26I0OroF8/ZjouLzjGM1j2nGPtkSCgGTzNL4QYdvxCPbBLKQq1JW7vCwcRG4K
	 VIICEvRWNIos6HUFongT95mWnafcD8kZlJiWvgXeuEKh3nPHcl8s+vL7fUcmtUaUO1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOew8ri3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9E606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 11:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAB9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOew8ri3
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2af4c8d00so5493821c88.0
        for <git@vger.kernel.org>; Mon, 23 Nov 2026 03:48:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795434528; cv=none;
        d=google.com; s=arc-20260327;
        b=N+cHha3OqEuaur/fmppRgDSnYmhu7v4CN4kPN2MWjYtNXrKMoQ2PFQVZu+qB+IfKgt
         yhByBidPWa9pAoo1J3ICeutjQbuKadP33GHBenyLi4LI3hUDBcvEuGKerSnY9GIAAVrH
         MYWxm6m55cOsqnFgRdJscU1VzHdkW9rv4WDKFYf95C+LPY8sIyMPV0DELJ2qzobia+g8
         ChO4xa/Z+1rrFqZbhWW9uEGs87uTIg8xpFT5mugtC1yQlp+0wY/nViOBKBoHL34eKbvz
         3lCXHxgMnvx/9LABfShiKaKmasGhtcYFiH/8tYRAlTUFJGHZu50/Rp68CEkqxlGFbMtw
         zFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pgFOvVd3IoZ0Bw5a6YYo/0+dcAKVgR654AEmB5Aq8Os=;
        fh=dcggSuVe4ZRTL5M36dE4XCZHo/UnTNoRdjvj58RjSv0=;
        b=Uk8AokGtkGyhuW9NlMPhoXgT4kuWdwmbtn52CouyQLOtjsUuzlbkHHpqIUTmFybFxF
         4W80J8zP9p6XpQ6n9XqCg49tUzIeDm1hXI7R62iB1O5cF9mjuIoYNIn6znDNAy3fg4ch
         X4NTdZYpO+EXOjL+/nUBJxBn6Xmd/jkRdkLwQyEGq/gxS7dqySR87+0wUROKnWC7f3x6
         /O1ifnWOYrO7LAd6OEYcZ5gBAlNs6atHHH17NczqP9RqGOVKRnZ3h1dlgnGRnAlXjJjj
         BztAoyDHMyeY5YBZutEdAAAlXUeB5a7XyjuM3XD5FUfMS8ez2c5x3sDNIXx6vP4gkTpt
         Bl6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795434528; x=1796039328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pgFOvVd3IoZ0Bw5a6YYo/0+dcAKVgR654AEmB5Aq8Os=;
        b=gOew8ri3kNDg2fJ2caAEYz7BtSF0Dg+jzH1+xYT6/XKOxiUx9f78wYx7NGXGwFBn5W
         TUHN6Diqg1SFCUX6MvjZkt8FLFN/uXHiFhNAqE1rbtfzIAWhy0derBM9uOhP1m/nOFBX
         1c04fdbGO+2nJSEJ7flfLQtjkShBa3CYvIlR7UpHLyoWPMvNO00k6Gzlr/JYZcMZrvPI
         zGIWJgBvLtfp/D1slQ74ga8Q101y5p3BFTubHjYXMbjn9CwouYEfGIMamG4DJWgzW3fl
         01OEjoXuQTXfACwxZpMY1ckGOsi8a/biYEEAz41W+6w2wL7Fm+2P7XPJKHjQ8O2/YTJ6
         hnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434528; x=1796039328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgFOvVd3IoZ0Bw5a6YYo/0+dcAKVgR654AEmB5Aq8Os=;
        b=Hqm9eM8QoMqM+1Bu9i7wFPHaP/JtPLvMQsWZC51Uwpvc8cpLdGEZ81zWGqBgSKnEXV
         SIFndjTOHizlPQdfs6RLS0gpL2ZzuedCCeDfvgG6nJl9UPIG3uko091xnO0TAC4L3Iu4
         lWyERIvNlE2sv7h+SNADdTxV6TmLLEeXqy6w4rqCGiC2Hpidb6JIHfMd2m5ojJG/VJIh
         m2wit5zNBDSlAIDWTUJ//SmBTzyjQ7UH3ubzQl20nGeIzrzfet9WWfuwIHqXDN0DqLt5
         oV0Hrc84KXYjLbyTXsruaxNI7SzOKpq+oWWLutWcxFiKtjtvd8/XM5sDnylL18lVIFYM
         ZFlg==
X-Gm-Message-State: APuU4Z+x3w8/VE5JIQLm4jfLjdycKhCZqvGojM+k53qBQnIvv/+qlJ8O
	QP9lzaIKf11258iO7u4LhI7WKPCbpK9Mz+cM8Yj7Zy+Cz9ZjR+KWkML2FiEDH1TpCqa5s70azv8
	gvOmlhN5gjqg8I0nPVICx6xJToRDCmJo=
X-Gm-Gg: AZFdTZcpWDe3j+1W1Qn7r5uBCfsA7znDrvBGk9+SRCdRaZMjE/Uv/pzye8O6h9bUuNo
	p8IR+9JfBTA/E0dq55zQLqFLoiMPSU2HKZdFZypFNTZaQ8vN6gARPqgDB5AZg3xbPPkh5mG4yHw
	KAoG3bLrYEZQMXNhKGKDerDkgsMD9EOad5BroZVXGQM+OHr8KlIU+VwAKLt+Uku249OawMlzuH4
	vuta+1spXgpBAzUcEuUeV5I6jAddE9gK1g2+Yt5dzPZdszzsucv27hly79hT5pNdrFeOkUx/Pd+
	c+0uOUsDVw+KWVydB91SDAmccyTcLUMrZfeWiYSeyuOEf/cg4h5vS8UTblwKcubtfqimHUL5SJM
	2RZsprCbk9uCAxbEbHEcUnwWtOhbBIxFNpe4sEUm3HJ66OP0Cn1SMHnsVCTm9wD0awN1K3DaDnd
	DQ7Dbte7xRP7SBcWvrx/Sn0ngvScQmdQj3yGZpTsCbpOLZqXY+v+O855rup9wT7leAArNspc+bG
	iyaXou7z3pjpWh2vrQFx0s/
X-Received: by 2002:a05:7022:ea56:20b0:149:1feb:6d9d with SMTP id
 a92af1059eb24-1b55689e6femr12990730c88.19.1795434527650; Mon, 23 Nov 2026
 03:48:47 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793439137.git.gitter.spiros@gmail.com> <20261119071217.828481-1-gitter.spiros@gmail.com>
In-Reply-To: <20261119071217.828481-1-gitter.spiros@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 23 Nov 2026 12:48:35 +0100
X-Gm-Features: Aa3M54qMYtIFqfBO99u9OxijDz7aFEO9xQ01YyijvYBsUgrlZ7hXP-M195VJG_s
Message-ID: <CAP8UFD2aRMn0CiPNXo24QPrmaWykQ3GuNLfOD_KVjkBmFS+q1A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] use size_t for a few more object and buffer sizes
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>, 
	Shuqi Liang <cheskaqiqi@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 19, 2026 at 8:12=E2=80=AFAM Elia Pinto <gitter.spiros@gmail.com=
> wrote:
>
> Hi,
>
> This is a gentle ping on this series. v3 has been on the list since
> October 31st, and it still applies cleanly on current master.

I just reviewed it and it looks almost there to me.

The code looks good. I suggested some small commit message
improvements, and possibly adding a few tests if we are fine with
accumulating EXPENSIVE tests (which I am not sure about).

> Two other series of mine are waiting for it:
>
>     https://lore.kernel.org/git/cover.1794984184.git.gitter.spiros@gmail.=
com/
>     https://lore.kernel.org/git/cover.1793524457.git.gitter.spiros@gmail.=
com/

Yeah, a small series of mine also depends on this (and duplicated one
of your patches), so I think we should just merge this one after a few
more polishing rounds.

Thanks.
