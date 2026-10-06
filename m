Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7083D9529
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 10:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791281575; cv=pass; b=K+ZSHWxbtVGQ6/lTqVS0jspD2RD9H05VOjFNn70wXkIC7mVuzO0JrdBTBbAOejBcLvfPfIMesQgiebre1WcH661Rn9UX44ocK4wL/7EBBfI5OyhmbaFk4BB3sSGe6ERuvmIO7cVK31GfAI+Y73RC1NqcDSPOj0E/7qyixoMbvc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791281575; c=relaxed/simple;
	bh=LRzJZweny3P8bVb6iqldm7MFPfqFTQlIjxttOszu6SY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsaesmuT0BsuhcGPQKaTavv1aG6PvYq+8Jzbtb6nMbK1xnvefUE1aalhZLV1X+rxLcOJEyBty53OdkjXQqyDTM1rEF00T4Zr0N9uPyhf3nILY0Y7MeDKx4r4pz06HOrZNlzspJ0PUqmWpu4k5KNC6tS90nlF+DFZJkomJbiWvWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=XkLSssu/; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="XkLSssu/"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c70f69d3fso2139753d50.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 03:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791281572; cv=none;
        d=google.com; s=arc-20260327;
        b=evbjTmBIQcrSBTjxWx46I7nDYjraZ70Q5fBhpSmOr0wB8l6O2iBejBDgm7Ht35f5TP
         VgGQYANoUOaHD0293XdwHiNc3FPeDcFXEqLStLCWxgetFLUzq84U9zP319E5IpVTHNdD
         dMnRMLwOLtxOfJ/GFc9Wbt2Tam3RhRF7ZzDmX/29AlqlsXbovq/QzmGxl0q2dcIymrmM
         lJP6LmMygYimJCWYokwMqWqJAzAbYfG3Za04eBGYReU9IvSUKW1l8Cgm4VxQ/oAD6ilN
         YOgtoxZoZxEPadRPB/YGn0BhB9bC4b6fd016ROARWuO6rbdjZ22XuSGWbksVPCEEZ73X
         DxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xa1rStP541USJoSPcycL0PPUTQl7ZGAbddBBi7niSm0=;
        fh=fv1HBlMK6IpDD4fijPB3f7TCjQylUID7nv1/l2e6b8g=;
        b=KLzS72bVWxzxAEuWoR8rdURVsLMmPHqQI3VDGza/cT+DKshN3q+tGrlQeOr3TlbCgb
         AUuloX9XJpti3ny9CGW+MfqJWHDfyMTIFA1XXHXpQT066nSCAWtSyYSonolM35RQ/KpX
         vhZpzPh0JsO9/CInv5dO2n9tXED0LCbKUuHKmlQQuhI4UJZ8m7IHAwkuVg/ZS7gv67u9
         t2xY0yPbfFWd5/Z3YT82kUrE2Hk5ibnNmsPE3mLYMt/twIq4dx9cehJETYOznsmKdnek
         N3S+tThuJsLp/loe/fvCIjOEpHzvtvoZ+FJRxzC7tsiPVYRn6dbsBOsf8AqOkarKHAC4
         ZStw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791281572; x=1791886372; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xa1rStP541USJoSPcycL0PPUTQl7ZGAbddBBi7niSm0=;
        b=XkLSssu/TgAgJppqgWPOo/UhHFljTLybXUB41iVNinuTjuLBVcFZhxwYNVv9GyzFy2
         f6phxC1xW60WwgRuGwKGovSFVlfBXql0unZEAdHiWYvbOK/nQUIxIy3UAqViz65dT85M
         Qr6YvBPwKhNwXz8bpSHY/wHc0wU/eKdj83yZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791281572; x=1791886372;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xa1rStP541USJoSPcycL0PPUTQl7ZGAbddBBi7niSm0=;
        b=Yl+usYXw6831v0hQvLoALyl7vnkbNeG5jMlOfygqXemyYyU0WXZ83gExnVHbYl+JbN
         U2aChfbzM5lfvjXkOi9e+queCFzc6i0LD/5PEP0w+QTcUQvCoxKg/kqgPNvafWFfiNc7
         DWruRutu4t8t6FB8P+ZZ1qd3R8ppN++SYeWAbANymox7cMUproTGFzRI4OGD4u8pmf2D
         bsnZ78TQXQk8/eCNCcPQi+v2cvKPP38itf9qFuJxEPWy6vxZUgggkAmZy6EEpUIo41Zg
         vH527ShPfkuB48nOTkPACosrBp5BnZVoYoRULU2OuLZ5BqMBleeJsQqQFaH7Y3DUtXz1
         ztyw==
X-Forwarded-Encrypted: i=1; AKwUvBwwPPJ2ShF4g3nYJgPRu9NsKFXKXbyNAQImXz2cRCNI3/pB9TzGbgMMGxRbiTKb+ekjNwY=@vger.kernel.org
X-Gm-Message-State: AFq9FYId5w7YDaZ7CrT5U6Baal8mQW05XTxA9ADGnrgcmTVO1EGmYARe
	dPMjgQyNl4qfLArCJErdwlYws2lDql8wKqPEcDaAeUMgsFkq+w39z4KayzdVXFdIX2PkhxviRYD
	miti9uVP0Z89QIWPpwfxHV/81VkMJ1CaitaMT8tKlGCeLzdYvoZmIRHOgLA==
