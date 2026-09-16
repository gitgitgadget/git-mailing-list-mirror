Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9304AAC64
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573972; cv=pass; b=ASMi2X77MqxSIjTFARHPF2A3TN9nfMoBI4WooO9gBTjIgFKu66X2AeW/r9Rq9wG3iNrrrhnAJxDLzgbxZgtHx13KKjQxq0hAgNiFvcyyG0Moj6ZNIMowFjpmFMQz7ZuOZg56rO2yqoVikIEZokORaKKP3pEA//kVG/lD2x8gCWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573972; c=relaxed/simple;
	bh=uvYwBV/2gzMyoRaqMHR9o9bk65JgpEy2PyAD8vX9iAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5ejNUtUr4ItqGVKg1ISuwYueBXr1HP2vmNTe8vlG0TQT0Ufz8hhm7P41oWREcQRzvu7Qn+btSU3R6MjSDvVBv2qJ7lYGPbuuIO6dy0oY6Wcut6MxXE567a5t0Y4VBiTqM9nwI5LWTFaQ5HSxsPXJ4zToFlS/LBmThj/XC8S1xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=d+m5IdAF; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="d+m5IdAF"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b1b1d128a0so1079750eaf.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 08:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789573967; cv=none;
        d=google.com; s=arc-20260327;
        b=jGFjNRRtb36zwqklr7stcSSUoBjoIJgYNTwvs1soQ5gl7lN6gXm5CFcjKY0UJE1L8a
         SaKwya4gJS8JLHBAqMDp11u/cP35FfMvdYgukWrHumicfbSjbNwT26B32WM5f4q+CwNM
         XJBpFpn7Z7ZLB/vhOrcCATQn2JRjUX5rbQ0DSrWJ1c0ycFCRUXxFpV5omd17lZnSVwx2
         q8Qsja2PW0VF5li0Vfobf3liYg58nK8xWmrpJgIv4babDAx9Mbt0atwDeN8/KVikwvtW
         o/KqcoNW3fi14NrJfG0IFtjdZvBPsl3wkaR93ONTCS5KwEhqyaaV5hn56mGpBBMUR0oY
         A/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=keNB5yl8o+hBeLfvkwxTj5wlyjk6UU9bZBrGZcR+c10=;
        fh=pQNJC67sjjTM1IZf5x4FN1CTVfZR4Ud1kyS93PgzpdU=;
        b=m/7w3Yl3kkeTzzQILJ2UcI4cxM6TOCm4uS2OFgpMB+SE3EqDxR8O2htpC8+eNCHzer
         tKewLotK0GpB/pB7N5dt+J11vMHJ8NzuW7fLgPCLON6iIGatAw7KfFoeB5SEEti8VDvt
         ddz94kA6Wt2DDRYZTKPD0HXNg4BaLQEBzikN4K8z0TNx9qgizbsoqe2BqjoDZLnpCatL
         zZeI721LqBBqPiQogvz3dkdGcq/OVbEclJSdPnhJOhNwmYud182wCIUKEIUCCpP/xNoB
         ClLsq4f5xjRmU8dtlTIdvr50LuvQvPKbkYVFq9xznWR9P6RMdXlGoD2TYv9/i4MrWU20
         aDng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789573967; x=1790178767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=keNB5yl8o+hBeLfvkwxTj5wlyjk6UU9bZBrGZcR+c10=;
        b=d+m5IdAFMdOAo5u7ebGRvXK9bF60a11znA50EN/JYY5Qxxyut0NWuOTNgwQppm1KtH
         SU2bR3UHhT1oPLsWCV/U/EznqSZqPA57s23+OdHw29FD1pU/bZ30O5tbM8EWMjgxeKWg
         9bkYYvJJOtyNunyfp5owtUFQSwh+pu+WGQq9Ci2Tl4eNKuL3pg+Md/lhKQON5C/nd34W
         DF07WTPZCZdZxHMbrtG1lG0fhuNp9RWPH9sQFccv97FUtTOaeGRo6ayXlgJF67I3Qzcv
         j5bF6Q2+982+WWYdu66Os7kCoF09sN2VDpWceGX4qJAiHW3t4KYw68Xe+niV4OHH9IRl
         Cjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573967; x=1790178767;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=keNB5yl8o+hBeLfvkwxTj5wlyjk6UU9bZBrGZcR+c10=;
        b=2LlcbAoZsGhUJ8JFvLl23Euz1a4+vBAgcyfiUdfxMFvg7WvO23WoPkZU9EQHd9+6fG
         kKa8M8C+kBkbYsVoKEfZf9lFJeFjOmbw9htK+o+qkhTXEPJW/VfL5OivMMb5fxBRwrMB
         o43+Ry59YQqHv+QsjJgqNLI3ge8jobHuv5AnLJw5y219mwAuDKx0HZzq6NEpCcvu8KOw
         GBOooYfeGthmsVdPz/5iFM97GblFGqFkkXNnsRGJEATOzu6ZST40kBZDHE7OQmWXZqVD
         ivHvrWDqPGc557VPt17BK+V1VonCJ/wiUUVSI71Q7n81+/wkOZh47cIUOUAEmbjiRmgu
         u+ig==
