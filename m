Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794412078;
	b=gBaxhXxt/I2fe1fIT2p7eoeaye7fPFxdbc+Y+OvzOuTg6PrWjvm2MLi2WMogBPsiui4w
	 i4ZKtk2Gn9gtKVm+pQPc3Nw9oNGvLCVf8J6HaGZws29vCfq4gbsJ5T3OuuL+T7vI8gKBP
	 0Shukyir5fy6zFBwywk+S/3bZDbk98frgSBe7mJin3CYy+YVvPLu4uBbT7W8QaB1km2qg
	 ZFudNODHEwzwuw+PnjJs6SuOMdfFPGrVFHXtBC9f9Dvg5VQWO3h9xBZ24sy1qTUQumo/n
	 v+h59pwizTrudQDsiKcIKVBRi2T5GPwi0xF6OkeyKRUdRc/pbX0tDZe/vTNnWE4fmdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=FxcKzxqAlYoVo3tPKNtm+jORYRasEk7RMZDJV68DSHk=;
	b=C+4gtdYnBrcaGE4aZm+M2bE+5jOA3LwpLSHzVHxg3wXxe3rP+fPd8STdoztJqAJWWrhG
	 imBRlnyqdnvTyPT82VWxoB8F9Eh+gUWGTxyx+/d395EAWcfzAfttiXTFHcJBiDTjKMEY+
	 gQPdwSy+upxo8tB2LvrA477vw+EpOMFkvwY2+96Qo4VI625BLxBtbum4JNczogD9aKnDP
	 LmBOHkXla92OY6Si8BCO1TqI/x6bCiAk1zXEIZwKObj/YAqCzswwiN/3ILm+g80PZa3dd
	 jd3qswB1K3vz1iN9bjpcNveuMDHEO+d6vbdQEWFT/YTXFlQlHs3/vmdJmKnJq1Xpyow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=SZm0TNCC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D517606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D517606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=SZm0TNCC
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b6e8b6d424so4888960a12.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794412076; cv=none;
        d=google.com; s=arc-20260327;
        b=S5KBQ9h/iOwDPGnz2hZ7T7Phux2sSiWdASpLifqb9CjPdpFfMvZz5nV4mSvYFY4JNP
         MZ2OYwOTlRn28DfMFFMJ5jQVFX0dNw9XWp59u4AsNvS3atviXjfwX/kwU7Mu0sTqGhjP
         6ph+e3WpJrg+tSYZGR7an0hPIMp38Afb1ZmLR+M3/gsGCjiBpC3ZeVhhriM+s1cT7+6R
         jnRq+7IcfL1MLBpgqeBGbFCH2ufqqJ8mRdX0/6gJ2s3a+2CdoyrjW934vs+DMhw0ddOO
         UxpLTKmOCYXITToB7+C0g4qjBNF+2Q9+Wl7D747SkfZ8pReGDbXzrw0v+hK75VPwfVKj
         ZUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FxcKzxqAlYoVo3tPKNtm+jORYRasEk7RMZDJV68DSHk=;
        fh=cgmEJ8r3zziAYqPoD8D4wvCToTOmzPK8f57o+XC7ubk=;
        b=ZBYR9hUX72eQg/19k8JQk005h3IwZxSfu60L+En5rbkZQBN5+lTxiT/mqyplYLIoIJ
         H2Ezu2vevQ76o20Av1T73Lmk0K/8vqvsOPcPM/VoDndrprT2Qdv3HUGpbPD66uhA1/ef
         ZPavc35kwAq0SUWtozoLMCT4oqv079VcZQHs/9j3kC37eSaVh+Hks/NKrlbfZVvcVPUv
         JkOlzq8CZYJNwoZ4toL+k2PxDfhgDu90XU2dZPkZo1450qX0IcSYIS+ukU/rAQ/J/HSX
         xKul8o2wAvAhX2XCvyg/PcaXlldyRSOX+EQy7qamMFpCUoZnyA4zFRRnsrJ5TGrzrzE9
         +F8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794412076; x=1795016876; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxcKzxqAlYoVo3tPKNtm+jORYRasEk7RMZDJV68DSHk=;
        b=SZm0TNCC9V7e5u8JCjyTYl0txvs+RUpEMgu1Gr+KE7gwkv5JBHSocUYv8C+9b7uEXF
         FM4FW1KrbE1qddzqP612FFNtARInF0gcne1PX+xpE8XBHsx184XpvWZu49klZQy2xcYq
         bbWZXyKu2MgL8DCfwv8DEf4l+4fFC5NYHci2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794412076; x=1795016876;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FxcKzxqAlYoVo3tPKNtm+jORYRasEk7RMZDJV68DSHk=;
        b=w8Yg+S4hioeeG5Xj8uaKcVc2FRUSZvp9F3o4rDIrEAoqp3xS2b7hOedgNvPnovELmQ
         O8uPpZIOuGalSd3FXKths8Ou/hK/WL3AKeAQPrCJ2j94sLWcyc5eZpwp2GkbuwMAi4qG
         TImgVArKMRQz2EFvBoOnMxdFFP3vaJucC1lOgbyKa24oWd2ZJbPshZkDM++smjSuiMcL
         2e7fHCN/ymTKQcLK3wn4glJXCOl5u5WsQ1Ak5XC62v8Zg/9ZBRNWTdydUJf1Z/wrvb7X
         K0eYsZ/AyNiH8H00e6f9j1B75ZFkLFbbY4nVne+Bj6LVgQ647cgiY9TSB5nI4zAKr7gS
         BTGg==
