Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794671245;
	b=TsG6Rlfm0V9OSeZjUBbNxQjQ9q4TQdSFZr7tMGb8MFZiDMtB28TJFfgt3iu0RtFKEtN9
	 AcpzbfcEQLYaVAaMDd14ZEVjEZvUWvjEssjOQwRztwVsw2dPwV42OYmo4/OzHQMjlk84A
	 ShZCPuWWRBd5kGLLfgVeq8mkWyIxC/a/wNSjOZbDY9PCgFkRSdbMs5ecyUYUMIa8tKYwU
	 YildW/iTQieCXZQp5gMxQKK1FL3jXARuH0LSLoiiMFsKQjUkNVmkRLi+6MX5+yRmXVL1U
	 bPpfj6A0R9ZjnI0XDssjl/uWWDHt2EvGluJXAt7lARIkG7QjQpPDPmllUBsfNpx7oXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bRnLbC1kCYzA7Lkhx22grUFZqG9taiURvNL792diVK8=;
	b=A76ZRtw1FRDRvjwZ0pWTOFCrDolYDFO/VxmcbTNOhDKnqCIAirVWrJWq0+esLowOhzef
	 m8jxTdbe+unVRLIuPEcnWBa4mOybXEpjWE1dD/6x5rEqoIeq5m9MfnstdPLQ0TL6eJMW4
	 nTeVnbfH339UgsBI8FbZWmYndoAeTrFyc/6yT1Bp/VhM8nRiJ9yFHb93zY2rTDy7A0LmO
	 e3ss6cYzjunDb/pnvZHPeBPw359/8Z5HxShJJe3dJQPFuMm/lwigp4LXIW0pfah2RmvAQ
	 crIIBdXXEW50glaI5lcW0A2gD1TNXueGYoNe4EjZ8PiY3T91mO5lOT9j/sGUHBWu1Gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j+iZUicj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE214606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE214606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j+iZUicj
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91ea16d8072so23757366d6.2
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 07:47:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794671244; cv=none;
        d=google.com; s=arc-20260327;
        b=TOVAKTjX+Mi8DRRKD2z9hi+Zk0TCVYiIyfPL+CIeZjZEDnU2Es4gRfCiEEzbWZDZog
         6ezPDcV69V3tf9SKvXi5PTSAsa2CNte4N1hoHuvc5vByFbuywK9pie9+iqa9kiCB5VZj
         JgDNsTqGk7LbioGrTgGS/o3DFDdvjQEv1txdGwmQsn7hb3Nibk1Tno3noCImrZEXsZ/O
         8VLJfXGv8c+lZzE9SeJJb+7Kbg+GImxqvs91qxrgFxQNLEiUx+ooIv/EaC9flyy64Cq+
         wnsovM+DzDNrBhPtG/9J7br+iF+wJSDEHo7LOr/b6wyzT0x4L+XrH5B9c7yAnlp1K7gY
         bGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRnLbC1kCYzA7Lkhx22grUFZqG9taiURvNL792diVK8=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=mJGMPAawJtMpuufo5MviZU+w7QCf5V3YKJwoRuGY1cSaOYPJWpBa9x+CXS+rWJoyzf
         Wm3hasFH+Grgj2K2neHQTfnY755u6s+hTj1u0PiMz4Vm80SKoZCee0XHxJRnkjKhi/ex
         srFSH1T/7NA1JKM+vAW/uzhBzufwJFT1Frysj+mQ8h4i8/PVqpTD6v/gaVcnS5BWg1Dq
         tgQEbK+6S0uqPASlFrFgAzBuh3cHq6G7unov82r0TwJYQmxfct4Tto2YdaXwB0/xpwFf
         ChE7DizsSVR/BhQdFxr5UvEmFC52+ZriLwBrCFalelyR1Zo1Fn3J8RJa41Zv0e8w18zA
         SGVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794671244; x=1795276044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bRnLbC1kCYzA7Lkhx22grUFZqG9taiURvNL792diVK8=;
        b=j+iZUicjjq/PCM0mzzdBSr/l7SWEOYlemtijfrxtdZKhQDGwOp3ofP6EpFznr8jZhc
         BhrOyMhpt7JRp83GOhP0J3TLd2NHju4zg3YBFp6n4YYpk/e4MJfRKK+fQlGO0Lx2tf6f
         tfRc3uavYjg6vgnUbt2wSpK831lGWeMVIO0EhScQX5uIbTfiWv49WwKbE7LoY5nRv6yq
         OrjWp6acqmUxK/OMH1C/j6AGaBe+RdaqmXbOJ0bAR6hn4blWiZUW/HOaSxxCW7JVNrsw
         UvYOLmGeFMsViMzRi1AtP2Y/DzMEC8dftWx2rLZ/Hlis5sJ7Y04/7gavJYdQ29/tSwWb
         yx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794671244; x=1795276044;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bRnLbC1kCYzA7Lkhx22grUFZqG9taiURvNL792diVK8=;
        b=pf8Ew/SfZo4WDmtKQRUbBV77502sUawmn9qhSsWGRv6VNPR2RYhARzlppqRpGJuVhs
         FKPLO4eJDFcxWLhELHXeqkyC097hw0FRn4HA8wUqOvOWtzCXXwd37GE8d0GjC5QSU6YR
         DffPZ+4i7LF7v04nAn3weva6mGRcyS3FHvAOMg7R73uHssp1fVs58NYjrrk8u7AF8r1R
         DCZYhcR67Hvm48i8Y5fNZbco9NdSedS9NaE76RJoTxnaVaK5jvInAmcZwysaizuymXUF
         NFQDpzzPR6GEg1LLz5u+eK0YKaQgcGmSfGLnvw9KUXMt0ZeJhnrqSm3C+kh/wGTCqWM2
         GJOA==
