Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93AF25B09E
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017683; cv=pass; b=AiLSHc2X1bKyoWOjeQDR1yVNRhL0Hsv7En/Tu8gMjk1KyE9OEXk8/efiV1tZUQBFEskdEpH3DqFUWe4PBEe9RRwSB/kfRBqDuImCdVNZoW+d6fJCwcwTxpsrhtAb8G2sK8sC5k47f4We+shosbifEGGqLOuoPTRQRgKhuLZxguw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017683; c=relaxed/simple;
	bh=lz9CeNIxmfFl8jiRe3JB8PCgn0bM3BWrDiiw4EXsPZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so6kxkenPLJeH6gknOMc4anmT4sd5Inil+guyKGtN4K3mRcweTq8tqhLXuwi9adPI0hVCD3tWIMQnGXImhNcbIQ6Z3vgzuWASrhFBx9kj4PW+JMK7ZnhyHC8chMraNJ1BkYKnSGknfuUjDMNgZIqhcMyIldjkh+ZdYBWIuF7Uco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABhXKOiz; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABhXKOiz"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8487088510aso2857718b3a.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 05:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786017682; cv=none;
        d=google.com; s=arc-20260327;
        b=SRunomjPEexDgKExqLW4q7FYoooKIFw94TgRc+fy6cnYjFrD88bbLSntwZfHCPlj6x
         +sHoLGcg9TRHu6Rm7WWZdiViF7jNA+VtV9TvgKyU3alK0O+PactSZ11As8fHMBJfZD+m
         4O3YSO/Cemhf19dnKNfyFw7srWbpRvjwoErH2uBKQsOJsWVKL6OnNXCDnl9L5qZWEYp6
         LX/4Q1/eKdJR3Lr54+PdDEYaFOT8SNdsXyoADho//NXeCQs2g0RiNaoiUnFhZLgkiJ9T
         h7hao4Tx8MK03YOKc2Gzf1zQbBUahq5m4PyzunFBXrqCkpEY3/M0q0YPV0NdPKWPjBFX
         b6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vb25Li7ckMN1G+nh9iY4UBGxqydiRQh1QKct11sJFHo=;
        fh=58aqjzKBLtwKAOUAhvXQSojgvObQuwGGhumB11Owezg=;
        b=mvs7eWYalFS6yZdgsNNYJwRizTTHb+t+cMDuXauwlITJ8fIkH017BJU0y1IE3rijgA
         6Ac2huLEiEfKzEDMWy0QX91fKAubou1Y4L3bpym8lNj+JHxazM+HRzDrXhsStXZjTeQa
         PytlJLzwFr2u24mkzSoTonyS9jXChCKftF/iCPr9JMjclMj6P8tcOV4KIZgvHqez3EZF
         JMSzCVJkwLHLlABKI2psePHPa/1TYJMk0Yy9nXOHilLeXp0COVMxpIlgw2jE1hVZkn73
         CkjRsSTW+vUhCcYQBrBRG+gtgpI9j3957W3Rp0I/Sm1zWdvsmwRBagrG2pSpnn7DDfiM
         ZMKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786017682; x=1786622482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vb25Li7ckMN1G+nh9iY4UBGxqydiRQh1QKct11sJFHo=;
        b=ABhXKOizt0jJ/IOAw3hxKceOMYVx2B4A3XYHJqMq+r+EsCbsIjRFFaHn8Fue2YHpFq
         ugYrwS6G1QELAIi7gdmm1TSSOdHCj09yH354fGRbAlxpwc02JGel9qVdU2EZ+5BRmEGh
         UQ5Zu0SjXzBuhxOjA3L7E4JBkbEeSTc1TU7LPsUbwk1jga7d8QAmsTLSh5t0oWCpJINX
         Z8k3U8j9bS9IL8jG5z9T4bNOrH5xlnbn/82mVmhyDyg9uTsQMZkE7PZeIFdxlAZJSXRe
         Wgjcs5aUrIUQvtz2kQqPL5Dn/c5Uke3/ms9FbzlHPoI9VsUUpdjvZWtS+zI9PmVXUyQg
         /T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786017682; x=1786622482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vb25Li7ckMN1G+nh9iY4UBGxqydiRQh1QKct11sJFHo=;
        b=Y5wAgr4bgFPYiH79/KUFabdy+kCQZ+tr/2Fek3H36CtQrXJdc4EeTWO3+8EeRUbu8C
         TT3uvgawYS10HqaPPcV0yZnTyBSDwMvYufKidxQKvohAuPw4fl++wpdmvSe28T3uWcEz
         9R84x9Z5V0lrW7A/1+itG0fLWqqdtWr8nookZ3sBa3z8WA/ASa8jkivdQjz0nfWYRoCZ
         jlEoMsep4nI0+iP9X771CW7GeYDC22W6RKG+N1AvazkrVLQmsdmyDjf2nTg5nkxEhITA
         XFlTLYUgI4PisnH2J2s6E15uiNkU2X+yPXTqAEa8BRPgOvcJFob0RglynSKJiJTUOWFr
         U4yg==