X-Forwarded-Encrypted: i=1; AL+hErGOFbmIY4B1TPdQMupQo/qw2JyCqkbpY69uExYaYCy5lgVk5mpNLk7rYppeo2yyDXFkttg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0LfI1MQlzTmTsnKvIzwVlbC/HyWTwJBebQDIQlvbmCpEV/LI2
	tQ7yiKSWwCBQxp1O+3v60rzZ4VwHWZ2dsoryApa+oS+g2O7aRAeYfCPjRrSS3pIFJDG904bcq3N
	pMX8R2tKX6fpTqLfeV9QunGHskKE3iKS4k/C1KBCVJQ==
X-Gm-Gg: AYBFou3AwhX1DcCTfbrOC3/PRkF75BawPt50uWmZK8Re4mFM+r1UShOzzafDA4jOYqA
	LRvdRwGcEBcMsPQB5LkHjed+/eWuqskmgp+NOY3LH23gyZmVAX4plp5Ji4IH1fchHjbxerPVPdE
	Y4sE236xtxMvQ9IttAEaQ3hZH7/gqwu3Vb5a8HIEKLi/+hBcH9X+K//uksZzArsnFXiSJc3abJM
	AULFIFx4KVYs97JRb2ARxVByGSsFvxYkQpJm3upiX4mOsU6viX9q0+CYTf5Ea7uChm42aDnwnWg
	ggNkvd3Nis+7LJF3jllHn/U1IkVWH4eKAnr9TjQakhpeRmEJPEQl0N7jHAXsO+8vxIKGvQIuU4c
	95TB8Bosbz9achp14i5vg0CuKpfW3O7xl4NkWc1LUypcsTwzO9CJKJoTT5po=
X-Received: by 2002:aa7:c70b:0:b0:6b6:4dcd:967e with SMTP id
 4fb4d7f45d1cf-6b7775ec268mr1557292a12.20.1794412075868; Wed, 11 Nov 2026
 07:47:55 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <pull.2301.v3.git.1794335168170.gitgitgadget@gmail.com> <xmqqse17nztl.fsf@gitster.g>
In-Reply-To: <xmqqse17nztl.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 11 Nov 2026 16:47:41 +0100
X-Gm-Features: AclHuK8uNb-Czx76Mnu9GtLh_S2qV4qbOiNYeBCwsNuhykrQ6Z4Mj0oqdma4zE8
Message-ID: <CAL71e4N2T0XLZgnUVPEk1q8JjRiWbRo5B47DN_hfs1CreYH6Jg@mail.gmail.com>
Subject: Re: [PATCH v3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Johannes Sixt <j6t@kdbg.org>, Collin Funk <collin.funk1@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Nov 2026 at 16:38, Junio C Hamano <gitster@pobox.com> wrote:
>
> "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > Several tests create fixture data consisting of a single repeated
> > character with "test-tool genzeros <count> | tr '\000' <char>".  This
> > works well on platforms where tr(1) is implemented efficiently.
>
> This looks good as-is, but once we merge this down, we will find
> that there is a new use of the pattern that pipes test-tool genzeros
> into tr in t/t1600-index.sh recently merged as part of the Git
> 2.50.2 update.
>
> Perhaps we should rebase to catch that callsite?
>
> Thanks.
>

Oh that was unlucky timing, but easy to fix.  Not only is this
new test using tr, it's also using very large values.
I'll submit a v4 rebased on latest master, which should fix it.

Thanks,
Kristofer
