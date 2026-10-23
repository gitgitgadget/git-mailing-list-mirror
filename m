Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792770867;
	b=HVqC+50NUaZyc4LpLmlYaEEwGDpp5/gv0/3E97gJh5JIaaaS5EoduGOS380YQnkh6Brv
	 pHsuxLz9JayNjgEc4bzPjAdXBYoa8RZmTc2r41If+HnrEl5wkUbwu6/R1v3HXhunA7+En
	 lw6MkyXzb4wYLz2fIBW5FcrMlMg1239FsGjS42QmRksoio9WOgT/XZUdWnYcC8mcP1MDE
	 E+vtad8m9X+Jz+BkFftracdNv1LQCHzA+CipCPo5FrCIGQaoKAY4A1p6VIDeZgIFp/bZv
	 fIKoPRuUZcrgwhm0CxsbAC3nFXSBqu1vZGMUABOTNc1o0Qll2rIKIAJKynIq0E7ifLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=7TKNjFidEyR/8s04TLEVl7iGb9HScGfoL/WA9FICl+k=;
	b=X+SFsQT1eaFlk7b0YRt3Yo9c3g20eJAi1Jb1+4aldA7BbomRx9IOj1trOEiZVkRFm2rn
	 vy1xQqqNQJzaGwteMXfZKLJA36trmJtT2NaCJCFkE31LP3P8HKofZMuX4vYmNdWv4Yun5
	 FOe+D9JYcXJ1dmzI8Ys/8X2aWn5gnyZsGty60Taru4YeRACPZ801k0kBam4UhIvmT9m/w
	 RAbZa16QTP6tS94LOonwBteR3zKirC8lS6ko5UmSIUyzuJZ0bqk9iu+PXCy+yqA8dI9Ja
	 +jMzMN7EpWdAmwWVoy/9OlevNIhY7JmmWV5y0/61RZKYT4E2+PvKehTRyT4TxiThVKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OlWS63ke;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32342606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32342606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OlWS63ke
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso1437742a12.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792770865; cv=none;
        d=google.com; s=arc-20260327;
        b=D3oa6Y6xvSNcJfCwDC2CAvN9fnvxwKiouaWcrZN2OE9IpKyncIlIuEvRSqwk7VXlYq
         whaCBXuSvz6XaRQBmjZWtCATsBJDTE8GhcMq1HuPlBX1kfLUzQgX/5SaAzX7dpB8WdZv
         VaSR2uc4PZasIzQZuCPTxiFFUMhrwJEFimSE46Xk2ppa++nbFeF0JXWH8j/d764C8xKC
         dIp/RiJ+7cTC3GpPzQl3eFB5ckzzOhm5/aUIWT5+SuWxLTimCK8azwpOsUQgtJHAz0TL
         EJk/iVhuo2jtig8/A27lft4lASPOPPFd4yr8oT62lTQ+lFzcg1tHxk+ngNYDwwx3FA0s
         1ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7TKNjFidEyR/8s04TLEVl7iGb9HScGfoL/WA9FICl+k=;
        fh=n7F9EqUfkoAsJ8ANt/Z/UpBLyhGPgbSe7AnwH6Rpm/g=;
        b=mWaTJL5gj4Q6NYrCNPXv1dVAxvsI13afLhtrL5tOnJj5iGJErwV5cfjPXqHxBELVHx
         0M+NYYpaHjidzwGrHfNbxTrB2kj/obGc3t80Qgwxbh+Orf6VnYeYNjFLRVsmDjW/f7km
         cn6sEACHOAzV03G2/r3j4SfuyMI9Pn5Vzj5MT2vAUGEw2v/Y9PZSboIa6w1nevK0xgM8
         /nbiuUwbYmcc5lwOrWKRgdQ84Dmf8ce/8CixQ9HukGYfxAQ+ROUGQmYMLp0ObQepevQR
         mB3UDZ/ma7r4z4krLXQZR+oVrIel1j+UIxTh7VW2QDVxOkG7JXsICFEZ/eeR1LERz52r
         I86g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792770865; x=1793375665; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7TKNjFidEyR/8s04TLEVl7iGb9HScGfoL/WA9FICl+k=;
        b=OlWS63kefRZ9twaPMUuAUGdfJ+E+FCSTBOaa9XxYz5mUrVXg2UGO9L+6H/ano8icE1
         29lL198jD+N4B+4JwizziPZiUJWiSc2IFXBqQUUkHW/VE01LkWPzR4kMKo4jwjHYji6U
         QFJLR2rsxo8M44kogvQTyqlWqrkvQYvrc1pWDXFyoU+RGVOCkeOiv1lsdCC6rDSy4VOH
         qDft7SvHhUzeEjhNTW/TQiAx8/Dj8Xw7m1V4RDvnQul8qHgdZQlgbhB/JLLijMha9ooJ
         p3ylSCG+oVlQltcVKsKyINX2EAIM8Dm3wqtZPUi9/FPM5fJBJY/xWVEKyPYul+gzkta0
         yiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770865; x=1793375665;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TKNjFidEyR/8s04TLEVl7iGb9HScGfoL/WA9FICl+k=;
        b=GYdWdHtRfbFIiTNvbl9Xo3o9prxkPAem7OIBXCCmw+RsnjwCuZAIgpfwFCMCtfKqXJ
         DU7b0HqKMUVE+dzn6Eq4t9gB+8hxHbczi+A9n8hxwemvr0byFSaV0l38vdawta1N9SfH
         OdrrPgLr9/TKGd7hSN2CRpq3R4FtBl4JYBdpVQ+raEHZ4Nl+gUrrutEQUjU5LZn8j0tx
         jEpeyAznRjxhdxaL694H6jCXZjhAZtDv2ajeBRGEygT/A5qycWAVeeyhXAYsbyHgoV9Q
         Q0dMHkwHF/kJlisdIoIPHIhqnebJuJuwdAG4A3Z2FAHb3bYLtqgD3KtJcFFOd+08JK6/
         GPkg==
