Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AB2BDC1C
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946192; cv=pass; b=AVUzPXHrLyVXzaGKLRmWmphX390DbTy7J+rWOLqtQ6U6Tdm/8C4uF+osEfCKPpcnWsuAEksFRFtNDRCz6TLb2hX78g7tgYPNVzL0G4dYw1NBWQ2PxpGnUtnQzybO73q3KpcNcqf/ZJSu9xh8bBYtHXItVXCCq53/R3oHeiVTAlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946192; c=relaxed/simple;
	bh=ONIU2cTz/Nz6HBBGFYLHUnBN+Y3tAWrISdwCxPfrsuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kn96mdGcsNjyH4k52QUPewsYpkWx5l3x5kbroReS9LSpCKLX6TvT0SInclY4SWZPHuq5s2eOCMZ3Ph5oweAkTq6moHTqBxbZa0jg/KzX61aZ0fzYOAF2v8ZMMP8qC2YcWIwWMHMQ33gf2V5xgA/8DTtDQQsJvf6em5EC1H0/AJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKOHTLLC; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKOHTLLC"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39677c434efso48746221fa.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 12:16:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780946189; cv=none;
        d=google.com; s=arc-20240605;
        b=IfEj1crfsk/NouaR4GT/4fEDE2N7nuZaBnulNGt+os5bbEEZoG+ZHiFUrP8jN47SQZ
         2H5BzFH7ABwU72k4/N0medQmx0l+D9MnFCpZE25IFyl8361C3I5kteTHzS6G4cQQ36Kz
         mbDHHpKL3h3EDZuq84EjBJHdGRQz+aQsT7SGw6u4F4AVh5OBIFyYTzaeE5E7RwVWHaNz
         WICWTv/uswFQ2KdHGUh3SnN2aePz15d35A6DEL50JUoIKdsv/ROwOpYtPXZMuKodMxxO
         8iEoz+0Oi3WwHGgXXv3HvOyLc2trKeaEYwUlyuxz7AvdlsdPZ6teLzSqI+ZABg7MvMnn
         9JGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qw0/0XkRMmfxw5FAtIer1mkazdNIgEtObNK04f3nudw=;
        fh=QF2T06WfIjsmCPAE/ZTVcX58jMfEr6zdBGNX73WiwaQ=;
        b=ZvMxGT0yg5/jacdISaRgP2gRNofWFt5baYYwaCHet7M3sJeD089UhCIztORS1SyMLf
         6uaU1DuNpKh9jTTCdjiPvPH/xbMpZuBOynVAMNLTxquInzM7r7Izjtvc3WQ3hCr4grAF
         PkPHgmuTJTyqtgpV0fCiMk7nS7k1Nmf1O/HW9D1xPT43DJSwY6+5h0l3okWM4Ka7pqmT
         G1ruvlrypyH1qES8UgD1CVTyGCI/8R4fhJ0jFYo36MBHZ7n3TEmn9rUVVzh/3kQySVwT
         TWA1NCpvJYKOFJECdaId9F9fc7Yeb9I54WNy7jp0e/d4vRzSEBFx6Nf/loXZMfgUwG+s
         cIOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780946189; x=1781550989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw0/0XkRMmfxw5FAtIer1mkazdNIgEtObNK04f3nudw=;
        b=CKOHTLLCXFeDtXF1x8XBl1fzh+sWdrEo7Ie8ne7cXzPn7//YefwBYoWhasV2G8rTV2
         cgt0xtjKkddiTOux0R5H/NU4GYGkc4JqRAMLkRzTGwaAwWD3opK2yf8eLJ9kghz0Ktwd
         lkeG9sCK2gfqakeYy8Bq5Lzb0it7gatvGUl0Acqo+bwPCyQjFeZwkQNgt5ZAS/d+z7O0
         lgPvGh/OM7RophHIP1ykhTZ+l2REg8VGUnU7NoX4EnUNvjGcSmVpnKSt2dQSypTrlQeQ
         /ItQ2+DLStmlkZXvNmMODkvVqZM11XThCnx/kRoNsMMZd2pqJOJU5I6sGt6/qlM/2ZRj
         uP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946189; x=1781550989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qw0/0XkRMmfxw5FAtIer1mkazdNIgEtObNK04f3nudw=;
        b=jpD2n7pvg4iwBw9KI09nNbwvLkmLeIkecHitT0cPay3xMdKqqksFR/umZ9xCwuqFAf
         5tr2p6gDKxzMFApa5rksqACxbUhu9z2QIaIB1UfR4bQVCnGTZwtjfgebM9e5CVt139qP
         yrl8CEzgmUeGNnX2/j7PrwcjpHY85SdOdR390Q0jeDtTxtqkG1yUqAben9OqGs3+dbfP
         MUDJDHAeJInwoTBDDilI0NM0tjxfwITZ4bSU5mxegCtDFOM4br0SiXakIxiav0grsFzq
         VnQgxVDDEO7ALrjflL+PdTtHHaSUPxzQZTBanJtegEtykllcuhbd9akU9Rx3t0amIucL
         fzHw==
X-Gm-Message-State: AOJu0YwCcOLa214Vu+ys85aU7/a5QB37c1fXprZSkfzCqyAVtyNkF87+
	WdtMS/9RJNSc8Gocbo7pDnupYtrhIWCPkbkfigP9rDSgSZmBGgZvKbBu/gtvgVx6hk5DGJ6XzPH
	P2nWuEpN1Sy8z73EIfxXZALMF6o9/GLCzkE2avRw=
