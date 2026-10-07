Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B833FE05
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358421; cv=pass; b=BauVbtQBs/kwAx63y9qm5++hQeiJf6aan21NQuEf8wLutL7HLf5FeKdUZ8SpoWTyszgLxA1j/vp3mHDNJ+UVicESTENcGghRKjLaDmhMFxWRBySWNVGsin3iKKkGH+re4JCFTfInBEoa0TXgJKtw8ZHPtpeWDBHAFjA/6IYPQ40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358421; c=relaxed/simple;
	bh=GXpDgVsdF9avJgzqm5htujKze4M/r1k95X6GM+w8t8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNj0fOKPvM7Jd54sRcjfHXiMKT/RmZHypq59mWh0tEPeF2gYlSyOnVd7ff+JBMfQdI89dHppNFz0M/QKX3V4DaS4F04u2m3lkCiP48QM26bNHuTKf72i6RLYk1Zf90HhYYqNk9rtVYFh7a/JDfI0FqnvZv1D44Zg6/4fr4duvwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=eOHvIbq/; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="eOHvIbq/"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66c7e3a2332so2688439d50.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 00:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791358418; cv=none;
        d=google.com; s=arc-20260327;
        b=P6rFJJz9pfproZ6v2eY+ngnXwPFBfgJDgvJ1hkkT21fdS0/6OjIaEfj1O9/PSb1tpJ
         DItZiufi1xMesn/Xpg91g5kEHbvrhWJobdvi+BCyfdbZEt5g70pp8eO90JOg7CtL2UCd
         YPvUmWrF1fR4nLMq7ThRZwmrZYQeXuaFBWnCDtJRdBSx2q5FB2qwTCMM523gL0LgnbHB
         /fgY/bGQKZYIoQs97jeHg0UhtKivxitssvnTShvhX62DeOwX9oA60qDRcDbawca2jC1a
         7Af3nQYe43c53AYxKmvEDkyLU17vcSCfGM4Yg1UGG1GscBYYzGpKwRTpdsodnXyWPMsa
         dKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iQHhVLS9jTWm139dNdWjmco4tMIx9Axj/s962SwII2g=;
        fh=vYBhavwS2nxAlS8uOVqhXrczpBWBFOb+uXzChm3htS4=;
        b=Ffy3bz0Y4nNP7NNoqIXcho+2DW13zKPyNC7xSVuCDSAoa8X5DdnbRJ2QWoo4zMn7tA
         WKwpX16NdY5vdIlW526J8GYtivKCmSuFoIMFXY2E/pImyn2zmoiTVZOCzqyGowja7Wth
         BEQCNLVU7WQUOJh3kF1MFxveK5AEYfKoDwlehFBLVLv8djjNi63h9pzMRHESlPYMRlcL
         ZhbS4vuWgh5Ab18mg69dUzewgjNwRFKhl8Q3zSajrqdFPF6xdtmDTV4tJmajgpwUgeVc
         r3wlnBNA1ql+KJYZG+32aWlfX2GlqOXu1IoW0oZ+QcvytgivCnEGyd3DiS7VbPoZLmBq
         oC6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1791358418; x=1791963218; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQHhVLS9jTWm139dNdWjmco4tMIx9Axj/s962SwII2g=;
        b=eOHvIbq/tK1M6nvIAZs1qx0e/ZOlxZaxyklHpFfvijTJNOZEJlIqdb8IaHK61q+z8H
         hPrhYZxijj1XxIOUFLfQChrHlit+LZUu9QQnRWQbUsNlYJr1um1en480eHN/vEEu0jYN
         lXVsgSG2TKMVV9M+Hg8X9D7YZYd3kNJC0351s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791358418; x=1791963218;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQHhVLS9jTWm139dNdWjmco4tMIx9Axj/s962SwII2g=;
        b=halHZdab9wzAxS+rzig9Gd36oneihsdC5CgmfNmeLp1QUnug9XjOUwXjlwPLMSGVbj
         nX4bG9v1ONsJHulUvIrjpWbm2OoFBAWbCndviA59j7s5hfRoN3Csu1hpYS3YvS048Gfk
         AQiKYkyJ+dlRuhfZQYhZTxdkaUFDywSftqRFv3rkkpPQaV1ubhT3vLJr7hi3ffsL2lwj
         YqXYY6V2TaNelpu274VRtvN1YnXp5Z4GGiRGR4TnBE/mL6jRbT1u8LscDJ7fisJA+Yz5
         +PhFMIcNi8C8/wtQFSEzCIb8qxJFCRZ/WX298Or2XRf7KrGmP8h/E/KLAeo03YLU6VxM
         l9NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJcYb9KRF/Jk6j3maRLJM9VIMcsN9kFlrDaOus1BvzEPYA/RZGocbqCggV1xwnRBsUppY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGq9wRZt8Eo2L3PWrTMQ4JVPJSTH5QxYVvHaGXzMR0Q/P68xuD
	8bpCiauFClwtO+vdIlkvT62pm6sSopTSYHGLM0pSQwV8IUHl7urmPFeXEtdO98t6whKC6ow8Tk3
	6v9IhUdsGM6nvHyGC+EzdoOZTlUJok7tY1bivAvbVEQ==
