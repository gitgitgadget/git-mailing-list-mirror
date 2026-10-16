Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4942D5932
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151436; cv=pass; b=ul7kIYlqeFk2dgs1ZBXeqgjwrVuYuNILOXiN/M/ZuVOmKW6rfM0dbmzCZXVA77YwJ011RmGykLCYwNvXv8SCTn57VDEtnWtRcXnMm3EekjIwQbXfUaabeT0fC/FF4cFUXcFnmqVDi+YcDlJPOBJbZARiCcHq9jeK9kaGrk9rIqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151436; c=relaxed/simple;
	bh=fP1sxYyDeyPJRnJdgYHqqksXyVniPD7YsYnPzYm3OTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2qBi4NkD8odH7HQKLpqn7b+gF1smes6pLhrH5mmCPzUk3PpQdSeQk/yVj5hlGvZnK7QWBuQO8PFIFTMDIniPLIPSu3MXwgYHiqNG52qUrofCVAEcjQoaSTHTNzGXlgLSTXNVNmo2Ja/rDOBSenUdfgc1+iPZhacIP+KCOCaWm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=QBtNrSW8; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="QBtNrSW8"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-49e13495e5cso836283fac.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 04:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792151433; cv=none;
        d=google.com; s=arc-20260327;
        b=Z+NN007fVHldWmT/Xraf+IE/DGws7bQ8QF4lhVU9MQ/A15taL8/0C4+I6LoerP/LRX
         g4YMuK8+8eK1lH71v8PHUyD4TX8gY1wXM3YRzmf14YaAZrk66mIykFx3bFzR0Ha8lhsG
         0tkeXEeAaVgyPVWGdZ05OLlRNYB5UKmrDp83vUidtqYvT8XJIvPfsPYpBEOoL/i1UpCS
         14IPQRBwnAFbOvHTuIDN1/waapRTpQql93hGtlKDR/F8iXJXzaOwNsrhcJgpx6CGy9FJ
         S5fvGryb4APusQYEjjNadGxmzZ94hNeC63AkbnOkmyjMczNQodDp/La7B62gh/V7N0SB
         BMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6/qA7V3DG7kQAgqrGFawElxThnGIIK1Qs8DRsIsxVf4=;
        fh=3XqWVWJQBO6v2hvdho+RNmkNefQ0LBvNC0vnOgA1fqs=;
        b=D+iTRF54Yy4jSFzfIJfn0glo0/RaJ4ziPENvBmPsoKbhhii9tPGOmP4maRQ6nFs8Ht
         /5CTmgGcFFuZ7lgmjlVaLG3FuEOva7JXw92WA7vNCHXmG/8tu+ucLWiMTM0cejvWqu8r
         ZEmat4jkPdx+GUC1R+8Gk+T/TajGv+1haUCrwL5IXKDVFZNlsJ7icAvAKInEZbURDSgi
         ZmaN4wDYDA9mixvIRY+ekPqd/tZbiGhmCDuOkP/HWdRP5MCreYGpFCCzSfKsww52hEF2
         P8cU8X3LlYgyKwfVcMTU0OOU/zeWnzWMWAgl4ni1WbMBnphe3grdZuUZGOLt+i6+8MiC
         O3eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1792151433; x=1792756233; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/qA7V3DG7kQAgqrGFawElxThnGIIK1Qs8DRsIsxVf4=;
        b=QBtNrSW83UXuAeyZPBsIWQODodtyzPnnNgpk+EFZW3l8EemV7BaH1S20qSACG8Fyiu
         +01tsjr4I6sewU+KBpk55b8l4UzTPRFCOfzhnNtG1SJcVecu35LUjgF35KOIfeiAjS0P
         PKi/MUkfHYKayxzQIdGv5dCsZOhNcUq1DRJnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151433; x=1792756233;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6/qA7V3DG7kQAgqrGFawElxThnGIIK1Qs8DRsIsxVf4=;
        b=mvJUtx8Hm5hFYlFsi0w5gOawfr5Ti6eb27FpyP6KJE98mwPzslONA6g1HxC+esR/o5
         FkCduSLaCG3xmKBiANh/Wue5gtrMRRU6l1g6miVXlJVHrmoyRVy896r9yLULFRwzEpMj
         5DH7c7QV2jtyEj8pqVN24BE03AZqWvd6z2+bRA0+XpATBG6VJPomdw/nECIyAs48zLJX
         q4dDE7XnugvwXiGt1cSxNqfTLYGEjMtCX4sBrmyTm61iKVJHM6Hoz/+sPNx+SV+/Nvg8
         NIfWjSM35FIo/a0ZKkLAmIqOfjbp7TOaWdAZV1Ly8ipgpLAfHS/vf/umq40IHUJtJFPX
         d+Nw==
