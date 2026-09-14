Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF93A7593
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419141; cv=pass; b=PwNMaEtJrbuua2nBPWV7l+xtCsapoDt+fQWu+UBgO0QvxTvkCJ5rhVuMRJtUC0z/nHR5PgZRwKErvagkU1EP9BWM6SMhGEpBjuTH/LiGMmT5HkZ0Zaek4zhj8eKNBsJBE5A25DdewITN00V7JKFMlTcSEaYgOxGgYrVIF5p2FYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419141; c=relaxed/simple;
	bh=cUG+b+m92M+pxLPvjsf3i+K1xYQaIljlY7M+jTNQjKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVxY9UAZ4tnsfN7td3b491uQ2j1DOBiJzVlX8jZH/noLiDggdYh4pHY/GALJ1t81N+8502Ek0gRIVQxjT46C8wEbtgCiKgDV8UkMFmff/yP0nqkFm6S1gUzuWj4f69gpFOnDA6hd/B7yT2FJ5oQ9OCl4rvtZG5Ma9So3pvajwqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqVMAnEc; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqVMAnEc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2dd020a2e44so35244695ad.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 13:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789419139; cv=none;
        d=google.com; s=arc-20260327;
        b=YAix7Tvx1W67uWWDP5VBWkOZdj+FiUYwWNthcXip11MvzFK1cHbcSvqdBzLQnwVDT/
         D0a6KgYzj7FDCgGtb6Mh3ippHAGHLS5fFtRP23YKxnJ2Wzry1iGubyBWZxxVdHxS8vUX
         oRbGOmZq96pAXt5NoyLfcBTTJje5Z7vC8STtiPqIaTMjj/iSxdorlfCO0XeAXA5B4pev
         GfHoxw/xwk2U4rkCkECDNH9RRdUONFoGyFlr+MdwpdsBQZLJjd930yIMGiAbf/LeLU+e
         E47gUgN4XWEn6vN/LAm90CCE954oJ6JfOcWpGbFKRnMNUSFhPyNewo9bqAlRNozawLFl
         1oAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jamIKpUchTvTEBamMVX0xuoSuugiUNDUusi33LH9Sqc=;
        fh=7SnmKOQODkq4e20rl3LLSfm6mhdBKxnqqO99/bzjX3U=;
        b=d7MBl65/RYzNH6+gVHCgea5MZ8qobMi5iw6Khi/OrsUjeDO6xwVhkO90WrdO3FOSjK
         HXO2bJGgQS9TBcyg8gRIx15osFk8oQShr6OveXGuvnIMXYXkAWHYPhS+ZSG5vwh8TY3o
         KJ3rq7o7pXkaHdlb+QftZoqUxtp05I2DYe+X7FbewYZDwfTa8svGzqa15FbQ79pUB0yN
         vfdGSKvQhrMMQUap6lYFSgqgVDEjVr9L7WEJOHRHvnMWL8xIBFykMHjBUXS7egYtXkiK
         pbzVYTKCYhHMVYdutBi5KJeKEaIw6sgDGZYm+4K/UwFyZtAwL/KSy1CMyoeqWSZSRe/R
         nx2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789419139; x=1790023939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jamIKpUchTvTEBamMVX0xuoSuugiUNDUusi33LH9Sqc=;
        b=ZqVMAnEcwY8d/Cd+mlCjEPyf6kApwARbyq6w9m69aK5bV4vrhOoxSe1nCfLuSSsp/f
         ActpV4eTbQUdVPvp8yD94+/GK9Giwk1NteeCiFVGJLfPduA5iE8NTO9AaSU4LyKtdVe4
         JdOOVO6s1yU6W6mxleJi5rd41c8g91UIoK2LqC6nliKyuCjcQM9iElahC7sBX+jX5Dba
         gYgsz42IOGU0BtWPLcohPqr1eXVGqnzOMjKmx7++mu9eJRoQ27woJC5rG7AhYLJ8RInJ
         GZ4o2/64wC3q7QADT70SAGxqPotLmzDUboWSkcXslRvi4F4gcBiHQ5JYvpPq0To7MQy4
         wnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789419139; x=1790023939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jamIKpUchTvTEBamMVX0xuoSuugiUNDUusi33LH9Sqc=;
        b=vmqZI+MFac0iMnmY4pUJczPBubYw/9ijqT0JkaTuxRcxq5tu+5omx5IDM5SqMk2cYP
         pvhc12igy3fjPTCkqOy1j1W/rKJCFw+OUxJyAYA9ioYg+qdP1zWTcGiNTmxzamrAzcJs
         IuNkSVT5s4LXegewvXB0fdmeiB53gdUvnqAmt60Qr3P6FuAKbGaGn2PMJwAGIBL4Uqmv
         JR0UfCeuwwF1IOd2EeA8k7Dcm/dKiiPahEoFXvF2vOxdmeKgNRpNn+lJIpBQNzt/H3No
         2qcFuwgZPRsztVmJ5nv1aSbCyoFTYWbqk19+ACdm51CJH3i/+a/HFP/uDQKN+UxlbmUO
         UABQ==
