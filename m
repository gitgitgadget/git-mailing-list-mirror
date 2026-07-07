Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B5430313
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440766; cv=pass; b=HVGjjIB1hHC9eDT8aLQ+Id9aLKjT6E4ePoHLmrqQhMt1AR3lNYLMILMDWMh0T7Sk4JIHkkHDMN4syee+zWvAcgfVhOk36xtCRUCTZuKO+Bl1ectKxxZO/lRu47O5X0s5CBOQLj4Y87tMRs+J4UKSA/p1LxrOc5/LS0Xv3ZrNPGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440766; c=relaxed/simple;
	bh=T5/Z4X93OWta0/FPFh0UA8kIQX8pjG+kcoF+9FUFwvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwAgJPHqyCwhSR5afKAHo+lKvniHZHSfmWdyoKcVb13Xy+sMQf4x2e+lRTWMy3FvutKfcj051cX5gmsLpk72EFheC0/GO0Uw+jaw8Xdrd0HLUYosXwEyu4fjxfgCIjPaMvUTKAbD2naFn786WGi3qvTtdCkzsVfpoPZwlrxog8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=LnIPqQVI; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="LnIPqQVI"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6663b4fe293so3424959d50.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 09:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783440763; cv=none;
        d=google.com; s=arc-20260327;
        b=V136/TWGfqt1MgUsDiFy9NNCxccONP9x9Y2EgtwK4huv0lYm/ArEZu/wVN3Iri6/em
         Vrftm0jZQB55jgGwniotDBYlnTOUxzXE4GZ0wNjkrNGg2er0D6654dQ3/ig9kDf2fsjX
         XLJl36poLbeP1/30M39vlpFozRaeCLoQ+ZUdECfSfVPrVBKMiHBSTZDsQqFea+tdRf7U
         pebvxQqmVTbx9QfUXFYx2aJJ7JbIHoEzmNoKnF+PSATlv5zKDcSolLNtVapckHxorQkY
         ISiOmZyKQby4+FaO1S5b4kPif0JHDmZSFRvrviv4udcMGoU0o+IsWeN6ryEfhBmrd3Xc
         rozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BhA7hU1jkJka0X//COtl6Q9QbmoZzHFdfSao8db9USY=;
        fh=1KhExktlnSu2y9/+0/RlCLzpgz6Z45msX1+HJXZetPs=;
        b=Zt0JT676FyHVDYZ1KVukULeSrwroQ07m5pJEcqeXkmULaXGD2jin+mMOYNjFV0z4q1
         MOlbnU7B28T7ch3rL6yR42De9ZqpglqU8CNAEJWMS5Eese2WDRYCZQntTWc4Yct5KwLs
         BStZf3X+QHDuomjbpz5kBgGFTPFkmkeS2hXPrc6y5JfMEyvDJo4jR2RgFoHH1IEC7rZ2
         Twda3uaJ0HLTdoTZeWqaSXFN7RKQi5YQeWNTWND/nBf5I5yBEhyjNPCm1cxpFBn97NUg
         tq8SjbTJ81/S89LCN7OFyuZNKqjxJ1kbKtTIMBwxzi1NZvNemRsutU0LI3WSeQD3kSHr
         66Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783440763; x=1784045563; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhA7hU1jkJka0X//COtl6Q9QbmoZzHFdfSao8db9USY=;
        b=LnIPqQVIYcY1fhRNZhECUQFqlQsYfvCVYnFOWxDa/EFzCOkhT4rRFVnxYVE2b8ksG0
         rOqPk0KXc8IS5FvQ/wXwanZfJuIeKM8t7Q7OHx5QPWitdtQlUbQ545/Nbnr5I3awWa1v
         iuViwx73JqEIeulzUgs0bnEevBzzZwfxAdsKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783440763; x=1784045563;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BhA7hU1jkJka0X//COtl6Q9QbmoZzHFdfSao8db9USY=;
        b=FhQrjauWXx5FHc7hGZN4XfLu26GaPDCKt7ITYTiUapn/104Bs030WGhBv8vyC984LG
         ahGle4hkMI5M++RkESKxNaEp9u8zQamykpAGxT/+9VVuWOKxR7mHn+364cZTISw6S67g
         s9RzsdScDwDtEHSWHnixGMIYeX/JyWVgxKfZArjkMxYly+uJ4YkDvafJyUXBt5VLWL35
         7ForD5JyJ22ctBat2MgKnS37E1bd+s109Bbo7dLgkAKGbRZ9on4TMBVbxsDJnEkTcNDc
         hS+fF/3/YD0ZHpwHDAAh7o3q4XhwgS4yPFcWqDRXb6VAx1mLEKqAwaVqZHlP38yfitwE
         jEiA==
