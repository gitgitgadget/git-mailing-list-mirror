Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8283037DAAD
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364886; cv=pass; b=DB0ZQf0HflJ98lWkpmRJVfAFqSd0907O/yrb/9ROQKcYvFPxNFSgbEYRP5aHekhlc2Ye1wmVC7K8f+XyPlnXgKWdHKqbxfMGPOpTnSBSWFaSnVJhIBd4cp/NrpCBib6fPpOjYKMznrEKDaOgeSr5Yqg/1hNY3qI9Zi5rdldWN4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364886; c=relaxed/simple;
	bh=ma2yA5+UgzYGmUVqEzR1mqSyCPnvMuHgccNLyDeg0pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7stk5Vw30d7Vk3ryOhyDNsTsQ74jnk0PcfGxp1ACBkocc3ZdE7N6ItlQMwdMa/IyNzSoYmNhcOX2z2rS+w+F94HZL9cu916dm5RvhNDiVgj3IbD5ljZdvakzecrJ74UKQQPT2eX3cl5hokeN/NE2WFgMha1B9iSPU+UKUrSFvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3aKzym3; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3aKzym3"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf27856f9cso21010335ad.2
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 05:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786364884; cv=none;
        d=google.com; s=arc-20260327;
        b=aXF5wIBQPl79FtpGjAWXCpiK4vLPuGa5NZIdxuDP/0vOOF1Rpwp4sGYluAHpOF5Nwf
         6YOwJOLHwvxmVqZ1pKetHACvAw7J/XMGBpZ2L2btLWgTW3TWyZWe3XHlAnoVketR94RR
         VkzeyZ2B8a0nGKIciqz+PbJxl+IT2AXOZVUHvIuhicHUDB+6GsTMURIguLbLv+GMxBDQ
         hqcKcMLwSFB8pVnJd3v5G1wicQsYDziNlxXbTrkoLwAsYRJG81GBgW8leZ7fIuQb9KDF
         0R59ntjlDAo2dGddy3sghHXhDZsUcu/fazPIeLxu75xPeiNu2FkSYDdsTcHZox3a/tMP
         uk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LD4khu1GH/4iK0k5oQMEXA8Z+Uy8Jmbiuwn9d+bbhxc=;
        fh=cmfxGXLybgx4rgzqBZMifc3hgtIbixshOPogRMqxeCA=;
        b=NrFANfpgiZAYLDCSQC2yLh4b/bVkDc16rmRtgy5KD8bXR7PiBgmvgt++JoDKyRZirH
         AtBIvql3T6kARIY/3ybPj++9u71kP2+fK86LUet1MWYlEGFae0p8DY8fyfBIgw16cJpK
         do/MghF7gL9ELePw5rVHLcn4SEguO0tAsfR1ler4dGtYy230TvjKQIU5C7T4aOYwPx+o
         ogt63ywMrerIdJzGJQwXtEpkYe3nCp0IPkHvsnBQbAAylCiCb8QcdnTC7jCowJjgJgpG
         bJDjy0tu+YK6E2JXEocfLyhXUb0NQ2dvYbDgCjBAgEQl0itxQ0yJ62w610avE6jTTeAg
         SH7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786364884; x=1786969684; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LD4khu1GH/4iK0k5oQMEXA8Z+Uy8Jmbiuwn9d+bbhxc=;
        b=q3aKzym34z5JBmJabXO/8n8Dy4K5apkV/CG78HnLzXmBl20GCF/NdLw+BzIW8bCJ2A
         twljAFuaGNH2+pyTnNw0PJwsyI2qg2lRf8HHJwvVTgJtosR6IWZZw/A1/8vaAxXRHR8J
         ofaCCRRjXwFVK9AWegkh/b2ciM/wh3Sjo7RB4PJ2MP7GxqRbvYA9yiBAteU5ADacCZmO
         iAUl557RZZij5WN07ykQlurAALy0gmPEun6AklAki/h5zE/97lMjrzFJraPDQwYEwvnm
         NDhZkPvBJDPOuIxDqwrgbg5jgiwyDOto7NSbl/Lt/Hu9+F4zxgUI/C1E+XG3z4h0w4mY
         zIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786364884; x=1786969684;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LD4khu1GH/4iK0k5oQMEXA8Z+Uy8Jmbiuwn9d+bbhxc=;
        b=RSWvUVU8f+4w28hrSyTH7uSNSf7Qx6GyDYPCNYRMYEUGgbKT+THOEspkb9lHXSOR9q
         yvatpd6hjT964B4kS930+lrr4RnBeqKjpJwa3h1vUZYaWT4H7D4TW8/r9V47W2XovTl1
         B79onOY6CEnWEcqUnUrhRukKrR5/NQSGOuPyDX+g/GjXDnJU/dXsIZZHUHHfI7lVUS04
         zR1/9eT2X/QRI5mH4SHmrHr5BiV3H38UkHGw4cFwhjoGcDolxhHpliOkYTjAMVQD3BG+
         3C1gBBOZEDs7FmSawz1BLmmqAEz+pwiASn3TL8LzbXjrJi2pXqwq/3qDwM/ch3Yg6gRd
         xlvg==
