Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBED26FD9B
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373493; cv=pass; b=VlwqM1LiVkedNNQJsQIrnOzuTbrHhmj23frynIz76OVB5GkAMFPNZGS5fgHDieBQwo1bN8GyRhJmdK9frAgr4SR4VV4yPdaRqoFC1eRPIS8vuMDjnq9g38z2mhgn4Hhgvxf0e4aFVPqmOjytN/+oE8+tGRRvhKVG9HNY5gI8ds0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373493; c=relaxed/simple;
	bh=ESjhN3pxkMwsFOEEbY3VYjzToofTlqUZ5lpLoBtjnJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/aS1CHNYzfQSfjNsEzp4BJItrAPioBN12IFOd5RGoUdn3Cbj2oS6neC5pG7yrjyG/cyxhqATJQKaSFJ0NA5LrpmM+hsg7rQF0DkpnMUnOMb/nKys0yg64GOhf14mb8AOHTDkn2hZuN43K0tHWgbuyV+vcBzcjzUdW3LvhOXmaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+fqfBqW; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+fqfBqW"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec49f7e35eso376421166b.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 00:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782373490; cv=none;
        d=google.com; s=arc-20260327;
        b=Gxl/Ia8/BrGTMgG6FqMkfxZQUZ86gcLWVRnXrzpzbjgLDdrdY70w7qvwOO2W/8LgLr
         Q4tqJvP78BVpelIdgZ4tbX4YKZE4QU2FtCxEB8QyHEISE/+dq+wh+zTEJgmzt/owyRhh
         BW1IqgpKzPJYDC9eecNv6Q9xRlwFq/21x8cWju5v/NpdgpcVDrhnn5RdbZHzTvqA8ibl
         Nql6Mfqk4gXWv1BaEZAYodXZj7ePAkoJ2K/Rlb/IEVou4ye/sX5IkU91K1YLb3oUjwCR
         FY6ramfHSm9yd8JyggI2sRHi+DIAIReLlRgP4/UQe4FoTb6eyKUwaURjGKaZ6y4iv+4b
         TsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q0HmryeoJ2YoV5z9Xs4fG1S4SRHFXr5Yrzac3HDSp40=;
        fh=MEuWzNFXKZwyDprX/c1KZ/cRZNHiTRPZsM4AJ1wgX+o=;
        b=lY4d0443EMVSGpG08Xg8NpzUoGXar7oFAP8vPLVQhyUzN9Y2iBV5w5tJKSL6d5T7qA
         A1sM3Jd57j3MQPFybTuISCjY0juE3QKPvwv0Re19ab3TpJLxdeZBUUGZKs1o5s1LIuaS
         bRU09hkK2Hj9WKJTLOR6XYH9C+oj2exKwJQ4lS+ii7C5vxYwOwnmi3T6O4nz9CY4ZFNA
         0ypKxDrHJ3qc0OAL+LyXh8LBnfdpkt3BgGuyxO4eR5JWcChtVDIkPQcMLmXpYUXEyX0C
         yT+mTRK6t18GuCLMMcTx5GH6aB7N6c9PIFWosLhIhu+314qIHmNkLHh6TRRZB7VPB10K
         4u3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782373490; x=1782978290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0HmryeoJ2YoV5z9Xs4fG1S4SRHFXr5Yrzac3HDSp40=;
        b=B+fqfBqWH0XWSJUJ4h4KUrbFqs4NdQb4ZmZJUCeIvb76XM6bckyM/P1kePfULpYrcn
         DxXeByEUZQ0zl8zKtK235okMqdEdSZLEO7TNDQkX/oeOmg8PYX9m2AGe+KNhl8lgh0bA
         FBlj0rZsOagR3JqljAE3iQKXd0QsEbHZ+xc0WSSZ6YMcJhJaX868iUgx3cncPrw7S5g6
         NGwWyo3RXziSCYBrMcNcNUhj5iXH9LIscYHXaSP3CX0+YPhIIJMqjWRjMcSRs5hFyhwQ
         jIHbkCWJIzJkjiJT8cfFEgoZWetVmy5/A3bzXccUAxhtNetbonSUNeNLmXdkTSNboCeT
         L8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373490; x=1782978290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0HmryeoJ2YoV5z9Xs4fG1S4SRHFXr5Yrzac3HDSp40=;
        b=YKvOas5K2U+VMtSvTag6AxyjbnALOUz45PV2nO5NgzLHbhQ9Uf/AhxrnkZ5G0pT1gT
         33oLsbapP00H4HypH9sX8GXO4+qxmpQBUlDkxCTFnk53vhIHgkZHvEeV01mT/wq3a2WY
         GL+NPJCd6+KZ6/2ivwzOt/einGiupYvR4ZvjW3m/WTP+bAOJK4ZY/nnkEE0J82bWMvtu
         7eucoGgeDQpFq5s/1H5WM+A/Ps65UV0z7gTrpOZIWy5kA6y2JSlxrp8ZrkGYE5uH/xDc
         gakM0KorwH+21luTeQYtjfQr+A4VDuxuTN5/x2cYREKEvhcu83JVisNCY03zIHegYhhC
         Td3w==
