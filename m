Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794243166;
	b=z7m5hdEL3LANDvE60kf7LOl0YuRH6YuEwaVL5QMpbXpD2AOQJx4kha5aCx7D6xGxxQlO
	 0PenM+N9ItbyPxZDDSorytua+MqJEsXk0uJrunGcAg7xxaNU2R48UUv02W/62MFKxVN3i
	 ov711zbI/Woq6aFt+v33zMpYgio8ACyYYu4crMFvJWxLqQo9RfQ+QqETbT/vtabzjdCXk
	 hFCtBWtsAm2yoi5yriJJsTYMsTkNhDkbR8YPb4JpSXJT+6yLmVqyPxJSQv5M/7eXnwi9s
	 ynWE4Xz8b7gHvm5jM9XIFFLNbMrckRLLW/6IYWxf2NnGVwQbot7l8uwarGVyXLrcOUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6uUERr27QQZKN8Wc11DLfyY/sZuiWSrqV1GN7wVbBjQ=;
	b=gr24mDeHLUzwA0XJbpny7PX/T4Zx/zeRqs5t9cDqHuQdgKnxYCR2mKWSog/759pQz5Jy
	 JTCWuM4MkZwO62IzD1qz9pCstjgjG14rXBecLtj0AM9dL4WwGjM/gsw/TckwfDOfzwIPd
	 eVqVTr3N/IV/bIdoDRAvd4x/gsOgWJXEnG37g1iWMn9yJ1MFpEiw10OeCTZwtbiHygU+1
	 A1QnDztOIdyD6DSIIDm811eS6gZYLLcTVKVQuGKjrCxWG1ivKedzfiq15MdtGE6ZSndD3
	 2pLVuV5hZ6O25Fc9kGmLKf0TfSRl08fMVkmiRgC4RzokxjSrPJ7KkHP9hQX5JyKwZPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="z79/NQXJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D5A60A6F45
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 16:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D5A60A6F45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z79/NQXJ
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-84d5e56f876so664179a34.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 08:52:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794243165; cv=none;
        d=google.com; s=arc-20260327;
        b=Hj6csgSfacizyCP/oCzo25GHuusiBhtrVANQnHT/ANqDGm8V9pO3GTnsFoLYE9CkgG
         l1gzmgjB2MZCpEngVlnZg5BI5/6HuBIBW44w9mDAfuNoN+Qak4N9xz+IOzU3A2sMUANf
         oCZckzMXF/DipQ2tnuO4zDkqOlWjm0C4rbDDTWdPCrl/MbWznaHQupvkI4xCs3Ybz2QX
         GMX0dOS48SjpZYX1jCmUZbwt7IiLEcc9H9097Wd7KP8WCwXgb+mbc9oipEeg0LUz4/Ve
         yGu8RBSh5bHVa6bKEFfpurOgcfaDV/XPq3RTCg5TTBS2IRUN1g9CQ0Sx3aylfEkTNVlJ
         v2LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6uUERr27QQZKN8Wc11DLfyY/sZuiWSrqV1GN7wVbBjQ=;
        fh=3mzlwYPDJ/lBSmOWAxWkzd+VkdWK33pRUzGZ6WiHMQI=;
        b=i/H9cJ61DtoK2+Wz/BvYolDI/S0iN20iooe12t/X8Qj+os1DhwAaC7S/VsP2mAvQy1
         BBKSzde4jyy6xtFDAoIaI38jzuGFgFEE8KbRwXHsABrdgSsbOjX2ro610USv4d8lZ+5r
         +7WjGQZGpIoRipM93YEV8gSd/MQa6l1FuR1Z9NNekE8Y391Bh6KJBMqhw62QHUl80gkB
         O1WUfx7WPLCPWzvWRxCIvOLkDQHeLumURMzu4eEL/EhvLGfqPUG9r8E7jb0hFfHSoSmv
         qzLZGDgpEeAH/4JHX5xR6PbWSugc287p9zxBv4yID4jIW5Vln6P3Ol09lfY13dpG/l2N
         2vBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243165; x=1794847965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6uUERr27QQZKN8Wc11DLfyY/sZuiWSrqV1GN7wVbBjQ=;
        b=z79/NQXJxAB7xX4n4sLg1IVR3R93WaerUpLKOzC+i5UU5q1PrWXdrrQXb8IkBHhogw
         tGn8uYoRSZQAl9K9P/7gafacSdrO8k8rvK1LMQTMIjzPDUsAgzn8sFwa5Mh6RqSEOhh5
         TAO3g8M4+DubbGmV0zfkCF/wVJBv1b8sM+/jGsrfaEOc1iH53KqC9bVTZforg96YtgQq
         mb/cgJL0BWmvRvxoDHd2xSst+bisml8lCrdEW8yCxelAK8iEvTBrR/y9VWtkpJtrbzBP
         8Llfb1gg+g8lMuGCCjttqEX4RAejS5qUiILXDEBcVMTvm7H6rcSxj9ASG+iDa5Qs4wMI
         6d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243165; x=1794847965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6uUERr27QQZKN8Wc11DLfyY/sZuiWSrqV1GN7wVbBjQ=;
        b=2VZy9oXGabFLg1/7Vf1aTRCWcU4ahv4B0FKM/n9cRHbishXyOofRdCpo9VieNfTCJB
         C9jjIp6UOJcCXx+5UmYK0q3TSiyGAGjoL/qItTgWJR/pEWnm7KpRPIYwkNatGZ79ktd2
         ziDkz+muSMmiTSJftPxVeOP/gvCF/58T9n/ONpS0smZKMiB32Y7RoW10jKnjhvq0FwL4
         zBkgwHOPHOMUrGRhiDlcLuRO6n60kaVzvJbl+kKhDhs5EPelW+gY2E9eb07jjvHj2DU1
         6nDw42j4zotbRp5eGW4cpt9Z8rIArvsCPPn7ncZfQXAPxrTKbKlr8eXYuSiGdRp9jMaU
         cZCg==
