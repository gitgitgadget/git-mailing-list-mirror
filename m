Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E23CF05E
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680116; cv=pass; b=eJmSXw1q9ZhrSsMSMJLoB74wGl7R9KRR6ThF3f27dzJ75Fh8XMJEEt+/tEFqKsweWxAgN1F8jLlewn/yMnPqFcZFtuDypJaqpnPKWUfpVzIiQJAeLOEP5tote7bjbRvhxZq8/SYlA1UPxU2Z7Xhabp7FBsqbIKyitqSlGlwm6O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680116; c=relaxed/simple;
	bh=zkbUWNqudiJsm2rNUngzb+gsBd+UEzzTaGTcScqR86Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0oL5ByubTdVRTdyFWNQrOfYKh+LrhdWtzuNGoFB2EBM321cpZlSe2Z8vB4pT9KomOR+HTL8BNoBHjILKuJhY7Rc7AP61I212SuxQT/xBJQO/2kelicZCH9LccoJcd+V+EXPx8BhrXD/9xWtPaMV2a9JyWK+KumN7xWHsMAGsMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlDhPYz9; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlDhPYz9"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1869548a91.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 04:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790680114; cv=none;
        d=google.com; s=arc-20260327;
        b=Drca0YT4ujAvI2coPY0ukkt51Yc7q9ckO8EQOs2zg9WHHgqE+mS6S6jw4y+BPiWl/M
         lYwJkcTHiWRLSk0RTin4ZOgUDCE5BpeGcbAj+HOtxd4WcBwAgc0L69yBUkGxkHK4xWtP
         cFx1busNClP2Gh01jg6NuOHIFHeYZSadUX8TLunEUBVPq1NBPocADPpsynuqurjN+Cz0
         TWFXTE5JJxdPnXzJ7lCYmml1brbEXQC33Cp29828XVnrNjKeC9GAPDAnVg8MZo/GfBKy
         qgCv+zuDbH7NHYvKEouJHik+RyIIAfeYquTQPR6KibHaO1wrA2zzvLqFul6ZEQsrE8uu
         UWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zkbUWNqudiJsm2rNUngzb+gsBd+UEzzTaGTcScqR86Y=;
        fh=f+h1iMKJi1P64nc1JtGvSKrsrHCTiXkebaRVSaX9X1E=;
        b=m9osTsn4kIk4HtaH7nnSXlK92g15hp121sBNkomVcdkJqtRTNHTUzbnf0CinwdjAZ1
         hNfr4/27g5jcnjfMccbeptkZ8+gBpd6cvNFXHYzGzn26NgUXk9R/2qO8l8nViF2JmOZ8
         a4qmDPKoMVn324aB2UtDWKNVQbu1jdu0cEMhj9CzgEnjmVPdLo3Fb3gXoYD0k6nZctoU
         yFB+9C7J3Eup3akFJnccndi/ZIudtfB5t6uOivA3Pt3nLxfCWrwPr/SkrFbZNqJuNUdP
         jSlohtEm0YZXaam8NK5jo2dB65QbQvGt/AONxYLUHsVMsxk4Ex5VQbcky7+1VOr8tQGj
         Pncw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790680114; x=1791284914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zkbUWNqudiJsm2rNUngzb+gsBd+UEzzTaGTcScqR86Y=;
        b=YlDhPYz9nPYoAQfsT1LrybS8BO0uaT1zx/ad9S2HiZYx+Nc2Nza6dFWgdhm/Rezfzi
         g3qZt/odV2RMyIexA1+seH8vsOuzV7lKBuUBFb5vk/iAYrq41393ye+KWe/VzQanCs1F
         OOct+bQGNh4dQBByrdat5E/hiISuuR+DVqqKaJGpR07StQssAFz/YJ/JJEp6JnDdpsRe
         nAYyZ7OLVtuR5ePuRhDPaHHrjVGqe/Zlc0V4g1SVnwXbLrSfZb05c+jY8NETVBwEzxZx
         z+l5H5yKk9n98hy9j1r0YxRat07FYQMVD3TpFX/87ZzKQ9RwC03M7grCBlgRVoxZ1Pnm
         z1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790680114; x=1791284914;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zkbUWNqudiJsm2rNUngzb+gsBd+UEzzTaGTcScqR86Y=;
        b=j3K/RFZn3NP1HL0eC+uExiu0ipgCAxVRy45qlslCTusI993DIBBJTtk5FX2Zo++YG/
         4hPXdyg5tI6Ewfwzu067RLRnC1pI/qPNbu03oCWW/zmjnbc3mFRw0NzDHENs3i9I/G0+
         kL9a8Cmwztxf5lyshII/+GWh0djhmPadIdfOa4NOkKSAfPRgq8r11wvI5Lm1T7i7sPvZ
         RQfIPoumxAVRcOgn/VFpH1GCZu7jtSEekSkM8AHsN54hzI4/GLA9IC1RaNek/G8fT5rR
         PMKh3ybqfNwr9ZmSh+5bss+UZDSJ7C19zJ3ABt7ZGhV0ovNKqfX6KxomcnDm0GVZ0Abi
         8aCg==