X-Gm-Gg: AYBFou13dioNzK+PnIQwgpFdYCdNNk72JncePb8kmd/KanbuPZg51Zo8rJL/mgMIOr3
	jgDoyN6zz8269ep+SH6c4q3j1cEbcnCBnCTuzctc9PT2ttjBIEuB/LijMgQViobUCnrqi1yFk2c
	blvDzii1l5YXlYceOWjBfIXCbC8KFiLm/QHiKhGWoB5lBHRdM4/9lEMeZSxmaTPTGb/iTgRoIYX
	zHgb16OkvtmWRCG299P62Q10s0J/7jw9JpJfyINKFwl3wwpin1Guog/A97Bka153WV1D5DtC32Q
	IRzfDGtDdIcVm8OWFHzaAN0OgimTmIyls5HqgdzlnKy7zVu91JF3NGQ=
X-Received: by 2002:a53:b64d:0:b0:677:afe7:1f98 with SMTP id
 956f58d0204a3-6790a46cd20mr615063d50.83.1791358417577; Wed, 07 Oct 2026
 00:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2239.git.1790930019.gitgitgadget@gmail.com>
 <pull.2239.v2.git.1791279992.gitgitgadget@gmail.com> <7507354cc97bb63b3bcdc4a089b5387da28500a0.1791279992.git.gitgitgadget@gmail.com>
 <asXpD2YB_MpunVFs@pks.im>
In-Reply-To: <asXpD2YB_MpunVFs@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 7 Oct 2026 09:33:26 +0200
X-Gm-Features: AclHuK87XG3sql7vlcZQVwDuHPVTlMR1Omhkcf2x3vbR4H7g85vHMHwwjcE3qgA
Message-ID: <CAL71e4OmArbY00EpGZfSME1XoHJZSjusm-AJPQajd6Qg1SDDPg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fetch: write commit-graph using updated refs only
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 08:39, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Oct 06, 2026 at 09:46:32AM +0000, Kristofer Karlsson via GitGitGadget wrote:
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > When fetch.writeCommitGraph was introduced in
> >
> >     50f26bd035 (fetch: add fetch.writeCommitGraph config
> >                 setting, 2019-09-02),
>
> Tiny nit, not worth a reroll and something I missed in the first round:
> it's rather uncustomary to have this commit stand out like this, we
> typically have it embedded in the free-flowing text.

Will fix, since I am rerolling anyway.
(And will keep in mind for the future.)