X-Gm-Message-State: AFuF++nsY8Wyn3ExC5kQPmPSa3lBfU+oNMO2S3LrEcsJHZjJ6z0IMcuf
	JFwBLv2TLp9HM+bHqCfmhBBT/MjPJTY6edBJeLtyRf//qihUhwX/yUcQ3KwdCv1indO29QwHOhP
	Laocm6uKsfHKGD5sE0Pa0IhdZm54P3bU=
X-Gm-Gg: AYBFou0bq93dbTiCLKeMf0A81j1/OCM6qZ52MWdkCM4JD+yLD49iurgvOnBsqndyZfg
	oAgoAEGIMM6wMg/qki65gRCMpNni3sJp73uxLU0V6KnRydeNIY+XnND7BgVlVV4Jb8p7JbNpd4L
	GYk1nduPvvAj2CZixsIMYMFxtVz+jaEXvQKmW8ggtS5werF0mg82swma4afxjmeNj8hjyLFLjCk
	+28/LrZ69uzmxw2yhXbD8kGrLJUEWreroQyQW1WekYCaqdCVbxIv52zWfU/IUS1olHrlDxVpyWi
	6yvWwVQ9DaNMpYamuIqwys0N2Gv4wxLuy712Y8FuW88tzEhUM/w+WMzi0RxatNv3q5HCcsSNICp
	BoiCvqerNK8t4Wu/lz6N1jXnm4FwNVwZVN2njmEWmEiR2uVP9q8n3c71M3Kd2PvNZvauQK1OW+N
	2vUEqpg1c=
X-Received: by 2002:a17:903:458f:b0:2d8:d4ce:9f32 with SMTP id
 d9443c01a7336-2dd6c70a474mr74715205ad.16.1789419136355; Mon, 14 Sep 2026
 13:52:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260914040018.76111-1-tyler@tylercipriani.com> <CALnO6CDz8QBcBojmhjgwgWzi4oUbs+V4KVQ1h0+JgN7k0v-SYQ@mail.gmail.com>
 <CAHLx=O=eH=7g=JUn5dOJgatv2xJVbQygK4C7zCA0Uv=BpzMkxQ@mail.gmail.com>
In-Reply-To: <CAHLx=O=eH=7g=JUn5dOJgatv2xJVbQygK4C7zCA0Uv=BpzMkxQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 14 Sep 2026 16:52:04 -0400
X-Gm-Features: AcwNN1X3jbRKKQ3ke1f5y7Opb841ddiPtcPmzWMPEPY7mTIphur-J55zXHVLjac
Message-ID: <CALnO6CAaoNjGmU267j_OnMErxK=vjH-sy9hAMO-WvUFOk9_vMA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] push: check pushed ref for --force-if-includes
To: Tyler Cipriani <tyler@tylercipriani.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 3:27=E2=80=AFPM Tyler Cipriani <tyler@tylercipriani=
.com> wrote:
>
> On Mon, Sep 14, 2026 at 7:03=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.c=
om> wrote:
> > Hi Tyler,
>
> Hi Ben!
>
> > On Mon, Sep 14, 2026 at 12:00=E2=80=AFAM Tyler Cipriani <tyler@tylercip=
riani.com> wrote:
> > >
> > > Changes since v3:
> > >
> > > - check_if_includes_upstream unconditionally resolves peer_ref with
> > >   RESOLVE_REF_READING, now all non-branch ref pushes will be rejected
> > >   when using --force-if-includes
> > > - add test for --force-if-includes tag push 1/2
> >
> > This is intriguing and seems like a significant behavior change, let's =
read on=E2=80=A6
>
> It's definitely true that this is a behavior change and it'll add some
> friction to your process. And it's also true that the current behavior
> is failing to provide the guarantees it claims.
>
> > > Range-diff against v3:
> > > 1:  da27c421ed ! 1:  e7912c3fd0 push: check pushed ref for --force-if=
-includes
> > >     @@ Commit message
> > >     -    Find local reflog using ref->peer_ref. When using a refspec =
like
> > >     -    HEAD:refs/heads/main, we resolve HEAD. If HEAD is a branch, =
use that
> > >     -    branch's reflog.
> > >     +    Instead, use ref->peer_ref to locate a branch with a reflog.=
 But if ref
