Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794387838;
	b=zKp8a73bYn+MUYDbox/F3sEBIi4ptegjPukz4C/96D2o2Lsx9nFlAJbfi8uxJniPkMB/
	 W9RUiIy0J5y9Ague2dZsqoxF7jpN31awiIe0S5fiKWNwTAg6zHnc9jBBNiC5/T+X5iRYm
	 6xZCaLgowGkN8nl6c8BMh+bc9aWuoIKLoR91RoPKoCptOHdTXUR7M7LgM145mXuSGshXU
	 7o3AcLHgCUoudnrDBtPBJaLT07O7L9zTDuI7MZBWdbOk7P2PArL5uE2POWcZ3pDm2j1GT
	 KG7GsWIWFzoQMBwjaFuDeI38a5m57YWtOkQMlS0pKom3rWhoJ8e+sCegxX5puRpMszQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=yUfN3pE1OIxTLeeEaMLNSirmUUykODoDJ0MvkCoor2Q=;
	b=dmK26pwln91R5qeBDGyG4Jpy+LUisvDZoVOSElo8Zc+X0z++P8tGJ2KA4eDs5hhakYSs
	 SyqYp1Kjf7QNnx7hUjgc7gb/mvlTyIPyjVvJGRXn9r+6P5+LCFE4joJaziNnXYoMQzxvu
	 wpfiyW5q/ghn/okMcK2/MSqrLE0wgQrmKUtx05L8CBCORXm4AuXSQSmq65tCJsj3drUFH
	 vF6vf6WFOo0vcj/qnSFsFrD5Dir/XMot4QY3fnh6CyAe7oEKg7qIjMM8xYIayfPTTFQvl
	 k2X2jsX1vHlFiNNb+VOBudWk7rYziHo8kZNiyde93XxwWHMHhRdTg3W9mgciqxuddjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0o0CxwC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7110606A323
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 09:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7110606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W0o0CxwC
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8451a619da7so1817948a34.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 01:03:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794387836; cv=none;
        d=google.com; s=arc-20260327;
        b=TaNmkdKB5l/vqO7dThsoWwBzBTe2B7DtI7V9VmMT1tVNf5vr8b0wI945MuUfXOCACK
         nWKsvlMo6XmOFRpZXdSi8bDpoK1ZGd0Q8wrmqvG9+vZm2YxZYlxFMIP7usaM72KdBfi/
         HvNeMRJTlgdxW+pXKyQ0ETNRzpK0N5uXiPJESR7HPk4gsthC0cFgnjRYjjaMMueQtEoM
         2yDwe4edjeZJzyMm2fqbdNxHN2PXqMd3LmIdb/lxmMMH5rfuEvatn6oad2VN6p5Xiluu
         VFGw/xV8q1ubF183oLUaD7pwvczYC6YX+7Us0OSpEm3RN1Nu1BNZDmddcabxOn8c4QrN
         QDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yUfN3pE1OIxTLeeEaMLNSirmUUykODoDJ0MvkCoor2Q=;
        fh=3mzlwYPDJ/lBSmOWAxWkzd+VkdWK33pRUzGZ6WiHMQI=;
        b=dEifA2F5JokXFjlUcNKaGwssWPPPinLb1mg14uupAb1FogCyRKfabcXrPDMMHXHHUf
         VDjpqcrx8Vqtx0DsHr5X4YL8ZQHo+67iMS2Hu88CDe1tEs/QJGIVbNzhF8kncA3nrY/m
         2JcUWYhcwfv570SqlNRuDKW0UY4ECXkxzdQo8Xiy2iVXx+9o3SIVmPaMZ7N0S42OGwri
         Mgr0nw3hrBYtOrGqqU7LDnmNSch3Piu+j1V3pgr24bQ+rd6M3HQM7Jej8N7PhLtnFs2+
         yuCzuCvtbQ5tVoQkgjPcJ59xer+Hs49PzJHrXjhf47Oj02zud3v6VPd8EMCX6vLZx3Op
         xyiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794387836; x=1794992636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yUfN3pE1OIxTLeeEaMLNSirmUUykODoDJ0MvkCoor2Q=;
        b=W0o0CxwCvNXTAmU3Tf2+Saac68HBYUPUzxaFxmaGSHS9PoPjtJv5lWWRhMJ9QVHxpS
         /U4NVjyvlmOSqTLzakgdP05jSwH7smTY16enJEt/FE9aAbcuDv1hfn1CnqyrT9coFpCg
         s/po+SQbJMiP3lArNDxJxUnU8uiFeV97YqqIk1+IZ3pGQZz1TeAvuUoQAYJRUY/ZPJqX
         1aZzrP/PBIhU997Bo2BBcmn47pmWHoZSwexND70NlHmM5dW6rY4FEI4hH4ZQGcmdz1wO
         ulom3ouVHOqTr89lbVGOsMEKJbgsYg6wd1OEJHrUkCu30Gq2B61eF2JaBNeXaPEzGFo5
         pAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794387836; x=1794992636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yUfN3pE1OIxTLeeEaMLNSirmUUykODoDJ0MvkCoor2Q=;
        b=ukgtQAUG5qcHM6mKJ02qkhZja3DeKX6HV63P5E1fMVeAsSsnS8WcjvtTvgowYGtXuy
         l+SuOJghUwNQdm3u6Dvdra8qDV0QGTNK2Hw4B8awURzmTW85ugrrV36d7OimcJba/3Yc
         JllVWRZZTeK6zmcMozvzffKpOI+QvPp1aagLLv17FuFZGRAdVB+G3nmAKPxaTiCFORSd
         MK3CtZxKk/NhcGwMeYiRrHqRC/b11sT2PzXzxGkOOyrMDMT54j7IDfG0kwF1GLcd08B9
         txvA6a/vmktHLRLFQjiAvGsL695xrl34FOo6djYkw51mvJZq8SGY3VYZsch5hhultOEX
         m3nA==
