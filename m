Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FB43DB9B
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 16:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161103; cv=none; b=Ztq7wBFtIjqTwq4m34bT3VO7FwicBHVbGhAQMCfEU3/ba0XeXOXgWbpcb60cEbI8g8+nOgFxtR/ntawyAzsM6G4q9olRIsSt/LECBKth9k4Kog1aHphvQujTgHJ7aEUuSkwI4CO4AHvQdKlSh/HayQuSDroz0mMatdYzDG7Cax8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161103; c=relaxed/simple;
	bh=qW8XTaa/F2+/WMXNgdAMIU1lyAdmLpEKbQ20bP6FKsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVHBB0FlZD50AeBDVGKA60HuMJdgxiXtlfz79x/zFWKja3MT+p7erCMnLe+7RpYNPbUIPNXrRVy/ON5RIEW6c8lEnu5fwu3EdUGQ8Rxc927DH9GyQQ6gyW1tS3TJpqF6b8lMcJMv7oEWyyMbNBd04iPZ7tkTZ+aLeL2uvsD6AqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5sSanXl; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5sSanXl"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a58009fe88so36126eaf.0
        for <git@vger.kernel.org>; Wed, 03 Apr 2024 09:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712161101; x=1712765901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qChwrbOGEtIuRdcHKuLttsWRwjtlb2YPdFHeoz9q8A4=;
        b=V5sSanXlOfT8sJTr2+FyBlKNearYApAzGCfkk0oCHAgVppuY7Su/svnQcSmn4mVgZq
         IO4pV000JGKljX9LVa5U8VHId5XOqYQ/qTSpGLBYye52wLsSkY4h/aKYQdAACLhyvCWy
         KIBxwmCDJfTeOsVyLAGy7PZ0jPyuMSXe8CjIQXFbu4qGBQhthHnDZxVZF8e0BmouE3+D
         WILM6+uZ0QL3Snh8Fx6twqm0EiBXt2OKRl8VY2RucF12ajYmsdAga2jSyopzKHrPb4vv
         hcSzK48SulPyB+r3aZknIDxOr1GmACYFtJQGyspECM3oGgax9z4LinF27t/4jS0rWaB/
         1IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161101; x=1712765901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qChwrbOGEtIuRdcHKuLttsWRwjtlb2YPdFHeoz9q8A4=;
        b=VpmVIObS4nWIlI9HhLk/Ouq4uNsd9Evy1F/ifBMeKpnOTyAljiFohmKWWaUjIWwg1y
         ZBJ4slKuTJggQZ/vhUkB0PnhBaD+7aPnW4Pc89qD79P8hWzG7dSvHOtkxo1SRJb5ReQM
         QJpsC8+132mEAGhn556ysFB5LN3hAB/TEeo08BRd3wdHPlInzbmhXrpgzPvs6BfzaH/E
         OxwDf66RbbbOMNj2L4i+UAwU3mfFsIy4AaBrYdTBRvLSg5N05RFGeV1Ev0WItxcD8Fbp
         sbbqUIGpH/IAQUYOXj1bZzpl2ZX91mArLNTpFGb1XMNmG8bpEwWBexbmYyqyMSErRvPT
         Xn+w==
X-Forwarded-Encrypted: i=1; AJvYcCUUWCymKikD7vbGk+3biW5xE01sTUk4r00bzADCykbNXb77CyycwQ3wPFbOcJaYHgbJQUF2/9ugBwa+bX92O5DQ91W3
X-Gm-Message-State: AOJu0Yw+R+h3dFMQ6JZ4L7Awd6hH4Jz7obRy/OG4YpPKszOwswijgvGf
	33VwGyo1vNXkZujAMpQOSqfha8YmBsCKNu+x4tL3JTQ//zEG8iQPrVB5RMDWRi8nokMosGX50sB
	1y+ONcObQcMmvhNkVUFiVOpR01Mu/M2paLMI=
X-Google-Smtp-Source: AGHT+IHgFHv5gGdmoZ4+OtJoegNZKezuNDxXzixSgmqH127abLa8WIuO/lSShBi3MRa7UOwuVLReTob+BJUyB2YdkIg=
X-Received: by 2002:a05:6870:2411:b0:229:7b8e:6b82 with SMTP id
 n17-20020a056870241100b002297b8e6b82mr18203968oap.1.1712161101095; Wed, 03
 Apr 2024 09:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
 <0f65aae3-15a1-456d-8285-7923a880deea@app.fastmail.com> <CA+2m0i_zGcFBd2+L_Q_foMQ=eJbXqUZGqDeOwfefg=Y4GMBRWw@mail.gmail.com>
 <781ba921-e11e-4c9d-8764-1366b3043375@gmail.com>
In-Reply-To: <781ba921-e11e-4c9d-8764-1366b3043375@gmail.com>
From: Bill Wallace <wayfarer3130@gmail.com>
Date: Wed, 3 Apr 2024 12:18:11 -0400
Message-ID: <CA+2m0i9JE92EqoZgNKTQn8FdY8cAxVLupa1fyRPNG_RN=5H1Cw@mail.gmail.com>
Subject: Re: Worktree shares a common remote with main checkout
To: phillip.wood@dunelm.org.uk
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org, 
	=?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It helps, and I do that, but I really want it associated with the
