Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793285475;
	b=UgJVZiVE8iJGbM9QFfkqvTidlw737rG0we7k18MVvaTvAeu8segiidqZJIcJjNA0BudO
	 9wsG8kYab3fkHYekksNg25Aqlr8irwH6bLelK6eVBRYYvjfEhMkuiyiMis9vvZhAClb1x
	 tSID88YXDksf2lhajT99HoGnLTY+B5WT+uUYIbsLELQ8xkul7rtUjyDFJSY4N630I81Fb
	 d0+JwiLQ1uuEm514wDOKklhJX986OJSO+8cTgMxxLhG6UAwGTH/ksPidlL0xcIID1vkP7
	 vzcLdECztTI26CdtjSvrTT7sILZBTMFnBIfpyCREl0DyiwAnbc56N+mtRlWyv05LX7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mx5tFBiA3dO05v8gbjBVbfpQN2adnvaKmKRs8GJSkzQ=;
	b=OtDXMm2gLQsVvEQmUrnUghZS1jGesGr9EShCATk94rGgRKol/ffl/SBvWe2Nby454GL2
	 agaW1jZsPlGRoHMRVEWFejfIidLNFVYb2NaA582n6cJuEISya2axhB+9vv4kTFbBhwOpb
	 J+Jmyzv42naQbEhxvdnuwLX6KLlWmdGvE0UmgyhOzGsvBxNClL210qIG7uqyU+qLWPPN+
	 gyD/oT+ZYTIlid97oNBop8vTgl8I5Gw4KE0gviFNQB0axVOaTE8NY6sBbO6uxsnObKmtp
	 zPdn+A8M99OAcp1k7TUuxMMRzf4SCJ3JptuBAoFq4DHS3Xj7/KU6Krsw/jl/D8lxFyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qsc9iipr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFA606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4EFA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qsc9iipr
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so3498289a12.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 07:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793285473; cv=none;
        d=google.com; s=arc-20260327;
        b=jAI4fbpNGPh19YXA9ZIVXDlMSMMPVB1/YR2xasxO1xp7WrbY44ZzTa39Q/WG2xtTJu
         xlN55FsOUS+T3R+TTyS7u2MjKy/hzvUmxsKdolx63ali57JGaeIhWEoer/bE4GwHtlY2
         JxAzm9ZW03dpUzdhnHdO0zFsIFEDIx/KQNUumVJXrDCJkg3lvtqgREgGUIxFMUsvEj1L
         YxUfigfDt8BvKh9yVyqlTogqwTgHF6N35zHGaYXLwOps/Hk+o+pN8tV5EKOt17jUm4nC
         gkA6vplbShEeqvLLZgtFmsZ3eYX1M0oIDyPi+Rl/ya1UTS4nswiY1Ffq1YQTICsGvgUY
         l4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mx5tFBiA3dO05v8gbjBVbfpQN2adnvaKmKRs8GJSkzQ=;
        fh=lkbOC9JB6vrBhUIr5VdTVSM5soOpx4hwYHRkxVuu9TE=;
        b=PRHL+8LA0eBaVetOjdpYPfUt+wFapPaWaelnXjZNLiSz1hJNJC6IiS/9oT7oEBnpSl
         aBa5Pa64gJ8UOCNRhBJiEcv5ffODf8sdKZRPEZXuGdtpD0M94d6AG6BPYQl3wcA6WTf/
         2hvSVAGJNK7kDPzgM7BqWqw1s6yin149AlhIlC+v1B+XoR2C5+Fbb5iFP7Fn3nSxHx1w
         wGqQ9PrnbYv3353G+thO+MMisFhz696jlfYBNKy5LvXYNfglbesqMRXn85/LTR3wymoR
         +jGr69nkQn5IAaV/9C2XyN/r1EA7znT1Jwiw8D7vaqQYSs8utA8Rtp5yJ3EVvl69bbg0
         JKdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793285473; x=1793890273; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mx5tFBiA3dO05v8gbjBVbfpQN2adnvaKmKRs8GJSkzQ=;
        b=Qsc9iipr40XyQm0r4Faq+yx3HnCZBrcpMpmLe1bn58EBAUejMRTydtzRX01nk5F/yB
         85gYd5xNtwBtI01iaRjQqQVnCWD/+9UvR9RPg7mik846pvC49ca83CeK03rvnxwT8arN
         d0JEdVgqvGyGt+cc8mW+OcQ0U03BjO4Py7dkD5fxZMQW//XWX/a145Zqqo46vxYujr+w
         vVeEckl/kb1/Thi7jO/yX1w80ySCuuq2ynrTQFrgxdc5O2hsQyUA2Y5rwBuHMWyAbQ9o
         Ja415gf+OeG4lIzGS/jiK+8jVrmXChnnriIWH7HX1mt4FL6sS5ue1QUicI3h/jKz+U5S
         FIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285473; x=1793890273;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mx5tFBiA3dO05v8gbjBVbfpQN2adnvaKmKRs8GJSkzQ=;
        b=Fd7zzDh6yiqGJIdRcTFTf7DupCWSiaIHsv2cgEa776hBJRR7z5XvmtyaM6852M5hQC
         xTpsrHbv8H1+qoQoNSCJJVcA/pHqc4HoY4289Z4pTexTF44Il/oj07DC4LwC++8lXFuZ
         Ys/YxVUgo+wa0kFjM6DKs0CI+A52Ip42GOj78vWYbsHiwtQseOvFGDZwKTqbIadPGi5v
         58sjYfvneNzprFZrwX9Wk0ymRQfYqB4Ows7DRZu3ze1f0iN2uSTWIbEgVNFgDfpfu/2/
         SkaEDtqB35WsCbhDAHwPswvWIiD6NnHgLHySQKSmifOySNW97Dc3/Qh46H/X68g9otgA
         AvyQ==
