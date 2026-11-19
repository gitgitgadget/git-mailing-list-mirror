Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795132278;
	b=M6aV9SsOMWG2j8gX6T1J1JvCeFLmLwtSkP9TxGlEqX3yLnDRQZjx5skwavL8y0/8j8qc
	 rKRoW6nuqmHnxDGX+U3JNZSQGEyT7J3DTdhOF3oxQMJ6QO7fQJH3BvB438hOAE8bOwCma
	 VqIRAPiZrmyyB4nfF9NN4vp8acBs9KS/Bln1iSW2x53Kt0+caNnNCNGtm9yrcqAfE8Bxg
	 r0bWrPunutHiid4OGkooWUYFdE/qjyrTUAT7hJTEK/nDgJfelCAmbP9Tpg5ohBlreHapc
	 jp120y+3r1gVeH9bUJ/XoAtL5MCUTWscUIWZHZVMFi9cC7NRbS5nN9oMOSDjaK8RzPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=kizmuETg+xNffFhqxk/y8g85gkA4vxrEoJ/DVgly7IE=;
	b=crJ3uvkxhS/aVPuBZ7llrIY+9aeFzNM3gJb0VcmaEaVGDd4NjP3PXJuwpTM57dPGA+ku
	 fvzMoGjibV8OY1vtk+J/2XcM524iORzBPxmDFxOk1KZFi0b7MFlfh7Hbe4GbfOgSWDawj
	 FuBMJdf5gO+FDWaKNVmXENraLDm4moKXB8Le2GZt8QjPhE4b1mgdzhuTdkTQTRFUdhboU
	 yJDMwLuxlo9YmSGv+lNEnqwTpx4q3eEEYJE/DlpTppSdVCGV1Ir/ePBNdku1g480qNkm5
	 Ys1r0llaDQ8JkJhbJkFlf8X+GQjSjb+LONHXJ2kGJ3yzEFmtozCfGBF4k7wnNFzoz0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xxum+6jG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.52
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC05606A325
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 23:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC05606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xxum+6jG
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-8470d7d430fso179917a34.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795132276; cv=none;
        d=google.com; s=arc-20260327;
        b=TpdF1gWySaALpnwJGK7zZc4PjYx1Te37tTv510/O9evc3RLlKubieHImvKrvYazJBw
         B3waLspVhCT5mDmOTmkJzusc+TBipBqFScRQMiUMKcXfQ0QiqJ+3VRByKv27Ss7RX1yT
         Yv81RNRoLW+E7akiCnZe286FtyWfOA8ZI6NHCxPLu1FD87qQjwArk7DRXmQ/WODcMcMC
         NYLMq27GgMiToFCUQab7kJ0ioj6bCRWr32iqPC4SODlE9sC1WWigcbp5dmAPGljsVPij
         vVnSINzMAK5S27csOaf+KptgQabtjH9tPn24+tJcQE57e7m0CdbvOzdwG7v/DI3IVjQ5
         lpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kizmuETg+xNffFhqxk/y8g85gkA4vxrEoJ/DVgly7IE=;
        fh=aFNFXGlkWr9VHec7QZLKR569visIXwnMh1bDez6nAoU=;
        b=Q0D1BQkJoENIt4OwGfkHAYUuJKJ2N7LLFuiQGo8Gt/74TIWQypPq/NKCWKxSM71VDk
         TOclTkYV0RjVCBLBRWwcby6Pv7BPh8oatJLJxVhnVpRKdtIt38ikVpgwr8Z9iwuragLz
         /4MC5wdm+2y5QVxmH8XgN15BNkhD+cOxSsL6bTwEO1SR6Kf7NDNpLRZ2qF6DrR7u5cT6
         vHSObuwUP11/QYbhRtHUIovHDG6dYttUzmg2jaWzSXxI7kjFDIb4Umiq0uw4EdfHLFTX
         UYQ6fSgDUa7Qy2qxN5AIBdLFgehYSVvl6NKc85Rv1RTMhsU2IJMB4Su3OCYmIpG1ApiB
         bzMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795132276; x=1795737076; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kizmuETg+xNffFhqxk/y8g85gkA4vxrEoJ/DVgly7IE=;
        b=xxum+6jGgJYqb9aDMkPFHMwwkqLHNn/psgxQYw7GG3ruy057tEnc2gL8XeuPiQTR8y
         2ApIQLtksh9NiVmudXXvwIXBDO4JUwY9KzbeHcV/2f+twbUFKjAVjhfo4z/9+17zhkxE
         BdKv3b0nIGBBVJREPnZd/aY1W0CYOZQUEU+knvaiEOEiD88ouUF+Gt4YK3upJNcvtBGk
         Kkxgu3+vaOTTSqlXxzBdEMP0LOAnla3zm9cUaw3EHFnsAo1CoSdJUjrMxpvP212/8TeS
         skn+qf/AtlhuhnyXsNAzBaQb3/6Ps3fwiq85SAUXKK2QsCuEetxUT0zNGKOzedA0KYIQ
         7bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795132276; x=1795737076;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kizmuETg+xNffFhqxk/y8g85gkA4vxrEoJ/DVgly7IE=;
        b=E4mQRu05BaHr101cvCNz6ub51M76msROvg6PO1ohPTHdWrDquLqHAq7NqW8m3s/m90
         XOa4GYxB+xW4y44SsJYWAIwVZNWiSBHe7+fkm5zWR9spWEPClWgise3kRnwOc55Rk/c1
         mV8i7gX2jcUAZlvNfpBp5wr04PK8KQ9qUKnLowhp+lJ0cdy1uRz2jBcKr3qk2S+d3wvF
         yROkd/UiSCJvyXKQSWIuaViYHH2WGKg3rxzuOYV91lsOPSmOznnLkKx1fjezJOBG2ZN9
         V2pxy7ie8kWvoNCyvyl+8MlKNDRMX9uYY3C4f7B4+NE6AUgEUJzQKatON6j7enVS+Ywr
         FqHQ==