worktree so that I can work on projects for different vendors based on
a common open source framework.  What I'm trying to avoid is
accidentally committing a branch to the wrong vendor's stream or
mixing changes between streams.

Bill.

On Wed, 3 Apr 2024 at 11:30, Phillip Wood <phillip.wood123@gmail.com> wrote=
:
>
> Hi Bill
>
> On 03/04/2024 15:26, Bill Wallace wrote:
> > The problem is that one wants different default remotes for different
> > worktrees - for example, suppose I'm creating a worktree for two
> > different projects, plus the base repository is on the "origin"
> > default remote.  I then have:
> > base_repository - a directory with the base/default origin (call it
> > 'origin' for now as the remote name)
> > project1 - currently checked out with 'feat/1'
> > project2 - current checkout out with 'feat/2'
> >
> > Now, project1 is being developed against a remote repository
> > 'project1-origin' and project2 is being developed against a remote
> > repository 'project2-origin'
> > However, both are getting merges from origin/main on their own
> > projectX-origin/main branches
> >
> > Now, when I'm the directory for project1 and I do any of:
> >     git fetch
> >     git checkout X
> >     git push
> >
> > I want the correct default to be chosen for the remote - for the
> > base_repository that should be 'origin', while for project1 it should
> > be 'project1-origin' etc.
>
> You can set a different default remote for "git pull" for each branch by
> setting an upstream branch with "git branch --set-upstream-to" which
> sets "branch.<name>.remote" and "branch.<name>.merge" or
> "branch.<name>.rebase". You can also set a different remote to push to
> by setting "branch.<name>.pushRemote" - see the "git config"
> documentation. Would that help?
>
> Best Wishes
>
> Phillip
>
> > I KNOW I can specify those manually, and git push will give a
> > suggestion, but I WANT all of them to default to the correct remote
> > associated with that worktree so that I don't accidentally pick the
> > wrong one or forget to update the correct repository.  This is to fix
> > dumb fingers that sometimes do the wrong thing without thinking, and
> > to try to reduce the number of things that don't get done
> > accidentally.
> >
> > What I'm doing now is to create a new non-worktree version against the
> > projects directories, but that then doesn't share any data.
> >
> > git remote add ... has nothing to do with this, but I want something li=
ke:
> >
> > git worktree add project1 --default-remote project1-origin
> >
> > The idea is to make the expectations of what happens to be consistent
> > with cloning a new directory, or at least as close as possible to
> > that.
> >
> > Bill.
> >
> > On Fri, 22 Mar 2024 at 13:29, Kristoffer Haugsbakk <code@khaugsbakk.nam=
e> wrote:
> >>
> >> On Fri, Mar 22, 2024, at 15:50, Bill Wallace wrote:
> >>> This issue is just to fix an easy to make mistake when working with
> >>> multiple remote origins and worktrees, where it is too easy to push t=
o
> >>> the wrong remote origin because one can't set the default origin on a
> >>> per-worktree basis.
> >>>
> >>> What did you do before the bug happened? (Steps to reproduce your iss=
ue)
> >>> Used
> >>> * git worktree to create a worktree
> >>> * git remote add to add a custom repository
> >>> * git commit/push to try to push changes
> >>>
> >>> What did you expect to happen? (Expected behavior)
> >>> Expected to have the git push recommend a remote origin that matched
> >>> the worktree, but it defaults to 'origin' all
> >>> the time, which means I need to checkout a clean clone from the
> >>> specific origin I'm making changes for so that I don't accidentally
> >>> push to the default origin.
> >>>
> >>> What happened instead? (Actual behavior)
> >>> Suggests 'origin' as the default origin - which is CORRECT for the
> >>> main git branch, but I want to use worktrees to allow working against
> >>> several remote origins, with the default being determined by which
> >>> worktree I'm in.
> >>>
> >>> What's different between what you expected and what actually happened=
?
> >>> Suggested 'origin' for the --set-default rather than allowing me to
> >>> define the origin I want, for example 'wayfarer' as teh name of my ow=
n
> >>> remote that I have cloned on github.  The default origin is still
> >>> supposed to be 'origin' for pulls/naming, but when I push, it needs t=
o
> >>> recommend the matching origin.
> >>>
> >>> Anything else you want to add:
> >>> This is a bit of feature request, but the reason I'm listing it as a
> >>> bug is it makes it very easy to make a mistake by pushing to the wron=
g
> >>> origin for a new branch.
> >>
> >> I don=E2=80=99t understand the expectation. git-worktree(1) just gives=
 you a new
> >> worktree to work on a branch, do a bisect, maybe a rebase and so on. I
> >> expect `git remote add <remote>` to have nothing to do with the curren=
t
> >> worktree that I am in. A remote ref is for the repository, not
> >> per-worktree.
> >>
> >> If you are creating a local branch based on this so-called
> >> worktree-specific remote and this branch exists on this remote (and
> >> *only* on that one) then you can use `git worktree --add --guess-remot=
e`
> >> to automatically track the remote branch.
> >