> > >     +    does not resolve to a branch (e.g., a detached HEAD, a tag, =
an oid),
> > >     +    then we reject the push. The alternative would be to use HEA=
D's reflog,
> > >     +    which is too broad to tell us if the history being pushed in=
cludes the
> > >     +    tip of the remote. We need a per-branch reflog, which means =
that pushes
> > >     +    of a ref that do not resolve to a branch are rejected. Rejec=
ting the
> > >     +    push of a ref like a detached HEAD already happens today (if=
 the
> > >     +    same-named local branch lacks the remote tip); now the detac=
hed HEAD and
> > >     +    other non-branch pushes are explicitly rejected.
> >
> > So, we would now reject a force-push whose source is anything but a bra=
nch (with
> > force-if-includes, and that presumably includes push.useForceIfIncludes=
)?
>
> I should clarify, reject the force-push of any source not ultimately
> resolvable to a branch; e.g., HEAD will work if resolves to a branch.
>
> > >     ++test_expect_success '"--force-if-includes" should reject forced=
 update from tag' '
> > >     ++  setup_src_dup_dst &&
> > >     ++  test_when_finished "rm -fr dst src dup" &&
> > >     ++  (
> > >     ++          cd src &&
> > >     ++          git fetch &&
> > >     ++          git switch main &&
> > >     ++          git reset --hard origin/main &&
> > >     ++          git switch -c newbranch origin/main &&
> > >     ++          git checkout HEAD^ &&
> > >     ++          git tag stable &&
> > >     ++          test_must_fail git push --force-if-includes --force-w=
ith-lease origin stable:main
> > >     ++  )
> > >     ++'
> >
> > Which is what I think this test says.
> >
> > I think this would break a common thing I do at work (although this is =
soon to
> > be deprecated, so take my anecdote with appropriate salt; I can't claim=
 that no
> > one else relies on it, of course):
> >
> > As I think I described in the message you linked, I have an alias "pf =
=3D push
> > --force-with-lease" and push.useForceIfIncludes=3Dtrue in config. Our t=
eam has a
> > "main" release branch and a "hotfix" release branch for emergencies. Wh=
en
> > hotfixing, we first reset the hotfix branch to the last tag to go out t=
o our
> > production environment, which I typically do like this:
> >
> >     # validate that we won't lose any interesting commits (no regressio=
ns) with
> >     # something like
> >     git log --oneline --graph --boundary --cherry-mark --left-right
> > origin/hotfix...<TAG>
> >     # push
> >     git pf origin <TAG>:hotfix
> >
> > (On a second pass before sending, I can't recall if this works as-is wh=
en I
> > don't have a local hotfix branch tracking origin/hotfix.)
>
> Yes, this workflow will break. And it will not work today without a
> local branch named "hotfix". It's broken today, insofar as this is a
> false pass since push.useForceIfIncludes is unable to say anything
> about whether you've integrated origin's hotfix branch into the <TAG>,
> you're pushing so it only incidentally works.
>
> Today, git pf is actually checking that your refs/heads/hotfix's
> reflog has the tip of origin's refs/heads/hotfix. But it makes no
> promises about <TAG>. That is, you could:
>
>     git checkout hotfix && git pull # This line is what makes it work tod=
ay
>     git checkout --orphan junk
>     git commit -m --allow-empty 'Totally unrelated empty commit'
>     git tag <TAG>
>     git pf origin <TAG>:hotfix
>
> And pf will allow that to happen since origin/hotfix's tip has been
> integrated with your local refs/heads/hotfix, which is what it's
> checking today.
>
> > If I'm reading this version right, I would now have to say
> >
> >     git pf --no-force-if-includes origin <TAG>:hotfix
> >
> > or perhaps better
> >
> >     git pf --no-force-if-includes --force-with-lease=3Dhotfix[:origin/h=
otfix] =E2=80=A6
> >
> > probably after seeing a (hopefully improved?) message after the origina=
l
> > command. (Do I need to disable force-if-includes in the more-specific l=
ease
> > command?)
>
>     git pf --force-with-lease=3Dhotfix:origin/hotfix origin <TAG>:hotfix
>
> Should be sufficient and as I understand your process, that's what
> you're after. The explicit --force-with-lease argument makes
> --force-if-includes a no-op, so --no-force-if-includes should be
> unnecessary.

Thanks, I think this answers my questions=E2=80=A6

> > Now, on the one hand, enshrining existing behavior is good for backward=
s
> > compatibility but has earned us a bit of a reputation for not innovatin=
g in
> > useful ways ;) On the other, I wonder if the description of force-if-in=
cludes
> > allows some latitude to break with existing behavior here.
> >
> > The relevant docs say
> >
> >        --force-if-includes, --no-force-if-includes
> >            Force an update only if the tip of the remote-tracking ref h=
as been
> >            integrated locally.
> >
> >            This option enables a check that verifies if the tip of the
> >            remote-tracking ref is reachable from one of the "reflog" en=
tries of
> >            the local branch based in it for a rewrite. The check ensure=
s that
> >            any updates from the remote have been incorporated locally b=
y
> >            rejecting the forced update if that is not the case.
> >
> > It is unclear to me what "one of the 'reflog' entries of the local bran=
ch based
> > in it" means! Ignoring that, the surrounding text only talks about whet=
her the
> > remote-tracking ref's tip (or "updates from the remote") have been "int=
egrated
> > locally."
> >
> > So I think we *could* say that, in this case, we don't have enough info=
rmation
> > from "<TAG>:hotfix" to check whether "origin/hotfix" has been integrate=
d locally
> > or not, and we should tighten the meaning of the check. (Perhaps when
> > "--force-with-lease=3Dhotfix" is given, though, we now have more inform=
ation
> > available to check---but that could be outside the scope of this series=
 if we
> > don't mind breaking backwards compatibility now.)
>
> From my perspective, this is similar to the detached HEAD discussion
> from 2020[0] where "[the reflog of HEAD not attached to a branch]
> _does_ answer a different question from what we actually asked."
>
> [0]: <https://lore.kernel.org/git/nycvar.QRO.7.76.6.2009161214030.56@tvgs=
bejvaqbjf.bet/>
>
> I opted for a direction requiring explicit arguments to express
> intent, since that's the only way to ensure --force-if-includes aligns
> with (how I read) the documentation and the previous discussions.
>
> Specifically, with tags:
>
> - tags may have a reflog, but it answers a different question vs. "has
> this tag integrated changes from an upstream" it answers what oid/ref
> does this tag point to
> - tags may incidentally point at oids referenced by branches with
> reflogs, but there may also be several branches pointed to the same
> oid, so which would we choose?

=E2=80=A6and I think this makes a good case for the change (but let's see w=
hat
others think).

> BUT I just realized there is existing, more fundamental breakage with
> --force-if-includes here that I'm making worse.
>
> There is one case where we do have enough information to say whether
> <TAG> has integrated the tip of the remote-ref locally: fast-forward
> push. And that's actually broken today, too :)
>
>     git --version
>     git version 2.47.3
>     git clone repo.git repo && cd repo
>     git commit --allow-empty -m 'Normal, no-force-needed fast forward com=
mit'
>     git reflog expire --expire=3Dall --all
>     # Regular fast-forward push fails, even though it does not require
> --force to begin with
>     git push --force-with-lease --force-if-includes origin main
>     ! [rejected]        main -> main (remote ref updated since checkout)
>
> Checking for fast-forward happens after --force-if-includes checks the
> reflog. So that will need a fix=E2=80=A6
>
> My change makes an existing problem more acute, and probably requires
> a fix before other fixes can merge. Otherwise, --force-if-includes
> will always fail when pushing tags and detached heads, even when
> they're fast forward changes, adding needless friction to otherwise
> safe pushes (e.g., for tags that fast-forward a branch). So v5 will
> require a third change that touches other functions in remote.c. :/

Personally, why --force at all then? ;) A bad habit to force things
that don't need it.

Best,
--=20
D. Ben Knoble