X-Gm-Message-State: APuU4Z/NSqQrFV8fLB/buCDRGx/swCs6SAZ6b9iOw5gB+84EYX+cXfvO
	Q/SFBR6MqsOEoKU8AGG0EXlNHbTtDS6CaSDzU8YKidbpUHmo/ELcuC214JUfk7UR9aGYNrGq9Rv
	7VRRfgW6q8C9UzGfBuoRywUbyxTLrHqE=
X-Gm-Gg: AYBFou26vCTKJdQTdsOD2cWl/K7RTwUdL4MFxku0CUMu6NFft8pz4teJs5XMFk1j1Hc
	gTueM/tm1aQox1pajkqDICtqX9dXqry3/U0c2yf1+GS0ej5wo2pMjAEAF/1AAF5WeFoANUrWhbc
	RATuF8VzB9vVsjI1Gi0CvrQnruj1rU2kifQ/2/mGwOQT1Z/K3JbNjmllgWf6PfoASITvAzrtlAj
	SBQaponpB9L74tjBJkdSXjWJu8Nexy1qiRLP0Oh069EPHRDLU3em5jBZI2mzTza7/NqvcX3TLc9
	OzqFUGdByrzzrpQNAMV6woNCkG/JBhyaft9WqA7C7zIlnInBObqt93uoMlurSTW1c9UQ2a/esT5
	faZBWRtdHBvL8mui9+Cr/7mOjb2qTb0BHs1T54DU2b2hQhJq+GGKjvrYjDokghP2IzUB3hefzCY
	JsAIi02yUMe/UvSC3Jl+KtjFl0RVXwZC2RmPxdVtgQhgr8L3mbELSc
X-Received: by 2002:a05:6830:6814:b0:81f:138e:77a0 with SMTP id
 46e09a7af769-8631595daadmr2076670a34.24.1795132276327; Thu, 19 Nov 2026
 15:51:16 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117174353.1158905-5-christian.couder@gmail.com> <20261117174353.1158905-8-christian.couder@gmail.com>
In-Reply-To: <20261117174353.1158905-8-christian.couder@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Fri, 20 Nov 2026 02:50:40 +0300
X-Gm-Features: Aa3M54oJFAzIHHiajUgGBvLRPaNyhIF6HGuJvm9EFmaCQR-oMQVzbkuuPhwrJK8
Message-ID: <CAKrRMNqMRkkb9+n+11p04YDhn6p39uoc_Upc9voYhZZoLyPXBA@mail.gmail.com>
Subject: Re: [PATCH 3/3] xdiff: drop LONG_MAX check on merge result size
To: christian.couder@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, 
	kaartic.sivaraam@gmail.com, peff@peff.net, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hello Christian,

Great work with the series.

On Tue, 17 Nov 2026 at 20:46, Christian Couder
<christian.couder@gmail.com> wrote:
> Let's then get rid of this `size > LONG_MAX` check and allow sizes as
> big as `size_t` allows, so that merges with results over 2 GiB no
> longer fail on 64-bit Windows.

I ran t4300 with GIT_TEST_LONG=1 on a Windows server runner on GitHub Actions,
as you requested in the cover letter:

https://github.com/tmjoris/git/actions/runs/44423166965

On e1ec09b23c, the two big merge tests are skipped, because long is 32
bits there. "merge-tree dies when merge buffer size does not fit long"
passes. With the series on top, both big merge tests pass.

I also ran it natively on a Windows laptop with the Git SDK, and got similar
results.

I went through the other callers of ll_merge() and xdl_merge(), to see
if any of them still pass the result through an unsigned long. They
all end up in odb_write_object(), write_buf_to_worktree(),
strbuf_attach() or fwrite(), which all take a size_t with this series.
So I agree the check is not needed anymore.

Looks good to me.

Thanks,
Tanga