X-Gm-Message-State: AOJu0YzLKmY7PnvH3M4WsALFEGdPYTCjpTPdquhabtnWOfX1px560jCe
	+UtfdZy2QkKpb9ZsydnqeZqPEhd4ZI5HVa12V5yHemSNnthfWErg1xlNUHTGKsMvCTcJTzs7f7j
	rC+wlDsU1tbrBlQi1kzH6c7/fkcSco4M=
X-Gm-Gg: AR+sD12Zod/XD1PBtyLuHUIP6OIS4kk3lUtRa9Ml67F/dka7S3+4NUhpJ7rNMo/tWgm
	oLlwtAD55zod10PjEgkvI81DW7+WNcyfKG6wseoFVw+CfZXneWR0wSdCNF+D1fyPhvEsZXi/z9Y
	jUhz1VRPXi6J0M/q5LRITMsqDialpTCkRHPHqeB9E44nPJckCAqTB8vI+hjcyqwVBQruAqswS+3
	5ULwuuOdl9yatNPBmDbCFcf6HXZ3+f3gi7C6u7q32+J73zgGHrf+ickEGiv1bzgNtbAcyWzv9Ov
	sYdmj3S17l7mNvMi/b/XUEzu5wG2fs91riEs6Hd8sHIwjkn4KrTYjrHgUmcuVhQBm8wV+HDDsVk
	sv7yywRQYUrKgAY716mOgbz0OAckk2S/JcWpxAHKBfRpcp7go1s9/MIMSNOQ9WY+mZhzubJrjU6
	i4KcLcbnyBTRo9Dmus24BEQd4K0q+PxA==
X-Received: by 2002:a17:903:1746:b0:2cf:afe8:b722 with SMTP id
 d9443c01a7336-2d0ca761e0amr481223965ad.11.1786364883604; Mon, 10 Aug 2026
 05:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786103607.git.ben.knoble@gmail.com> <dbbd96d50811e4c2decb6f754b56dc1f7ee0944a.1786103607.git.ben.knoble@gmail.com>
 <xmqqv79ld40c.fsf@gitster.g>
In-Reply-To: <xmqqv79ld40c.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Aug 2026 08:27:51 -0400
X-Gm-Features: AUfX_mxAYw_-U7C5SAzZlpshwRg-oocP43bp4bV7AN3796ypUwLV5-LEMJGfsV0
Message-ID: <CALnO6CBm4g27mWBvD9m6yL0e5YZu3M9_zcUeLZk7QwTgnxMLQA@mail.gmail.com>
Subject: Re: [PATCH 3/3] core: convert build-time USE_NSEC into runtime core.useNanosec
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Tian Yuchen <cat@malon.dev>, Todd Zullinger <tmz@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000053af610658b07c69"

--00000000000053af610658b07c69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 5:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > Racy Git problems persist today, manifesting themselves in the
> > performance of commands like "git diff" in new worktrees [1]. We have
> > long had a build knob "USE_NSEC" to tell Git to use in-core nanosecond
> > precision when available, which mitigates most if not all racy issues,
> > but most builds we know about it don't use it. In part, that's because
> > someone distributing Git can't safely enable it at compile-time if they
> > don't know exactly what platforms their distribution will be used on.
> >
> > [1]: https://lore.kernel.org/git/CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEu=
PUh-yoeK9TseQ@mail.gmail.com
> >
> > These days, most platforms are likely to be safe for the USE_NSEC code.
> > Regardless, we want to give users the ability to benefit from it. This
> > requires exposing the compile-time gated code as a runtime option.
> >
> > In addition, update the Racy Git documentation and other mentions of
> > USE_NSEC in the code.
> >
> > Best-viewed-with: --ignore-space-change
>
> Don't do this.  It probably is helpful to have something like that
> below the three-dash lines, though.