X-Forwarded-Encrypted: i=1; AHgh+RqnP23yjkwrqQT7d+OHTlFwmedKtst13FEq0KHMm+G3qGF3YTQPAqAP0fYYgboaO21/9ag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgPeZ3FHDYcraR9r8UAZBFpAiP320eJ1QPANZ/fd/wrGtT9uS
	5HdzV9spoM4jCkMgiKDlhPlE9XG6qwSHWHICrzzL8eSDfFv3lmFLn51ldOxq8skYYjgDZ2JvHIc
	/CqB2QxGFgKJ4K/fReyhy7+jHXXPreEQ=
X-Gm-Gg: AfdE7ckPU6IuiKNzHUscyOftyz2VLKHCfoVnR8oCT45PctburPxJ/YarJzLOZmmbPBq
	xXucFLhgYlL/zakRN62GjLiOgFAjFpm+FJoby8Jig8NNnO3L2j4ADaVWh7Q3LIPhZoBfHCD2BBw
	ZqR2yxKua3Q7f2Xtqj/i2jQ6AqCwrlm9FjDl8EfgiRELheHazJ4dxYaL/n1FuLmvfVJe9iHZPrN
	WGlUImQWRl16vb3dlzV0pDkap78meNrcmZiHJQ+xbnUXESzbbZHEDnS8Ny587dufce8lDYG3OZF
	pPnDpgo=
X-Received: by 2002:a17:907:3fa7:b0:c11:cee9:1ea4 with SMTP id
 a640c23a62f3a-c1205d97e43mr77547466b.2.1782373489713; Thu, 25 Jun 2026
 00:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
 <pull.2331.v2.git.git.1782338114.gitgitgadget@gmail.com> <11bcecebf43797a889f08e79401370f43b2917a8.1782338114.git.gitgitgadget@gmail.com>
 <xmqqechvh8m8.fsf@gitster.g>
In-Reply-To: <xmqqechvh8m8.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 25 Jun 2026 09:44:12 +0200
X-Gm-Features: AVVi8CcztOhWdscHXRYtWVTjRwP8Qi6lkV3jDGvX5nvmIg-YyUMq1P2cf4NZs_Q
Message-ID: <CAHwyqnXZ_eGUPOhq1hXs==uYuYbRBWw120fXRQa=apWKekxVAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] branch: suggest <remote>/<branch> on upstream slip
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Do we still need the _if_enabled() thing here?  Isn't the caller
> gated with the same condition in this version?
>
> > +     strbuf_release(&remote_ref);
> > +     exit(code);
> > +}
> > +
> >  int cmd_branch(int argc,
> >              const char **argv,
> >              const char *prefix,
> > @@ -957,6 +980,9 @@ int cmd_branch(int argc,
> >               if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
> >                       if (!argc || branch_checked_out(branch->refname))
> >                               die(_("no commit on branch '%s' yet"), branch->name);
> > +                     if (argc == 1 &&
> > +                         advice_enabled(ADVICE_SET_UPSTREAM_FAILURE))
> > +                             die_if_upstream_looks_like_remote(new_upstream, argv[0]);
> >                       die(_("branch '%s' does not exist"), branch->name);
> >               }

I think we do, so it will give the advice and tell the user that it
can be disabled in the standard format.


Harald