X-Forwarded-Encrypted: i=1; AKwUvByyzPt1Erw3ewteTQjY382Hc7ETp9pI49sE/XcuDCy+X8tFnzTutRf3s8eqwOVAK6x5IyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPhyi/MIjQF3tTXmyRco1I1mTLzJoXDRXZeLM75W1Ak4lbsY81
	aD1z4f4prRN3Vo2+epVDR28gbpzsUngknF34RXEKQxzfjF9WGW5hy6sUEwVL6B5PGoTEOhFWZAx
	xNPQav1GKbkc/bTEuBXNi0eFFBwHsphWh2D0/JkoXOw==
X-Gm-Gg: AYBFou1SFDgh94vduilFN+c/6I5sTIHbm+SOM3WCxY7P3h1a8YC3kMJOMRVK5agjuJx
	oFZfKG5/KX1q5Me9HgTydbWvTpXq0m/Lv2dmUxYu4qj7iOIrY0MDOt9P66JtpzjJUizCxOIurW3
	tH+sB323tdtFjypzDn1pMZxAHurferYOAdP4r49G8pI+PmeQfpj8t4YUeMEy+gIaJHbWYeeYVet
	70AnjxL7cGU5JVzaBnRoI+ceDS7HJDTy9EpDTOTIEH0vuK9TMtOk8enoTLXt4uvDWbTgz8W3XYp
	YgJNAdIgUudSWb58ZhQx8C35L8tGaXXvfw45QvicUI038Hsm/Yz7GXDY
X-Received: by 2002:a05:6808:3518:b0:4c2:e32c:1ee2 with SMTP id
 5614622812f47-536fda8949dmr2059029b6e.22.1792151433406; Fri, 16 Oct 2026
 04:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2211.git.1789379276.gitgitgadget@gmail.com>
 <pull.2211.v3.git.1791806877.gitgitgadget@gmail.com> <efaada0b6a8ffdb4d1c01d7f34a0d6596a99c149.1791806877.git.gitgitgadget@gmail.com>
 <atB48HLgZr3ssOfx@pks.im> <CAL71e4Meuv1KXTX9HeQzmyVdmtYDCrd4M6VNcRRt5HZ-DKzbQA@mail.gmail.com>
 <atC-GVBnQrfr3cQ0@pks.im>
In-Reply-To: <atC-GVBnQrfr3cQ0@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 16 Oct 2026 13:50:21 +0200
X-Gm-Features: AclHuK_iHRCRDAbBTuItQCm4rsmRAyw2ZlqhnSdtibHZjgYzfZhJqygcCERbS_0
Message-ID: <CAL71e4NA3SH8V_haxJFeYCBmKk8+96j7ckxLDZA7+XMNcVfdKg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] connected: add incremental connectivity check via rev-list
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 at 13:50, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > I think this is where it gets tricky to reason about.  The win
> > from from larger trees pays off without bound -- the larger
> > trees you have, the larger the win.
> >
> > Scaling with commits on the other hand we have ceiling of how
> > much it can regress.  I am thinking that could be reasonable
> > that anyone who enables the config flag for this mode could
> > simply accept that it would likely speed things up in most
> > cases but in other cases they could see a ~1.5x regression.
> >
> > I am hoping that this tradeoff would then be acceptable,
> > otherwise we would indeed need to add some way of switching,
> > though I don't think there's a single good indicator value
> > for when it's better to switch.
> >
> > I could add a new config flag like
> > transfer.connectivityCheckIncrementalMaxCommits to control it
> > perhaps.
>
> Yeah, making this configurable may be reasonable. The way I understand
> it, the new connectivity check is most likely to be usable for smaller,
> incremental pushes. And based on the above table you have, we see that
> up to 1k commits the new algorithm is faster. Sure, it's an artificial
> benchmark, but maybe this is a good enough cutoff for now?

