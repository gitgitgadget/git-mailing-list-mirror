Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843AF324B2C
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361917; cv=pass; b=mYMCCQoVpw+vKKguYQaaQ+E/hRPgeQaVatSyeUZBPFcFIR2GIZysn3qrkkSg3Nl5sTN2Oc7KGhgM7kK5BsYZzWxnBcGPPoJIqH96sqiDQwrVqBF+6ADyXpjtdfwO/wxR8YeMIpweW73mPwrOwDHHmkW53O7PhGtyG/HcadBjtgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361917; c=relaxed/simple;
	bh=Ud4Z1v56s5qScUXm3BNAcVbLwdnD+EXPSJyy5Fu0/eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fviik6f/jC5DvkYYLWZ11XaNYfaSFaM4wHVc9nmWNVdHy3dOHH/u3ucci6UcYSmJ64YqxOEhU0d3J4zUFqqWcir5rTBXlfZDL/q9aEzxfoDAf28cjHPwa0x+eeRu/JRjKJ/Ujb9J69ffWLzyTcTLbBZlWWrJ1hskebj4zzkqqF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHqSuN2j; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHqSuN2j"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c8dbf4f38so48310161fa.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 01:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784361913; cv=none;
        d=google.com; s=arc-20260327;
        b=nbuW7A8/rVueRIo1WlyAQUFJbS4oFUc4NeKRjg5S8U9kQvPtQUnQwpavBG2U83XgGI
         qJjFpHVLBv1CMZud/K3iDb403Nrc4c7UliqYZb6J2YC+k0Z//D/UEkwl4GIbat2i79Xt
         K0TpBNFnhK3IPQOZxrVCngsUsv2Q9Iukbfqcz5NBP7T1/xkA+56mkhnd0brX81cNUtWd
         rHOPz3DjfsQh9Q9TbgCcuxmNV33gflzFGY3tqLeW1RyuszGGxCYPEbL3dnijzrYgDkbt
         xBgQDeR8T/SkyElUB65gWd7krTo4UQ31jhsAQznnBC0KZIW4ImH5ahMkhr7UWC9NKW+Q
         VayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lYGN+MFH2Ye/9qeWdZn154Wezb8ao5aYMkXOCCgvu7M=;
        fh=v8NFtVHnyC+/bq+jTyZ7/j2AzjHcFHpenvAYXyxs31I=;
        b=BtRArv/jSWd413YAj6XZBr9ITqcLrC7XNG9PGiyCwAYIDWv4J2ICezkHr+u9L+XYUr
         CdXIH/7jkrCGgru8H11iEgawx8ayrM0TiR+QmyeosFAU/ngLGBewjtsYmap43Fq+KfzQ
         NFeXuhuhmFydY8eR4qDRyk0cIDDcBevv7ZfczNJpzlV/khDyTuyh2vcAatI/pKdehKvA
         ysYDU/GWTRyzOyFMSrhkbtGREqd8cyxcXvn2ez26plbrjblcEDlmdg7XK6ErWthimd6J
         EvJcXwW9fD93Jn6VRchrqP10OOcat/wPPyZ8Pojz7KvBnqnVhQFCaPly761VCpMVkXKR
         7sAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784361913; x=1784966713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lYGN+MFH2Ye/9qeWdZn154Wezb8ao5aYMkXOCCgvu7M=;
        b=IHqSuN2jkKmqosEzxQgZamI/39H7v+wT2vwtGhM58XgqHzoyeaxPoGLIv/sb6geaiX
         qXI0zbyvx6mtBO9bk7ZHc5eu9vOK54fsgE1pf+GzyxNBHje4TrFZ34aetSmaWrdJ+Mmo
         S1WG+u3Cb0CXajz+oUUCqUnk+J7Jlrm8tiggQvaGpT5OFPK1wAy3IGYu6WGdEK6LEND2
         MdYmKq7r2GnrNUfTSll1jkTnzx8aFX/YGClMnJFWv1zuOeweX2RCTewNGI0U0K2n6jfJ
         g8XScGSec7g0cEuzCRYXfWiNiBFQRbasNtC0dbCtdZZ2NAZpa/UdZR15c0CSeZUH+oZa
         UKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784361913; x=1784966713;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lYGN+MFH2Ye/9qeWdZn154Wezb8ao5aYMkXOCCgvu7M=;
        b=rVXnJDFfD0gTeMvShjDH6u+xTDAAsFUaWcQK5cWCjWdGF8oARwLXBVxWW5R2vMnxX3
         mAHNeezpbiuIuk/kmfmx5dtCwCn22K9mcK4P/K7CS+2Z5V0ayni+k46pU8MIi2EwWCHG
         vQ4VrVBYDPo0egGheLCqGhLCbqP+Yynsnilu8lqApH0veVPoA7+gpDLP/CtT2RZSuzPn
         PD9a2zPj7bd3S8MEQpYkdX2Oi9+fMFmqIRXnSzEz6Wv74E/tedh5tfq54SDlfikpv3/b
         1SR2fIYz2KkVzSNQyj5IIpaSWSxyDBFAmHBkNsUyTooe5sxgKdbHkfLQFcIfBiIr0QI7
         VAhQ==
