Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD28448BA2
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785930996; cv=pass; b=bC3GGqkz5QlTJt5Hz0j18opGjqUM8VyHdMC0vhoAaYDFBJp/ijgvxNPFJFnPGDW3u52P95f6WJUzwOAvqnst9UagGU6zGQ/8LNW2hTFFTjwRW9XFgkp28iEQIzMbdGOovoCUaKGGxbWO+qiFYnLfp6GPJjtdMIjvlc9XbygX+wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785930996; c=relaxed/simple;
	bh=UkyvHaRnwoR1uOfnLIr+W4Mx/DC/C/eE7Zu6+F2DZWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuQudFyl1gqGyStC45Gg4R0PbZ74bmedMc0Ud1gOT6foad6EKPbIfKO1Gq0awty9ytBFKxEkqbwxogxBrlKC3EN0kw5K9oVaoQsvhOnXNCOBjJd3cYLTGRCX5Zkw5tdf8IimeVW/OoKb3ORX+NQhojtQYo6PraCwdszImol0iIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUKIgEPy; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUKIgEPy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cacf197759so13606065ad.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 04:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785930994; cv=none;
        d=google.com; s=arc-20260327;
        b=RtckXVhccMPWdELzz8NXthZ31/vJ3+gxav8fxOFsaL83HgH1OsXUCJS+UaXvtLTaC/
         acQy+K1rqd1Iut24368NH75sktcgzAHfsmbS9SM2/g2a1sgJlj0hwFFMz+5m1QfPNXys
         AZBFUG5SNOMZI3oi6MgP+ytnEA89ClmtP0y/8kROKu46YLYsWyFzv6AMc5QSH0XWNzAQ
         9Uwn99+kt6/lYtnShz2Q3r8g6+bWtfB41dhjdQCdVehSlwr9gyyIT+TNO1P4Q+2UdyKN
         wJzUXy1CAjwv4lv59gtVbCAne+PPfLNMR0QnkW4p0y1TJOhEmwOLWMMAdRQf5kfThHf8
         9w2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FGzmCFwLoVQzYGGgzNsKGJVtiQlBr1r2zCv4G/ylr9k=;
        fh=7VV4ezNbjyKpzI/xyuXvkusYEyAUdhUm74LY9luIBKY=;
        b=XcHsGojRmfSc3RXjjobafzm639hb9ZQ/YEnJdtE+6Ij/MsDM8zG98OYYDFUe2tSM55
         4CBiPG3DIHvJOl2SPWhx1wHY4AR7vRcn/HFt5ZL417ru6zm+y3iYMAzLwWcTNL1Z0YPH
         OyefI7p1DEFNffsZiTLgfJ7flTMuZ1RpYgQ9IbgLskFOT+2C92SqsiS4jJ13UlUbv5QR
         5BV+AlpV2BnDprUOnx0DFgKT30bY1o2oZTFS6m5vGLk8keg7NPV+EnDluVM6nUNPpBhE
         tv9gQLKGlBtrgcy7n9KNhVyeyyvkLih3+S2KTIn6uQ90X1Dvep66WoOd1scHrSKqdIZR
         01rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785930994; x=1786535794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FGzmCFwLoVQzYGGgzNsKGJVtiQlBr1r2zCv4G/ylr9k=;
        b=gUKIgEPy2/AvmWmg77vs6ryaqJYy3aONG2y7BDtea9DlyFw8Xn8d30/jU33q7P8fxb
         vGQPerM2Q3QXeoKghQKt+kNo2is3MYp+AKQkScM0zZH5RWDxCSvtyJ/OaomRKACe5ohT
         3CRRAZaK6mRpUkp77tjzjliv0eMMIdY3vuFvNrz2StJUZpmc62cYmqdOpzpbeueRnjSl
         IMkMoIEu4LCKcRPXEHtI+JGk6FiMCy3y5iQCbLst0qzQ9/vH816WNPG9RkRINxeNFwrv
         ImMWv/XIY+PGPLsbto7kQtuBPrrk69A80WUZ/Rex0/hPiWPknxjKTWE6Nvjflk4v+YNH
         UteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785930994; x=1786535794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGzmCFwLoVQzYGGgzNsKGJVtiQlBr1r2zCv4G/ylr9k=;
        b=DSKiU91CeIpa5k8C4TrmcpZRRSIkaqh/+feq0L1hGkLLlC2FGG+iJfwUOVxeI0qBGl
         kwZLROCuN8/P3d2bXY9VMsZMEsV5vjoCsR76JVCae7wp5YCUyrpkBvAw5cID6Gx9NO07
         T60sLPfkGC1pqGutOd+ia3/Xa8btzJbNoCLKafA+6UP36IYT7smqCCTFEI3CcY6tPWGI
         fzCTcbrz9b06HbuwbDW2/DmjMS0R1XSMB2f0JtcZOkFNLq3oG7ovrUs76Y8LChkoZ/xg
         eNyWvpJjZvt00m5KJQIMnpw85QfAspdzDEoZwHQ/gK7e3iJdjATs2rBKfxDiGNkx9Bzn
         9nOA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5UdnrY2pBO8q4R7q2ZorUOvj4YqYvY1Jc05kL7EOHI3r2MkilHq4dDruWpgyl5f85Gvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjgd95alzzBmymExtvrodBKbL0vllgHo5CWyAKlNduGIbQuiM
	vyQxTZnJM4QgoS3snpGoDqkylqH+xYccfthYggxiA4nTpoM8YMnde6BkZ3pzZO2gf9UA2mG1xOC
	xcJpqgg5vGll++6bZn0dpydMXcqUilcY=