X-Gm-Message-State: APuU4Z9DT+Pvit8xoy/zdXKpP+Zr/+mgvEmCXsuZ4xgERNcUsgODworT
	I2iKcCzIekYg3lg7FqtveVmOdJAHoibz0G0H2MpH7NlShne75Yt6XKDfYQ8RGOOGga/fhOjI2sw
	Yo3FjNpsCFB54NPKc8ak3LPLhnIKwQpYImVOc
X-Gm-Gg: AYBFou2kGHghpUYnzmfYKOCTzHK53HtOXHkjSf60MzxvEW0dVYyBm33FoLBM5Dcw/ZY
	7nBhLmQ0/7A/oN9gHHEPQ61eEiizG97aXNt8V4jeCBU+OuKfXba/2gZtOccDP6fnpxamgQ3BZgD
	HVNmAvpjprixAic0BVGrkSE6s04m5ByOB4ATYONZKlb3P+xQnmcAdayF9MA4X57HY20VIgZS5+a
	RXwSPXESwyACT7biy1iRVzIkk8I30tKShSvCYJP8/Bvur5Ir7qm/9g9dkS3g95eLbB0f8x/qvD1
	dA1HQzLRQSJ3JPAQK7Tek7jsqYxUhy4DM+e8qHrtpLaPczQH/1LPgf36Vlii3wcMDPCfM7mjkK+
	DWVhhg1TCRarL5fdxeTjPdj0oBhmiAdEF/+yMUPVdKDhG1zO6rNXpxjiUADRZ+C58dMUnCA==
X-Received: by 2002:a05:6214:509d:b0:91c:8fa6:1789 with SMTP id
 6a1803df08f44-91f2414801amr93070906d6.28.1794671243523; Sat, 14 Nov 2026
 07:47:23 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
 <f9adc6c85c4b098a0df8cf18783d1969a68fc048.1794484985.git.gitgitgadget@gmail.com>
 <CAF5D8-sJkCzL85boqNDnuU+wWthMSB37h5SJOny4hDUfe8y1rg@mail.gmail.com>