X-Gm-Message-State: APuU4Z9uNH9KIc8gHtlIsn/ltJFEoHPHFZRJ9BHj+whDcG0RhjeGHwu1
	jzJwH081t+dRhHj7yKRon07J7kNflBpMb7iDqHesGm7nJdQ/tha1rI40qsAob70+kiuDFi4ARu1
	QKZBrbZAkrnmuA8GK2b3lGL0iTUCpPOhKcg==
X-Gm-Gg: AYBFou0u8T5/y0GRH2i2oI9VLUjf9WYaGtrt1xgXmOu1WWaUzEl7MKN8S76VmoWxEIR
	UJ9BRPjFeymhe1s6zQNQOMklOpQDtHnMbTasD80LHgKFWk7FRDEzdEfafMtfKkxFGZ+25dCPxWc
	8hCe8/HYEv7ohyfYXpkNbWHIug6J1bFcOaMirfTBNV3xBCtm23rfwcY6gTrXlTZIdFWMa4aTvl+
	KAK/vDftNbIhszdNTo3HnsFe8eCYkrcIlza/vrocncquhXxAgUvjusyX3HvxsDdTVfjftuu7Wmo
	3E4fjLQeLMIxv5EbS7bZ4V/y2DvUWiYSRwhkDVKrISw71TTzlUw+dnLjZnYp7EUluHYCbQfibJa
	cirnoZuc4AveSy7Z4c82qLS6hdPPQKqinhCqFVLqAtMSeG69+cJxIJhyJ7BOlmdh05xSyY1inIZ
	k7qdWuQp8Ioar3zRt2PECjGjNCgOsS1lZX6o8TkA22AXnMXgl4CrBxPGs=
X-Received: by 2002:a05:6808:4fe3:b0:4fb:90ae:2b0c with SMTP id
 5614622812f47-56b9822dabbmr1686008b6e.68.1794387836330; Wed, 11 Nov 2026
 01:03:56 -0800 (PST)
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
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
 <9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com> <CA+rGoLef6b35hjJAcO5Nm57NiyDGK-iDbWO2MUMeoKVCkbRf5A@mail.gmail.com>
 <f7489c12-8529-4d0b-b820-225c9ee4d297@gmail.com>