I looked into this a bit more and I have two main notes:

First of all, I benchmarked multiple repos, both with small
object trees (such as git.git), medium (linux.git) and some
really big ones (proprietary).

    repo          files   commits   full    incr.  full/incr
    internal A    552K       1000   1.69s   0.66s    2.6x
    internal B    331K       1000   1.48s   0.57s    2.6x
    linux          95K        609   0.34s   0.12s    2.8x
    linux          95K      13965   1.86s   1.90s    1.0x
    git.git        4.9K       356   0.09s   0.13s    0.7x
    git.git        4.9K       976   0.23s   0.31s    0.7x

So for large and medium repos the cutoff of 1000 is
conservative. Incremental mode is faster but the full mode
is also good enough here.

For small repos like git, the incremental mode is slightly
slower, but since the number of files is so small, both modes
are still fast enough that it does not matter.

(I could not get an exact 1000 commit test synthetically by
looking back in the history for all repos, since it depends
a bit on the shape of the graph of commits.)

Thus, I think having a cutoff of 1000 is indeed a valid
strategy here.

Second of all (and with the previous in mind), I think I would
want to change the configuration into three modes:

  - full (default): work as it does today.
  - incremental:    only use the incremental mode
  - auto:           decide on full or incremental depending
                    number of commits to process.

This would make things safe to roll out and start gaining more
real life confidence before potentially changing the default
to auto instead.

We could also make the cutoff configurable, but I am not sure
that is needed in practice.

> > > These probably should be `size_t`.
> >
> > Sure, I can change that.  Or intmax_t since we'll need to cast
> > to that later anyway for the trace2 output?
>
> Hm, okay. Not a fan of using signed integers as counters, but so be it.

No worries, I will switch to size_t instead.

>
> > > > +     if (type >= 0)
> > > > +             die(_("object %s is a %s, not a %s"),
> > > > +                 oid_to_hex(oid), type_name(type), "blob");
> > >
> > > I'd love not having all these calls to `die()`, as this logic is
> > > essentially part of a library, and dying inside a library is a bad
> > > smell. We do this everywhere else in Git, too, but we're slowly getting
> > > rid of this as part of our libification efforts.
> >
> > I think this would be a bigger refactor in general --
> > the existing connectivity check also dies as the way to
> > report problems.  This works since it's running as a subprocess.
> >
> > If this is something we want to change, I think it would be
> > good to do that refactoring separately and make the connectivity
> > check subprocess only die() at the very edge, and making all of
> > the internal library code support not dying.  My first prototype
> > tried to do this but the amount of changes to internal code got
> > out of hand, so this version was the simplest I could make it.
> >
> > But I'm happy to take a step back and revisit that approach if
> > this is a blocker.
>
> I mostly aim at not making _new_ library code die anymore. In any case,
> I don't think it's a blocker, but I nowadays consider this to be a code
> smell.

I have spent some more time thinking about this and I have
changed my mind -- I think I was too stuck in the idea of
all-or-nothing here, but I agree I can make this work in a
mixed way -- not introducing any new die() but accept the
cases where it already dies.

I will include this in the reroll (likely next week, don't
want to rush things).

Thanks,
Kristofer