X-Gm-Gg: AYBFou3QAFVN1jsSW8AjvG4XMS23xJrPab0njOzYDBtW5kUUqSvHn9Af9OVKB/hwMQo
	cauNKxn7HE7B/Ic3u6uHvUjExpF5QPX2HwiWMiu2ReE6VGFShx2CvJdnjwWZhbtIm6qNIKzo71Y
	b3wNjzDCGdCf3vBhjBZPRz7GkkfQw1sTn14SkizPx5zCe7nDX17X+STWEKLJzmeZe82FENl9HAk
	4bel1MkJ3bILUUHgrMKa6YipodC0ojxgL22ypFp9Z+oQvQQ0MXLSzMGlPMVaUBQOMG7HriXxQco
	+5+ELjtugkPS6R70NHyhlBgJtXOt5uMv8KBVkHl4AOWUKlGdY9ca+tQ9BoMxfiDfgQ==
X-Received: by 2002:a05:690e:b46:b0:677:da43:28de with SMTP id
 956f58d0204a3-677da435183mr1698535d50.37.1791281572414; Tue, 06 Oct 2026
 03:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v2.git.1790600552.gitgitgadget@gmail.com> <97c11449aeae924436ba22a00a2545254e988a58.1790600552.git.gitgitgadget@gmail.com>
 <asNY7SfEohsOSf0J@pks.im>
In-Reply-To: <asNY7SfEohsOSf0J@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 6 Oct 2026 12:12:40 +0200
X-Gm-Features: AclHuK_HJDsWTvXM-QjUf6C78f6mybnG6ubtyHl2xQKA5dUzWxkCbCdUE3p7OEI
Message-ID: <CAL71e4Pd3ziR-7bbBDUei-pcF69mEpt33fE51WC-H=7YgXq=NQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation: describe connectivity checking
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks, it's clear I'll need to do some more wordsmithing to
improve the clarity here.  I'll reroll/rewrite parts of it in
some way (and aligned with the answers below).

On Mon, 5 Oct 2026 at 09:59, Patrick Steinhardt <ps@pks.im> wrote:
>
> > +A repository is connected when every object reachable from its
> > +references is available locally (with exceptions noted below).
>
> Right. I think it would also be important to spell out the reverse of
> this, which is that nothing can be assumed about objects that aren't
> reachable by any reference. So even if an object already exists in the
> object database, it is not safe to assume that it is fully connected
> unless it is referenced.

Fair, I can make that more explicit in the text.

>
> > +The connectivity check maintains this invariant when references
> > +are updated.  It trusts the existing connected state and verifies
>
> Nit: it's basically already implicit, but I'd clarify that "existing
> connected state" is again just the connected state of objects reachable
> from reference tips. So maybe "It trusts that all objects reachable from
> references are already fully connected and verifies..."

Agreed, I will make that more clear.

> > +Full connectivity check
> > +-----------------------
> > +
> > +`check_connected()` (see `connected.c`) normally performs the
>
> I'm always a bit hesitant to directly refer to code in our docs. We
> should either make this documentation part of "connected.c" directly, or
> we should not refer to code. Otherwise, chances that this documentation
> grows stale is very high.

Good point, I will remove it and make the logic more self contained.

> > +The check proceeds in three phases:
> > +
> > +1. Walk from the incoming tips (T1, T2) against the trusted
> > +   refs (L1, L2) to find the incoming set ({N1, N2, N3, T1, T2}).
> > +
> > +2. Walk the trees of the boundary commits (B1, B2) and mark
> > +   those objects uninteresting.  These trees are already trusted
> > +   because their commits are on the already-connected side.
> > +
> > +3. Walk the trees of each incoming commit and verify that every
> > +   referenced object is connected, stopping at objects already
> > +   marked uninteresting in phase 2.
>
> I feel like these phases here basically just explain how revision walks
> work without adding any more details that are specifically relevant to
> the connectivity check.

Yes, though I think this is important for understanding how the
connectivity-check is implemented to see the relation to the
rev-list walk.  I have some hope that this dependency can go
away in the future, since the general rev-list function is not
necessarily the most optimal way to reason about connectivity.

That said, I am happy to remove this part of it's not deemed
useful.

> > +When a new reference points to a non-commit object, such as a
> > +tag, tree, or blob, that object is not part of the commit walk.
> > +These non-commit tips are handled by the subsequent object
> > +traversal.
>
> Huh, what subsequent object traversal? This part puzzles me a bit.

Good point, this is meant to reference back to the rev-list
implementation but that's not very clear.  And like
the previous feedback, perhaps this should also go away
(or be reworded in a more self contained way and less tied
to rev-list)

Thanks,
Kristofer