X-Forwarded-Encrypted: i=1; AKwUvByA7Zg8KDunas27sseEHq3swEUiri10pvu+eYP+CXfhaXs1Fsw2dRxobAFu/sSqycmyMzM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9m+D/HhOrBb5CxbvFHe0+BAmNzGXa75iZUYMmRG3cL0sO5/HQ
	pgm0hbbgG7nmAME9alc+TML/YQeyAl0PuDsrKLVzVSLk9utUwFc3EIZJyJK2plc6ctWQz0Mhw8O
	6rNTeQH2hipOaSQdZ8l4Qqb38Unm1fWVST3pERuA=
X-Gm-Gg: AYBFou1scIKTObNTiQrz5pU8k4R7lESs98BfDpUm7MgR56i7JFrXwKmJyCoNy8B1iUH
	kW/tXFSAixv65Lv+Z7XiZVJUaig7qGlhynZ9Z8bJSmHX0phnhMon14VS/F3cg+E6ValO27k3qgq
	Cl/enY/6RRZ/mW78BqiqSjA4CKUZ67gNsypAP7x9kkz3hJamcxHtx4OWrmVAqT9N8T+SOAx/7Y7
	nvQ8aRIKiz6W1904YfwbcNN9lQQvSOrXQDefcxCkhv+ihWKXsr9UIBNThPGNBYggRDWaanwR+AL
	6vvWOJ2aHvHFMyUqcwRXAw8EEpBIk3B6gVXg8abWl2r8Pv8CclcV8qxgBCsafaWx7TKpdjGuSIk
	o08wOk0Boje2Or329IWHZ7uz0/oab2gWIngbx5Z9iSoh3EcsK1NNNBlRgMb54sGIQ4VObp6g=
X-Received: by 2002:a05:6402:b8a:b0:6b4:95cf:24f with SMTP id
 4fb4d7f45d1cf-6b49cbebcb8mr2932727a12.19.1793285473135; Thu, 29 Oct 2026
 07:51:13 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <e6af5d1e-4ca1-48a5-8a84-5e0cefbdbc2b@gmail.com> <E50044F1-41F6-4FD8-9A22-A43FF36932F2@gmail.com>
In-Reply-To: <E50044F1-41F6-4FD8-9A22-A43FF36932F2@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 29 Oct 2026 16:50:36 +0200
X-Gm-Features: AclHuK_H22sZD8Alm5hLcXid7dmyheDVtq25U7KYW-QQcxvfo3qex98Xu7vI7a8
Message-ID: <CAHwyqnU7apDDjR2WprKu_Hf9eUD_GM+yfmY=VBFJW5XKKpYHhg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Ben Knoble <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 4:30=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
>
>
> > Le 26 oct. 2026 =C3=A0 05:44, Phillip Wood <phillip.wood123@gmail.com> =
a =C3=A9crit :
> >
> > =EF=BB=BFHi Harald
> >
> >> On 20/10/2026 14:42, Harald Nordgren via GitGitGadget wrote:
> >> From: Harald Nordgren <haraldnordgren@gmail.com>
> >> Add a per-remote config variable, remote.<name>.refmap, that provides
> >> the default value for --refmap the same way remote.<name>.fetch
> >> already provides the default refspecs to fetch.
> >
> > The second half of this sentence seems redundant to me. Can we please c=
all the new config setting "remote.<name>.fetchRefmap" so that it is clear =
it applies to fetches. That would also allow us to add a matching "remote.<=
name>.pushRefmap" in the future to map the refnames of refs that are pushed=
 without setting up a default set of refs to push.
>
> Yes, I would love to add pushRefmap atop later! It would
> ease my working with notes, I think.
>
> I=E2=80=99m on mobile now, but if I remember I=E2=80=99ll try to spell ou=
t what I mean
> more concretely. Thanks for the reminder!

It has already been renamed to fetchRefmap in v12.


Harald
