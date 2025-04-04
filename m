Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37228DF5C
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743733733; cv=none; b=XRbr6Qnllcqns46QGOulmnvnfQCL7aHX6e4ufXweuzgHicy8Z7x9sfHfZyF9BiTB5RxnT0Wy3HHvqmHvpFe3WU2KGMmS6OZhMPKb/iu5D8eTnRMnQYsEyIXsDAatfIWDiNKf/dguNeaFOzxLrqpDaKfeZjI0sBC7GIkqeG+K4Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743733733; c=relaxed/simple;
	bh=pUk6PmcjGPi9PijUco7QleSN9BR2hgXuU4wDTaAXCyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgNmerh+gPu5y4/mBkOwDP42sXEok5SbK0uIGLuG5yvKOvccL3DkZMmXWd6RrsY4nVCt8jDplgn/yisPInV8bbazGDusqWLx/vPN6eiAgmNJut1Aw5wD2BIBBdRvE9U2CCOHsnnzskr5wsFOFsWOPPnZzJ1LeOlJhBnQz9z43ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZm4n0cA; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZm4n0cA"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d45875d440so6209935ab.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 19:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743733731; x=1744338531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hszZOGf5DE+Nn5NqtjSm+4eK30ciV5T1GkZwcHkMawk=;
        b=eZm4n0cAyVCsCiV+fxj6gnGeaMCKpPOtBp4iY9NePwJ9919Bf+sDEBHLiuF8PfDKJ6
         s+Y6jClksD59K3GuoBAB2y/uaoDd7ZToblbXOwTnrnHD8pYZCjtgGCjJ6T6y0+3VamHv
         XdsCH2OrJ3wc4FiH3b9Qcwh19eBZWk8fMR2STg7U/znciE+1gAXr1WRE23xW5Qlv8xWb
         z5vWIy9XU23XwuxL4/Bk23b0/Zrps4aAwwJMlnQnlE3kUlOYcMjKjzvo0aU4oC2o3zMf
         59nUxOKX8eIDfUvS4PGRgTP0xidsWPcuyYSTKrFtBlhpG/tlgeKYFhTwVlJFYpv3phOc
         RCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743733731; x=1744338531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hszZOGf5DE+Nn5NqtjSm+4eK30ciV5T1GkZwcHkMawk=;
        b=JkUDSErks+y+WI1aNSCGTVZV/SJp92MDAnnoDU9fABnjznyKE9GWyknl/7shaN1oKj
         5k45Ndc+vQOffjeRPABwlZmBnNoh4NRzWOINvKBkD8QpwFrA075jB/wkYIe4jx5PtZyX
         fSlT28UzqekE3WMTz4Hl5ovd7yUmJ0QmHQmLanoCAKLdmUTFoetpIVkyrjalWkN9FE8a
         EDAUXGn/GiOCmA9LW2M5kdVUFRvRsKNMEoX5RUWD3rX5rmbo3UvosCVDWuizwF8Cs+sR
         1Jq1fSgzWnEiZj1D8EDp7KMyfDmC33LK6RMxJx3Ijbb7lqA6eR+A8PG4XuptLe7YEtG5
         GW1g==
X-Forwarded-Encrypted: i=1; AJvYcCXz5dJLeXT5cxMaw9Xb2vXj9S//+oVk/8gDQYTMh9NNcyCmr0eDrjwGsncYVpa/Chzw3+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NfjmBzO8EG6rY9yRqo69ogX393Cl24AqFZ1iwoay+Op9cb/H
	r9SsX9p28qZSiEP/DoGH1pMzi3RmwyLtzY3qpLaZfVce0SkxAmV8iqfIjCr9M9fdsjO54F1ORsO
	B+4D9ii0os5GaKb2NoS16FcTbATw=
X-Gm-Gg: ASbGnctPKvzMrPcmFgDon69wZjcnaQXr7W6To6/q2pkCcQdzLZiY/qKVYCiwEeluTqZ
	NbQVoK/AE8jnlscIFkpxe6vt+MTmVqyFKwgsdYQMCfkvoFfaqfF3KHFPKtsOOTy3yyOfNppBCm+
	GMAS1PxDeXzKYiUjL3P4GVlgnP0VLAYq3yFMbW+V8vOBbJ1jdGDzC9xOYxl1I=
X-Google-Smtp-Source: AGHT+IFr5LIq1DYFSKBihHKDLJHKtrdrjCSftjJZACEb9sAyuRIVmkS1ya66mt6s5YjSku2tkHnbdHKI8urSSqKn/88=
X-Received: by 2002:a05:6e02:3e03:b0:3d5:890b:8ee with SMTP id
 e9e14a558f8ab-3d6e3eea2b1mr21318795ab.2.1743733731069; Thu, 03 Apr 2025
 19:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
 <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com> <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev>
In-Reply-To: <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Apr 2025 19:28:39 -0700
X-Gm-Features: AQ5f1Jq04227YqIFe5SqDmw74fRU-cBi-ehfq-itN3Bx2x1PfIK92L0N7Z8cS8E
Message-ID: <CABPp-BECTrVp9X6bVmzU8LEeYsC3KbzeJvAaDPN+FgZz_uEhmA@mail.gmail.com>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
To: Remo Senekowitsch <remo@buenzli.dev>
Cc: Martin von Zweigbergk <martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, 
	Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>, 
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:40=E2=80=AFAM Remo Senekowitsch <remo@buenzli.dev>=
 wrote:
