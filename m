Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793129080;
	b=Ma0tWFye2aBUqrPc/aOnV1YCgeR9Repy6VtOHQTACQwBGxMqmEzpywr6tiG5XwTEfLto
	 ZJw48nORymbOo2mmSgs2dOGgS2NJfa1Z6kxIecn5SKqil9f7qTwqj6CcLS3OTS5pYtXR3
	 W46WdfUFRX3qanjZZHMZf0/A4qK2suxdoa+p/yNQfEzsFeHJZ8YMtLp8hnDv04a7DO8Kk
	 G2Id4nzYimyNsLjW473xDN7i6d5wTYWi3Pjoy22TbfG9bxg/G2o4mXq2pL1L4W0hzOzl4
	 qwkS6RgF/ndFRnay0Y5qWnhWuULhqZlThYc4HCyDJk/FNw6Dy7xDPTYSmCIy/S4niPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sOsvs8ECDZF9ovW8/USOVFjMJNxzk4FS3pPpn6msIvM=;
	b=a8Otc2mQ4+j4pL1J+XAsudojieLmR6olK+zEBO4qfS19r3hJAHsJAZT0wi7ibEkGkYBM
	 BxNnyvuuU5F3JeZCM65TqYZl8fBnkfDLFtgFMUlqHS8/dwCtj2zMrSUA8NNS9lvPD7cG8
	 STB6Jt4DAQEPlj8SDLzAgEv7Nj6og3+PkSDYUeryRVgSAGPbhhA1TAySQWwtxA9Il8H3G
	 4hOiWPBN+pIcdGtIMxO9HWp1GgWonndbfqgLQFZsesLG/3ox641EMzusNfISE7y2c9Zhl
	 BKGgCS+dvYB9zk7iYpwBofcIu5gO6MMB0kQQyzXSKRooA3ZhLnNPCfM3EvorcRLCUpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jq950eDA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D5606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA5D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jq950eDA
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e946155442so1148415ad.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793129079; cv=none;
        d=google.com; s=arc-20260327;
        b=XlJh827VY44KwlrP4mw2mZPBbfyuAwWuLs22bynKjSG6+32S93wQQgOzAzmZHd4hEM
         K7izQkoLwl3pgjvEZa8Nt8NUkSKtthsSM79MWqri94KW9TwiI3Tj7AmmWo1TiL/YZ3F9
         dMETxVSxJFluk+lVFE1FC7Mo+yzKoMFS/IPfPQLRw8fUW8yrzCWNV3MYxduSVoyLR/6j
         TQA6fxtocsQmjXn1AWW5tR7FbctW9NOgUYpQ5BKESPhWuf86sqZMLkBRHOQfgIZLgGOs
         JhMulvh0dU1fHan9mj5q2yXLSqY2Xxe7uHCCTBCNPhLhWrXOVZQUCRYeQv76090XwIC2
         ue+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sOsvs8ECDZF9ovW8/USOVFjMJNxzk4FS3pPpn6msIvM=;
        fh=NMTStYaZCmhqu/MFezBFdPpecEgJl5LIcCGd7W7enWM=;
        b=On5y1XD0i3J2TzMUwLHSLv0xDpMaQe3SzrkHNv+4fcB8yH3E37KOUcTThLZcqN3yZR
         uouuxMLo8jZnko9269/z36uMrx8/PQ4F4rizqnrEQBABICr5FfMWIUYJYX4n7hEYQq80
         hQgYRxA65ztUtK/cW8IV2EdZAYs1f7GCYKPs46dwbTVin7Nia0mZ5Om9mkbp9q/NpUtW
         tklsYXEOdv124CV8L53US2G7gYM+RwT7m6iCejhVWH6aX3RoSdrvPFM9e+8X3/7eBZoE
         rP2OsuuWdg38oHfqStmB/z/yJ21/4H3+f8dvsU5wHwF214svYeF807Co9wEn8tjE/yfF
         Ihuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793129079; x=1793733879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sOsvs8ECDZF9ovW8/USOVFjMJNxzk4FS3pPpn6msIvM=;
        b=jq950eDA8D+ZzcMUXCSXiFArOV5eEnCInd4/K/wnWyCWGiWg1iCFkE5f8wG+xcLgcI
         OOjDE19n2PfBMIX/tynWVQtz3G5wuWq4nY9HMg7NiwLkr8s8TZGXg7Du8ZTxp9Ga3rZr
         qd9/d4BE/9p0w/3W4nsnctVTM+12aXxzud5kRIRnyUYmHEslwh48BqHh1SG7v/UpcvgW
         VpvQrqMfTca8hl5HmUAwyh8jKWFUx6i9MeFGRl/N3TPuTg40IfBEcIPQ6UrTydi0QkUS
         O0dbdlAa2d49l0iVA20ACrLlKIg+ru67Q8M+vByf44jAfgALM60gT0F+jyqh6xC0nv0J
         YOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129079; x=1793733879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sOsvs8ECDZF9ovW8/USOVFjMJNxzk4FS3pPpn6msIvM=;
        b=NfHIAaphWftk2PbDc0z1vJI87hpf1f+19odoqgrlCgsnPir+S/0tYw43NWYkzylpbB
         keKxHypfppmFWW0SD1JDyAK8FgxOtemVMhniqpdS5mUe5lgpC/9eG2pYfHiVX8+tSGil
         H3N9yn0rfFCMG6SSYBhe9ihP4MJb1rGkCsTuiZm43Lq8JHqiWLbl5ULDHYdSw/Z/fQDu
         ulZn3EATChi08sGBxaPfPGGEsC/icgHODBipaLNTtOGgm0ESjS7dXR/4xu/bROe08Oe5
         YyHyrQyQPTaeMKKooI8XIY/3kA6YA2+pEkIEX1uKraDnVrcBpX5dwvOn7758rn99llv/
         0HWA==
