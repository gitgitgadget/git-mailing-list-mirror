Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793347559;
	b=18ebMNoX5lwWIe2GQ/CzFnYyg0YOQfkFsRnkpYngu36RfxW5kv76oKOeYN41wpLs1PLq
	 NMAwwOXBFMDsY+2jyWVnE6ga8CWPccImAxKUiKPzN4rCH+2z+LcmlI49Ik5t8oTk2/CcE
	 7KSrA3N9TbVc+Khl7PWMpZwwGYmblB01W222md54jnixAMNexzQdny/nLfc8ODcgOgQXW
	 ZKtjn7q70Z5RZCN/3v1+8Ig8FdWzoEmKKoWJJ4/FgmAKpqd9zBrf9WeCEDNA1R8dn3Sc3
	 yb813/SGgo+CGzc+fF0MFDCblaV4Cv8+BtG4UibyBB3jVajGMaBDaSGjp7wIfLGQBDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DzBp5CmojQczmnC2CnTbllLv1ccLIBs39rAPPwt24ow=;
	b=C5/71o1QTg3ZhcJBqE88qvjfm3+UFBLKwFhXbkmhblrfzMWpEzXCYYP1nlxqUebFnWpv
	 M243Pn6awU+vB2ytewaX16MwSXBgIEZsLtQnzdkDP9GDIfJbDIB60fqlwni75NlHfgm4O
	 27KddFTftzd9TsWwY/FES4kTtPYPpQQZUtliPn4vaj+k5CQMyUeZPeffYHxyIZy5Uien1
	 lTGyqRC+ujs4c1oMFTunwIHpij4wTIrHm5SrTZpR9LIURP3W5YmMXvtBrm5UpwRD2dnJv
	 RaULMke0VGIRM/Bqe9W8ocLbu6gTrlD8zStTxd5rbbKSTIvyQVLSiOFLJ8+XH0YqkHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIBu1QAU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5D606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD5D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIBu1QAU
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c763de878so3402476d6.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 01:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793347558; cv=none;
        d=google.com; s=arc-20260327;
        b=HQLmGOdNXOliIlWEcgym1FeoakO+S1itej5M9WAByJWBRHura1YFwFAyMKTfz6OTW0
         bk9g83BoQuwWlDdSe6MHk2+GEDtCefbj/2LJWvYaXwBgULOAloe11V1sUUwKUFXu6nId
         rOFqVT0xaVYlTjHcF50l2zIhJVK7UjkkfW52uEFosk3B7obgyVBI4BhZ2eVBkjoZEBaW
         z0gAchoRBvJR4oig5YctYaixeLw9pAtNpWN55lw7zdyK1cFA535EOcndwwLJw+YBLLnC
         2DIOLeQoucfGMb4KXJX5aKp05QwsdwZdaslgtgOrzkRBf7442quqhSc210ijHHSYSKsc
         uAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzBp5CmojQczmnC2CnTbllLv1ccLIBs39rAPPwt24ow=;
        fh=ilRlB8df1mivv+roLhAGpWaY1n6XqAuqE8j94tQ7Olk=;
        b=rTP2RiLrDQK/kK4WU0Z+WL4ofdeC0joNDTw5USnLhIg7EhvFK2RaBcZCpIXI0xNVCD
         fJ9pM872rFnn7FwRNbz2RbJushAqTCMoMw+s0uV2gePNtGUdiiEMj/jOXW7aj/p2dk2k
         lz35LYhh3SBTPlzQgie9x99YWwzt7C2EtuiHZiIsOWTPuA6mpbw1e07YJPHtgDOY3vCH
         W+ia62f1lzlEKh7JBN0OPeFuQiGWnLQKvryqnyHZ41eeFCRksue4ORNhkTqf8AjW252o
         UFzap2ot4ke3rw7bzsAR5+XZKj2yzuDkMeb/HokJSKdcJHcmx/34yH6NrHweJ4puvF7g
         CggQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793347558; x=1793952358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DzBp5CmojQczmnC2CnTbllLv1ccLIBs39rAPPwt24ow=;
        b=WIBu1QAU1eFIBLpUjPLbLDU03rSu6CvLC4kLr/LS1+6lWPjCKTjYDkyicJ4/JaC22g
         EXRjIT/Ky4KivazskyVp2UWbVngVUk7C5TXUwUImZKNML8Kg2YWt7dbg1ske1pdFkGRc
         dxv3pwVSZmCEWF5mjQKtPOtcFzd7MnCG0muBmMgHK5LAq0DAVXtY1aH9hSx1mAeuxIdt
         mNZ92HmRRijP3Vuy6w+TSeVa94rqh92zr359Wrxo+bsjAqPPGRWQbrzwNBW7GtMQrxZl
         G/TDy15A2381Gty4d++9lqTQ0OQzuKLF5wh3gZXCg5c1plyYBCUkkQzKZek4P6/Kl/+s
         BS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793347558; x=1793952358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DzBp5CmojQczmnC2CnTbllLv1ccLIBs39rAPPwt24ow=;
        b=xxm/XAQsNyPt46ZapH6Vf1iI4oJwo7Z+qK+bylpVlw1bHRaWGpZu5yBTRid7HswClJ
         LIaN91eeNcFK/OAKePZ+MvV+SzZzIibazsPmtoGIGhEmjElUtPECNT9+ZdjtKsiw2NZv
         iSXD0zfjwDYqFVmI26IB+mrotFf2j/jKVzc+fiaf/SrH/liiQhdXy8tJtmvZt2p7zWtc
         GXijbCTvN2lTDxy3/lrA9pOdVbsbfe9XBBp6OIwIY1IuTuee24EdJx94YAr7g166owkp
         x6IxSwtPbkDpXI48in+SaqAAsmRiGt++08WJSTcScEq7qVohRBg07TZlZkiqT2vBX/FM
         r5oQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqmxzH3uxI5LHpcAtNQXcQydbForDJqy+TSBer2owQfDF34bYIH8hEyZO2c7jQkA7CpPQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjZQiohSq+nyDma8QNeBsQU6GH440yuUkX5CbDvvx9oWlOI9yv
	KOkP09T/QCY8bfPEy/eL3tvYUIcANmyDsgB0nrr8rTZvqRBkxTDJxeRhGaop0TVU/IUC4smwMbq
	5xKKxx5WEv17bBN+sJSTVPcIl6bXOj/d8f2FxTQI=