>
> On Thu Apr 3, 2025 at 5:39 PM CEST, Elijah Newren wrote:
> > On Wed, Apr 2, 2025 at 11:48=E2=80=AFAM Martin von Zweigbergk
> > <martinvonz@google.com> wrote:
> >>
> >> There are many benefits to having a change id even if it's just
> >> local. I mentioned some in my email to this mailing list in [1].
> >> For example, it enables
> >> `git rebase main <change ID>; git switch <change ID>` without
> >> requiring the user to look up the hash of the rewritten commit.
> >
> > But <change ID> isn't unique, right?  The whole point of having the
> > change ID is to preserve it despite edits (e.g. rebase, commit
> > --amend, cherry-pick), meaning that you end up with multiple commits
> > with the same <change ID>.
> >
> > Why would this work?
> >
> > And if it does work, isn't it expensive since you'd need to walk
> > history to find it?  Or do you keep an extra lookup table on the side
> > somewhere?
>
> For rebase and commit --amend, the way Jujutsu deals with those is that
> all descendants are immediately rebased on top of the new commit, and
> refs to those descendants are updated as well. That means, the old
> version of the patch with the same change-id becomes unreachable. So,
> at least most of the time, the change-id is indeed unique.
>
> This doesn't work for cherry-pick, more on that below.
>
> Some of these features are not in Git yet, at least not to my knowledge.
> That means getting the full benefit of change-ids with Git itself
> would indeed require some more work. I know of rebase.updateRefs
> and rebase.rebaseMerges, which move the Git experience closer to
> Jujutsu, but don't go all the way. AFAIK it's not possible with Git to
> automatically rebase --update-refs all descendants of a commit that is
> amended or rebased.

Correct; that doesn't exist currently.

> Jujutsu does keep a separate index of change-ids, yes.

Thanks.

> >> There is a design doc [2] about the impact on Gerrit and how to
> >> handle various cases where the client doesn't understand the
> >> `change-id` header. That also includes some discussion about
> >> whether cherry-picking should preserve the change id or create a
> >> new one. I think there is a lot of value in having a
> >> standardized header regardless of what we decide about
> >> cherry-picks.
> >
> > cherry-pick & rebase preserve author name, email & time, while
> > creating a new committer name, email, & time.  To me, the change-id is
> > about the authorship, and since these commands already preserve
> > authorship, it'd seem weird to me to have cherry-pick not preserve the
> > change-id by default.
>
> I'd say Jujutsu, Gerrit and GitButler think of a change-id as associated
> with a unit of review. (Although it will naturally support reviewing
> sets of patches as well.) Usually only one person will push commits with
> the same change-id, just like people don't usually force-push over each
> others branches. But that's mostly about avoiding logistical problems.
> When an employee leaves a company or is on vacation, it can be perfectly
> reasonable for someone else to take over their work. In that case, it
> would be appropriate to preserve the change-id, even though authorship
> has changed, because the history of code review on that patch should
> stay associated with the new version.
>
> Cherry-picking on the other hand often represents a separate unit of
> review. That review may revolve around whether it makes sense to
> backport a bugfix at all or any additional changes that may have been
> necessary to make the bugfix work in the different, older codebase.

I've worked with many projects hosted in Gerrit, and they all had a
very different view of change-ids than what you've espoused here.
They cherry-picked changes to other branches, fully expecting the
change-id to be kept the same.  They often checked to verify that
important fixes had been backported to all the relevant LTS branches
by looking for the change-id.  So, we'd typically have N+1 commits
sharing the same change-id, all reachable from existing branches,
where N is the number of LTS versions still supported at the time (and
the +1 comes from the main branch development).

> As mentioned above, there's also the issue that preserving the change-id
> on cherry-pick likely results in duplicates. For Jujutsu, it would be
> nice it this was avoided. But it's not infeasible to deal with that
> either.
>
> For Gerrit, it would be important to be able to track a change across
> cherry-picks somehow, since that is a feature they already have. If Git
> decides to preserve the change-id on cherry-pick, there's no problem
> for Gerrit. Alternatives include storing a separate cherry-picked-from
> header or enabling the -x flag on cherry-pick by default.

Cherry-picked-from trailers can be nice when it exists, but much more
frequently than one would want it provides a dead-end.  People will
cherry-pick a commit that was local-only, or only found in some
security-embargoed repository, and you'd end up with dead ends.  You
also occasionally get chains: E cherry-picked from D, which was
cherry-picked from C, which was cherry-picked from B, etc.  And more
complex structures are possible.  And maybe part of that chain was a
local-only commit or some commit from a security-embargoed repository
that you don't have access to.  Then folks get to write scripts and
try to deduce relationships from those trailers (e.g. hey, these two
commits both claim they were cherry-picked from the same non-existent
commit, and this other commit was a cherry-pick of one of these two,
so they're a representation of the same logical change on these
different LTS branches).  It makes it a hassle to try to determine
which LTS branches have the appropriate fixes backported and applied.
I've done it, but I thought this problem was logically the point of
change-ids as found in Gerrit, honestly (well, that and its byzantine
push to refs/for/$BRANCH stuff so it could automagically determine
which CR that your push was supposed to be correlated with instead of
just letting you specify via a real refname in your push command).
While I understand that having nearly-unique change-ids let you use
change-ids interchangably with commits, that seems like a questionable
benefit over being able to actually track which logical changes are
the same and have been applied to which LTS branches.  I fully realize
folks may disagree...but if we're suggesting commands like `git switch
<change-id>` which can only possibly be meaningful if <change-id> is
unique across all branches, then what are we supposed to do for the
many projects which use change-ids for LTS backport tracking?  What
does `git switch <change-id>` (and any other command where you attempt
to use a non-unique change-id in place of a unique commit identifier)
do for them?
