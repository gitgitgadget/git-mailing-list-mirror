Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4B3769EB
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925041; cv=pass; b=m9FyYcdbqoC4FYUCqWt+XW8Id+kZFobJ191bP4lgwaUnJ/U9ayR/ogxa7nt4aY1qbWzkj4OadXE4nKS86GTSJdl2/nrSDca9rWX6Z7rgQWU/jp6c7c9azYUrSnnBzLF+cP3yJX1TDVFdpYCxBMwvtHTQ6VPG0S1E3u9O628SqhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925041; c=relaxed/simple;
	bh=W2WvWYUzb4zPzkLj41XuemJoB9PojabkK4sT39Ml5mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKaDa77C3oAr/aJ8AzAfijEDwJMkRilu2B9yjWAovf/Jdh+wrf1Z4xfweoGqicoSQmN8lIvIuWmf+bglNPSh+SRr5IMsgnSR5Cofd/KGDzphXKI5UquOTWfp5VWLV0RR/T794qWlVqfC/2b/bluNaenCYLSquvlGrc4Zn3APb/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6Szwgr1; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6Szwgr1"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6603246b66dso4253870d50.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 06:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780925037; cv=none;
        d=google.com; s=arc-20240605;
        b=B4Rh6PYzymq/3EmREmpRuJdG7bmle3vEQ1HPze9VPzpB+OTgXwM+eDo4MOhZ9hvKzL
         AVC0AAwHNaVGg/i9Fs4EoJekQ0qh8Nq17fd/Gj5lmx1+mO1eXQj5L1hSGjDeeCnYstu7
         ACDXCVPrt0JtXoOPzMgi3mtwWIF1Qtlnx2sUrCCTyEUVHpPkXf/emh4X8s68TNpuKE2a
         nFikfaqEvL+5PMkwXCKWYkqysbNZSNWop5hNU+nyKJt2N29QEURO6nbt6AbYonoJzOB/
         1AGa5EnHOlGPBfGe5s4cN6BG5VENcdleyYZkPsWOGc7xf9LZU+j4xFpnm/x5aOboUKer
         8d9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=34CRcD695ceqYie9DDVQ1MQ2frVYDJHnWEgWQL6Lic8=;
        fh=m8B/XNuaTqYsNUOoywnyMFBQHQdEKktYU2HE5XqewuY=;
        b=ir36VU53hU2Kql7I02YMcbFFhEgUoRYCn/fsq4z3DnBMju/+G8afeCJhGpyjZpRe0R
         I8Ve2FdJcdyCDGaAJMUDCg7TvLzi5qbYWnm0wnX40Adua3gYrV2y0bQe5l6jFhM2Bte0
         PGiWvC/dd/OBYeRrz4An75oDgXysjIqsjXu9RFXtS4cJhPoTuZtK10InhA7/ZqDmEH2d
         yvC6x+0cEIOWokdNwlkL5+JEh8cieD50Q8zTHxgAoN+iGKfL11zqFvLLG0v98ziA7WpU
         z9Dr5MYwfLT4VD12lpnyitabybbx1wYiHvXMp2rmZh5yZ5lhBIUGYz+QHMpqg1hGxaZg
         lklQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780925037; x=1781529837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34CRcD695ceqYie9DDVQ1MQ2frVYDJHnWEgWQL6Lic8=;
        b=G6Szwgr15bXDVZiI1I5jsHDuEQDcvEYZn0N5oYDxJ0KbxUBwZOdkpKBtzadKshqIib
         K11tHzBOrKxagTiJos9ya7BsfQCarh5eiyfJ5PYU8/5jzEcVe9azglWftijDKwZ3X8bK
         T/FvIJ1qxi2z3cFWz9XFIf95/FXkL23a3HfhvvwSIlRi3rKGEfSc38J2GxjAtnTxJNEW
         Y0CjImRYaaCR3ruGWdM3p64/d56oeXIGxcAmgWGFzylTpMWYbd9m1GFSxLJdLTMVXgNh
         ntEhQYNJbshad+7imt/FF17aW6BgDHZWubdedrGxItdeesmVHg6/Ln+UdZF0vDduW/aq
         sIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925037; x=1781529837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=34CRcD695ceqYie9DDVQ1MQ2frVYDJHnWEgWQL6Lic8=;
        b=ofOq1tIAXcmc8yHydZRfNMyO9iG4dP1TezVoMos36F3jSQj8L/V+HuRMf47vHoiBXk
         3E0ks9NmRiMt4885AvMO7TmhhSsyar1KcUYVTJnatRM387n/tJv0HJ7M/RBUn0vTaDPk
         SP7w5Dsk6PH0qd/KYLwpnYKunXaat/FcqcFjAK9A4uYCz58eIC2iPG3Q0U4pxEXUz9qy
         7daItrhhujoCR+tsNwbJJP0gjHU3aLqA45BcZJz9CXXr4vuTUpqUQLNUPTBwg0Lv3YGr
         skPW20OerG23mGVn9VHVnir0LQFyb9SvE+a7B8I/EvgTuANqvwesitiEtdHrjTM4F9Hx
         0Xkg==
X-Gm-Message-State: AOJu0YwnW4M4/HCArO5jAktuMDckoTA4LKP6u0llLVUaQLLLBYqrI32b
	bdLqIsUWZMaBgN6a3sIdjdXwzoGiHYxSKr/IHwRieAMRQeCD+KBA+6jR8EoHaNm3H7UM6irBtTU
	Znb3X6omISdusi41DR7+4uvUFO03tupg=
