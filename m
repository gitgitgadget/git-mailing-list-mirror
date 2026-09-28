Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A34B95B0
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597008; cv=pass; b=uXnu+W3Ctk+YVjWDOvgECqpAbfxlI7p4gyxFUJPRTt6YaaqWDVoPUE5ZXT+WpRspqCjNlQqZjhBnwoqf5+QN2Plg0rfMbozn+ukpVtpiE7EhYmr67bfVK0Cjgd8TRWTCs3MAbqjLJYGY8AyoQxN/dvyP0cFrlEZ72BZY4gB4o1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597008; c=relaxed/simple;
	bh=2HWVJ+DgvJh5pHhFVNCbVFtOiwK5g8rz6yJkpACk58Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcNyqFTAO95qbCBmHW1Hx5ZSquxhD3k1pHy2Mwn3Z8h9lb88StJSMR+PCEiojnmR43DqSHOM32JYe1c1yAT6FTphoTlQBo5w/sRtyhcvdsMMf1kWM9EyBtU926FPPEASLRtcmgznOlWzPDiS/pclVCVCCOBNKLppInCNahjb6/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JivNtyPn; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JivNtyPn"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so16685635ad.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 05:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597006; cv=none;
        d=google.com; s=arc-20260327;
        b=TqPnrD29Zb2ZXJljVn3cC2g8nuCvdgKjU7hediGZDOOlMgBBN0RIz+tM0bdfUQ6RAI
         eHStg8z6kbfTQOHXHg1SNHH09QTCtmJ+MzRDB4b2n6P0jCIoGC91YYzpsoRUfKHELhR2
         0awYqjQuRwayFg91Ur4dsb6n9FKOGBkWeUIqE/B2sKlCll1OH5BREuIjKceJKe7rmDUx
         pumRXZlPK6k5Od/4qJBIKi9vPMOcmvOqRI2HVyW0C8kxVkKVYMPWpnFJKTXKWUx/v+wk
         TUw9IHzOhBX/FEfzEimoq3m7dsdABqHIFI2G2QnrdonZOiIzvsuF1m18am4ZvplEO6g0
         nu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nunWiHg2dFN1fqt4IFvfXpcCjDFnYOA05LuzgwUpyW0=;
        fh=Z3CCosVd4sDZb32LVg0WeJBc97tT2N78jkAGs3iZyx8=;
        b=LkjQiuZrwV1/9+GN4GYrp4a18Ma+6vaJrUv+N41y3YI4OlovVOLxFvfFHMUDHP20Y2
         TbwKOpmbHHbC4fCS8WIYTsPDhKy+KpjR6tZEJ6X+zRolBAKKQHgxR+r9EBmhnSGRp8Pq
         iAMLAiIp83EAhy5gnOOASp+Cst+iDnbbND9eeY2anII1tkDqqZwvToIkf52fLMDLydk8
         +vd0tnuExXydWWb9tcBBGWihGKtb+WxaX8xQ7jiU21I74ptZuAhS6QwIxcCYoZhcUPNo
         o9upnMG3qoI2Tj31XX4GBM8f5sbP8P0/8LDrjtvwtOU9PY4f3XrdDr8KG6aAD1QtBjsx
         eB1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597006; x=1791201806; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nunWiHg2dFN1fqt4IFvfXpcCjDFnYOA05LuzgwUpyW0=;
        b=JivNtyPnb3naMosk9FimLd7/wnCCVv13A/CRG+wcOC6jLE/KHJqqjscnKUAOsRvMOM
         wb2Ye1acvxVZYiDgDHvrM4Bqg2X5XdRQKWninT5xbjmxQXSt4f81p3qoZ/saWxVcrJ+C
         u6Q5KX7soFFij1ij8tSjqz84tQs6m0GuRJxjKcTrtQAsLg7je6EC04ppfipHqvGk61jm
         7Lvgeqdc/7SYxgnVcPdYDitC59b4YPlFlWvADaDm9FOUkmX05ap2EabdbafNqAHHCLXE
         RRXF0XCj5Mtg2vDEf/imS6hGboI+qPcIvF27uk9RXAJslEPEnHlVpcYmoBBBGoMz18Gb
         wmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597006; x=1791201806;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nunWiHg2dFN1fqt4IFvfXpcCjDFnYOA05LuzgwUpyW0=;
        b=PHltOryRxt19eWZLNQLX+aK0S3TVesUIxM24uqIb3b2kW8zrdhFJJ7qSSmswFNEReF
         wMZ53yJHQEN7nrgZD2rSa2LO+IzR3B0C934LhWoVRrn7HokEuuAT344JeTTZ+ebY7Lkm
         T5IbeV44MQWPWJwwXhxWJM64VSVNzJ+pE91TgrOrxIMamCG8sNznlVYT7tnB0rCqMT2K
         gx+k/I5PUMdzOpotlpUqGAH6Ip/kD4A6G8Fn9TfmvJviDd4ySjiAhLY6bJgZImjqmXAp
         4aK28xRx5qfyq75oUERwA9daGUBsrkFzo/po12gpW+h6AsuKmuFgK6n57LcpzwsNVhgX
         oyoA==