X-Forwarded-Encrypted: i=1; AKwUvBzChRjR6CwKD8jiIalfcXdfbELFrl82g5xgRW2gbT+dJvjbwanNsnTzQdWcUv0Nax+cvT4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLI0A7hf5u16oYIqzFnNQaiIn5yRvlZnEV7cXITVvklvLlOjkh8
	zNIOgOlb69daIDd1oVvEyHsWqTbzY1tWjBv1N1RX2k9VKff0d2EggYHW45FxS7GXDili3Lfz2By
	s0TrJZk7rAURqXElwh8TXrLnHmXCecbg=
X-Gm-Gg: AYBFou3Rf74OZzIiZ0+uFhFjVNILurZXOmaLa3Pq6BelJbZKcsRzJ8Y4+/cc7pQ11S0
	XLHs/D6TXGBtTzfeZ9s1pVAllXrlX+iq/QaMVjbgS2fuxkrnFznAxMeTEpSnIdszql3mNqoaRo8
	uuCZBdItt9JUibdfzHZJ7nluE0bsYo/n4Si/lvIxfdroZp6q7nWnn9WNCfWg9KDSrObu7PzlDHt
	k1VQrAPDStDnRRrSEeI04zCjtxp1rkgdsBpz3UQrGOZCIFe4zU8RETBYkx7b7F+MpcFy0BsBANd
	Le3mtmsvu2j5xF/qccMEwEkl6uMtQ/F2mRRCgBeaKUUGdUCzz8RT6SYCl3RMy/84/H0qR8/Koq5
	4S4U65Hgc0Yd3h624kYNn9HmPZcvrRJw0dY/KIHcq0oZACbm3L37eUfxqUR3BLDCyQoR7MT1Zm4
	jtq/u+WBP1/8vQl0E8RJjxi2g7/pLXWDG9Tfg+1V5gMkNwlG4ksD7mTygVNE87tiBkHbSLoNkQL
	NeKtTlpTWOS60Bk
X-Received: by 2002:a17:902:f691:b0:2e9:5eee:e071 with SMTP id
 d9443c01a7336-2eb00587616mr2975925ad.57.1793129079008; Tue, 27 Oct 2026
 12:24:39 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
 <E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com> <xmqqh5i7kpc0.fsf@gitster.g>
 <CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com> <xmqqh5i7j6km.fsf@gitster.g>
In-Reply-To: <xmqqh5i7j6km.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 27 Oct 2026 15:24:23 -0400
X-Gm-Features: AclHuK_am4V8GhB2IFFmXHCAd3cPTRX-vCqjm7n2vFOk19Hgzty9961epPU9HVQ
Message-ID: <CALnO6CDMjtNVuvYNdnaKMSDQ0gxEXXo_r=133TeMNUCBZe1ikw@mail.gmail.com>
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:18=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > I can't speak for Julia, but I read her attempt here to clarify things
> > in line with the ways folks usually use "ID" vs. "name." Of course we
> > don't always want to let what other people say dictate our
> > terminology, but in cases where we can make things easier for folks to
> > understand by using vocabulary in line with their expectations rather
> > than subverting it, I think that's a worthy goal.
>
> That goes both ways.  You can tell that to those who are subverting
> terminology that have clearly been documented for the past 20 years
> in our official glossary ;-).

Fair enough :)

> > I still find it strange to call "main" an object ID ;) even if our
> > current terminology says that's fine. Heck, the glossary says a name
> > is a "unique" identifier=E2=80=A6 so there ought not to be more than on=
e way
> > to spell it, even if there are many notations to refer to it? Alas=E2=
=80=A6
>
> I do not think it is OK.  "main" is *NOT* an object ID or object
> name.  "main" can be used where an object name or object identifier
> is called for to uniquely specify an object.

Ah=E2=80=A6 so in that case I think we may be saying some of the same thing=
s?
Interesting.

--=20
D. Ben Knoble