X-Gm-Message-State: AFq9FYJf7gtdRRMWljv75Ir6Ky4XGdvh0yvb97z+o6VWE+PsX2X3eYDB
	I26w1plq01NV4H+RtK66Pri3AIe6PW4PLWzvvwN0aFCzCSUGhLCNsC7qUO+Nq/ILNTjYPhkLaJq
	HaCStAoL47GtaGpSMMyKxSeiBTU9FWX2dhIXF
X-Gm-Gg: AYBFou0Vu3fdPvq07uQ9jyYLX2RZZhI4swmXNz5hJtieDHfh2kvdW3f85EhYVu2mXFv
	Ogn7hZK1YBg7KMbQuiJUcXIri9wH00/cwRfcuZZ2CAKA42Ht1e9PoSdb667CyQ66Ki1AIqQBIpC
	M7vSQDaSh05j3yZUX+X9PRNl1q5CsBu4WaxUTa0f51uj0/aQAp6YTeNW3/470dehS08MchKDj0M
	vckhNF6J9N9HEGpL+NDzURE8FnHofB+J5PLqDzwHQRb4FEMT7lHp9EAJCVaudBC4zYRc4Eztl8H
	+MtkAby/MjX490Ig9pAVAM2HflD49CMWltLUs5E1JT4MwTruQQ/KOYRMQP39J1unyQtP6xkiYvr
	PlO4IO4sqNqdHxaN9dRZBLKlHqbOvntZazfotpyI9ZtXzsVE7qu30WV1PtA==
X-Received: by 2002:a05:6402:2022:b0:6b3:cbe9:7231 with SMTP id
 4fb4d7f45d1cf-6b432b14e35mr3097841a12.5.1792770865383; Fri, 23 Oct 2026
 08:54:25 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CACWAS-X4BqnMa8iJKTakF5E=zYkkyr=qsQ-=c3bxoAJ+Kpcfiw@mail.gmail.com>
In-Reply-To: <CACWAS-X4BqnMa8iJKTakF5E=zYkkyr=qsQ-=c3bxoAJ+Kpcfiw@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 23 Oct 2026 17:53:48 +0200
X-Gm-Features: AclHuK8P08VOOd5GmJqqfs2sMo2uLlI4Hcp9udLHXs4hD9uzH064mxXB1S1rlzU
Message-ID: <CAHwyqnXEC7cFijGWATqfA+fBcn09UoNPBDA17GYEY4P8mS0fWA@mail.gmail.com>
Subject: Re: [Outreachy] Question about check-ref-format test coverage
To: Fien Dora <fiendora5@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> i tried running
>
> ./git check-ref-format --allow-onelevel foo
>
> ./git check-ref-format --allow-onelevel --no-allow-onelevel foo
>
>
> it returned with an exit code of 0 and 1 respectively.

`--allow-onelevel=C2=B4 and =C2=B4--no-allow-onelevel=C2=B4 are contradicto=
ry
options, and shouldn't be run together, so that's likely why it failed
with exit code 1.

This is true for any `--xyz=C2=B4 and =C2=B4--no-xyz=C2=B4 options.


Harald