X-Gm-Message-State: APuU4Z/lm+tCFktM2cTC1JOn3yYb+oAqy5m0CTJu0pKw8dC2WUvoGmGX
	Kd0ITmgenCP8pdnRqyqrCElmLKGMy1uJDpnOQ+XNuGQwHj8zkryJvELyCHehdbsy9/iPFbovA8+
	9Tusiy7Pjd2OuSt3/c7nfefWUQjU73M0=
X-Gm-Gg: AYBFou19oJKcUxFD67F2yhRtgFHMBIt+xEUJJL4H9FtoUVd2mZnyVnWc7VgdUdpqRiY
	+euLGxEwN7LVf/vaMXhm7m+39K5FzrZEHGTjauS7TKlEUEaUToqqKuuo2z/dVeema/N1fI+KJaD
	pqCsmY8nLinkDFRkPj9szCMrkKMbk6ZXPZg2FXCjLDz/1qdeAObehDkl9k29+2cyOPr9BrsOtMk
	PQSdPDNgh2bFL+DhQFxt1b0qR2BuHFXVJbi8hU9uaFnZCeZDkdZsnhAHIPMWhxOhlOZKQOmzLEE
	z50n7GiE2Pr7icHL7yEsk/4UHBQHZ4ZAwVPtjJoWK14MII0tManoYliloV7rRhfnL7e8YMx5vnJ
	Oxuy5hx3C8+6SZaiTYJOpwGyeH9VfAEySELQD142o/fCA07Qdr57DJa+hN88uQyVSnuegqlz0Nl
	ATBHESOrK0Atujw3Ux9FL4WQy7nuFRLr788afarK+7mLTBsQj2pfKlEoTkDyFPW/J6vBCEr8Jxh
	Fkx
X-Received: by 2002:a05:6808:c235:b0:55c:856:8216 with SMTP id
 5614622812f47-5683ccd57c2mr134978b6e.37.1794243165253; Mon, 09 Nov 2026
 08:52:45 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com> <9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com>