In-Reply-To: <f7489c12-8529-4d0b-b820-225c9ee4d297@gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 11 Nov 2026 14:33:45 +0530
X-Gm-Features: AclHuK9_w0JSrb9HRuZ1BR0gRSdG8ItdIxW-EhrkMZKBCmgwq1bexwPc0V_jFCA
Message-ID: <CA+rGoLc0Mc82fTL85t6BRcGUJ8+S6cFfu0kzpxqUyjyShQW7UA@mail.gmail.com>
Subject: Re: [GSoC Patch v8 0/7] repo: add path keys to repo info
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 8:10=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 09/11/2026 16:52, K Jayatheerth wrote:
> > On Sun, Nov 8, 2026 at 1:27=E2=80=AFAM Phillip Wood <phillip.wood123@gm=
ail.com> wrote:
> >>>
> >>> The path keys added in this series are:
> >>>     - `path.toplevel.absolute` / `path.toplevel.relative`: The root d=
irectory
> >>>       of the working tree (or an empty string in bare repositories).
> >>
> >> In our documentation and glossary, we call this directory the "working
> >> tree" so I think "path.working-tree.*" would be a better name, rather
> >> than copying the name from the equivalent rev-parse option.
> >>
> >>>     - `path.superproject-root.absolute` / `path.superproject-root.rel=
ative`:
> >>>       The root of the superproject when inside a submodule.
> >>
> >> Personally, I'd prefer "path.superproject-working-tree.*" here, though=
 I
> >> see Justin thought that was a bit of a mouthful. As this command is fo=
r
> >> use in scripts I'd rather have a descriptive name.
> >>
> >
> > I don't have an opinion on the name itself, but, that said:
> > I think superproject-working-tree is a more suiting name.
> > It is becuase you may have a working tree in a different place and it
> > might not be the root itself.
> > I think the same logic applies for toplevel too.
> >
> > Any more thoughts from Justin, Lucas, Junio or any other reviewer
> > would be better I reckon.
>
> Yes, that would be helpful
>
> >>>     - `path.hooks.absolute` / `path.hooks.relative`: The repository's=
 hooks
> >>>       directory (respecting `core.hooksPath`, including `/dev/null`).
> >>
> >> Given we have config based hooks now, do we really want to add this?
> >> Scripts that want to run hooks should be using "git hook run" and
> >> scripts that want to install hooks should be using the config based
> >> hooks so that they co-exist with the user's existing hooks.
> >>
> >
> > I believe that is a fair point for new tooling, though wouldn't many
> > existing scripts
> > and third-party tools still learn about hooks directly via `git
> > rev-parse --git-path hooks`?
> >
> > Since the main goal of `git repo info` is to provide an alternative
> > to `rev-parse`'s various path flags, `path.hooks` still seems useful fo=
r scripts
> > migrating over, unless the consensus is to deprecate querying the hooks
> > directory altogether.
>
> Isn't the goal to provide a better interface than rev-parse, rather than
> just porting the various path related options across unchanged? My worry
> is that by adding "path.hooks.*" we're encouraging people to use an
> outdated interface that ignores the existence of config based hooks.
> Anyone who wants to keep using "git rev-parse --git-path hooks" can do
> so, but I'd rather we didn't encourage that pattern by supporting it in
> new commands.

Well, rev-parse is one way people can use it to access, so sure, I
will drop this patch.

> >>>     - `path.cdup`: The relative path from the current directory up to=
 the
> >>>       worktree root.
> >>
> >> How does this differ from path.working-tree.relative? I've never reall=
y
> >> understood "git rev-parse --cdup" - if you're in the repository root
> >> directory, 'cd "$(git rev-parse --cdup)"' dumps you in your home
> >> directory which has always seemed a bit surprising to me.
> >>
> >
> > Well looking at the code itself
> > What I can say is I find couple of edge cases,
> >
> > The cdup command relies on a slash counting loop on the prefix string
> > to output directory-up
> > sequences like '../', returns an empty string at the root and falls
> > back to the worktree path when outside.
> >
> > On the contrary, relative formatting uses Git's path utility library
> > to compute true relative
> > filesystem paths, outputting '.' at the root instead of leaving it blan=
k.
>
> Right - but what practical benefit does "path.cdup" offer over
> "path.working-tree.relative"? "git rev-parse --cdup" was added in
> 5f94c730f3 (rev-parse: --show-cdup, 2005-12-22), four years before
> "--show-toplevel" in 7cceca5ccc (Add 'git rev-parse --show-toplevel'
> option., 2010-01-12) and 15 years before support for relative paths in
> fac60b8925 (rev-parse: add option for absolute or relative path
> formatting, 2020-12-13). So when it was added "--cdup" was the only way
> to find the root of the repository working tree, which is not the case no=
w.
>

Well, you are right, it adds nothing new per se.
I was replicating rev-parse without any benefit in both these cases.

Same logic applies, I will drop both these patches.

> Thanks
>
> Phillip
>

Thanks for the review Phillip!

Regards,
- K Jayatheerth