X-Gm-Message-State: AFq9FYI6qvQKTEJEqLa3po+PXzAxl1Mlo0MEzRuMEungW3L0udcakHaL
	K+C0aYDEzh4Z1OAS6I0vKL1KsyR1RawoUki74yvwBZzbfSZOe1dr58UHwH3DFQldXAtfNCVaxSc
	SgOxyCt5Bo96LmlsUyw6E+NhwBsWmKA9qoSgR
X-Gm-Gg: AYBFou1UPdvzjczIu48mX+g1meRLd0QnqxdAT7MJNjZZr4cLE1575LU3t/b2RG+7Wjd
	4pFYeJbSvXiUGe0bX91KC8CettKr7drU3tZ+WS7HbbGgPdRWv/LdUTKgVR56YEBP2hqlZ2GSoOI
	BH0EJAezu+ZSSCEjb5zoE8/Altvoty9KzNPqUAJN8ua614UrEknKLo22GuRRcia44QTQcs45Dfb
	wnXHP9x2qwXrjOk6RRz4riNyvh7/IXVWFpSkOerjoDSA7Y2bl0HYcVvItKEiHp0+gcT5lcLt42w
	AAbfc/vXcasJrm5kGvcR1kw00SHJkeKtux+HLYefg4D9NDoz7MiUnDikiSvyzK3iW3Cd163PDEU
	xg4i1zE7EfdiJj4AFBXN1druM2+rvMC6A7nG5+G9WfBlixr14f45RAjfaxg/+5KfoNoGOtrDSDx
	c=
X-Received: by 2002:a17:90b:2812:b0:3a4:b50a:1106 with SMTP id
 98e67ed59e1d1-3a4b50a143dmr45977a91.63.1790680114046; Tue, 29 Sep 2026
 04:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929064935.GA1276867@coredump.intra.peff.net> <20260929065239.GB1697497@coredump.intra.peff.net>
In-Reply-To: <20260929065239.GB1697497@coredump.intra.peff.net>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 07:08:22 -0400
X-Gm-Features: AclHuK9ZAGxUipIsjCXMrxVCkrpPNApAjv6dAYq21ipk4agKuUgG7EMBl5L1bY4
Message-ID: <CALnO6CCW8K1bajbk3jqS54bP1=jyiYqnqZVRK66yO594ChoASQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] xdiff: replace mmbuffer_t with mmfile_t
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 2:57=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> Our import of xdiff has two identical buffer structures: mmfile_t and
> mmbuffer_t. In upstream xdiff these were actually different, but the
> import in 3443546f6e (Use a *real* built-in diff generator, 2006-03-24)
> simplified mmfile_t to a simple buffer.

[snip]

> I guess this step might be controversial, but I hope not. I think the
> ship has long sailed on trying to pull "upstream" changes from xdiff
> (there haven't been any, and we've hacked it up quite a bit already).

I think for a while Vim has also pulled in xdiff from Git (since our
copy is actively maintained), but I might have that wrong. I think
they decided to stop doing so after the Rust bits merged?

At any rate, I don't think that should be a strong (or even weak)
objection to consolidating our code. Thanks.