X-Gm-Gg: AR+sD10deMxyRZMsq9oSYpAlRYA+wZpWTG9kvof/kNtqweHB+GO8qsgY2XXPAv8Rbl4
	QgMkjewppVeahM4Gz5Yaie3+2rKMCuuG3QlSGO1BvTsD+TjGpiOhZ+RZ2k2FzTGVf/4trRMGm8V
	281ged+X1ABrGcLYhm5yXnv38JmlbZe4blMbkKP0nPZ4CmCghRp1dDTxQpusJgR3IofGPkn2YTy
	w9PphKdEAb/VWPJHJHXhRUVqeFxr5O6642aXHDqj5J3EuJpKvYZnKXJebIeF8Ay+nQDP9Ljop2b
	ShJNpuYieUb4d64ctkiVcx65uVtrtzcG42tvDeOMi7BtxtmNHPJ29mMSUbCWlAqOZDcDtktsfxt
	ujCBDy/Rm7A+wIVoTTHZY7lxm1oc3Klx4EmjqQCg9FBTSOIigHoxwxZKqIwhLv2zWCSZJ9jMs38
	dBDMe8HAf4hLrPsd2veQ==
X-Received: by 2002:a17:902:ebc4:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2d0ca1564c8mr74279025ad.0.1785930994579; Wed, 05 Aug 2026
 04:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org> <anLV__4THdvugj8f@pks.im>
In-Reply-To: <anLV__4THdvugj8f@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 5 Aug 2026 07:56:23 -0400
X-Gm-Features: AUfX_mzgRAlZuuUt7X_clDUpvBFYZoW4QxswJRYGMcuKwSX6ZxHhuI1Zr1so5dc
Message-ID: <CALnO6CCbivaD8ZwD0+mVs4LXqkTzyc1T1Nt7eS-dYbTdQQw5KQ@mail.gmail.com>
Subject: Re: [PATCH] completion: add 'git history' subcommands
To: Patrick Steinhardt <ps@pks.im>
Cc: Vincent Mailhol <mailhol@kernel.org>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I agree with Patrick's review below, this looks good to me! One note=E2=80=
=A6

On Wed, Aug 5, 2026 at 2:25=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Tue, Aug 04, 2026 at 09:56:32PM +0200, Vincent Mailhol wrote:
> > Use the parse-options completion helpers for the "git history"
> > subcommands and their options. Complete positional arguments as
> > revisions, and add coverage for each kind of completion.
>
> Ah, great! I wanted to write shell completion for git-history(1) for a
> while but never really found the time to actually do it.
>
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> > index e875787710..f10813c8d7 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -2137,6 +2137,30 @@ _git_help ()
> >       fi
> >  }
> >
> > +_git_history ()
> > +{
> > +     local subcommands subcommand
> > +
> > +     __git_resolve_builtins "history"
> > +
> > +     subcommands=3D"$___git_resolved_builtins"
> > +     subcommand=3D"$(__git_find_subcommand "$subcommands")"
> > +
> > +     if [ -z "$subcommand" ]; then
> > +             __gitcomp "$subcommands"
> > +             return
> > +     fi
>
> Okay. We first try to figure out whether there is any subcommand passed
> by the user already. If not, we complete available subcommands.
>
> > +     case "$cur" in
> > +     --*)
> > +             __gitcomp_builtin "history_$subcommand"
> > +             ;;
> > +     *)
> > +             __git_complete_refs
> > +             ;;
> > +     esac
> > +}
>
> Otherwise we try to either complete available options if we see a
> leading "--", or alternatively we complete references. This works well
> for "drop", "fixup" and "reword".
>
> The one command where this falls flat a bit is `git history split`.
> While the first non-option argument is indeed a reference, subsequent
> arguments are pathspecs. So ideally, we'd notice that we already have a
> reference there and, if so, complete file paths.

=E2=80=A6here: I think it's probably going to look a bit like what _git_ref=
log
and _git_config do, checking the subcommand and using somewhat more
specific completion in that case.

BTW, I'm also reminded of <xmqqpl6g9fyu.fsf@gitster.g>, where Junio
suggested we devise a way to improve _git_stash. Looking at it again
with some context, I bet we can reuse the __git_resolve_builtins
pattern there, too. Not for this patch, of course, just thinking
aloud!

> But that being said, I think this is a good-enough first iteration and a
> strict improvement over the status quo -- we don't have to be perfect
> right from the start. So if you want to also make that case work then
> great, but I won't insist on it.
>
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index 9ae3c48ebd..08ecf682ed 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -3107,6 +3107,23 @@ test_expect_success 'git clone --config=3D - val=
ue' '
> >       EOF
> >  '
> >
> > +test_expect_success 'git history subcommands' '
> > +     test_completion "git history " <<-\EOF
> > +     drop Z
> > +     fixup Z
> > +     reword Z
> > +     split Z
> > +     EOF
> > +'
>
> This will cause conflicts with "seen", as there's a new upcoming
> "squash" command that's currently cooking there. That's fine though,
> nothing you can do about that.
>
> Thanks!
>
> Patrick

Thanks!

--=20
D. Ben Knoble
