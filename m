Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEAA22D781
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766161825; cv=none; b=scoRXW4FVpvUeeUMQL9sktNhUrEbVgSe6h1j0CDATumeh/pqUQ6VIzuwMFd6x07iF2RBCMQMpr0ZU6OA/qDOlwMHUMOUbJ/F3jBsAfTHlWP955d88XjEd4AZj9KevnB06TUOmDDoZv81TCffYEabmS2w1MBt0Nf+HTh25pkfbUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766161825; c=relaxed/simple;
	bh=rLP4dYa3cJtH3nA2KMN0BaNQ+FzrxVQp6bFjUQN62RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY588aQwxdxiu5IEPWjXDTN8JhVwt1ORQtwoPufDIiFI2yBzppabrejREtEMZtDZhbg+8Fm084cH1NpgV36aH7tajTHsoAbtH0S7uFe9sYavGn+wYjhjCh+pn11iRUh2rcZto3FJa78CKpvzG7SnkYtHjcOOEKszXQYywz+4yuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox75igRq; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox75igRq"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6e9538945so2000723a34.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 08:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766161823; x=1766766623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWqvTVz2sVbh3A/0ZIhbzjDKqvCT04HppcTteSxRIvs=;
        b=Ox75igRq05dyBJMTNVGEGqsLGesQefAzPdI0JgbLYVXgqYbsGM6KkHsqLzCZFKDNVu
         Uhla21gKzZQ+7kiEzOtUHEZaoQgj+1YyWrhUerhG2NIgvh6T6im4bbdYEygj44nB+X3S
         miodhR9cEYfc2EeVGVArvfLs26N3ulyVJp8p0mU2FITmtYkH7Eybey82gpckDlMTAap/
         m4ynJtkuq/LEaO7Lcv1ks7pW29ZgLCgOi6Dvkmefn32G3PetXCLMe2cMiwF14gB89h7z
         vpTJ7l9NcKDR4gUenhbEoygSEs6VA/D2rvpMEvX4zJ2H8XI7uQ7d9weyGL3DArROFrtt
         kKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766161823; x=1766766623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWqvTVz2sVbh3A/0ZIhbzjDKqvCT04HppcTteSxRIvs=;
        b=qCZ2FQoCzqM0A6DMwfKFGbl5RsCkWqld+PiVXY9XqOqxHCwkDQrY2gAQinaitEmfTG
         mWz4ZpOr/3YVZgNFl5pYzomeJE/x04bWHJeIQZgwbgW3mgk1UqUpBACGANkAgHAzNhHL
         A/+KBLQ/FtdatzJ+W7RSuonsdMheE6cFxSLcy+rQnSdbeGCpSFH5QrZHhhqIo7edatC7
         aDTRoyF9UjGskQHKe/a3YDaYua+knZC2Ognd5I88D3ZvnXQgM4geM5ZWzxYTSV/KuSuk
         wr5x7BidEY1te5NgTsoE6MoSwi7yC2vk6pCZwm4DFwVGB7bCPvsLMfA4PDTNO6Xw2nBS
         zCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUmfHuxVmN5fXEmX3aiET3r4PLnVxnesT+4H9B0IHAAHSweaJ6kLpsV3UPvHdcRVOvbnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZuOznuojvKRbKcu/H7lXh2z9e0tmKIjTbGIxpQNH6QlpDK8v
	rBIj/dSivqGOZSQUwLgzMgHxCkLEzCiG3jbBRHQbOhLOpoiA+x8qGvAC96KAYpLrjWVFmeg2nHb
	ZsOGJrUh9iZaLrZY9U40v76aqxHowLqg=
X-Gm-Gg: AY/fxX5yoBkwe1HDwqYpyak8cqR9syQQtAVQS1pmqsiH03NzVDLTEVWjQHsI1i8//L1
	u8P/7vDY1Dagd6rPtA503++4Uy8QWUoMxP5BuK9N6vb+dpHtlf6egWyJIHMeyb/uMIj5OByYvfW
	sOmHRYMXFp/DqEis4KfFUfbLiADmKwmeEbh7CiLfsHPs8zAWSqitNz83gtD7jjfjMObYejNQ/QJ
	L6AKSIuqMk0XAdmuEW0SY8Jim8C/hxBZ0BN3P3LQOqvQOYnEYugIHh5eOxEwD1sHtijdzmqL/xT
	N08y5dCcLF7iSuWe4i/n0euIQ5jy
X-Google-Smtp-Source: AGHT+IHdRJYsR7+bIcByU7Q6fx47ntCQO5CTg7Y56Zdhj8FLO9kYAa4/ly3Awo6wN6CJ1aI0g7SyzFweCUqpuRDOo9o=
X-Received: by 2002:a05:6820:7711:b0:65b:2f3a:d5a5 with SMTP id
 006d021491bc7-65cfe4e96a9mr2776401eaf.0.1766161822571; Fri, 19 Dec 2025
 08:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <CANiSa6gXbrZaMLVq-AAg38sm+7qgzn4w98WWowLtUHA2P+BdLw@mail.gmail.com>
 <aKs3tqjE510MF0T-@pks.im> <aMsWL2cSoytbmRjA@szeder.dev> <4m6rmefbv4hftclimitz5rp6yapswjtnjsxymrsdkuan4jbg3u@dm5jzdiq5cxz>
 <bc01706e-b9cc-4cd4-953a-971a3ccd6c79@gmail.com> <paqf2ko6kcm5qdcqxqz57qu6gjw3vf6boabjsryeugfnlzzb7z@4dzqo6jug6l2>
 <a6efc710-4062-4955-8fe8-bb6d428a44c1@gmail.com> <xmqqms3qh13e.fsf@gitster.g> <aUVDax0PbkaXGB61@pks.im>
