Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794082958;
	b=pE8vwLBLWWJX1gVJlqcL9qnA0S7VWmbBpAO9nBanA5mTyQvu9qNK4T3gLR+BLA+Ik6Fn
	 /B914EIcWLmFSIUeAjYHVJEP7cjDgBqLePSZgrFDr59IwRM9wZakaozTZlZ9ZuT2/be0M
	 PP7HSPi3baxxoq7UUshftScq6p14/+2yXrSuk1efT6ErgEiXbSl5/PQzgFYh0YTCJPjtV
	 NTjTMmfpY4P4H5tjC6T1a5G+N1THzNfibluTSWnyNvt4PpXv6/NOEeIGPWFkdg+QkUU0S
	 +ieIIt1z9QzVMpnz3jY6CW1E79//SfrRE/KsT5Q/Q/+gUVvE5eo9HSo3cU/Wl80bunA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794082958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HkHa0MmbohcLnendMJPUcMjg7m0dtk8v4dWX0lgC68k=;
	b=jZ4Im0MNcUidWyrzjDqwWonkFP/HNS1ILXGOIpxDBg+WQTwC91XtLzk25CD0tMKQHJpY
	 +up1CBSg6NDwDKV6h6FrR/zGLD1x7XFLSfwhNRXNsoZYo6ze58XqfkOgxcKWdH7JJZ83+
	 j/DbiS99YZcsxgU/36fwhoCNvXK1E25FLMdwkiWkNWlGCd0cGXypb7/pQPMABPT4KHGkB
	 EiPNvd9IGIz9Z4fud1DYkQFnqipm6fncx/2xeqL63gUr9ikdCK8tPGIQKPIGkHC89oQLY
	 rS6NljouE+BIE9aqKTlXNGqi41rWZMn9Mbkiv2ZMxzmdOAOY4iLvqJXlbL0HTdVOw9A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ed034aLi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA7B606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 20:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA7B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ed034aLi
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-8446af403b5so1039939a34.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 12:22:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794082957; cv=none;
        d=google.com; s=arc-20260327;
        b=i4gLZCmG3HTL+0zm2gaV/aigvJYRNrNem5vtPjIocgJubO2eh01mJHJ7DXslb6tDD0
         UNCCYlYgI31MwK6RIOqi/+l7siYFfIJICyo6vtumq6PgDtCAwF0e81s0tMwYsYmpCjyn
         dzUcAxW2PEYpQs0KliKECcrYVmguPofFrGjDH1g2P3CBztGNgTxb5ebFEzirC3E3GYxv
         xIXpbBL5SPzMZUTUr6HM66++Bb2I0n8nN+4on/ch0n14GK9lylzdpfjl36IKNCcsPPve
         dAa41rpxLK+Cs84fJP5DzXTIJYbeFPpeo3mjT26bVRl14VL/V0w3RY4AnF9PcVZeeXSB
         Q8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HkHa0MmbohcLnendMJPUcMjg7m0dtk8v4dWX0lgC68k=;
        fh=cBAdvp+qb786Isyzx4xEvqJoewr0VYfO1h+dTkdSyGc=;
        b=DqDYROZkq13yZg06zptUSXc7Yb8AZ8U68ZNZOVT9EPqL0SvBB5h21mGD0vMyDmImEN
         SdGOxSHKMxV5AYdmNJwKJj1iRoq269IoeQ25QqOrcqP9GLeOMza9Pik59zdXt32k0OoI
         1jtwb1n5xM2RQYLBfN6h3RHXyd9pb61pUFDQPFVrhR0GDuZU7cEEy4HNsT1us6jq4w40
         1QGgc8StFsvKnjxVH0PkRiQLHUt/oPDFePsUQ5ZPUPQS7JII88WneLzxoWDFhq5rxIhZ
         +a6YYf4uKz5dEC/BUmtemIVU0bxnCE4sLOmlEo8UqCQdNUsOwbIgiB0iGNC5QgFgWUwA
         85AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794082957; x=1794687757; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkHa0MmbohcLnendMJPUcMjg7m0dtk8v4dWX0lgC68k=;
        b=Ed034aLi9OSmTF7jIDaOYwSwIZKcu1Y2gTQip8g579sxZVC399mMw0YRCZIKw5sj58
         SPloQXujjhryJz7oD/stJDhqf2sCMm+wupMpe+BErBAFE6/SQiFPmy/x6Ib1QaDFi31R
         KUTobEnYlhCvhME8FgbayqFMeC7NlCdwx8Mft3rqll/9pL0kG+G1Iyebpwe4MtwIO5Gg
         HHeEX8p/J+bGXPHiUj/ETC0B/XIpRhT+RwpZNE9Vsbj2BnCQcPtTFjjeuEisbO30t87r
         iuFo7wQ5asTD08EjW9+8Bx/8SYlYm4xvjIRtmrtKpDzu8QDk/0SAp7JuSsXBi36TEZ5B
         Iy8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794082957; x=1794687757;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HkHa0MmbohcLnendMJPUcMjg7m0dtk8v4dWX0lgC68k=;
        b=TFGuvfASbDFZCnsDRpygkgRAnzJEmV1cFd7HgHKQOlAjQqbx6GAnf2fS2EL3Oj00nR
         iOKwCZKYhawfQ6tO3nYnemaLMcXrzNr5YQptZyhV8JjstHSYaSNBqmIlwMDsHudw0uj5
         LEDo2FC4qshFJFXYI52qd8t5UIsOBWihSE+pjk67dmYUOdDPgLliDLrVVlORFkDvgqaM
         s1Lk9idggWXpzPBy4NhxBYzPW9rJaEDlyai6ejB5QWKuv+eWv8gWcoUA1FeftXn2KFhy
         p/afBPJkZtBR4lGlxGQYoTBb8KDhs6XB4KvYSdFTW9vhpE9rm1itDAffKD1rAjMnKqBb
         5BXQ==
