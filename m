Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B12F691E
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764715469; cv=none; b=CiR7EUXoCog9D0iZR4yCMm2r5G0b5CagUpD44TFzC3I7J8qHWUC4K0PKij4bNvY1N8LUb5qS0m9MJ+pAYSNG7iROn3ObogOxkTVN1TfaM8pz6tXMjpOnW5PaCq8CElv/aOZRhjSXr+YeEmNx6wf9s60YhfxB/Dg8vObKjs9RYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764715469; c=relaxed/simple;
	bh=Oc3/lzk77UV9LHY7OohrRkIm82BP9sMvGSqMnzzgnpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvM6Nv3mYawKRM/OjYw+HXGNvicdQAd6Qqo/i0fPeRkiV2TsRpDBvyDWB7Ai9QLh4DHMw2ZPXo6xjem0mCUpue7azCNj+L6zmB8Cl582cMplPjbLo6VzEQ2wB5M4LWi2FjPeu8K1jY0d6XVr/ZCvvhKll/mGWs5bV33duNtgk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh0HX/uT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh0HX/uT"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso5185199a91.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 14:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764715467; x=1765320267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRZOYga+UclKyv22PKImwejVNWT5pimRd8tMP5N5xRY=;
        b=Yh0HX/uTiu93RmvMlGnTrKs+Ox/DRaWBYAoSYfCLP+KMZcPCisjYLBe1aNoFrPilkA
         1JgOKCDhdgVAR5qxMHa0GPNQrVVyQS7G7WY2QudPaNwoqa/Z/R0JtPFYRuEs9rzbLM66
         X1FaiE28Q1lyHsdT2NZAPJALvRbA/LNM5dYh2TZs+NZursMWQaTqL66gWnY+KITBY823
         y1lJpJ1V/XAWXyUTZ2id55jgczzV5zYqPzOo7VEHEmWShBcVe6VU+RqsVewAlMS+PrZw
         4vznVtaZQjGunDDXEwsn9MlVpsTMbMyJaNpf/pks90HJYJplIXPBn1OzNjSfT5dJIjGO
         xbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764715467; x=1765320267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wRZOYga+UclKyv22PKImwejVNWT5pimRd8tMP5N5xRY=;
        b=VAbiM1VxHf/t1cmfICy+vvv6N+zFLjx46qJVg5oyxHDMbZHHpBU1UudpdV2Vs39M1i
         uBK3sARGJGHkE3KlxW0qFmEmddPA4pta7cc8A8PdgosQfm9ZS2Grnjc+mLpdFGVq1Jxa
         q/tsLl5lHZMmi5a9Bo/K99GRzHuuAknX4cgI5PtYQFbhAZESSrqIGxbdQIXn3d9NxNWK
         De7Dg4ydh4bcB5mSrGJlw/YeGpKUTc7KgSkJos0SyOnUvXmC0LXSnvR1khF8tpcQGo6d
         vvLup4wu16okNriI7qX7cR1eoAFIL6Y9xfv28mhR+MPoDnTGfFixYPLbGc81XDYwVNKg
         d0Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU8s/hxbj0GfWFikT3PfIiktmaXsenjREgaIecoJ7Zk+sg3wX3wEf4QVvKVJW8rlnaOxxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb3fZcg5YG4qkFEsImEsd1T2q1zX6j0oeRZKZfp+bapoVxiQgJ
	PHGaev4LI05HQgErd79Uw0UEhaBRzt/8oJto3tUedJtgFMCH92aLY6cNiA+seLkqE60Okesue7s
	OSMF9kqGEiBubMoga+1CDKZ/GzMjlEkg=