X-Gm-Gg: AYBFou2A42rYVT/wGSwdWx4FMcLIzu5f2UtH/1b+KxevdXOqDbLQ7OQQdIyRMGBbdaX
	xRCaGM+NmnRXbS13E8U/xFi8IhSB7epJBL1H34AwZoWBmrt77ZSkGqjRtLElS0VCO0IMMy+ky0Z
	XIWQsGIAjMEXJdJgswtm+uAiDe/VSRYJvMuVMxPU7b9rFU4LLnXgukAxmCDAkntNir9LHOJHxEw
	0D85vW3CE0H95HIJwxYnEJlQ9d89h7CBY0cu7Mbbc6yAF6OJm7ojNz7c/LxNBzVH9vNAlQEaLrZ
	cgd1jxZ1tsd+h1nxhZwT+jOwTKrHq8QBYLu2hmQDHEPGIzxAL8p28X/d3y9uumrz17QXxEjW5Ca
	axQ7fdQaW+xbnprByP9D/5xwAUhEVSSur3w5lwnha3Uxi7uTV+oWk/Z04ox0b6VvAzHh+HdRog8
	RtH+LGwD6OsRRrWuumloQhTavfN4pXJUqo9MKTHxWjZffJotnaVureX42e
X-Received: by 2002:ad4:596d:0:b0:91c:6258:ec97 with SMTP id
 6a1803df08f44-91ca4b03e2dmr21734976d6.11.1793347558307; Fri, 30 Oct 2026
 01:05:58 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2260.git.1792299301663.gitgitgadget@gmail.com>
 <pull.2260.v4.git.1793284463139.gitgitgadget@gmail.com> <auRGDmW0R-Ipn-gT@pks.im>
In-Reply-To: <auRGDmW0R-Ipn-gT@pks.im>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Fri, 30 Oct 2026 13:35:49 +0530
X-Gm-Features: AclHuK_bOiWsJ9syjjoCfTDNkZS5QqxaVhmuiiO4LJX4ZRhHanvM3_XxLUdLsj8
Message-ID: <CABh_KWgjkgbXhTcvTu6enOXcEDziJ4S5XZ7MMMkKLYqRxTE4xg@mail.gmail.com>
Subject: Re: [PATCH v4] [Outreachy PATCH] t0001: avoid pipes in test scripts
To: Patrick Steinhardt <ps@pks.im>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 12:54=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Thu, Oct 29, 2026 at 02:34:23PM +0000, Srujith A Poojary via GitGitGad=
get wrote:
> > Range-diff vs v3:
> >
> >  1:  a70ccdf49e ! 1:  4373eef413 [Outreachy PATCH] t0001: avoid pipes i=
n test scripts
> >      @@ Commit message
> >           [Outreachy PATCH] t0001: avoid pipes in test scripts
> >
> >           Avoid piping output from git version directly into sed to ens=
ure
> >      -
> >           that any command failure is properly caught by test scripts.
> >
> >           Signed-off-by: Srujith Poojary <poojarysrujith@gmail.com>
>
> Thanks, this version looks good to me.
>
> Patrick


Hi Patrick,

Thank you for the review and guidance throughout this patch!

Best regards,
Srujith
