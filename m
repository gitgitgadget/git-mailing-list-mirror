Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793379057;
	b=DfRIr9OB0jE3okVNmYADhRjus6cVVLS50fEl/qv7wYqz9ROJ8PpQWlnPS+f32EvAY7y5
	 Twfh8dbqp7UtipOe9tHKBrtuvme1PMt8UMduzVAA4is3OyDWugnF/uIVIoKwqO89zrZVr
	 qDh3zV7Jbn3RgXQ7xgJusZ3uNyJzxPNZXHc+Ckl6VYsvm0Z1Bbj+tg6dPSi4T0E/8p6Ac
	 Td4Wk0VlMueazkebNykfJNYHEYgAFrAi3DuWYn88qt/8Vl7QRSzl6rBCnWCfEMojNXEpH
	 A9WrnFpUTCELeHxr6pihsctbZNo1OVbAoJyGYE2rS0h+bGYeNAxcosB67oRIeBHM6hQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oRmmNFdW+hfvk1FQ9bgEVR8+/ydEZv9DTsrcl3zZZ5I=;
	b=5tJJcgNUhR/bDksyXYDuPcZ+t9klsYGiUrYnDBb96p41424GdWCHPgjL1SRuQeXsSoAV
	 C1S5SKhye8T+OGx3iQfZxf9ExQUrkY7xIO/u8nxHggnrpDxx7C41K9fupSLkNnt98Ul89
	 O6sU6XRZVRSwXZSkyVLfoUHlCjboL5WPNL+6F6kqUcqlfTS/856B/4GlnClbCzIzF3kWx
	 KAb0G4U0h4D8ThZFjTT2wXx5UXOOUaIhLKmSe8qdoy0aKOnx4AEWriI1lgBoENOhNQsSW
	 gELF1jjmChZ/oKSOn8nNU2ozV4dQIo5UcdCacxj6+QjNnxhq1hwrOix+yWpAYZLkSTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="pYR4Avu/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9845A606A31E
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 16:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9845A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pYR4Avu/
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-535f598d126so294731cf.1
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:50:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793379055; cv=none;
        d=google.com; s=arc-20260327;
        b=XJXqm0pMnlnEUA5vDpYR03wE/hNKDHyvC0XKjGt0HLwxwarWIm6M723PYedGftKDM6
         uunxN6npuiCwGL6gI33U1L+DPnZDV5Uis5pcTd1/JjY7o1b+PhuIJzifN1lfWU99Z9gC
         8sjXdXNqde6u/qoO7HrWhpI1gfRyqAwQmHP8lactwg9gmjQBVkr29Kn2EPVLI0/DXzok
         cGq6qmQxNTrgpGy0TIF9PlnJC/QGGc5UuW1DiVYBnn4NMjvwdbTJZiSOfZTqCT2jD4ec
         DEDL7szvzFcOHuu5lOrQYzl6qjyyyZK805+yD+02pl/0odM0syjJw9swBGpR1h9ykpkB
         //pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oRmmNFdW+hfvk1FQ9bgEVR8+/ydEZv9DTsrcl3zZZ5I=;
        fh=n4vyddx3movUIXA71I0nWf9z8JQOBq2jDs3+PAxHtB8=;
        b=IOwlznnVAo7VkiPue7rOX3drRvy+fWCwdMlLe+riaZg0+OMbqHLnVlpcCU9VARmj7z
         8YJfOtQ7E86uD2xAG87yzWRFX/pFSY6kGJRsPScELHcRMCDtxcdK4ZSEPnGLEqOU5XdT
         FV1xZvFiQJQCtrSHyPD9iMXCwdbApqhKyYsdIx9RnAqICyOet27IJY++yjzDd6pTnXJ9
         pCWZrQOStWsEDEfzFIk88xxo6o2kXVm0ZbmqFmi2VpY2e2R9PbF43XkVp9qBPt2Wvhfj
         7H1fsrM88JYlMCr/JHz22YxRUiyDghSDGsUjyBN4A9YR20z098gNsCv5FPNa/FWTXFts
         BYXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793379055; x=1793983855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oRmmNFdW+hfvk1FQ9bgEVR8+/ydEZv9DTsrcl3zZZ5I=;
        b=pYR4Avu/9lKAuyYF1pAoleo/SwJNihn09Tnhal6/IJdQjHyr1WjFfOQscXYJpbSd7O
         cBHIRJsLHELuuogCm61HD4ScHPimyTH8RDxYx8BwLavAdER6Hvx72YhFtP3nMICPdINR
         iU9YfO+UKqB8Y4bI09uuiF8hoD3zo1vJV2AZnd9IxLBtTOQUlYQOFHsDs3IwOfapZLmQ
         zzmoflH3SRL2GKCbvl0j9vXY+RD1RF9sH0MZnU0fN2l578MExC9yKLazmMtUQcJSYEdv
         uF1auUADayTDuUOemtEI0OZckIGp6Fh2JEIK5TfSLqLMMDMoik1+DyTW9niJD8ybaHkX
         20Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379055; x=1793983855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oRmmNFdW+hfvk1FQ9bgEVR8+/ydEZv9DTsrcl3zZZ5I=;
        b=JBCDQzHdcLlb3jRLfdlWMTO5ETuCH7Ur3NxWfa8NXR6XKRosoHS3PiQ3k/S2WH1stc
         e2Y3e5YxWYIFIk66zOcVLMKXGlHf3pO5xeguzJuK/J+vEUPuktIX+r4wnlqq9WznHHG0
         3lFiK4bficRxMp2V2DwzvfRbyaATiqZel1rW4sZnsDhF99EgNu9gdEYkOdDCjKcka+Q9
         mLjx4wfpbf4lq/0/UWnNIq+dYebYs81r2BHrPNUHpKWmVvd5YoAGYNKVBsmr0fQvuJ2p
         3Fgzbd1bzMpakETRXfK3ZOgn9ODjOBGBOAfAXBzD2ABsyWzXSnr05FAQ8rzeNJtMYiYo
         v9Ug==