X-Gm-Message-State: AFuF++nn7DgXb98FSqrD0hSvkm3pOLMm4yVndzNJUpCD2vBrD3gyTIqb
	JvWz8DQoYCDiRSfgtcqqm/fWFevkN5PHAlHDHDqaN+n9V/2TFQwwXb1DWlo8sf2UB304pXyCD9m
	vXkEkQJTb2lGVFFfYLkw8Vb5vlXWnlYf9r1Z5gswp0A==
X-Gm-Gg: AYBFou2d/JuxPT6En8XDMvYtEmO//QAFBwNtDFI7kgqkoaOTirx9O5SZJeDXwUsx1+N
	MRMg/rAkUAuOX7JiNs3cxmvbMKqMPf61+hc3aygTCBwBgbzXr10Dhj1antteYFYLEsTVHGB69qS
	8p/qZcK7UuoVglFB2p0eqszlNN8lacy5pC9vY7Nd+K4MdABhYKNk1igMPukH7A6HLvRDqdCxK/T
	jqPwH80YSSDzykfnCTKgDoOcZhbURxlok0o3ZYaffH7qgWfJCQCIrpl/Ndg7eHVzVVxDNoRYZs2
	aZV2If9Yn8ojyKBYAHw2J+gp39Mj0N68ZJSV0cPREzwLov1Rmhzpc4I=
X-Received: by 2002:a05:6808:6508:b0:4b2:8dbf:ffd with SMTP id
 5614622812f47-4cb67bea838mr71510b6e.1.1789573966814; Wed, 16 Sep 2026
 08:52:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260915233305.334115-1-tyler@tylercipriani.com> <20260915233305.334115-4-tyler@tylercipriani.com>
 <CALnO6CCpxwenphyZvEX7gjvAmLPidv+4iT98uh95mXj_MvshQg@mail.gmail.com>
In-Reply-To: <CALnO6CCpxwenphyZvEX7gjvAmLPidv+4iT98uh95mXj_MvshQg@mail.gmail.com>
From: Tyler Cipriani <tyler@tylercipriani.com>
Date: Wed, 16 Sep 2026 09:52:34 -0600
X-Gm-Features: AcwNN1XRjQ5k7SK575TIemafQghI70C41FItHV2ep1ddv5XtuBcdvW0RpNsRwWc
Message-ID: <CAHLx=On9sSTR+Ei2FmV7YSDtJ85SAzL3x=ALns1vsotn6c8Fiw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] push: --force-if-includes should allow fast-forward
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, 
	Stefan Haller <lists@haller-berlin.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 6:29=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> Hi Tyler,
>
> On Tue, Sep 15, 2026 at 7:33=E2=80=AFPM Tyler Cipriani <tyler@tylercipria=
ni.com> wrote:
> >
> > In set_ref_status_for_push, we verify --force-if-includes's reflog
> > reachability checks before fast-forward rules. As a result, valid
> > fast-forward pushes may be rejected when a force push is unneeded; like
> > when the reflog is expired:
> >
> >     git clone repo.git repo
> >     git commit --allow-empty -m 1
> >     git reflog expire --expire=3Dall --all
> >     git push --force-with-lease --force-if-includes origin main
> >     ! [rejected]    main -> main (remote ref updated since checkout)
> >
> > Rejecting fast-forwards is a mismatch with the --force-if-includes
> > documentation "Force an update only if the tip of the remote-tracking
> > ref has been integrated locally."
> >
> > Instead, defer check for --force-if-includes until after determining if
> > a push force is needed.
>
> "push force" ? :)

Whoops, good catch, thanks!