X-Gm-Gg: Acq92OE2mZdqb0FdcTzDOEjkrmIPhKVX/cu5zRuBvG1S7QUAceXb3hyKO+8Ds28gaCJ
	nvbnqGaChPaap8Jx/jnyTYMxEAkGXNqFPVi8jrXt9X4ZN+ojwexDhHdpJLzMmn510nG8PE5iS8Q
	3LxmyMYm4IW9VBPHfSheJD2Fb9OdIkSQ1gsz9sMxS+GzOL3HHgKZBBBxgEAGz+/pfZGzs2fvkFs
	jeE2/d3PvplezbWQ6JMmiFWujLkYYKguw8NZDTpw+ybV13+iMbGlitux6Nbreh9Ao1OmkzrRIKd
	C+Whoql77SH7n7p5cGBEGNK2wnRDM3KWXTJEjiaSbLEMZHwWqZy/8sYwvrRseIVLW8tJ4t1CDnS
	UWXnjCjDu3Pwg1lEQQo8VEnOf1U4BCEekLvMxPR+PQiuFbqBths8xRP080pLTy27zV6DggGinUD
	kDGDM9tkYL9ZHYd6jzuP6UPzk=
X-Received: by 2002:a05:690e:140d:b0:660:62e5:9300 with SMTP id
 956f58d0204a3-6610779e02amr13386468d50.48.1780925037333; Mon, 08 Jun 2026
 06:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
 <20260607-ps-history-reword-v1-2-ba43a3cbb81b@gmail.com> <xmqqqzmhz0pq.fsf@gitster.g>
In-Reply-To: <xmqqqzmhz0pq.fsf@gitster.g>
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Mon, 8 Jun 2026 15:23:46 +0200
X-Gm-Features: AVVi8CfShPKMIRHcep1gnrVXjEtQG430Ucd3pWlAXbhuWex0fHMIFjAf7SX7MxA
Message-ID: <CAN5EUNQNj86Q+hi6PouOZNWo1T4QTQ6sE5Hs9USZXWpkTedTcw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] builtin/history: print feedback after successful reword
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 8 jun 2026 a las 14:16, Junio C Hamano (<gitster@pobox.com>) escrib=
i=C3=B3:
>
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
> > Unlike `git commit --amend` and `git rebase -i`, `git history reword`
> > doesn't print anything, this makes it feel empty for a porcelain comman=
d
> > and hard to tell if the command did anything without using other
> > commands like `git log <commit>` to check if the reword was done.
> >
> > Print a message on successful rewords so the user has feedback about it=
.
> >
> > Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> > ---
> >  builtin/history.c         |  4 ++++
> >  t/t3451-history-reword.sh | 14 ++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/builtin/history.c b/builtin/history.c
> > index 51a22a9a1c..0f1ba3b531 100644
> > --- a/builtin/history.c
> > +++ b/builtin/history.c
> > @@ -739,6 +739,10 @@ static int cmd_history_reword(int argc,
> >               goto out;
> >       }
> >
> > +     fprintf(stderr, _("Successfully reworded commit %s to %s\n"),
> > +             repo_find_unique_abbrev(repo, &original->object.oid, DEFA=
ULT_ABBREV),
> > +             repo_find_unique_abbrev(repo, &rewritten->object.oid, DEF=
AULT_ABBREV));
> > +
> >       ret =3D 0;
> >
> >  out:
>
> Do other commands in "git history" (split is in 'master', drop and
> fixup are cooking) behave with similar verbosity?  Consistency within
> the same "history" umbrella matters more than being similar with
> other commands that can be used for similar purposes.

They do not, they are thought with the rule of silence in mind.
However I think that this output is valuable information I might have
explained myself better at [1] but my thought is:

git history reword aabb

Now that I have my commit aabb rewritten I want to check it again just
to make sure I did what I wanted correctly, but git log aabb is still
the old commit, the rewritten one has a different hash which I do not
know unless I search for it, if it's far from HEAD I'd have to git log
--oneline, get the hash and then git log new_hash. I think that git
history reword that does have the information about the new hash
should print it to avoid this search.
What I want is something like:

git history reword aabb
Successfully reworded aabb to ccdd

So I can just git log ccdd without having to search.

I want to say I haven't looked as much as I'd like to split, drop and
fixup, but I think it would be a good addition for them also. On [1]
Patrick wrote about a --verbose for git history, I think that the
basic information i.e. at reword which is the new hash should be
always printed but if it's preferred it could go there.

For split it can print the hashes of the new commits like:
"...split into ccdd and eeff."
For fixup the commit hash also changes, so the same as reword.
The one that will have more friction would be drop is the one that
doesn't end up with new commits.

[1]: https://lore.kernel.org/git/CAN5EUNSAOMRvmLGVfzQiwWoOn9VGNVU5rVMZizOry=
n_q2fbCNA@mail.gmail.com/

>
> > diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> > index 54ea8a7207..4b22d761e3 100755
> > --- a/t/t3451-history-reword.sh
> > +++ b/t/t3451-history-reword.sh
> > @@ -416,4 +416,18 @@ test_expect_success 'aborts if the commit message =
is the same' '
> >       )
> >  '
> >
> > +test_expect_success 'prints feedback on successful reword' '
> > +     test_when_finished "rm -rf repo" &&
> > +     git init repo &&
> > +     (
> > +             cd repo &&
> > +             test_commit first &&
> > +
> > +             reword_with_message HEAD 2>err <<-EOF &&
> > +             first reworded
> > +             EOF
> > +             test_grep "Successfully reworded" err
> > +     )
> > +'
> > +
> >  test_done