In-Reply-To: <9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 9 Nov 2026 22:22:33 +0530
X-Gm-Features: AclHuK_1cuRl3IMx2x0fmJjQKlNkRlYcHRJOAQb4Galui7x6JBdsFb42T-z6uuA
Message-ID: <CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
Subject: Re: [GSoC Patch v8 0/7] repo: add path keys to repo info
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Phillip,

On Sun, Nov 8, 2026 at 1:27=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> On 07/11/2026 16:00, K Jayatheerth wrote:
>
> I'm a bit late to the party, I like the idea of adding some more paths
> to "git repo", but I have a few comments about the design of this series.
>
> > This patch series continues the work to expose repository paths and
> > metadata via the `git repo info` command. It introduces several keys fo=
r
> > querying repository paths in standard absolute and relative formats, as=
 well
> > as refactoring `get_superproject_working_tree()` to operate on a `struc=
t
> > repository *`.
> >
> > The path keys added in this series are:
> >    - `path.toplevel.absolute` / `path.toplevel.relative`: The root dire=
ctory
> >      of the working tree (or an empty string in bare repositories).
>
> In our documentation and glossary, we call this directory the "working
> tree" so I think "path.working-tree.*" would be a better name, rather
> than copying the name from the equivalent rev-parse option.
>
> >    - `path.superproject-root.absolute` / `path.superproject-root.relati=
ve`:
> >      The root of the superproject when inside a submodule.
>
> Personally, I'd prefer "path.superproject-working-tree.*" here, though I
> see Justin thought that was a bit of a mouthful. As this command is for
> use in scripts I'd rather have a descriptive name.
>

I don't have an opinion on the name itself, but, that said:
I think superproject-working-tree is a more suiting name.
It is becuase you may have a working tree in a different place and it
might not be the root itself.
I think the same logic applies for toplevel too.

Any more thoughts from Justin, Lucas, Junio or any other reviewer
would be better I reckon.

> >    - `path.hooks.absolute` / `path.hooks.relative`: The repository's ho=
oks
> >      directory (respecting `core.hooksPath`, including `/dev/null`).
>
> Given we have config based hooks now, do we really want to add this?
> Scripts that want to run hooks should be using "git hook run" and
> scripts that want to install hooks should be using the config based
> hooks so that they co-exist with the user's existing hooks.
>

I believe that is a fair point for new tooling, though wouldn't many
existing scripts
and third-party tools still learn about hooks directly via `git
rev-parse --git-path hooks`?

Since the main goal of `git repo info` is to provide an alternative
to `rev-parse`'s various path flags, `path.hooks` still seems useful for sc=
ripts
migrating over, unless the consensus is to deprecate querying the hooks
directory altogether.

> >    - `path.index.absolute` / `path.index.relative`: The repository's ac=
tive
> >      index file.
> >    - `path.git-prefix`: The prefix from the worktree root to the curren=
t
> >      working directory.
>
> The "git-" prefix seems a bit odd to me, maybe "path.prefix" would be a
> better name for an option that returns the prefix to add to paths?
>

Agreed, I would change this in the next patch series.

> >    - `path.cdup`: The relative path from the current directory up to th=
e
> >      worktree root.
>
> How does this differ from path.working-tree.relative? I've never really
> understood "git rev-parse --cdup" - if you're in the repository root
> directory, 'cd "$(git rev-parse --cdup)"' dumps you in your home
> directory which has always seemed a bit surprising to me.
>

Well looking at the code itself
What I can say is I find couple of edge cases,

The cdup command relies on a slash counting loop on the prefix string
to output directory-up
sequences like '../', returns an empty string at the root and falls
back to the worktree path when outside.

On the contrary, relative formatting uses Git's path utility library
to compute true relative
filesystem paths, outputting '.' at the root instead of leaving it blank.

> One note on the tests - our test suite is quite slow, so it would be
> good to avoid initializing new repositories for each test where we are
> checking these paths.
>

Alright, I will look into them and see how I can optimize them.

> Thanks
>
> Phillip
>
[snip]

Thank you,
- K Jayatheerth
