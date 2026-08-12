Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE49476071
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549341; cv=pass; b=TbB7bMdEJxXnaztDZMzhmdt0P6L9bh4ANImpawi5FqxMaO3rKsvTyeduXI9v3cpaw9jt/GJzraz5/Zp5ocqayEI4S7aMayD0+taPNSOhtRmRbdks1b6UaqLMb5vqzcOa1QdFNymyh5DNVM3YrphUagspkekfJtVKNYLlJuAg6To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549341; c=relaxed/simple;
	bh=uv83jlln7i02aLn2OrDZfw0Y79oScInXA5Lj3k3s/+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jEg5ZR605knnC2HmnmJURj5uNzXYDl7KNi1LRyLhiOJgtUfEiT1utCQe4rYEqtgJZr3CENFIOX5GXZnIXzpTR2vSJ3YlNvCMvFshNuYLPcDdGzoIGYMBFkcTkWw0dwjTzB552x+4WPTN9Es+JnjDlTCWxstkj2fIeYqPHTG50Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8TlQF7s; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8TlQF7s"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6acbbcd3798so965191eaf.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786549338; cv=none;
        d=google.com; s=arc-20260327;
        b=i5BikBd35nCNxzwT+cx7QMVjVjuNtgwa8Nq4smJDyYG/gsPqNW3clowDGJCSCknn/B
         WxH3qMJ43GRFHxrnvht6rJpCeO8phtiTQ6bsYG75HqpdMmAcATxTCak0a6ZnEt3U0MKE
         vO1uS8p8aKVXeKm3lRpzuoBWLJMuQN4VnuVb5QCJJcMK/Kviwm3PBj3AKGi2oDjvyXKh
         IPYzZLx2fMIVf4FNeFLhVFfB/7Lv8gDGLNlH6e2k0UXcIlSFv7zUQ6GcARbfvNytnh1s
         iPw1y7A25r3Yy9YCkGwwB+JaAJ2h+rZMlIfg2mf+FlrxjevMiL07DUfn5aOFsY/qqX8Z
         ZTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4fz7p6do1KoplvaVuagA/3HPKgQTBFfHpWResmTHPHM=;
        fh=4eFNDgGlp4EV62Kb5J4R0JRVrx6ApYCcIhqFuX7aESc=;
        b=CRCvB3IGICRnNTDnap7ASsXho3fgw15++z9eWStLKg48733r+NWx9/fJnIaM9JZ1HU
         CLoUKvYExJJPAbgJdMv4GgG8B3wiwWF0f61l2w0BNWhaIolyifK0KDv27YDEYnTyAIu+
         BhyubgUdLraSelGpjJwD4aYnw/NTlfOm5+7qy85JmAcDWA7xbL8w0gWISy1uP9z3Q+pB
         DXgAGHC933LsFdEbfe/r2mn18N5sXyanB2FRl6dk6L2K3BSIkIi48+BG7Lgs9k+iUgZi
         xBIELLMnGE2RBqVgty2cytkbVJU+wmWEeqONQAUD5AMJRjELgwVUlg5j2LZzg3sYL56T
         M4dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549338; x=1787154138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4fz7p6do1KoplvaVuagA/3HPKgQTBFfHpWResmTHPHM=;
        b=J8TlQF7sHAWMuh4J80frEpqquiReidGDe/fGU4FCgdSjO2Wd/x+jd31o2zCr54QKHz
         noQjvZTz0PoYX3lP/Tm8RKa/odbalGDpLA8L6QILfTXtweLohTQJ/kn4w+XRXzhbjEYe
         cCk0tDV0hO6eAsSErm18j/OZXwustfLLutaY0tkgDbaTAZ2KJZFCu3pBfXNa3qO8kLF9
         fki0o36PKkI7KQ9jqlTXt2QpYwHKlgMvBObIP0Y+oEH/WNGs78k06/2n+F/wk/IXU33i
         /FePs2zzJrOeMZ6oi9Xdn8OeNSHI5P28nQw/3m0qkAd3H0RjMG9cYJRdZF48tGfyQ0h0
         98qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549338; x=1787154138;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4fz7p6do1KoplvaVuagA/3HPKgQTBFfHpWResmTHPHM=;
        b=TKjh+coJFnjVxvM00XaBgIbWWGbR7ze7CyzrZrcU8hsoQdriY0tZ0alxkIIbUIK8DZ
         S4KPq4E2/SB5n+Xic9jvMwVm9TXGZr5DMwmy6tQxBQTrTt789Qp+/scfG07NBnSDHQL9
         gMjc/NnPhw0Rh5pXICXyYdPVTVKhaiyyeoLED1eMwljXU18UW9uGGyda9Pi7Y2OU0+9Q
         vhV048G81LjXTTGA78WiYz0S8vMDozZLNiiZo75TiJcXwuufxCD132Aad9zWRaI6Oft+
         MG6+jzyZlRQ1NdSyH/ygEQb+iQc2aSB3T7bZdtczImmMFfOErkUxLWeqztXlacv2ExCc
         DpZA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6NFM4voiAqrQCuboP37oJpaocmMv+/EDtmWK3bB5hn1E/qJEXHS7K8z5YW8a9f3wzchc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnoBCT8SIQea7g5jEXnGeWTxeExCg8+IUWwiFQnLPVbmu1Vlrj
	iCPg+HGfAMvN8FxR9yHymerewYjzV5NSQq95kqjPYaNpPhUzhug+JNmJKMwexN6aToQlnRFLXMS
	pXpHgAvQ14OTSjoT+JxndfIkWj3RKEVk=
