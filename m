Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6643BE14D
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414062; cv=pass; b=OPqxI6QSp+peRpapr5nRW/jWSM2kWn87LAeY8Bfu4CcPYrAMO8WWWdsQV+8fzC7bHzBa22gBasRQ6k8Gk3GcodOk3cIOsTuTZmyA77W24A0XOjGx25BY/Uigd9DD4+leWqIhkCEjNt8Kw4TU2Hgd0Rh1d4Tp9vgt1XIQL2VZuNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414062; c=relaxed/simple;
	bh=2ypifzPFquCTYohA1CRnUWQtq9Cg+46hysNTDCK1npM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwzjTFCQtONqQkCJi9G3QHRUZ4PEVc0JHNkJJVPAheQNlTZYP6BZq3v1YJsF9wKzhdC02tfDUMw14vXripI5t0QAjvt2gjuPeiU/h0wue/ZQH1stNHZaliBdYoub+8H9GIWnAGxGRp2ueIBG0HAYwXE+aDATfhX/3hLQNpYco9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=TttbOGdn; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="TttbOGdn"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c13f2685f2so1645135b6e.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 12:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789414052; cv=none;
        d=google.com; s=arc-20260327;
        b=TQsBtXmj5XyTPcDIDer2sgMKXfz1Q04vzepRrD3JVnO7ZtsjudHl7bosURVicAXLiW
         uT7mCIu3C2/SSf2xu2v+LHtf1SgynDIwYFCYO/35bt/mmH0PYqCAKGBKNBlZcSB8UXCA
         5F5sxF3UxjaCjnHlBiUXoNrz4Liu7invpseH09CodMytN2xfdrLRH3EU9NSr84XGbq2K
         AQpBlGcRPNP7GF77FyLWEpEef/1PyLirOvsNTiysopg+o5hpkBz4myPRl5gqusS5I5I/
         KKa8MQCSR+QAdxmseH73a58sVV6aq0gO5koHfj392ibkiCQh3jRhzmuSrDjC2dt5QLsX
         jjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oXx/j3OYLxppJfmPW68fa+LVxQrX93+LLGft63aIrvk=;
        fh=qDHfzpnmgk+oijmCQwGUEgWfso2tkQtByiWMMPH7tgE=;
        b=EG+1wNf/ve5pIRc6NNW/SeOGyNKusweV9m9sMdlU5MMrSkgGPlxJDTSi7vkVod0fcq
         6HVAXdc4zyBAqNiOVuaZo25bOwGGGy67lABglUV6r5UlEZa2GFACTlcmbuB5vhcJLAza
         V7CjLydUXzRmNntQ3gms0dl/BdG6QUkox1s4WAWNOMYHmI3YIP/+5+5GGJFgzgrnZTwY
         6mDfZ9JAMzk0aFXRsfXvXU73MxQ1dkOd3kr/bjFJSDN0IViow7MlahaaO0nJzzx8fwhY
         5AeuVhF5AxpV3UN+OvCIYqQQhjELf3xJ6+THluf23YreZOlxokB3Pqs9zd1wPK7tveU2
         nGMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789414052; x=1790018852; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oXx/j3OYLxppJfmPW68fa+LVxQrX93+LLGft63aIrvk=;
        b=TttbOGdnD03ITd5anu+sZb+Qt0lFDRM2fa0Gul6AA4JPS2MAY9Pa4Hm7RHteijMc1Z
         +qCW88Q1UGyK8YfGoSUveg3Bz/DjAbnaWCI3YumK5We4Hq5POlO2wwVIxsSZAuFOubbL
         YqA2XB2BCGlH3pGhN66EYTrgxMzR423bpdNBdKJl5UL926tpXuSFaiYm94eDE+RfZXj/
         I6gEtNCNYZ/5VAZ+I0Q4B2IWt7/VZoUfi82pbGZBFIqIW+bgE4TESQoaiPvX3eCnmLpu
         xKMHXx03233X6mkrRqGR5aVhJ3WIQ5cWCP2CSONlViH/tfnHfGPxlTEUS8j3l12Zgj1c
         XfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789414052; x=1790018852;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXx/j3OYLxppJfmPW68fa+LVxQrX93+LLGft63aIrvk=;
        b=Ywd+zG9mYMa5FlVzntoyw+HZnQkDQC3IUkD0egXeI7zJHM330TQGsK2huDTk5Cgssr
         ONgSiZDf3z/NwcMvYy5O2pRfAGGHgY+qKrV9EwywxEdb7XR6zyiKYJL0+kxvvZxr3po9
         wIloT5ODJO8dR24G50vax21byhGwTRvGXrWFM10WTGfiQdFAvRNomMN0+NbkI3USBrL/
         1pa8kgi2ODuIGYV2f0BP81SI4EfWuXI1X/q+QBzVQulLdCAAAkKufanIMg4HDeo/Eaqz
         RYBRpkKbI7BpXfwFam9LWOsTCMiO27fsZ0sr6s5ZO/ppVoO5Gv0VbCRJfh10kI8irujo
         Nw2Q==
