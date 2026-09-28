Received: from mail-pz2-f15.google.com (mail-pz2-f15.google.com [74.125.228.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4C44C33E3
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597132; cv=pass; b=LcI/GS6tJUu7djzZYFgMxy6PZQ9wtLJZGwIvgeOlVbFIoCtpPh7VjB0SuZsCn4fYDh2dmPIHjixoUWjlLZWmONHZgU3BGOrTrj56iT+nkB+kZZje+blHM3/KfpbM0pw6WXGiaFDkiE3OGJ2aGeY7sw+7LgAZltODXXUMwrYKQA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597132; c=relaxed/simple;
	bh=aYhSRfzlOJlY7vMrXJd445oU0tpk6hinMN52bBrElGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTp4BgfeYwDudRDvcrnTdoMOG0nFFztJsl0eGd1dCSzrSDEn6pcxYPox7JLwXZRgkIBYl245Fb9HNWuHqKqztK0WKUsf0LNU/evKrAE6yuvQbEHyfCJNx0uVBipcou4tJbVPCTjM8sGIOob/kOpfAJI/Z1qACGDeXOIWXEJF7js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OK8eHraV; arc=pass smtp.client-ip=74.125.228.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OK8eHraV"
Received: by mail-pz2-f15.google.com with SMTP id d2e1a72fcca58-88379342f7fso502089b3a.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 05:05:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597130; cv=none;
        d=google.com; s=arc-20260327;
        b=YXIsibR+NG07mUz9iHLZB5hcliE6wdTcl2cIdRHyQY1lnhn+a0eenBN54D4+gPixpU
         Gx1MtqkVoebAi9nNEksoeFGRLsaKy+UFgkdiYSwG23b52NrM1MsuTUlPItLvSrJBCHez
         prwpq+z/yJDBkNqDgELBuaS8TbHQRxAt26OYlzOWtFUFMrr/X3795U7b3bJ5JivmE8g2
         KFmfDo0Jc0eqKu6eQO8v5HKYmETXiiC8BprAiu2xW//SeIw8dBSK7uzJ8MBNH5I6Sw8o
         4XajdEXOInYSyU0PkX+fschjzJWJ9UeplZzOT/GdUSLQY0Zh8dK4sa4XuyshdV0Ngk9j
         E05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L8gWqJj/7aJd4nH/XRz/Ya4LlAlG/jyoEq7Eobh6yjg=;
        fh=1OSMS//D3ruYhWekwh3fe3RVB58m75fZwlPuNEXDu2k=;
        b=WK3LFZxF0ONpgHtsoBj+UZPKpvn0dYJIi2Kenyb4podXS11J66pq568ew2dwgZZLhG
         pLdPcQtQIsntzZTsCcU147mB2PuqFyOqfl7bPI3lfXpi9Vhc+hqL0JRbLA18VNEwCqR5
         yIBBNhHKW0ZyE+tMZhmcVz1xZAOXDZEvXWctNpIihv8ryXbrPPvP6vg9sdX3ygUI8YX/
         FXJall/RwLDpRpAU/Z6x8tbILLd3UnZQwh5lte59VCEbxZLCeWlYHC6NdLFY14GtfC1z
         yFMcSRjJRw24ew7COY+aZHxZ1ky14GH5/mvBGFOLkqQz/YkCAVGAAl4/fS7ZkJTNZ0Ck
         AROw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597130; x=1791201930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L8gWqJj/7aJd4nH/XRz/Ya4LlAlG/jyoEq7Eobh6yjg=;
        b=OK8eHraVkOdpwTZDySlPDcL/NXbZak7IHYgCNgKQeauPVkHTpLGVZQFRImBdfBEbMv
         y+uQPd/34bzaO+iGxo+zWGl/NIgiP3yMhfK3PxSZf1FoJ8xz233GaGXff1wcnFnMS0p3
         +LqR/2pJZl42tNmQBEt/mtUG+FXgF3C6H9EyjnVI9rKk+DGM+bTlhHRc/pk0i+ekgIRm
         BwmUIgxVi0nwA7jPPEUX+HveCM+3gnWOfcCTsiUwcsLCUbFI0A5C8VG5EBec1dVun/6y
         g9ltoDKln5DkS41KuwaBP6lZpUton5u4P/gQfuEtfi9YllonsSeqQN8klliziTFuq5Ow
         PJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597130; x=1791201930;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L8gWqJj/7aJd4nH/XRz/Ya4LlAlG/jyoEq7Eobh6yjg=;
        b=lK5JqDU0/8gZC3BDN8u83TccCKTQ5kC1aZCnwifmPXv4ZXaH+izDz4TQ7CLkOxRbHo
         +CrsQkU6owv9m0FgRHZXZh9491Cud+3gN1+VNvmSYEiGu3lgHs7jeuBEuf7U25RxUb3h
         JCDAb2d27/jlyRtp5B7uz+/9nGLbBZ2x7nL4TLAjZCdQrD5XJD9gC82TeacsaVH5o1of
         5n2gYfjpsLzUc3hsxH5R/bI+heYqAjqBoX6MmR+UhA6WnZd8ueGv6NWi/NZXuzyGHAWV
         WptyIMTfvi5fCXmZQmPDydMEpOCm7WEMtJEwJTB1iPhzPBAEB+kIiyA14E7+ykusJTBU
         zhMA==
X-Forwarded-Encrypted: i=1; AKwUvBx9KC4M77HneJB2q1ad6wE04QAnRkZxmu9RZGFCXXAzQFqbrJ/0aNBBCTNc0TDzzujcD6I=@vger.kernel.org
X-Gm-Message-State: AFuF++ngEW4KX8B8X8IQ2ZtPZlbmSvFt4A29RStDsE4iQ6LYv6JxmVAT
	gKAQ8yiUHGJIHE9u0y6tkHDYY0FAfMbrKqxOCGvIdtVVD/XKvoDKrjsbLBYV6wus6KZ30qzc0Ii
	5fgmI7o4u27rNn86V85o7/MczIHmQ38c=
X-Gm-Gg: AYBFou0o+QSqfDHekHAHu69NN5eYGlhD+ixvaRI8L9PkAmQ9o3IXJq2H67N4gdrMrz8
	ZDYtyvyP6xdocekyj1Vebg1q+jxavIKJjEvsMUp7IFecMWtpLTTU5WRWHzkq4g2LelLxwdqcADm
	ZDO68SXzFoMOcabSRCXdLlAc8bXVPPwKYOZTdE8XUikRK9r5mhVhhtHFJiU3MhjpnzHN1h56z6P
	0dYlrn+aQ+YeKSzYrYbv2cPxgnYKfbCbuutZ9dbhQEesSvvVboWE29/S/KLbTE5ztOVSvgkh6pc
	AUYb07y+Fe0jizToSmm4jGKJYF9IHLcwiiwZt/NgYb9cQKrQQbrDXCfjseOmO7U4Jul/DahHU3k
	ir29c/TE2j+oFXxle2Y8+wXhYrQxvI5U97dljkqkRU79LYCgqJ6b2wyYeduzS57kqj8H8wtx7B3
	aOjFzF4fU=
X-Received: by 2002:a05:6a00:a203:b0:878:3538:8f7e with SMTP id
 d2e1a72fcca58-87e9f82210amr8832085b3a.44.1790597129904; Mon, 28 Sep 2026
 05:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790168285.git.ben.knoble@gmail.com> <cover.1790425008.git.ben.knoble@gmail.com>
 <xmqqjyo6qz3z.fsf@gitster.g> <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
In-Reply-To: <346c4209-9600-4302-817f-e8f6b364ce6a@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 28 Sep 2026 08:05:18 -0400
X-Gm-Features: AclHuK_DkldrKLjTSVEEUTv-lQ47eRlLHaf0nrA7vlOoD2NbgyJiskODMXOepwI
Message-ID: <CALnO6CCXT1HHUwL8+eYGVL443nO0eoC7vhpoLvC3RXjp39XQYA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] stash: clean up index-mode test merge
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 5:50=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 27/09/2026 20:21, Junio C Hamano wrote:
> > "D. Ben Knoble" <ben.knoble@gmail.com> writes:
> >
> >> Hi all,
> >>
> >> This small patch series fixes a bug reported by Eli Barzilay in the
> >> interaction between autostashing, staged index entries, and
> >> stash.index=3Dtrue.
> >>
> >> The first patch is an incidental cleanup, and the second re-arranges o=
ne
> >> line to make the change easier. The third and fourth add missing test
> >> coverage (which catch breakages from prior incorrect rounds of this
> >> series), while the last holds the interesting bits.
> >
> > I may have reported this on the previous round, too, but 'seen'
> > seems to break t5520 when this topic is merged.  I'll eject the
> > topic from my tree for now in the meantime.

First I'm hearing about it, but I'll try to bisect seen and see what I can =
find.

> I'm a bit stumped by that as the failing test (5520.69 '--rebase -f with
> rebased upstream') does not stash anything.

I wonder if a prior test is affected "silently" and we only find out by .69=
?

> There seems to be something
> funny going on with pull's fork-point detection. If I add GIT_TRACE=3D1 t=
o
> "git pull --rebase" then on 'seen' I see
>
> trace: built-in: git rebase --no-autostash --onto
> ae9857430e281d178a3755aecfc5e29c46a02306
> f29aa667ce68e4d514557081ca7f54b12e108922
>
> but with this series I see
>
> trace: built-in: git rebase --no-autostash --onto
> ae9857430e281d178a3755aecfc5e29c46a02306
> ae9857430e281d178a3755aecfc5e29c46a02306
>
> so the upstream commit has changed. The previous test also checks the
> fork-point behavior and the failing test just runs "git reset --hard" at
> the start rather than re-creating the reflogs which seems a bit iffy to
> me but I've no idea why this series causes it to fail. I tried a merge
> of 'master' and 'seen' just in case the failure was caused by the base
> I'd used for this series but that passes.

Thanks Phillip!

--=20
D. Ben Knoble