In-Reply-To: <aUVDax0PbkaXGB61@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 19 Dec 2025 08:30:10 -0800
X-Gm-Features: AQt7F2pZl0vEkj8OOJI7i5946PaimUfQAsX37ONP-OT-bCbW6OepyG7QUtqVMWw
Message-ID: <CABPp-BGE1PC0RhpkfABUL74Yade6HkMQd35bv0my9A2+1VY6AA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] Introduce git-history(1) command for easy
 history editing
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Matthias Beyer <mail@beyermatthias.de>, phillip.wood@dunelm.org.uk, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 4:22=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
[...]
> Okay, so the majority of folks here seem to favor rewriting all
> dependent branches, which is also the default that JJ uses here, and
> git-replay(1) does it, too.
>
> There is one major difference between git-replay(1) and git-history(1)
> though: the former works with revision ranges, whereas the latter does
> not. By using revision ranges we avoid the problem I have mentioned in a
> different branch of this discussion, which is that we have no easy way
> to figure out which branches we'd have to touch in the first place. This
> is because we simply walk the revision range there and then look at
> which of our references point into that range. That's simple enough.
>
> But in our case we're not working with ranges, we are working with a
> singular commit.

I don't understand the distinction at all.  `git replay edit` also
took a single commit, and then implemented the obvious (and jj-like)
behavior of rewriting all branches that descended from that commit.

> In my head this meant that we'd have to basically do a
> revision walk that starts from all of our branches so that we can figure
> out which of them would eventually reach the commit that we are about to
> rewrite.

Yes, and it's only a few lines of code, as I showed earlier.

> And that of course doesn't scale.

That's quite an assumption about scaling; I don't believe it.  Under
what conditions would this be slow enough for users to notice and be
bothered?  commit-graphs not enabled + weird local clone with
thousands of local branches?  Also, isn't jj specifically designed for
large repositories and with scaling in mind, and yet this is their
default behavior?

More importantly, this is being used to justify a large principle of
least astonishment violation (disconnecting branches with shared
history), so we'd not only need to show that walking all branches was
slower enough for users to notice, but slower enough that the negative
user performance experience offsets the negative user experience from
the astonishing behavior.  Typically, spending extra cycles to provide
users with good warnings/errors is a good use of time, especially when
it'll take them far longer to discover and recover from negative
surprises.

> Now we could of course also introduce ranges into git-history(1). That
> would indeed solve the issue,

I actually don't follow; how would this help?  I'm not even sure how
it would make sense; am I missing something?

> as we can reuse the same architecture as
> we already have in git-replay(1). But I don't really want to go there as
> it is leaking complexity to the user: they want to rewrite a single
> commit, why should they have to think about ranges?

I totally agree that they shouldn't have to think about ranges.  They
rewrite a commit and every branch that descends from it is rewritten
for them.  If the commit the user tried to edit was part of an
immutable branch (to be implemented later), by default you throw an
error.  For the special cases where users do want to disconnect
connected histories, you can provide an option for users to specify
that they only want the current branch (or only the branches which the
current branch contains).

> But now that I've thought about the problem a bit I think we can avoid
> that issue by implicitly identifying the range

Yes!  As I've been saying, anything that descends from the commit
being rewritten.

> it's all the commits
> between the commit we're about to rewrite and HEAD.

Huh?

> So, same as with
> git-replay(1), the set of branches that we'd need to rewrite is any one
> branch that points into that range. It keeps the UI simple as the user
> still only has to think about a singular commit, should be sufficiently
> fast to compute in most cases, and it allows mega-merge workflows like
> JJ supports.
>
> Does that make sense to everyone? If so, I'll revise my stance and will
> adapt the current implementation to do exactly that.

No, it doesn't make any sense to me at all.  It'll avoid the principle
of least astonishment violation in some cases, but leave it present
for others (e.g. other branches which contain this one, or other
branches which share the specified commit even if they diverge
afterwards).  I think we shouldn't have a principle of least
astonishment violation.  There are three ways to avoid such a
violation:

  (1) rewrite all branches (refs/heads/*) that descend from the commit
(code for this already previously provided and is shorter than the
existing code in this series)
  (2) walk all branches that descend from the commit so we can give
the user a warning/error when multiple branches are affected
  (3) force the user to be explicit about what they want.  Provide a
set of mutually exclusive flags, and error if none are provided.  One
flag would be for rewriting all branches, one would be for rewriting
only the current branch, and we could add others (e.g. rewriting all
branches contained in the current branch).

I don't think retaining this POLA violation makes sense as a starting point=
.