X-Gm-Message-State: AFuF++m7YtFb6NkOJhmzz/c+/rBkCCdNDnoiE7kvDPeZ57PYDIIv3Glm
	tpTPsRNgX8crJZ1sZ+nsBoWyHH3aZyouhblnA56aLfHql+z/KjzrSojAKZboKUXVZKoGcW7JgAz
	7gOsdIItAgqOoiwIT8FZ0glGAOA5r3QsmnUK1Tc1lkw==
X-Gm-Gg: AYBFou1/Cs/kyVIMkLFj3TvVsBwF/K4EzzjSBYB6EtWJu+JePw/frKDZVKnmnzjIStw
	Lmbp6dp2zmCJDpkOH0hou829AUNrpbD1cMZAFpdYUFnkBtebtq7cP5adL6C9BjQDnJRp9q5mNPo
	OHHAkVf/W/CRQEFdaGXosuWS9Rb+lszOT1dh4Jfp/KmikHaRMNrfc+vyzBwd3SlQ5KRrOGLWlJ6
	2FCa/dlAM1r2ns8OYcrG7X5G/vwlOdEXLCXsVLj23GzeVutWqr9qNGluipLk9yozxqnfW9kLQEv
	FRNq6s08w2MRm3IV4uISim2NDINpWjN+bF/Okp2fuupsP2zOR5YTdWA=
X-Received: by 2002:a05:6808:3a13:b0:4b9:a8ac:47e with SMTP id
 5614622812f47-4c7b579f6c7mr2891207b6e.28.1789414051707; Mon, 14 Sep 2026
 12:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260914040018.76111-1-tyler@tylercipriani.com> <CALnO6CDz8QBcBojmhjgwgWzi4oUbs+V4KVQ1h0+JgN7k0v-SYQ@mail.gmail.com>
In-Reply-To: <CALnO6CDz8QBcBojmhjgwgWzi4oUbs+V4KVQ1h0+JgN7k0v-SYQ@mail.gmail.com>
From: Tyler Cipriani <tyler@tylercipriani.com>
Date: Mon, 14 Sep 2026 13:27:19 -0600
X-Gm-Features: AcwNN1W3qa7Jqh3NYEhC_HgYI4MQ4VuQqA0dXPDSpwEVCxMENAjFAWfYGyLQKQI
Message-ID: <CAHLx=O=eH=7g=JUn5dOJgatv2xJVbQygK4C7zCA0Uv=BpzMkxQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] push: check pushed ref for --force-if-includes
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:03=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
> Hi Tyler,

Hi Ben!

> On Mon, Sep 14, 2026 at 12:00=E2=80=AFAM Tyler Cipriani <tyler@tylercipri=
ani.com> wrote:
> >
> > Changes since v3:
> >
> > - check_if_includes_upstream unconditionally resolves peer_ref with
> >   RESOLVE_REF_READING, now all non-branch ref pushes will be rejected
> >   when using --force-if-includes
> > - add test for --force-if-includes tag push 1/2
>
> This is intriguing and seems like a significant behavior change, let's re=
ad on=E2=80=A6

