Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4134A341C
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209832; cv=pass; b=oXwY0bIk1k7QFjFvuYWBWkCS+qHzE7AHdrwkKwzLIzdoHLnUgRp5GlrC5kW+N1VFo/yc9wV4xQbvD29aYAAQb7JW58w0pkIu1NGAUa8gYWBt/8mDHGganpP9jjOBqTdo6V5N5+rjpXAkDCbepF8CTZJJlqbH3Ikeo5QOu0m5Zbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209832; c=relaxed/simple;
	bh=oWuLiG3cU8eo9YWWij/Mc1V/V5E+xl1Lbfa8llX24m8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5HbBK+rS4OWWU5AVPrjhLYpCVQ4puleO1iV00RY9tvOZsXTQYxWTIvfYoovwmgIJQdEPuGXj7pbv+jG6tTa0y/XoPphhYSPENdOHeGzDM3deAQfALONKm8qgBd17cETG/Lcxjf1SVrPSkmKP9YF7Ig2EoCa0X+xffJxXsUL0TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOtEQIkZ; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOtEQIkZ"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a605c198fdso2514866a12.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 07:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791209821; cv=none;
        d=google.com; s=arc-20260327;
        b=PdGNmZJJ+beyYNWbV1haCr97wA9uJK7NXiKXvo+Nyz0t6o9idLlGI4LnkK4t3oaQb7
         iYW4EOHWiyuIsWW+6aQQkWzamPs24h0KVZDR8+yn7hHY9G9aOinUSACRM6IloNQYNmWM
         Z7XSl948jhI2xFAZY8Pw12fA86O7If/2uUNHh28iVX75QrhNKGuwW7u94dL/jxQfXC9V
         Dn+AAx5sUEyypSZXlG7OmqYnlspPZLBlFgJkuBZukw5hJRb6tyj1aNa0hOoeJpccchIX
         IJt3uBUeXbdwKYcqxNDE5s2PkB/quCRiRf1fktO1MBCVN8Qpwe4pY/GC89Ge0ockfYsO
         4lEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oWuLiG3cU8eo9YWWij/Mc1V/V5E+xl1Lbfa8llX24m8=;
        fh=mopak7wPE1PmdilJtsxSsc/WVdUbS1Un2uRAi88K/tA=;
        b=pSKGar/iJayie9XOQHRn6Ljcg7Kq+9gYn8bNKl5bDEunww7EgUSgPhnFYoZZ1Xqk8K
         rGTWfDhaZLIxSb3mY1KOhgHpH/1A5dbw1q/MhjUNP2CR2h2ucuP6cczjIH34ld0C+HH3
         j5dqPd0PDaiIgeNFEuHZaJEvADZtzGaWh+JdaGCnWoeWwRXGg9SFQeLF+sHdz1haH77R
         /SiiKmoij3g5f5UUj2VKozNb1PCz8vgOo+w6m9kbkeryw+78GdTmCf4lxwHju0354ufx
         1GpTd3qMoPEpj9qZxEEuGOHtparfvWocWqeN+bGfUMQxxIvi6gV4/SLZvo0Ay5CFgWqv
         /A0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791209821; x=1791814621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oWuLiG3cU8eo9YWWij/Mc1V/V5E+xl1Lbfa8llX24m8=;
        b=pOtEQIkZ3+qoR1wraY0dYFcBWbpLt0V7h2rwtL79uC/fkBXqemsE0EYvh+RwI4mEA/
         ck+BX1EfqefPmar+y2NHTMHZSp2WcO/oV2bVX54UJiBdkNsb764Vid+RIjqQucJy6dlB
         uBme6KdzvdxGpDbvVRI2kCN99Qawbpo1INlV40Aww2nlWPgLD1rUU/5qWGvEOKl2b48j
         0bjN6t44vswrtPy75o108HmIbl8lH+ngpRDvH0FHU9UHopH/iGdi9/nPMCZFZkhEgo4m
         TE2yBQzw6DI23Iv6ZrGNVchy2VlX4ckQVZLZvWO4CTdU9hi8MloVKbwjoP/tzzkMo7K8
         p1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791209821; x=1791814621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oWuLiG3cU8eo9YWWij/Mc1V/V5E+xl1Lbfa8llX24m8=;
        b=Wq21lfTwhDlQ9hwxXWVk9G+Y4K3ZSJufxjCe+at9eE6l35CO472qjjQ6AqfoLOdrt3
         6XG/FR7YFoDvR5Z9T0eKyXWWN6wa81PVp8B1gKF34ZY9u8ahJtV/skX8jrvNGGiaNoiJ
         LfBeMwqywsfJXZ7EcApbvAtp8dNxKXrA8mFYbdbs+jYpl/uoV1SyI9UH2dx5dCNzqQg3
         KNali9p9mG8wl9MMr065Vnt9heb0Pu+sdQlKm2/pgGI2aeop4fOPGIfV0ZGaL1nDnbzz
         3UCZ/OqqpVtIiDhc6EgktkJboQu550S02M4zHO+kjpCnXEDH7vjLRdpfVCZz6JI95joL
         Z61A==