X-Gm-Gg: AR+sD10oK1l9YfJ7Zp817TMl4ZD4tIgS+4cJRa4vyDEMuFGztBP3TkJL/HXpv5cF364
	iNh2e/sWmZyJRkkZ2DOYJZmEVmo2TOR0RxgglVsw/l6IS5wYQoogwf/CmRPTuLPrsQ0chbgLxnq
	dJ+9TfXhq/DzuJUESaddyhMOb1O6md9ZDE3bMba6O+6d6hmWoQFTs7ZC7n7aGu/ViY6tQnMpEvY
	NATd4m531hR40G9NvAhfZtHC1gLRx+Vlk4Bt2x05EGFJcyxHj/JeoraJXigoAY85c+hqFKhgXro
	/4DzuRe//ryKJrfQkGX0NKiTFVUvq07frWYSffuqgJdsbsGDHi0s51GN6EyNj6IVElpsSqW8SBi
	FjWye9qFTP8NTlYjZoHucyMNJeJtf53ieuTjCa/JL4Ti0Kqa9A7X2lxtWX/JT8XDsklt/hirneA
	==
X-Received: by 2002:a05:6820:1f0f:b0:6b0:566b:b8c1 with SMTP id
 006d021491bc7-6b0b2cdbee7mr4674813eaf.28.1786549338469; Wed, 12 Aug 2026
 08:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2035.git.1786516958048.gitgitgadget@gmail.com> <xmqqh5kzzadm.fsf@gitster.g>
In-Reply-To: <xmqqh5kzzadm.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 12 Aug 2026 08:42:06 -0700
X-Gm-Features: AUfX_mxRTX4YGJvuImwhy7mIkTBjm8LdAFpvvQRIDG4V6iwlYRbvq73cp30S8bM
Message-ID: <CABPp-BF_iHPxc_uAZBCiOsRMqFBzJtEQU62GTyPOdut_bar7Qg@mail.gmail.com>
Subject: Re: [PATCH] diff: avoid misleading statement about -l option
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 7:22=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@github.com>

Oops, I had author !=3D committer (and author !=3D signoff).  I'll fix
that up and send in a .mailmap entry too.

> > In commit 6623a528e00b (doc: clarify documentation for rename/copy
> > limits, 2021-07-15), the wording around rename limit options and config
> > variables were updated to point out that only the quadratic portion of
> > rename detection (or "exhaustive portion of rename/copy detection" as
> > used in that commit) was limited by these options, because exact rename
> > detection and basename-guided rename detection (which both run in time
> > linear in the number of files) still run before this limit is checked.
> >
> > However, the short help message wasn't updated at the time; update it
> > too.
>
> However this is an end-user facing message.  Can we make it more
> easier to understnad by being less precise?  "limit to exact
> rename/copy if ..." or something?

Maybe if we replace "exact" with either "cheap" or "linear"?

   "limit to cheap rename/copy detection if the number of rename/copy
targets exceeds this value" ?

That would also tie in with the documentation for -l:

`-l<num>`::
    The `-M` and `-C` options involve some preliminary steps that
    can detect subsets of renames/copies cheaply, followed by an
    exhaustive fallback portion that compares all remaining
    unpaired destinations to all relevant sources.

Since there are two cheap preliminary steps -- "exact" and
"basename-guided" rename detection -- using "cheap" correctly covers
both.  Does that sound reasonable?