X-Gm-Message-State: AFq9FYLhhbjQ8EHr3i1+TtHIY2n/x0LHLJxBmwVtDmgVRswEOMszig04
	t6VdLG6I6TLvKCHx5ij+mgAW9zr/YQ9KICnEXFifNxs7T3pDWZ36KQpVlKM6bAMrL9OBxnVsMzz
	OyZrExbkovhpAlhA+pfI53W/T87K6gN8=
X-Gm-Gg: AYBFou15ArPrqdnYfhDjsuFwCpMZ1iu5BoCoq9YCzAV0IGYZV4/sXEKHbriK4UeCygk
	WUSmgoh4FHTybvdkAOGTB+l8YRZ00JoUiBq7Y32BMEbblfXfnLkm7ICLXOdJBWlzRmb0tHY/nKv
	HD3QF/veWWneXmud4fIvS73d3kQI7dmb7ItVOkhf54ug84vot1eFvfmtZmeVfY3oOIamv4yevLv
	ueDNKTX46i9MO+yFyE84k97DeAAWXMkTOmLuwxxsAjBLQXdgDtCKT5JEtffStPMKKpXq8gZhUUa
	/G5FmnLt0sZSxnEdBlIbzG7cxBeC6+6ZZxlRFMXn6+ice0CnaGErDBDe+Mj+Guj6PNiBnJofe4b
	KTJ7dgof6/9twHFkvQ+KDRzyrXGWhijksRon8BnVwF5VpntUmieYV9p8ku6j30dIm2xPXWBeq6p
	XrFQ2PK0M=
X-Received: by 2002:a17:903:22d0:b0:2e1:3042:2edd with SMTP id
 d9443c01a7336-2e130422f59mr27028815ad.67.1790597005862; Mon, 28 Sep 2026
 05:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
 <fde7fb7988b695707c6f2776adc18eec7fe4696a.1790425008.git.ben.knoble@gmail.com>
 <xmqqmrt1pvd1.fsf@gitster.g>
In-Reply-To: <xmqqmrt1pvd1.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 28 Sep 2026 08:03:12 -0400
X-Gm-Features: AclHuK_zn5AVJiy1seRiiX_Ffp3ZVhv7_f96WXt_3235yHlip8YbnMIK0tF6LYk
Message-ID: <CALnO6CCL6-7Ze0az68NRs2PAr+VJJ=ihU0s+C+DK-bsMB+XGww@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] builtin/stash: merge index in-core
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, Elijah Newren <newren@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Victoria Dye <vdye@github.com>, Adam Johnson <me@adamj.eu>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > +                     merge_incore_nonrecursive(&o, merge_base, head, m=
erge,
> > +                                               &result);
> > +
> > +                     oidcpy(&index_tree, &result.tree->object.oid);
>
> This is risky, isn't it?
>
> If there were catastrophic failure (e.g., missing object that were
> involved in the merge), merge_incore_nonrecursive() may stuff -1 to
> result.clean and return without populating result.tree, and when
> that happens, result.tree->object.oid would be dereferencing NULL.

Indeed=E2=80=A6 unfortunate. Thanks for spotting.

--=20
D. Ben Knoble