It's definitely true that this is a behavior change and it'll add some
friction to your process. And it's also true that the current behavior
is failing to provide the guarantees it claims.

> > Range-diff against v3:
> > 1:  da27c421ed ! 1:  e7912c3fd0 push: check pushed ref for --force-if-i=
ncludes
> >     @@ Commit message
> >     -    Find local reflog using ref->peer_ref. When using a refspec li=
ke
> >     -    HEAD:refs/heads/main, we resolve HEAD. If HEAD is a branch, us=
e that
> >     -    branch's reflog.
> >     +    Instead, use ref->peer_ref to locate a branch with a reflog. B=
ut if ref
> >     +    does not resolve to a branch (e.g., a detached HEAD, a tag, an=
 oid),
> >     +    then we reject the push. The alternative would be to use HEAD'=
s reflog,
> >     +    which is too broad to tell us if the history being pushed incl=
udes the
> >     +    tip of the remote. We need a per-branch reflog, which means th=
at pushes
> >     +    of a ref that do not resolve to a branch are rejected. Rejecti=
ng the
> >     +    push of a ref like a detached HEAD already happens today (if t=
he
> >     +    same-named local branch lacks the remote tip); now the detache=
d HEAD and
> >     +    other non-branch pushes are explicitly rejected.
>
> So, we would now reject a force-push whose source is anything but a branc=
h (with
> force-if-includes, and that presumably includes push.useForceIfIncludes)?

I should clarify, reject the force-push of any source not ultimately
resolvable to a branch; e.g., HEAD will work if resolves to a branch.

> >     ++test_expect_success '"--force-if-includes" should reject forced u=
pdate from tag' '
> >     ++  setup_src_dup_dst &&
> >     ++  test_when_finished "rm -fr dst src dup" &&
> >     ++  (
> >     ++          cd src &&
> >     ++          git fetch &&
> >     ++          git switch main &&
> >     ++          git reset --hard origin/main &&
> >     ++          git switch -c newbranch origin/main &&
> >     ++          git checkout HEAD^ &&
> >     ++          git tag stable &&
> >     ++          test_must_fail git push --force-if-includes --force-wit=
h-lease origin stable:main
> >     ++  )
> >     ++'
>
> Which is what I think this test says.
>
> I think this would break a common thing I do at work (although this is so=
on to
> be deprecated, so take my anecdote with appropriate salt; I can't claim t=
hat no
> one else relies on it, of course):
>
> As I think I described in the message you linked, I have an alias "pf =3D=
 push
> --force-with-lease" and push.useForceIfIncludes=3Dtrue in config. Our tea=
m has a
> "main" release branch and a "hotfix" release branch for emergencies. When
> hotfixing, we first reset the hotfix branch to the last tag to go out to =
our
> production environment, which I typically do like this:
>
>     # validate that we won't lose any interesting commits (no regressions=
) with
>     # something like
>     git log --oneline --graph --boundary --cherry-mark --left-right
> origin/hotfix...<TAG>
>     # push
>     git pf origin <TAG>:hotfix
>
> (On a second pass before sending, I can't recall if this works as-is when=
 I
> don't have a local hotfix branch tracking origin/hotfix.)

Yes, this workflow will break. And it will not work today without a
local branch named "hotfix". It's broken today, insofar as this is a
false pass since push.useForceIfIncludes is unable to say anything
about whether you've integrated origin's hotfix branch into the <TAG>,
you're pushing so it only incidentally works.

Today, git pf is actually checking that your refs/heads/hotfix's
reflog has the tip of origin's refs/heads/hotfix. But it makes no
promises about <TAG>. That is, you could:

    git checkout hotfix && git pull # This line is what makes it work today
    git checkout --orphan junk
    git commit -m --allow-empty 'Totally unrelated empty commit'
    git tag <TAG>
    git pf origin <TAG>:hotfix

And pf will allow that to happen since origin/hotfix's tip has been
integrated with your local refs/heads/hotfix, which is what it's
checking today.

> If I'm reading this version right, I would now have to say
>
>     git pf --no-force-if-includes origin <TAG>:hotfix
>
> or perhaps better
>
>     git pf --no-force-if-includes --force-with-lease=3Dhotfix[:origin/hot=
fix] =E2=80=A6
>
> probably after seeing a (hopefully improved?) message after the original
> command. (Do I need to disable force-if-includes in the more-specific lea=
se
> command?)

    git pf --force-with-lease=3Dhotfix:origin/hotfix origin <TAG>:hotfix

Should be sufficient and as I understand your process, that's what
you're after. The explicit --force-with-lease argument makes
--force-if-includes a no-op, so --no-force-if-includes should be
unnecessary.

> Now, on the one hand, enshrining existing behavior is good for backwards
> compatibility but has earned us a bit of a reputation for not innovating =
in
> useful ways ;) On the other, I wonder if the description of force-if-incl=
udes
> allows some latitude to break with existing behavior here.
>
> The relevant docs say
>
>        --force-if-includes, --no-force-if-includes
>            Force an update only if the tip of the remote-tracking ref has=
 been
