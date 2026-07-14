Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F242448D14
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032584; cv=none; b=Hod29NIIklQGrX5IUBRJ991WrrDwgrxLemPwiFKEpvRaGsrm0jbfQd/huirdMSbcKzKoGbd3jqhUciqLMVjavGMiNXJfyqK4Ber0bWIS2qe9IvCSWmUqW2Ve2I18yV7l7XwrOE+Dim9irZlgDs5oatXxTAPB8HIAknP63YX3t0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032584; c=relaxed/simple;
	bh=WpMK1O+9ZZuscNmahyyasV6tDzJZDg8yrgdOwepvToc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=JtrFjx++C6QCX6WQtTQi8d+E4FRgY1vTKwCP4w5S8vH/W1sgGca19HAnP0bfhExKakT5k36y/kUjyceOeLyqnhf0V6Ru6mObSaYbRf159BrciK+C5lwO7B42PkYVEjHVnmShLynhjU3CcKLhNXNf6YGAMyrU5V2UJnf1ivUz9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjNIzh5V; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjNIzh5V"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efcef23d21so39064026d6.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784032578; x=1784637378; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c2ayaNkA+5ehuYfK6PGB1IntvbYa4KvC2GhiX++QzrM=;
        b=FjNIzh5V5vJDEyfTkCy6TdSuDw3CR3SbH96NR596tI1WLnszKzLaE1TcULu8v20JkK
         DrLBYmBIUkcsEQDU4LpTHy+9vcck+4hT0JeIp5BlYbdAR8zn6ZegYST+5kQlwmKl+qZ5
         e9aa+87H4W6H4SDDa9Hg+Q9BiJyBvVfRJelYcmLB7e0GKeenXRBLsVpwJEG2BnV80Wgp
         qzuaM3q7lyK8TZKCteYXguyp424eQ9nWLUA0RO4VrXNoToVVstDNquVob6POpFwsRT5E
         ZnH67yvs9o5KZNFa/lAfeaEMtTumUvVV/BTkjaQ7veWzH49HkwYEV3ZKUniGWloOYAmD
         DZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032578; x=1784637378;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2ayaNkA+5ehuYfK6PGB1IntvbYa4KvC2GhiX++QzrM=;
        b=Kw+4aAlaRKzhl5h5B0kCKlOodd/eBGfBcOgiFLwbp7Uw8abC4QWuzZJgX9XZagvvqu
         tdwY7axnCk7x/lOjU5zh8sZOIYnFRfdhtdt8OGyTSTSuVw694fG1qpsAWZqdyR7IBhbv
         JB6oI6CHReiKB1fClrpzIouSN6WD9I4MilEqTroSJOHCfqI8JMOswFqgc9p7sHTCDdq8
         HepOlgx/suv6KzPjFO3EZqpljnMtxvhev9qbGFLXhJO2UV/9WdCJLCumPaOJI7zak9Jd
         P2ohdVEW7qr3X6niYCS8R2qB+l7z1/xX7QQKGKkN9+g4+m4w7CQ87LQTP4n4u7BZefeV
         wLZw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2ovxQnn2KMIfD/JvSF0j3qYUJkQf2R4RBxr2qkpoMQ6rchcT/yxrLpMqZTk9X+P3wDMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC4XVHGGiBeiIAW+zxOyVeD4qmgwXpta7ZkQ/8i+GGhcqpRU+O
	EcAGYqZ2JxCAeBwLBTFmX786Hj/OZzX+DlDLxDCOI1iiixrOEKJzSRluo7ureH4e
X-Gm-Gg: AfdE7cl2yDuPUqxplwmgLX0MgOlOU22MI93q47iwcFabzB7Qxjm6vZTE3RUKaXG8iGN
	Z9hDcj89xiehO4CCB7SgioRcZvXsDX5rTPfmWJUIqSitR8PkNynOhzdbc4Fqn7WwPSVGMpBlPxD
	6DubYUTChh7vsFIr7+bd9fvLHZV8FKGN4xmLljoxMx431QLUpJECr3/dLsxBtW1pOe25JA0dSww
	XdXRbSLIgEXHY/zurGlSR3KYR7v81W9k6taWevxkv6Tc9u9SDSIaVAIMFwEfnt5OTYvLTYQUsT6
	o1a963v3COS9dNdYx0oVcdqg4EJdgNxjznFOjx3sVCCN2Ccg66w8P/6VUzN4zldnpAnSBc8BcQY
	IkbFktdFLmvsGovZ1REdXJeon8vTqNbsAP0uAXZjdy0MFSPpYA2E+s6qUYr9XuInbvxy/3ZG4Ba
	CRdxsl6ORLKolMlu+3LIPJaLXTS4kXCZStzuV202BljVt9F02L6DTd6IQxigNkSCxK9bsiawFHw
	KCsCEpW3v87SXz+6pICKTPPW2fhFOp3tDNo0WTh79zR2Eo7NrUY/IcnXdDPbK/Qe44=
X-Received: by 2002:a05:620a:470a:b0:92e:64af:3e59 with SMTP id af79cd13be357-93086c25339mr184814185a.67.1784032578460;
        Tue, 14 Jul 2026 05:36:18 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b089:8e47:18ef:4edf:c98d:d587])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d04e3csm1452548685a.27.2026.07.14.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:36:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 0/5] history: add squash subcommand to fold a range
Date: Tue, 14 Jul 2026 08:36:07 -0400
Message-Id: <0ECE2A94-0537-42E0-A525-FA16184D7735@gmail.com>
References: <DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us>
To: Matt Hunter <m@lfurio.us>
X-Mailer: iPhone Mail (23D8133)


> Le 14 juil. 2026 =C3=A0 00:45, Matt Hunter <m@lfurio.us> a =C3=A9crit :
>=20
> =EF=BB=BFOn Fri Jul 10, 2026 at 5:06 AM EDT, Harald Nordgren via GitGitGad=
get wrote:
>> Adds git history squash <revision-range> to fold a range of commits.

[snip]

> I'll mention as well that I really like the decisions made for how this
> command handles squashing a bunch of related fixups.  This "fixup
> consolidation" is a use-case that this command may steal away from rebase
> for me.  And the way a final amend! is handled in this case is what got me=

> thinking about it in the general case.
>=20
> Thanks for the work on this topic!

Ditto! I suspect that using a combination of =C2=AB git history squash =C2=BB=
 and =C2=AB git replay =C2=BB to emulate =C2=AB git rebase =C2=BB in non-int=
eractive autosquash mode will be much faster, too, due to the differences in=
 implementation. If that proves to be the case and we can safely do so with f=
eature compatibility, I wonder if it will be worth making the non-interactiv=
e autosquash rebase actually delegate through a history squash + replay.

I=E2=80=99m sure there=E2=80=99s a few instances that couldn=E2=80=99t be do=
ne (for example when the special! commits cross the current range and upstre=
am; that is, a fixup! for an upstream commit or some such oddity;; there are=
 also conflicts to consider), but in the cases it can be it ought to be a pe=
rformance win.=