X-Forwarded-Encrypted: i=1; AKwUvByxuaP5UZ9NshRNDd9hS9NeUMv93cpLZNu99bEbYZczxkOTudDcI4JWBp4HxsDmRFt4k4M=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSALZoy5QemeBcccg7XtN81nOBBg/l9Z4X7zB8g17+7KgxWvYt
	52wghRqKX8ewFoyc40Ab3nHrWbyecYewaXmx/jNLh4BWiLeeX/TgXogRuz3dbJJTet8uErHCXZZ
	5YdnAHSDEZmAikdJyBkKas1UIleQGJQ+BQF25odlk
X-Gm-Gg: AYBFou0lVHzyDuaDojuQcq+kA9gIK9HS5xmjIBqMyDZErVpJKQYkwqobApEo702wf38
	wSfqPkD89Xajrog1WbuPgxGYbQznGmAYa9guYNfm8+vEBicheABWyztOr2hidaXFEQKWcIkdec9
	nu9Ch07hWgCRXD69TVqKdKKknmp30ha7jIKKvvq+WGGaaumhiIL7BptThvMt2nWRBDh2cigVQjN
	OjHa6QPQfdK8rg874Hne8Nu550Iixtj3fZ4QRaEfHGwhmUMpgkCXGXHJgP+bFS62GP4Rfg815YR
	qPwzJ/zE+Hk2TXz4msVfPh4ZGtGLuBI77DS4+kCqO9x6ZP8IvRUrMjsDICAgkm1jmMDB3dxq+C2
	VMAmgb7YSENfsKTOEgfJ+NJigxaSyJ7v5jvbvhr1ccACgLuShjpNmEAYV8oxmqPSTh9dnoaoXMH
	g9KS52HNYbMf/Bbo2pOYPeSA==
X-Received: by 2002:a05:622a:2298:b0:536:d46:ffa7 with SMTP id
 d75a77b69052e-5414e3fe9afmr50280331cf.12.1793379054787; Fri, 30 Oct 2026
 09:50:54 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com> <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi> <20261026011731.GA3575069@coredump.intra.peff.net>
 <at8IBMQZtJP3bQ9-@pks.im>