> > Opted to create a deferred_reject_reason in set_ref_status_for_push
> > rather than move the computation of reachability or verifiability to
> > winnow scope of changes in this patch. Lazily checking for reachability
> > or verifiability is a valid followup.
>
> This paragraph does not match our usual style
> (Documentation/SubmittingPatches[[imperative-mood]]) and feels
> somewhat artificial to me.

Ack, I can update the mood. My goal was to make a note that moving the
reachability check seems possible and might be a decent idea, but it's
a lot of change in one patch.

> > diff --git a/remote.c b/remote.c
> > index b7b5ac0d28..db0b50b030 100644
> > --- a/remote.c
> > +++ b/remote.c
> > @@ -1669,6 +1669,7 @@ void set_ref_status_for_push(struct ref *remote_r=
efs, int send_mirror,
> >         for (ref =3D remote_refs; ref; ref =3D ref->next) {
> >                 int force_ref_update =3D ref->force || force_update;
> >                 int reject_reason =3D 0;
> > +               int deferred_reject_reason =3D 0;
> >
> >                 if (ref->peer_ref)
> >                         oidcpy(&ref->new_oid, &ref->peer_ref->new_oid);
> > @@ -1693,16 +1694,17 @@ void set_ref_status_for_push(struct ref *remote=
_refs, int send_mirror,
> >                  *
> >                  * If the tip of the remote-tracking ref is unreachable
> >                  * from any reflog entry of its local ref indicating a
> > -                * possible update since checkout; reject the push.
> > +                * possible update since checkout, then remember the
> > +                * rejection in case the push is non-fast-forward.
> >                  */
> >                 if (ref->expect_old_sha1) {
> >                         if (!oideq(&ref->old_oid, &ref->old_oid_expect)=
)
> >                                 reject_reason =3D REF_STATUS_REJECT_STA=
LE;
> >                         else if (ref->check_reachable && ref->unreachab=
le)
> > -                               reject_reason =3D
> > +                               deferred_reject_reason =3D
> >                                         REF_STATUS_REJECT_REMOTE_UPDATE=
D;
> >                         else if (ref->check_reachable && ref->unverifia=
ble)
> > -                               reject_reason =3D
> > +                               deferred_reject_reason =3D
> >                                         REF_STATUS_REJECT_UNVERIFIABLE;
> >                         else
> >                                 /*
>
> From these 2 hunks, I haven't yet seen the connection to avoiding a
> rejected force-push in the fast-forward case, but my read is: we
> remember why we might reject a force-push for refs whose reachability
> we are supposed to check.
>
> > @@ -1746,6 +1748,14 @@ void set_ref_status_for_push(struct ref *remote_=
refs, int send_mirror,
> >                                 reject_reason =3D REF_STATUS_REJECT_NON=
FASTFORWARD;
> >                 }
>
> Then in unshown code, in those 2 "remembered" cases, we check the must
> fast-forward rules. If any fail, we set reject_reason=E2=80=A6
>
> > +               /*
> > +                * If push is non-fast-forward and we were asked to
> > +                * verify the reflog but were unable to, then reflog
> > +                * verification is the right reject_reason.
> > +                */
> > +               if (deferred_reject_reason && reject_reason)
> > +                       reject_reason =3D deferred_reject_reason;
> > +
>
> =E2=80=A6which we now overwrite with our remembered reason in the rejecte=
d
> case. I think that makes sense.
>
> At first I thought the unshown code above, conditional on
> !reject_reason, would collude to make it so "deferred_reject_reason &&
> reject_reason" could never be true, but I was misreading the results
> of this patch. There are some arms in which we set both (namely,
> because those remembered cases don't set reject_reason, allowing the
> fast-forward rules checks).
>
> I still wonder a bit about cases where we remember
> deferred_reject_reason and never set reject_reason, but I think those
> are supposed to only be the fast-forward cases.

That's correct to me, too.

I hemmed and hawed a bit about whether to only check _some of_ the
reject_reasons from the fast-forward check. But decided that the
advice in 2/3 would get people to the right outcome in cases I could
think of.

> Perhaps we want to
> make "deferred_reject_reason" more clearly indicate that to save
> future readers headache if they insert code around here? I'm not sure
> the best way to do that, though, so maybe blaming to the log message
> will suffice.

I tried to indicate the rationale with comments, but I'm open to
changing the variable name, too. I felt that the "deferred" in the
name captured it, but the name also feels a little broad vs. what it
does.

Before I take a stab at a reroll for commit message updates + variable
names, I'd like to gather more feedback on the direction and
implementation of this series.

Thanks you for your thoughtful comments, Ben! I've appreciated how
you've helped me think about this feature.