[replied to SZEDER down-thread]

>
> > Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> > ---
>
> > diff --git a/environment.c b/environment.c
> > index 6676e6f5ae..e6a50060e8 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -571,6 +571,11 @@ int git_default_core_config(const char *var, const=
 char *value,
> >               return 0;
> >       }
> >
> > +     if (!strcmp(var, "core.usenanosec")) {
> > +             cfg->use_nanosec =3D git_config_bool(var, value);
> > +             return 0;
> > +     }
>
> OK.
>
> > diff --git a/read-cache.c b/read-cache.c
> > index 6c449f393d..297646c357 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -353,15 +353,16 @@ static int ce_match_stat_basic(const struct cache=
_entry *ce, struct stat *st)
> >  static int is_racy_stat(const struct index_state *istate,
> >                       const struct stat_data *sd)
> >  {
> > +     int use_nsec =3D 0;
> > +     repo_config_get_bool(the_repository, "core.useNanosec", &use_nsec=
);
>
> Yeek.  Isn't this a relatively hot code path?  If it is, it is
> criminal to force string parsing and matching like this, every time
> somebody calls the function.
>
> Doesn't istate know what repository it is working with and in there
> you should be able find its repo_settings struct cheaply, no?

TL;DR yes, but the patch series doesn't currently put the member in
repo_settings (repo_config_values). End of mail contains some
commentary there; folks from <anlmwaEtwcCPse1N@pks.im> cc'd.

I did some benchmarking on linux.git @ 848acc8ffe1b7cd5f1bf427b93069becfebc=
2c9d.

Brand-new worktree, without refreshing the index:

hyperfine -N --warmup=3D10 \
-n core.useNanosec=3Dfalse ~c/'git/build/bin-wrappers/git diff' \
-n core.useNanosec=3Dtrue  ~c/'git/build/bin-wrappers/git -c
core.useNanosec=3Dtrue diff' \
-n v2.55.0_USE_NSEC_disabled ~c/'perf-test/build/bin-wrappers/git diff'
Benchmark 1: core.useNanosec=3Dfalse
  Time (mean =C2=B1 =CF=83):     853.7 ms =C2=B1  23.2 ms    [User: 823.2 m=
s, System: 159.3 ms]
  Range (min =E2=80=A6 max):   839.5 ms =E2=80=A6 904.7 ms    10 runs

  Warning: Statistical outliers were detected. Consider re-running
this benchmark on a quiet system without any interferences from other
programs. It might help to use the '--warmup' or '--prepare' options.

Benchmark 2: core.useNanosec=3Dtrue
  Time (mean =C2=B1 =CF=83):      20.4 ms =C2=B1   1.5 ms    [User: 41.0 ms=
, System: 102.2 ms]
  Range (min =E2=80=A6 max):    17.6 ms =E2=80=A6  24.8 ms    122 runs

Benchmark 3: v2.55.0_USE_NSEC_disabled
  Time (mean =C2=B1 =CF=83):     839.2 ms =C2=B1  12.7 ms    [User: 796.8 m=
s, System: 158.8 ms]
  Range (min =E2=80=A6 max):   830.5 ms =E2=80=A6 864.4 ms    10 runs

  Warning: Statistical outliers were detected. Consider re-running
this benchmark on a quiet system without any interferences from other
programs. It might help to use the '--warmup' or '--prepare' options.

Summary
  core.useNanosec=3Dtrue ran
   41.06 =C2=B1 3.03 times faster than v2.55.0_USE_NSEC_disabled
   41.77 =C2=B1 3.22 times faster than core.useNanosec=3Dfalse

Same worktree after "git update-index --refresh":

hyperfine -N --warmup=3D10 \
-n core.useNanosec=3Dfalse ~c/'git/build/bin-wrappers/git diff' \
-n core.useNanosec=3Dtrue  ~c/'git/build/bin-wrappers/git -c
core.useNanosec=3Dtrue diff' \
-n v2.55.0_USE_NSEC_disabled ~c/'perf-test/build/bin-wrappers/git diff'
Benchmark 1: core.useNanosec=3Dfalse
  Time (mean =C2=B1 =CF=83):      20.8 ms =C2=B1   2.1 ms    [User: 41.8 ms=
, System: 102.9 ms]
  Range (min =E2=80=A6 max):    17.4 ms =E2=80=A6  26.4 ms    126 runs

Benchmark 2: core.useNanosec=3Dtrue
  Time (mean =C2=B1 =CF=83):      20.0 ms =C2=B1   1.0 ms    [User: 40.4 ms=
, System: 101.8 ms]
  Range (min =E2=80=A6 max):    18.0 ms =E2=80=A6  23.6 ms    158 runs

Benchmark 3: v2.55.0_USE_NSEC_disabled
  Time (mean =C2=B1 =CF=83):      19.2 ms =C2=B1   1.1 ms    [User: 27.3 ms=
, System: 100.2 ms]
  Range (min =E2=80=A6 max):    16.9 ms =E2=80=A6  23.4 ms    160 runs

Summary
  v2.55.0_USE_NSEC_disabled ran
    1.04 =C2=B1 0.08 times faster than core.useNanosec=3Dtrue
    1.08 =C2=B1 0.13 times faster than core.useNanosec=3Dfalse

So yeah, when we don't need the nanosec timings, this ends up minutely
slower than without it. When I apply the attached patch (sorry, GMail)
on top to poke through
istate->repo->config_values_private_.use_nanosec:

New worktree, no index refresh:

hyperfine -N --warmup=3D10 \
-n v2_core.useNanosec=3Dfalse ~c/'git/build/bin-wrappers/git diff' \
-n v2_core.useNanosec=3Dtrue  ~c/'git/build/bin-wrappers/git -c
core.useNanosec=3Dtrue diff' \
-n v2.55.0_USE_NSEC_disabled ~c/'perf-test/build/bin-wrappers/git diff'
Benchmark 1: v2_core.useNanosec=3Dfalse
  Time (mean =C2=B1 =CF=83):     148.0 ms =C2=B1   2.8 ms    [User: 142.5 m=
s, System: 124.0 ms]
  Range (min =E2=80=A6 max):   144.3 ms =E2=80=A6 155.3 ms    20 runs

Benchmark 2: v2_core.useNanosec=3Dtrue
  Time (mean =C2=B1 =CF=83):      21.2 ms =C2=B1   2.0 ms    [User: 27.6 ms=
, System: 101.4 ms]
  Range (min =E2=80=A6 max):    17.5 ms =E2=80=A6  28.8 ms    123 runs

Benchmark 3: v2.55.0_USE_NSEC_disabled
  Time (mean =C2=B1 =CF=83):     148.4 ms =C2=B1   8.6 ms    [User: 141.0 m=
s, System: 122.8 ms]
  Range (min =E2=80=A6 max):   140.9 ms =E2=80=A6 179.6 ms    21 runs

Summary
  v2_core.useNanosec=3Dtrue ran
    7.00 =C2=B1 0.67 times faster than v2_core.useNanosec=3Dfalse
    7.01 =C2=B1 0.77 times faster than v2.55.0_USE_NSEC_disabled

(We can see the raciness in the variability of the timings, neat)

After "git update-index --refresh":

hyperfine -N --warmup=3D10 \
-n v2_core.useNanosec=3Dfalse ~c/'git/build/bin-wrappers/git diff' \
-n v2_core.useNanosec=3Dtrue  ~c/'git/build/bin-wrappers/git -c
core.useNanosec=3Dtrue diff' \
-n v2.55.0_USE_NSEC_disabled ~c/'perf-test/build/bin-wrappers/git diff'
Benchmark 1: v2_core.useNanosec=3Dfalse
  Time (mean =C2=B1 =CF=83):      20.8 ms =C2=B1   2.6 ms    [User: 27.9 ms=
, System: 103.8 ms]
  Range (min =E2=80=A6 max):    17.2 ms =E2=80=A6  29.1 ms    132 runs

Benchmark 2: v2_core.useNanosec=3Dtrue
  Time (mean =C2=B1 =CF=83):      19.7 ms =C2=B1   1.5 ms    [User: 29.2 ms=
, System: 100.0 ms]
  Range (min =E2=80=A6 max):    17.0 ms =E2=80=A6  28.2 ms    170 runs

Benchmark 3: v2.55.0_USE_NSEC_disabled
  Time (mean =C2=B1 =CF=83):      19.7 ms =C2=B1   1.6 ms    [User: 27.8 ms=
, System: 99.1 ms]
  Range (min =E2=80=A6 max):    16.8 ms =E2=80=A6  25.0 ms    154 runs

Summary
  v2_core.useNanosec=3Dtrue ran
    1.00 =C2=B1 0.11 times faster than v2.55.0_USE_NSEC_disabled
    1.05 =C2=B1 0.15 times faster than v2_core.useNanosec=3Dfalse

Back down to being on-par with original code. So that's good. The next
version will include some variant that reads a struct member instead
of going through repo_config_get_bool().

But which? Reading the private_ member is obviously wrong; I suppose
I'm supposed to use repo_config_values() there. Or, rework the series
to put this member in repo_settings. I think I originally assumed that
struct is for things that are settings that aren't configured by
git-config, but=E2=80=A6 now I'm not sure. Looking at prepare_repo_settings=
()
shows lots of repo_cfg_*() calls. So I think I see how to adapt to
using repo_settings,

Patrick, Junio, and Tian had a brief discussion in
<anlmwaEtwcCPse1N@pks.im> about the split creating confusion. I don't
really want to wait for it to settle to land this change, but we might
want to work together on identifying the best path forward for
core.useNanosec :)