>            integrated locally.
>
>            This option enables a check that verifies if the tip of the
>            remote-tracking ref is reachable from one of the "reflog" entr=
ies of
>            the local branch based in it for a rewrite. The check ensures =
that
>            any updates from the remote have been incorporated locally by
>            rejecting the forced update if that is not the case.
>
> It is unclear to me what "one of the 'reflog' entries of the local branch=
 based
> in it" means! Ignoring that, the surrounding text only talks about whethe=
r the
> remote-tracking ref's tip (or "updates from the remote") have been "integ=
rated
> locally."
>
> So I think we *could* say that, in this case, we don't have enough inform=
ation
> from "<TAG>:hotfix" to check whether "origin/hotfix" has been integrated =
locally
> or not, and we should tighten the meaning of the check. (Perhaps when
> "--force-with-lease=3Dhotfix" is given, though, we now have more informat=
ion
> available to check---but that could be outside the scope of this series i=
f we
> don't mind breaking backwards compatibility now.)

From my perspective, this is similar to the detached HEAD discussion
from 2020[0] where "[the reflog of HEAD not attached to a branch]
_does_ answer a different question from what we actually asked."

[0]: <https://lore.kernel.org/git/nycvar.QRO.7.76.6.2009161214030.56@tvgsbe=
jvaqbjf.bet/>

I opted for a direction requiring explicit arguments to express
intent, since that's the only way to ensure --force-if-includes aligns
with (how I read) the documentation and the previous discussions.

Specifically, with tags:

- tags may have a reflog, but it answers a different question vs. "has
this tag integrated changes from an upstream" it answers what oid/ref
does this tag point to
- tags may incidentally point at oids referenced by branches with
reflogs, but there may also be several branches pointed to the same
oid, so which would we choose?

BUT I just realized there is existing, more fundamental breakage with
--force-if-includes here that I'm making worse.

There is one case where we do have enough information to say whether
<TAG> has integrated the tip of the remote-ref locally: fast-forward
push. And that's actually broken today, too :)

    git --version
    git version 2.47.3
    git clone repo.git repo && cd repo
    git commit --allow-empty -m 'Normal, no-force-needed fast forward commi=
t'
    git reflog expire --expire=3Dall --all
    # Regular fast-forward push fails, even though it does not require
--force to begin with
    git push --force-with-lease --force-if-includes origin main
    ! [rejected]        main -> main (remote ref updated since checkout)

Checking for fast-forward happens after --force-if-includes checks the
reflog. So that will need a fix=E2=80=A6

My change makes an existing problem more acute, and probably requires
a fix before other fixes can merge. Otherwise, --force-if-includes
will always fail when pushing tags and detached heads, even when
they're fast forward changes, adding needless friction to otherwise
safe pushes (e.g., for tags that fast-forward a branch). So v5 will
require a third change that touches other functions in remote.c. :/

> Thanks,
> D. Ben Knoble

Thank you for all the review and thoughts!