X-Gm-Message-State: AOJu0Yy1+3bkToHZGF9i/sUab1zxQU9hPF9YEqECLVkuXvzKnv1sn2tn
	GFoaBlNLTKn/wALjpGJEg/tjbLrmPG6qICuV7/ALsLI9YjnhZGYLm9Bnh9y8BUZnLqGYvVLQ3Qz
	FOiTJQUAq2/VmEiLug6YBxEswV9hk8Gw=
X-Gm-Gg: AfdE7cmc3DsS57Di2zabHTjKARKCZD5SDIOcNYa5n+HYLQ5NdQcWWigyeTGI/ojxu3Q
	9oG3RMJ8iJWH/vqptsf5b+OZnMcsRO14hFScRF3irHc67Kdv9b6Ps1LZf+wOBVZCXL4BneGY5uI
	g3HaY8TQaKRE+76oYjxL9ji2u1yjPnupXWa9+YxNUCHs+djL86VZTpCNK6H+SxLlfTfHaxWme50
	OK7s2A8/hZ9/63HzSVlDeGDHJ7dtPEcb8ieYCx5RsaZy76RI1ck0xT02Nj95rhv+x+t0z00OVmF
	OsT4UTejl8I57SEB85RL
X-Received: by 2002:a05:651c:c90:b0:39a:d7f7:9818 with SMTP id
 38308e7fff4ca-39eb286e341mr13688281fa.28.1784361912879; Sat, 18 Jul 2026
 01:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716185045.229320-1-sahityajb@gmail.com> <20260717144620.259031-1-sahityajb@gmail.com>
 <20260718073135.GA22588@coredump.intra.peff.net>
In-Reply-To: <20260718073135.GA22588@coredump.intra.peff.net>
From: Sahitya Chandra <sahityajb@gmail.com>
Date: Sat, 18 Jul 2026 13:35:01 +0530
X-Gm-Features: AUfX_mzR5n0m6fiYx8KL2zCTAbAoVBWY7Ol5m9pHaX61fzqVOr01L25w6xSi4xo
Message-ID: <CAP=WS+tZuQyodN1_0Z4D7-uD9dpi9CKp8_sWvVTXqM6hWcwx6A@mail.gmail.com>
Subject: Re: [PATCH v2] wt-status: avoid repeated insertion for untracked paths
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com, stolee@gmail.com, 
	ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 1:01=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> The patch looks good, and I think this explanation is OK-ish. But IMHO
> it is still worth talking about the quadratic issue, because that's
> really the motivation here (and what the "harder to reason about" is
> getting at).
>
> So maybe something like:
>
>   wt_status_collect_untracked() copies entries from dir.entries and
>   dir.ignored into string_lists using string_list_insert(). At first
>   glance this seems to be quadratic, because we may shift the backing
>   array, incurring O(n) work for each insert.
>
>   In practice, though, the entries in the dir struct are already sorted,
>   so each we never have to shift the array (and only pay the log-n
>   lookup cost for each insertion). But this is subtle and depends on the
>   behavior of fill_directory().
>
>   Collect the entries[...etc...]
>
> ?

Thanks, that wording makes sense. I will use that structure in v3, and
submit it right away :)