In-Reply-To: <at8IBMQZtJP3bQ9-@pks.im>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 30 Oct 2026 09:50:41 -0700
X-Gm-Features: AclHuK_R09JzqxgqNqdZj5henm_a9oiHNmtL3dgLcM4AJRLtbYOQX0OzG_bMnbc
Message-ID: <CAJoAoZnqzKv8ocsi1a-nC6LaRnpKKCO0Bxt-Pdn0dDUziEcpAg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 12:58=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Sun, Oct 25, 2026 at 09:17:31PM -0400, Jeff King wrote:
> > On Sat, Oct 24, 2026 at 02:18:56PM +0300, Tuomas Ahola wrote:
> >
> > > Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > > [...]
> > > > I previously mentioned "topic count", but commits are far easier to
> > > > count.  So instead of requiring two topics in released versions,
> > > > perhaps requiring five commits would be easier to implement and
> > > > explain.
> > > >
> > >
> > > Quoting the summit notes:
> > >
> > > } * Emily: Have we used a voting process for something like this befo=
re?
> > > }
> > > } * Patrick: We need proposals and a vote. Who would be allowed to vo=
te?
> > > }
> > > } * Peff: Active developers with a track record; perhaps a threshold =
such
> > > }   as 50 merged patches.
> > > }
> > >
> > > So it seems that Peff's proposed threshold was substantially higher
> > > than what has been put forth in this thread.  Any comments on that?
> >
> > I'm a bit behind on the list and haven't been following this discussion
> > closely yet, but I'll just say: the number 50 was made up by me on the
> > spot. So I wouldn't read too much into it.
> >
> > But if somebody is picking a number, looking at "git shortlog -ns
> > --no-merges | sort -rn" may be interesting, just to get a sense of how
> > many people we are talking about:
> >
> >   - there are 44 people with >=3D 200 commits
> >   - there are 133 people with >=3D 50 commits
> >   - there are 439 people with >=3D 10 commits
> >   - there are 2388 people with >=3D 1 commit
> >
> > At some point it gets kind of unwieldy.
> >
> > I saw proposals elsewhere to cut it by time. I think "N commits in the
> > last M years" is awkward, because there are people who have been around
> > for a long time with steady but slow participation steady-but-slow
> > participation. But if you just intersect "N commits over all time" and
> > "has _any_ commits in the last M years", then you can get a table like:
> >
> > total    | Active in the last N years
> > commits  |  N=3D1    N=3D2    N=3D3    N=3D5
> > ----------------------------------------------------
> >     200  |   17     22     24     30
> >      50  |   34     47     56     67
> >      10  |   71    104    124    155
> >       1  |  239    357    457    628
> >
> > Those aren't necessarily perfect metrics, but if we consider them good
> > enough and just want to tune the parameters, we could probably pick a
> > spot in the table that has about the number of votes we'd want to deal
> > with.
>
> That sounds very reasonable to me. Though I have to say that we
> shouldn't only consider "the number of votes we'd want to deal with",
> but also the shape of the voting population that we want to see.

I agree with this point - I don't think that the number of votes is
particularly salient, because I assume that any of the vote platforms
we would choose can handle a much larger audience than ~600 people. I
think none of these solutions require us to manually email every voter
or to manually count the results from each.

>
> I think it's fair to say that everyone has a single vote to cast no
> matter their seniority so that the vote doesn't get overly skewed
> towards the opinion of long-term contributors, as those tend to be
> employed to work on Git. But the other side of the coin is that the vote
> would get overly skewed towards newcomers in case we set the total
> commit bar too low. So picking the right spot in the table would
> essentially be balancing out the interests of oldtimers versus
> newcomers.

Right - Junio mentioned in <xmqqv76taubb.fsf@gitster.g> that being too
picky about the time the contribution was made can eventually make the
vote somewhat equivalent to a weighted vote based on total number of
contributions anyways.

Junio also posted in <xmqq4iedc99a.fsf@gitster.g> - do you really care
about the policy of a project you don't contribute to anymore? And I
think that answer would depend. If I think of a project that I used to
serve as a subsystem maintainer of, and I receive a voting link for
that project, and I see that one of the proposals in that vote would
substantially harm the people I worked with for multiple years and
still presumably care for the well-being of, I would probably want to
vote on it. If I think of a project I left a drive-by commit on, I
would probably abstain, especially if in order to vote I would need to
read five long complex proposals for alternative policies ;) So I
think it really depends. For example, I could think of a few previous
very active contributors on the Git project who I would still want to
collect opinions from even though they haven't been active in years.

I mentioned this in another thread as well, but for full transparency,
I'm feeling a little bias here because I haven't had the capacity to
make meaningful code contributions to the Git project in quite a few
years now due to my role at Google. But I still consider myself a
community member and would very much like to vote in this particular
policy decision. On the other hand, if the eligibility rules we settle
on mean I can't, I understand and accept that as well.

 - Emily

>
> How exactly we want to balance that is a different question. I am of
> course heavily biased as an oldtimer and would thus think that 10
> commits is a rather low bar. So from that table I myself would probably
> pick 50 with N=3D2 or N=3D3, but maybe a commit count of 25 or 30 would b=
e
> more reasonable as a middle ground.
>
> In any case, there is no "correct" value anyway.
>
> Patrick