X-Forwarded-Encrypted: i=1; AKwUvBxLO6v2dzRGF4hqQyiX/4aOqNnHw/TLiQbUeELkp2mJE7IHtLB+nf2tebs2WVSK9MFtn+g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz/y7wndY+dzR541sqgUpfLpN2o9C5nvXTK+ggL2jfrqdUjTdd
	lpGhse1h2WUlff2kI1eZcev1xhS2X+VzgiDIXkxTDVuIVWON6QpV87t9qdkcdFIsGMPBFhhb5k1
	8ZbBUZ354Feqe31t+SUJtJJ/kQnM/Ko7zNs3dmFiSe6fr
X-Gm-Gg: AYBFou3JaYeF/L7qf8tYlUt+C0+JYaXye59nLH+0KRpvuJVSCB7S7OdQKXr63sUt8I1
	ydJKFMYE8SsDq/TgRqt7tljgCTpF0wvbz3ytXqDMe8YMBEry0jip4E0236BN8mj043OP9AELlXN
	Z3UASTuaM3mZJS3HDmwNwL69vkBYczYN1St5a9fRfJshAjr7B5bfvH83CCcSnxHgCKxSB6oUsEv
	G399X2BFg9vj3hpEuG+V0X4GzVWnWqxwNtHPPeH3QcJrDu0hNhXyY0bmmb91MGEwo6wHXx5yNpJ
	8MgPmWuE9n4XH5E1jek56zvp9H411MCwWel7IHIlMwAuINEDpr1iWywMinHxXdltclMAIb7e10G
	mN7Nfqk2K/F0=
X-Received: by 2002:a05:6402:401b:b0:6ab:7700:9371 with SMTP id
 4fb4d7f45d1cf-6af9e322c70mr9596141a12.25.1791209820714; Mon, 05 Oct 2026
 07:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002081846.25144-1-scott@gitbutler.net> <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP2yMaKF4CRvtfTQDVe51SqEm_DnoVOmED5kcUSg7UvLkBp4Xg@mail.gmail.com> <asOa6dgpj0qV5QAU@pks.im>
In-Reply-To: <asOa6dgpj0qV5QAU@pks.im>
From: Scott Chacon <schacon@gmail.com>
Date: Mon, 5 Oct 2026 16:16:48 +0200
X-Gm-Features: AclHuK9h8puAw6d4WpfOVH0knUnkBQ1bR1O5grDUM1EuDMTGnW9ustiPf7DGeyM
Message-ID: <CAP2yMaJ+ss9M_27+kBN0q_aFUd-5GNqzQHM2orayKH+enOAG1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and tags
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Scott Chacon <scott@gitbutler.net>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Steiny,

A quick response,

On Mon, Oct 5, 2026 at 2:41=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
> The biggest problem I have is that the ecosystem has been entirely
> unwilling to do anything about the SHA-256 move before we announced that
> this is going to become mandatory. Only then were developers even able
> to convince anybody (especially those paying the wages) to get the time
> to implement support for it.

Bit of a simple question, but is it possible that this is because
nobody really finds it a concerning problem?

> So there is some kind of ossification happening in the space. But things
> are finally moving now that the due-date is drawing closer. I would be
> extremely hesitant to change course again and drop this breaking change
> now that there finally is some movement. Because the only consequence of
> that would be that the ecosystem will stop working on it again. And even
> more so, I would even expect that this will make the next time we want
> to do a breaking change exponentially harder as the lesson learned is
> that nobody needs to do anything.
>
> Maybe I'm too pessimistic about this, but I don't think so. We've been
> working on this whole transition for almost a decade by now, and only
> now where we're forcing the ecosystem to adapt are large players like
> GitHub even moving.

I want to remind everyone here quickly what "working on this whole
transition for a decade" has looked like, because this seems to be
phrased like everyone wanted this but GitHub was hesitant and pulled
into this important work only by the heroic 3.0 breaking change
decision.

GitHub has been essentially the _only one_ pushing this endeavour from
the beginning of this problem set.

If we assume Brian, Haggerty, Peff, Taylor and Derrick have been
acting on behalf of GitHub, then you Steiny, are essentially the only
major contributor to this project in the last decade that is not
GitHub/MS (Eric maybe?). Very honestly, nobody else seems to care. GH
has single handedly created this issue and then somehow simultaneously
been the blocking factor to it's rollout because it also,
simultaneously, does not really find it to be an actually important
issue. Google maybe helped design the transition plan in 2017, but
hasn't seemed to care too much since then. Nobody else has really
weighed in, at least with patches.

Scott