> >     when it started to validate the refs against the odb
> >     for correctness.  On a repository with many refs, this makes the
> >     full reachable scan unnecessarily costly for a targeted fetch.
> >
> > Optimize the commit-graph write by using only the newly updated refs
> > as seeds instead of scanning all refs after every fetch.  To keep
> > this change small, skip the optimization for multi-remote fetches
> > (since that would require propagating the set of refs across process
> > boundaries).
> >
> > Since do_fetch() already knows which refs were updated, collect them
> > into an oidset and then pass them directly to write_commit_graph().
> > fetch always writes the commit-graph in split mode, so this adds a
> > new layer on top of the existing chain rather than replacing it:
> > close_reachable() walks from the updated tips and stops at commits
> > already present in the graph, so the new layer only contains the
> > newly fetched history, and commits covered by the existing layers
> > remain covered.  This relies on split mode; a non-split write would
> > replace the graph with just the closure of the seeds.
>
> The part about split commit graphs is important to point out here, as
> this is what we rely on to make this whole infra even work. The other
> parts about how we collect the object IDs feels overly verbose though,
> as you're basically just explaining the diff without providing much
> context.

Will simplify and shorten it significantly.  Something like this:

  This relies on the commit-graph write being additive, keeping the
  commits that are already in the graph.  fetch already operates in
  this mode (COMMIT_GRAPH_WRITE_SPLIT) and now that becomes
  required for correctness.  Without that mode, the write would
  replace the commit-graph and lose other commits.

> > The reachability closure also covers auto-followed tags, since their
> > targets are reachable from the fetched tips that caused them to be
> > auto-followed.
>
> This piece of information feels a bit random to me. Tags aren't even
> part of the commit graph, are they? And for auto-followed tags we'd
> of course naturally cover the commits they point to, but that's just
> business as usual and nothing that we specifically had to make sure
> keeps on working, right?. So I wonder why this is explicitly being
> pointed out now.

That's fair -- I added it because I wanted to convince myself
that auto-followed tags don't need special handling, but as you say,
their commits are reachable from the fetched tips anyway.  Will remove.

> > Refs that are rejected because they would require changes to
> > .git/shallow are skipped, just like store_updated_refs() does.  Their
> > objects are received but their history is incomplete, so walking from
> > them would make the commit-graph write fail.
>
> And this bordering on the line of getting too verbose, as well. You
> already explain this in code with a comment already, so you're basically
> just repeating that.

Yes, removing this.

>
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 533fdfe7d8..574c361530 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1903,10 +1903,34 @@ out:
> >       return retcode;
> >  }
> >
> > +static void collect_updated_tips(struct oidset *tips, struct ref *ref_map)
> > +{
> > +     struct ref *rm;
> > +     for (rm = ref_map; rm; rm = rm->next) {
> > +             struct commit *commit;
> > +             /*
> > +              * Like store_updated_refs(), skip shallow-rejected refs:
> > +              * they are not stored, and their history is incomplete.
> > +              */
>
> Okay. It's unclear why the reference to `store_updated_refs()` exists
> here, as it doesn't seem to give me any useful context. But the other
> part about why we skip this is helpful.

Right, I will simplify the text here a bit to:

  Shallow-rejected refs are not stored and their history
  is incomplete, so skip them.

The reference was meant to point out that store_updated_refs()
skips these refs as well (which is also why the full reachable
scan never runs into them), but that is indirect, so best to
just remove it.

> > +     git clone --no-local --depth=2 .git shallow-graph &&
> > +     (
> > +             cd shallow-graph &&
> > +             git checkout --orphan no-shallow &&
> > +             commit no-shallow
> > +     ) &&
>
> Can't we instead:
>
>     git -C shallow-graph checkout --orphan no-shallow &&
>     test_commit -C shallow-graph no-shallow

Sometimes the blocks help for clarity, but this is short
enough anyway so you're right it's not needed.

I will update to that, using --no-tag, since the fetch would
otherwise auto-follow the new tags and they would show up in the
for-each-ref check.

>
> > +     git init notshallow-graph &&
> > +     git -C notshallow-graph -c fetch.writeCommitGraph=true \
> > +             fetch ../shallow-graph/.git "refs/heads/*:refs/remotes/shallow/*" &&
> > +     (
> > +             cd shallow-graph &&
> > +             commit no-shallow-2
> > +     ) &&
>
> And likewise, `test_commit -C shallow-graph no-shallow-2`?

Yes, will fix that too.

Thanks,
Kristofer