X-Gm-Gg: ASbGncukfdgt49ydK5jOKjcp9wePb6nWH/+J6HLM8cWVKB24tNK2LZ6CMgE01Q7MoP1
	B8yE1M6fKh3aZ/9RoMxHRj9rGIUCdvzHAU3vch8tVwlpHpWzBFiCV47h5Su51NGJX31cUyqDxj2
	wc+9s3rMhEEr3th4aiRi5lUUwoCSt35DoyW0+XdhYxIMkJxOOMt4/YYs76TztRaOGzdG9lnaUbc
	Ta6BimM6CneYb79HXQqIAVKU1z8WrhLXSSPNvN+AAAAXJm+t6xyvLc27kmwrG5Ry5aPThA6QZMo
	Zb/fxkooSQ1HFISWqZuFUBp++b9tSO5U/zJhpVij
X-Google-Smtp-Source: AGHT+IFyFK5P8/U8L0mEK4/pDkno/Psy2IMS4Xv8XY7z2pLYpiwkWSL37UlfTUEeVEDSWKhshzUThzzNDoWYKDTXx60=
X-Received: by 2002:a17:90b:3c85:b0:340:f009:ca89 with SMTP id
 98e67ed59e1d1-349127cb4bcmr250350a91.22.1764715466844; Tue, 02 Dec 2025
 14:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
 <CABPp-BGSYKPB7met4U_4ECNgA9vb5y_AWnMWfpiisOHnd_OyhQ@mail.gmail.com> <aS80co7VTABD6nXs@pks.im>
In-Reply-To: <aS80co7VTABD6nXs@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 2 Dec 2025 17:44:15 -0500
X-Gm-Features: AWmQ_bnYryFlQ_hAWjo77FnAJ_GoKeOQuf5IIfYIAulQ6f-iIigbxeOmhQw9rcs
Message-ID: <CALnO6CDG5EMha8k4DPy=p0FT1hO_SeU0wxm6qn2+Q92xNY6hqQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] builtin: add new "history" command
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 1:48=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Wed, Nov 19, 2025 at 11:02:20PM -0800, Elijah Newren wrote:
> > In addition to what Phillip commented on...
> >
> > On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > >
> > > When rewriting history via git-rebase(1) there are a couple of very
> > > common use cases:
> > >
> > >   - The ordering of two commits should be reversed.
> > >
> > >   - A commit should be split up into two commits.
> > >
> > >   - A commit should be dropped from the history completely.
> > >
> > >   - Multiple commits should be squashed into one.
> > >
> > > While these operations are all doable, it often feels needlessly klud=
gey
> > > to do so by doing an interactive rebase, using the editor to say what
> > > one wants, and then perform the actions. Furthermore, some operations
> > > like splitting up a commit into two are way more involved than that a=
nd
> > > require a whole series of commands.
> > >
> > > Add a new "history" command to plug this gap. This command will have
> > > several different subcommands to imperatively rewrite history for com=
mon
> > > use cases like the above. These subcommands will be implemented in
> > > subsequent commits.
> >
> > "...*Some of* these subcommands will be implemented...", right?  You
> > only implement two of them in this series, not all of them, or am I
> > reading wrong?
>
> No, you're right. The initial versions of this series implemented more
> of the above commands, but at no point in time did we actually implement
> all of them.
>
> Patrick

While I'm thinking of it, at work today I had occasion to use "drop"
and "reorder" (from an old version of this series whose binary I
happened to still have laying around), and it was very convenient.
Looking forward to it ;)

- drop: I had made some changes on my tree that needed to be in a
separate branch. I didn't want to mess with stashes for some reason,
so I did "commit; switch -c =E2=80=A6; cherry-pick @@{1}" (or something
similar). Then when coming back (switch -), I could just do "drop @".
I'm sure there's a better way to do this slicing that wouldn't have
needed drop, but I couldn't think of it at the time.

- reorder: I have a series of mostly logical, separate wip commits
that need some more explanation and might need further tweaks as I go;
I'm working on uncommitted changes that logically belong to the tip,
but spot something else that will be a separate commit. I make that
commit, then "reorder @ --before-commit=3D@~", and voil=C3=A0, I'm ready to
amend again when I get around to committing the rest of what I have.

--=20
D. Ben Knoble