X-Gm-Message-State: AOJu0YybIuGva3Z4Sa6tf15gxlTLw5d39FY87+TQ1cP3z6tvSWSYycGA
	uPSAsYqHhbEbPC5YiKX3ZkqmKilmCuZjDCMIzB0FMFlSNvrMwC7lPcsD/oJYDqBXh1lrbeECucQ
	p8ozhyHcJ1CUyrSpDEATPtYGvnIeX0MUYVOTY8NQ=
X-Gm-Gg: AR+sD11ObdRAncaCbOMxyJrNbfzXi6cH1RfLG0I9lBu01LHKNVqhZJrjww6zw9sM/7x
	/6FIQIIqO2cmgan3pg0tzzwMGaYMsSGhe4SqKh/hdSUEJqi0HMnumV2sXkHzsoN2zigTVEsdU6O
	5QwKK3cfKARCXErKNBRhTQcYLECayfbxBmqKdQE/dIsNGtisw+NY2eohVuPRlVh9YDVGXq+T76a
	X0pydqbPtEa18kkoIXfPBcgGCdYn6n9rqJCyUkYNzyaXcYcEuopGTs208Feg/1H2HxCLxO8NQlQ
	AoGF8w2/9GXpnjtFtpv9pgcky6JrhJyXkj6LN74NiWkJpyheBK7ORrPQTyn8+xRUDOK9zY7VId3
	KgflyGfWhySybNgGyM+iBoinqfDndt302qwtXw4V5gbKYjTRvINSu6sq/xe9rWglUhT1ZargBf8
	8ymMHzazu1Im+iCZTQh18=
X-Received: by 2002:a05:6a00:409b:b0:848:467d:293a with SMTP id
 d2e1a72fcca58-84f2e12c9e9mr17560419b3a.35.1786017681625; Thu, 06 Aug 2026
 05:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALnO6CDh6kbL5KH=Nt00ksZCaDbJAnjbepU_tyRTcbGekSyeMg@mail.gmail.com>
 <307abaeb-b033-4c55-8edf-1ea765199dce@gmail.com> <de96a0de-a0a3-4e3e-b44e-8991f8ae87d3@gmail.com>
In-Reply-To: <de96a0de-a0a3-4e3e-b44e-8991f8ae87d3@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 6 Aug 2026 08:01:10 -0400
X-Gm-Features: AUfX_myWLy9S9veyvTZU3KNzd_mIqgAkWsWqk7j-tyNH7XKM3-muVVOETMwzuZg
Message-ID: <CALnO6CC82PCbYrrj4nGPSjs=+U5tsZo5XuLpO8DXtzPiNsJAUA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_BUG=3F_git_rebase_=2Dx_=22git_commit_=2D=2Damend_=E2=80=A6=22_lose?=
	=?UTF-8?Q?s_notes?=
To: phillip.wood@dunelm.org.uk
Cc: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 12:30=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 05/08/2026 14:42, Phillip Wood wrote:
> > On 05/08/2026 14:13, D. Ben Knoble wrote:
> >> Sigh=E2=80=A6 I haven't minimized a reproduction case here yet, but ma=
ybe
> >> someone can tell me how I'm holding it wrong.
> >>
> >> I have a local branch with notes in refs/notes/benknoble/commits (in
> >> particular, the tip commit has a note). I forgot to adjust my author
> >> email before creating some of these commits, and I wanted to adjust it
> >> to match the mailmap patch I just sent out, so I ran
> >>
> >>      git rebase -x "git commit --no-verify --no-edit --amend
> >> --author=3D'$(git config get user.name) <$(git config get user.email)>=
'"
> >>
> >> Upon checking (much) later, I discovered the note was missing! It had
> >> not been rewritten. And yet:
> >
> > I suspect the note was rewritten to the un-amended commit (i.e. the
> > commit created by rebase before it ran the exec command). The way the
> > note writing works is that as rebase picks commits it remembers the new
> > object id of each commit and after all the commits have been rebased
> > passes a list of "old-oid new-oid" pairs to "git notes copy". If a
> > commit gets amended by an exec command then we don't record the new
> > object id correctly.

Ah, thanks. That explains what went wrong.

> > I have some old, half finished, patches that try to
> > fix that by making "git commit --amend" update the file where rebase
> > stores the list of rewritten commits. I think it worked for exec
> > commands that run "git commit amend", but the effort got bogged down
> > trying to improve the way we handle commits that are edited. I've just
> > pushed them to [1] if anyone is interested (though the commit messages
> > are dreadful so I don't know how much help the patches will be).
>
> Another approach would be to copy the notes before we stop for an "exec"
> or "edit" command (the latter is complicated by the fact it might have
> conflicts) so that "git commit --amend" could just copy them to the
> amended commit. If we did that we'd want to copy the notes in-process
> rather than forking "git notes copy" before each "exec" command.

Yeah. I wonder if we could give enough information to "exec" commands
so they know what the old OID is, to let them decide what to do with
it? That is, could we expose the old=E2=80=93new list rebase keeps around a=
s a
readable artifact?

The other option that occurs to me is to have an easy way to feed
old=E2=80=93new to "git notes copy" (or any other command) *post* rebase. I
can get at the mapping using git-range-diff, but I still have to
copy-paste or parse the output in a way that feels likely to be
brittle, I think.

> > [1] https://github.com/phillipwood/git/commits/wip/rebase-update-rewrit=
ten

I probably won't be taking a look anytime soon, but thanks!

--=20
D. Ben Knoble