X-Forwarded-Encrypted: i=1; AHgh+RrNYi2t2Fn8kvFbprw29kxbFgJjfYhU26zGun5gwcxqAylUKDjv0cGeFFWw2n7NjF1duMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBuVzNvWHp+rfXaOSAlL/lPThWHf1Gxbv3SkgBmWXHU16omex
	lVINwOsXQKkMQos6eZrKQDWw7wb1oBS4shT26lwakiTvbXi0p+4zs7yN3QmWYk7t0GDgRckuykf
	/gfnspY/FWAtjn3ekWaXSHs/UvClGAmcYQqm42HI3sA==
X-Gm-Gg: AfdE7cma+hwmD1i9jTbe7Q6+DWtyRs5SpjdspRW7TayMleeadg13Ig8TI6vLLtck01X
	jzTBh057I8b9b6yzfpsW9DnhO60NR8mmVLWR9ZKSs/rwcfTsgCNlP5sEOmcxMaQPyTypKUVGa9/
	6abVSO0Yyq2Rk5+mVPGZXigend2yznbSkmrRd4A0Rp75I16DVySq0zxbQ8Mqd2kzppYMzXHq429
	R3WXbxS5kL1fIeCp0JvPlKt5xfV721wcCJ/8wzedJMKYy2smNs6suvQ+rQLkjE0cxo/y8KQFQdG
	dl/1A9f/
X-Received: by 2002:a05:690e:14c8:b0:667:9010:2afd with SMTP id
 956f58d0204a3-6679010324cmr1714560d50.38.1783440762843; Tue, 07 Jul 2026
 09:12:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <d8ffdcb4f8c1988c109761ddb9daff8c07caa2b1.1783344957.git.gitgitgadget@gmail.com>
 <ak0aNrBpuo7ZwZ2k@pks.im>
In-Reply-To: <ak0aNrBpuo7ZwZ2k@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Tue, 7 Jul 2026 18:12:31 +0200
X-Gm-Features: AVVi8CdjhE41CYZ2RZm3K1jFkiv2iX9JIz30yT65mAo6CbHMbj8cbTZ90trf41Q
Message-ID: <CAL71e4ORdJXsz58SH71VjDNAWZ39T3+TrWN+gScAFx=Gt0CTkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t: add tests for ref tombstone scenarios
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 17:24, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Jul 06, 2026 at 01:35:55PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> > diff --git a/t/perf/p1401-ref-store-tombstones.sh b/t/perf/p1401-ref-store-tombstones.sh
> > new file mode 100755
> > index 0000000000..e40a6dcbf4
> > --- /dev/null
> > +++ b/t/perf/p1401-ref-store-tombstones.sh
> > @@ -0,0 +1,44 @@
> > +#!/bin/sh
> > +
> > +test_description="Tests performance of ref operations with many tombstones"
> > +
> > +. ./perf-lib.sh
> > +
> > +test_expect_success "setup" '
> > +     git init --ref-format=reftable repo &&
> > +     blob=$(echo foo | git -C repo hash-object -w --stdin) &&
> > +     for i in $(test_seq 8000)
> > +     do
> > +             printf "create refs/tags/tag-%d %s\n" "$i" "$blob" ||
> > +             return 1
> > +     done >repo/input &&
> > +     git -C repo update-ref --stdin <repo/input &&
> > +     git -C repo for-each-ref --format="delete %(refname)" |
> > +     git -C repo update-ref --stdin
> > +'
> > +
> > +test_perf "recreate refs after mass delete" '
> > +     git -C repo update-ref --stdin <repo/input &&
> > +     git -C repo for-each-ref --format="delete %(refname)" |
> > +     git -C repo update-ref --stdin
> > +'
>
> You're not only benchmarking the reference recreation, but also their
> deletion. If I'm not misreading things, then you can queue cleanups via
> `test_when_finished`, and these calls will not be measured.

I don't think measuring the full create+delete cycle is wrong per se,
but you are right that if we can benchmark something more isolated
is even more useful. I will try to split this up better.

> > +test_expect_success "setup asymmetric" '
> > +     for i in $(test_seq 8000)
> > +     do
> > +             printf "create refs/tags/old-%d %s\n" "$i" "$blob" ||
> > +             return 1
> > +     done >repo/input-old &&
> > +     sed "s/old-/new-/" <repo/input-old >repo/input-new &&
> > +     git -C repo update-ref --stdin <repo/input-old &&
> > +     git -C repo for-each-ref --format="delete %(refname)" |
> > +     git -C repo update-ref --stdin
> > +'
>
> Would it make sense to use separate repositories? Otherwise, state from
> the preceding benchmark(s) will impact subsequent ones.

Agreed, I can use a fresh repo for each scenario.

>
> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > +test_expect_success 'delete and re-create refs with tombstones' '
>
> I wonder whether this test really adds any value. We probably have lots
> of tests already that test creation/deletion of references.

I could not find an existing test that covers the delete-then-recreate
flow (where tombstones are present when the new refs are created).
The existing tests cover creation and deletion separately but not the
interaction with tombstones.
(But perhaps such a test exists and I just can't find it.)

Thanks,
Kristofer