X-Gm-Gg: Acq92OGfk2xiv6amu/Rl1FA2x362mlUCGOXK2Ts5/IZ96cKCO8qip2ZCia1Au2BNmOz
	y1E33akh8D44Oa9OaOgUF8aDjYyZC9TESwZFAcQfb8zikmrK7MrMNLGwtu7XV+jz23bflCezlpc
	09ozY4urnMGncs+L4WG1/IlJXorJQHIcoDRgbCvM0urtA/QFdeMRaBCgH6FXksRI+iaaJjzbPnl
	Tdr24WRh9gOTSriQ4Zgs6sMGXy0KwLzSe+946xRZ6rKcLol8inCLvbK8KJ+7KkJXTEgpt/GQUAJ
	5mw0NbPysCc7KeG5nd7dBiDZhEyogh+4stdBbxRM/4fk3Icm0OLJ7xr7VjlaRr5dLztLV+8+//v
	UG+G2asUrhNHAN1h6V4m18C0MyxegSBeJU4c+9xaaYQ==
X-Received: by 2002:a2e:2242:0:b0:393:a31a:ab3c with SMTP id
 38308e7fff4ca-396d0a41913mr33402571fa.25.1780946189434; Mon, 08 Jun 2026
 12:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607-ls-files-pathspec-lstat-v1-1-8cf40b730146@gmail.com> <xmqqa4t5yyee.fsf@gitster.g>
In-Reply-To: <xmqqa4t5yyee.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 15:15:53 -0400
X-Gm-Features: AVVi8CdyiuZ8jwFBmSYc5yEda1z83zVdNoKvGEI2A0gHDO4VY2N6iYVul3hyOt4
Message-ID: <CAJ-ks9njUM4TqHd=3H+aY8TCk6yG4o1yAhiSn2Tfz6oDnML20A@mail.gmail.com>
Subject: Re: [PATCH] ls-files: filter pathspec before lstat
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 6:06=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> On Sun, Jun 7, 2026 at 11:40, Tamir Duberstein wrote:
> > show_files() checks whether each index entry is deleted or modified
> > before show_ce() applies the pathspec. prune_index() avoids most of thi=
s
> > work for pathspecs with a common directory prefix, but a top-level name
> > or leading wildcard leaves every entry to be checked.
> >
> > Match the pathspec before lstat() for the deleted and modified modes.
> > Keep the later match in show_ce() so --error-unmatch is satisfied only
> > by entries that are actually shown.
>
> Adding an extra early `match_pathspec()` check before making slow
> system calls like `lstat()` makes sense, especially when most of the
> index entries need to be skipped.  But if most of them would match,
> then we would end up doing the same match_pathspec() calls twice for
> each path, and run lstat() anyway, so you may also be able to
> construct a perf test that demonstrates a case where this approach
> is not a clear win (or even degradation), perhaps?

Yes. I added an all-matching pathspec case to p3010 and ran:

    hyperfine --warmup 0 --runs 3 \
        'git -c core.fsmonitor=3Dfalse ls-files --deleted -- "*"'

On a checkout with 859,940 index entries, I ran the parent and patched
binaries in both orders:

                         parent          this commit
  parent first elapsed    56.807 s        64.618 s
               user        1.256 s         1.270 s
               system     10.633 s        11.068 s
  patched first elapsed   63.361 s        64.316 s
                user       1.238 s         1.280 s
                system    10.296 s        11.864 s

The added match costs 14-42 ms of user time in this case. Elapsed time
varies by several seconds with command order, obscuring that CPU cost.

The later match in show_ce() is reached only for entries actually found
deleted or modified. This case therefore exercises the extra match for
every index entry while still performing every lstat().

>
> > diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> > index e1a22b41b9..702c607183 100644
> > --- a/builtin/ls-files.c
> > +++ b/builtin/ls-files.c
> > @@ -450,6 +450,13 @@ static void show_files(struct repository *repo, st=
ruct dir_struct *dir)
> >                       continue;
> >               if (ce_skip_worktree(ce))
> >                       continue;
> > +             /* Only entries shown by show_ce() satisfy --error-unmatc=
h. */
> > +             if (pathspec.nr &&
> > +                 !match_pathspec(repo->index, &pathspec, fullname.buf,
> > +                                 fullname.len, max_prefix_len, NULL,
> > +                                 S_ISDIR(ce->ce_mode) ||
> > +                                 S_ISGITLINK(ce->ce_mode)))
> > +                     continue;
> >               stat_err =3D lstat(fullname.buf, &st);
> >               if (stat_err && (errno !=3D ENOENT && errno !=3D ENOTDIR)=
)
> >                       error_errno("cannot lstat '%s'", fullname.buf);
>
> Hmph.  In the current code, because there is no such pre-filtering,
> show_ce() would unconditionally recurse into active submodules when
> told to with the "--recurse-submodules" flag, even if your pathspec
> coes not match the submodule.  With this change, such a submodule
> whose path does not match the pathspec would not even be seen by
> show_ce().  Would it cause a change in behaviour?

This path cannot affect --recurse-submodules. cmd_ls_files() rejects
--recurse-submodules together with either --deleted or --modified before
calling show_files(), and the new check is reached only for those two
modes. Cached and stage output continue to call show_ce() before the new
check. t3007 already verifies that both combinations are rejected.

Given the 60.742 s to 1.061 s improvement for a selective pathspec, I
think this small CPU cost for an all-matching pathspec is a worthwhile
tradeoff. What do you think?

Thanks for the review!
Tamir
