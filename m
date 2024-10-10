Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5FF18FDBE
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728561860; cv=none; b=Ae3DB9iEbxt9wUhBduJMyZUUb84zs8jLXwLYSh2WG9FqQfU77zm8BaljSWp6gaiPHRBetVgf5+6B0V4QuVVw8KAO8oUjj8rTpJDvl1tlE/zsxthvosNO7CxO08xXPjvWb2Vt8LRrQqvWAQ4HGnjhITk3o0tM6GrgLLR3olQWTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728561860; c=relaxed/simple;
	bh=NHMASbVKn0Z/jSG+3aW/I3RtYSWc237cptheY03Fl4Y=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=B0e0oo66J41gnVodPbhL0SDd/hG5b9zNeHpZ+ciHJzBnLuOStWDldOoKSJhjx1Gxax0o0k0tv/b2V9F+1UnzLbJOFinIRqbb+8YQBZgd+/rnJ4sT+fTwq/LbRTsjsZKGmQbCvzIv/zUNuJnSRuJ8A5rAr92IkHLA4FCgSzNigD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiD4AVMN; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiD4AVMN"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9c3a4e809so64187885a.2
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728561856; x=1729166656; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qj4soJaVFGYxu3m8/UBnN8gWCzvaMUMF7nKJQjVZK38=;
        b=OiD4AVMNVnngo9Tv44nRaYWnQu4uCSwA5hdDLgwlpHIm5XdVdULGXMFcFrwoquuXfv
         E+KuAYnpZkpQ+asm8WXYGfnkO5/V24co1mM/frQ0K+JPlbzg13XJyTyZppNEYBY7WqON
         j2lyzbVj4U2aO0TXUX2JRtMYRUSt/7mZaDonmQYoJVUj+GUFCrzgpdtmMju8ZoZE/gkY
         3os7J1J0n0u1FO7Y9ZkmLNgRRHUOikN682aF64V/BSLiez9I2zCO++Q0UP2Ysl3Djbnp
         GZxSIzN2ErIB+Heu33GrTl9oqrtiA1DdmMXJCiWzl6cUbAl4XQ/MU2vHTKh6Js2/OQl4
         ItdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728561856; x=1729166656;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qj4soJaVFGYxu3m8/UBnN8gWCzvaMUMF7nKJQjVZK38=;
        b=tx+TjAlD0lT1lSIKN++y3PiF7Np2OJtGa/IXptFbpFsPPeTbkxCh0hXUGhH9qzrxdA
         B8kVqszENUnQ3pdazjpi1VTa1N8QJFPlSGTuVPzpkt6mN8Bfjh/0VKVXA4ZdB/9KaEwY
         NrItF+Q2V+84Y84f5dTKbEWg/mdg4+JA+Io+wwiV6Q+eNTOTu6shaufSfm+QxphavS2V
         0J3gZw9b9XVo4AjqPxtbSVueffXi/h+AC3EHPgnu1kalM/PdexiUPaGxoQB3RfJY8zDs
         IrYhmuwE7px0dCELH8nTFXRdAzG19VpcHD9vq3PZtuptXIopjt0Wu4R6shX5tqcQ9VRv
         Uidw==
X-Forwarded-Encrypted: i=1; AJvYcCXZl/hIUnXDgTYb/p9Y0wghTsF/nA/+meSLGsp1iRygdCzz7Cin/CdHT0kaR6Ywe10hEaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTi1Hb1RqE0N4YeGoL64ees3R9BJHUrF7jIKAp5wlQGVcsKVG
	jW/W0h7IySCwkcJg9OpNSfqQOShkyR6bDBMLzQ1X7QHdmbB00DPO
X-Google-Smtp-Source: AGHT+IFIqu7v/x42ghvsAO7lxFHMRTSGLfrx5RX34PSXgmPZ/HZOOT5FrD+aAhmHludgLV0CkiWdvA==
X-Received: by 2002:a05:620a:44cd:b0:7ac:ab4e:f0df with SMTP id af79cd13be357-7b0795277a0mr1056804385a.7.1728561856407;
        Thu, 10 Oct 2024 05:04:16 -0700 (PDT)
Received: from [100.83.152.97] ([204.48.76.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1149893basm40653485a.134.2024.10.10.05.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 05:04:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
Date: Thu, 10 Oct 2024 08:04:10 -0400
Message-Id: <C05B01E0-5007-4FB9-94CD-CBE74E79F9B7@gmail.com>
References: <ZwSt0ZrlDaYCzfRX@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
In-Reply-To: <ZwSt0ZrlDaYCzfRX@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (17C54)

Hi,

I had a closer look at how the header dependencies are handled in the Makefi=
le and I think a cleaner and more idiomatic way to fix the problem would be t=
o add clar.suite to GENERATED_H.=20

I=E2=80=99ll try to send a v2 tomorrow so maybe hold on to merging it to nex=
t for the moment, Junio.=20

Thanks
Philippe.=20

> Le 7 oct. 2024 =C3=A0 23:58, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFOn Mon, Oct 07, 2024 at 05:53:41PM -0700, Junio C Hamano wrote:
>> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>=20
>>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>>=20
>>> The clar source file '$(UNIT_TEST_DIR)/clar/clar.c' includes the
>>> generated 'clar.suite', but this dependency is not taken into account by=

>>> our Makefile, so that it is possible for a parallel build to fail if
>>> Make tries to build 'clar.o' before 'clar.suite' is generated.
>>>=20
>>> Correctly specify the dependency.
>>>=20
>>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>>> ---
>>>    Makefile: fix dependency for $(UNIT_TEST_DIR)/clar/clar.o
>>>=20
>>>    Hi Patrick,
>>>=20
>>>    I tried building v2.47.0 and stumbled onto this small issue. It
>>>    reproduces for me from a fresh clone on my old 2009 Mac with make -j -=
l
>>>    2.5, it's a little curious that no one ran into this yet.
>>=20
>> I suspect that nobody tells make to build clar.o (and nothing else).
>>=20
>> Instead, the t/unit-tests/bin/unit-tests target is what is typically
>> built, which is part of $(CLAR_TEST_PROG) that has clar.suite as one
>> of its dependencies.
>>=20
>>    $ make
>>    $ rm -f t/unit-tests/clar.suite t/unit-tests/clar/clar.o
>>    $ make -j1 t/unit-tests/bin/unit-tests
>>    GEN t/unit-tests/clar.suite
>>    CC t/unit-tests/clar/clar.o
>>    LINK t/unit-tests/bin/unit-tests
>>=20
>> What is possible to happen from the broken dependencies is when I
>> did not remove clar.o in the above experiment.  We may rebuild
>> clar.suite and then link clar.o that is outdated without realizing.
>=20
> Makes sense. In any case, the fix looks good to me, thanks!
>=20
> Patrick