In-Reply-To: <CAF5D8-sJkCzL85boqNDnuU+wWthMSB37h5SJOny4hDUfe8y1rg@mail.gmail.com>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Sun, 15 Nov 2026 00:47:12 +0900
X-Gm-Features: AclHuK_yqTzLyCCssRxR7pUJTZdanBcngHSh40JFDH_ipg98Ctx2DJQdnD_I7mI
Message-ID: <CAF5D8-uCq26c9G+R7uzoepY28aN0H6d+XL5DYBc5_cp0pF35vw@mail.gmail.com>
Subject: Re: [PATCH 1/3] submodule: make submodule.<name>.gitdir relative for worktrees
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 12:27=E2=80=AFAM Yoichi NAKAYAMA
<yoichi.nakayama@gmail.com> wrote:
>
> On Thu, Nov 12, 2026 at 9:03=E2=80=AFPM Yoichi NAKAYAMA via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> >
> > For a linked worktree, always keep `submodule.<name>.gitdir` relative
> > to ensure it continues to work when the worktree is moved along with
> > the main worktree. (This benefit also requires
> > worktree.useRelativePaths to be set to true.)
> >
> > Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> > ---
> >  builtin/submodule--helper.c                | 68 +++++++++++++---------
> >  t/t7425-submodule-gitdir-path-extension.sh | 19 ++++++
> >  2 files changed, 61 insertions(+), 26 deletions(-)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 461b682d0d..56d7720e93 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -37,6 +37,7 @@
> >  #include "wildmatch.h"
> >  #include "strbuf.h"
> >  #include "url.h"
> > +#include "worktree.h"
> >
> >  #define OPT_QUIET (1 << 0)
> >  #define OPT_CACHED (1 << 1)
> > @@ -507,50 +508,60 @@ static int validate_and_set_submodule_gitdir(stru=
ct strbuf *gitdir_path,
> >
> >  static void create_default_gitdir_config(const char *submodule_name)
> >  {
> > +       struct worktree *wt =3D get_current_worktree(the_repository);
> > +       const char *modules_dir;
> > +       struct strbuf tmp =3D STRBUF_INIT;
> >         struct strbuf gitdir_path =3D STRBUF_INIT;
> >         struct git_hash_ctx ctx;
> >         char hex_name_hash[GIT_MAX_HEXSZ + 1], header[128];
> >         unsigned char raw_name_hash[GIT_MAX_RAWSZ];
> >         int header_len;
> >
> > -       /* Case 1: try the plain module name */
> > -       repo_git_path_append(the_repository, &gitdir_path, "modules/%s"=
, submodule_name);
> > -       if (!validate_and_set_submodule_gitdir(&gitdir_path, submodule_=
name)) {
> > -               strbuf_release(&gitdir_path);
> > -               return;
> > +       modules_dir =3D worktree_git_path(wt, "modules/");
> > +       if (is_absolute_path(modules_dir)) {
> > +               modules_dir =3D relative_path(modules_dir, wt->path, &t=
mp);
> >         }
>
> I noticed that worktree_git_path() returns a pointer to a static buffer m=
anaged
> by get_pathname(). I'll copy the result into tmp immediately, before call=
ing
> other functions that might overwrite the buffer:
>
>     modules_dir =3D worktree_git_path(wt, "modules/");
>     if (is_absolute_path(modules_dir))
>         relative_path(modules_dir, wt->path, &tmp);
>     else
>         strbuf_addstr(&tmp, modules_dir);
>     modules_dir =3D tmp.buf;

Correction: relative_path() does not always store the result in tmp.
The code should be:

    modules_dir =3D worktree_git_path(wt, "modules/");
    if (is_absolute_path(modules_dir)) {
        modules_dir =3D relative_path(modules_dir, wt->path, &tmp);
    } else {
        strbuf_addstr(&tmp, modules_dir);
        modules_dir =3D tmp.buf;
    }

Thanks,
--=20
Yoichi NAKAYAMA