X-Forwarded-Encrypted: i=1; AKwUvByAmjSKu+jx9JDzNRNk6tNZEedmAy6t4PgAPsX3lMeZ3tdT0rvTs6EHqJ2cOCMGfkXMJKw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WabyQXCF2rXae72cOrUB2eentnJCWjP0pT5VugwaHs6yPSAM6
	4dL3RIZbgb6HO5KhlaUY6ThEocVeHU132Pu6Kd50b96Us3BmJ8TPYBCdXxJB7EAPlGIWokebjm9
	vDnkCEMlPXNp8VI4IkCqy2dSe4V/NCzQ=
X-Gm-Gg: AYBFou3rfdCUB3IqxiTWKCygWuqf9cKxcaG9KMjuGl7lKulbcIqkxMGhiN5GBLY6QnT
	tfNYhOqYODtGVv/ampopWW+NuVzuM3bcLchuGqpz2XiyXvVaha4b97dCV/FLKeXkRrEHyhni2gM
	o70G/1OFwv8G9GTLFoaCMmLSgAIAMyCnYDtL5+m2OGtt04wxiM4rE1D1OvWrs9S2PEHAKkrFCJy
	7hpNzFnVQODP2VVLCSSKU99QJCOIAWO7nt6Nlu7wrOMsnyUbaHrsmLGBBNHfADB9es/Vz8SIQtE
	m2VRpCtK+USRAFbIteVEY418ys3lhDIZpDngGUQsdmTa7fW1F9W8wKaPuToZ3j+LvRPBQIjqrzj
	XyLdbUS3/cH6xAUsTkd3ofhTbtCkC59qWL1dUeSkjM0g17lo/JoUFQELZSpq17BKdXJV0txocan
	YyJcvy5mZiSJT3rw9Fwqjv4gcrciBAzX/Dervz+JxjA1NUeOzLkZ7/
X-Received: by 2002:a05:6830:908:b0:7f6:96ad:36a8 with SMTP id
 46e09a7af769-85f1cf93edfmr6598870a34.8.1794082957245; Sat, 07 Nov 2026
 12:22:37 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103043756.61627-1-eddinen77@gmail.com> <CAKrRMNrLvPck5psPpKX1eWe26To5srfFSLFObZ4zTX09RE551w@mail.gmail.com>
 <au0ZOsuyo0YYyZsa@fruit.crustytoothpaste.net>
In-Reply-To: <au0ZOsuyo0YYyZsa@fruit.crustytoothpaste.net>
From: Tanga Joris <tangajoris@gmail.com>
Date: Sat, 7 Nov 2026 23:22:01 +0300
X-Gm-Features: AclHuK9p5YGOiDnbihN-_BF91nFA6PgzdTgSj_amv3oeORt5pAJJDZrELY-F0I4
Message-ID: <CAKrRMNqBCiH06xsre-YafBJiqPTiBgPnNZ3xPrhjTQWU3czwHg@mail.gmail.com>
Subject: Re: [PATCH v1] hash: handle invalid algorithms when formatting object IDs
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: shrimech <eddinen77@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi brian,

Thank you for jumping in.

On Fri, 6 Nov 2026 at 03:03, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Minor nit: I use they/them pronouns.

I'm really sorry for getting your pronouns wrong.

> This is not a valid configuration.  I have a patch on my sha256-interop
> branch, 5b208e4a3d34ffba0fbeafe991643d6d47a5caa0, that should make the
> members not public.  It depends partially on things other in that
> series, but it should be fine to drop those pieces if you want to pick
> that up and send it in.
>
> If you pass the structure from C, it's intended that it panics if algo
> is zero.  That's because we don't want to rely on the behaviour of
> depending on a mutable global in Rust, since that's unsafe and leads to
> action at a distance.  We really should just drop that fallback and fix
> all of the relevant callers at some point.

That makes sense. I didn't know algo 0 coming from C is meant to
panic in Rust, rather than depend on the default hash.

Since this is shrimech's thread, I think shrimech could pick up
5b208e4a3d (making the ObjectID members private), and I'd be happy
to review it.

Could you also push 5b208e4a3d somewhere public? I could not fetch
it from https://github.com/bk2204/git, whose sha256-interop branch
seems to have an older version (c38d0c8475, "rust: don't expose the
internals of ObjectID"). That would make it easier for shrimech to
pick up.

Thanks,
Tanga