I don't suppose it really matters to me which struct I put the member
in. As I said, v2 will definitely fix the hot path lookup here. Just a
matter of input on which struct we want to use this time, I guess.

--=20
D. Ben Knoble

--00000000000053af610658b07c69
Content-Type: application/octet-stream; 
	name="perf-read-use_nsec-from-struct.patch"
Content-Disposition: attachment; 
	filename="perf-read-use_nsec-from-struct.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msn77mvs0>
X-Attachment-Id: f_msn77mvs0

ZGlmZiAtLWdpdCBpL3JlYWQtY2FjaGUuYyB3L3JlYWQtY2FjaGUuYwppbmRleCAyOTc2NDZjMzU3
Li40YmI1ZjQ2NmExIDEwMDY0NAotLS0gaS9yZWFkLWNhY2hlLmMKKysrIHcvcmVhZC1jYWNoZS5j
CkBAIC0zNTMsOCArMzUzLDkgQEAgc3RhdGljIGludCBjZV9tYXRjaF9zdGF0X2Jhc2ljKGNvbnN0
IHN0cnVjdCBjYWNoZV9lbnRyeSAqY2UsIHN0cnVjdCBzdGF0ICpzdCkKIHN0YXRpYyBpbnQgaXNf
cmFjeV9zdGF0KGNvbnN0IHN0cnVjdCBpbmRleF9zdGF0ZSAqaXN0YXRlLAogCQkJY29uc3Qgc3Ry
dWN0IHN0YXRfZGF0YSAqc2QpCiB7Ci0JaW50IHVzZV9uc2VjID0gMDsKLQlyZXBvX2NvbmZpZ19n
ZXRfYm9vbCh0aGVfcmVwb3NpdG9yeSwgImNvcmUudXNlTmFub3NlYyIsICZ1c2VfbnNlYyk7CisJ
Lyogc3VwcG9zZWQgdG8gdXNlIHJlcG9fY29uZmlnX3ZhbHVlcygpLCBwcm9iYWJseT8KKwkgKiBv
ciB3ZSBzaG91bGQgbW92ZSB0aGlzIG1lbWJlciB0byBzdHJ1Y3QgcmVwb19zZXR0aW5ncyAqLwor
CWludCB1c2VfbnNlYyA9IGlzdGF0ZS0+cmVwby0+Y29uZmlnX3ZhbHVlc19wcml2YXRlXy51c2Vf
bmFub3NlYzsKIAogCXJldHVybiAoaXN0YXRlLT50aW1lc3RhbXAuc2VjICYmCiAJCS8qIG5hbm9z
ZWNvbmQgdGltZXN0YW1wZWQgZmlsZXMgY2FuIGFsc28gYmUgcmFjeSEgKi8K
--00000000000053af610658b07c69--
