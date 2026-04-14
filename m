Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FF23D297
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177176; cv=pass; b=MXPsR6NyQ9LbqdmNb/Yo1qBD6YoQC03omlSAj/lwVr11SQBEuk+z7fMyFGz8xW7RoRf7CULUoPibPR1AHN5XjwALrd0DnRysF3niQLCjkgolUf+CjGFn6uX6wibYrr9kPB/MBX+np4EX6pOLC+rlQm7Vx4w3IM9xCznkqMXmUus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177176; c=relaxed/simple;
	bh=N1idMJks421u2G25pu5men6z4lXcRDK80qjtI1+9GFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Flys4XE2/JFbiUgvJ1wrKHsUKmkM9oHxRu9a10sIvvOEH0zi/ZZ0VlSDswTKd9yg35Ynq5pwyyN3r2HoN6pcURNAGti5hk3byeqCQjjObMUmM2lbGn5Cxfu/uvDIna1nT6UMrIs1Q0WyJVKQeyDdchXckl+yj1/cSJdBblP3tUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OENzl2L2; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OENzl2L2"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1279eced0b9so7935188c88.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776177175; cv=none;
        d=google.com; s=arc-20240605;
        b=Iu8U11OuRgUGPsVJflIDht976WsjnSAMB1q+0X+IvsGj4Y3FV57LcjAI/elZsn8KXa
         C4Nym4kOCbEKU1ahlNmhZTglinMyhV2+LUM+Sen/Tli85oXF7Ht+XfMnfK1rvp89/las
         EZ9rlMPU6F4eRyoemJqZW5sVZO+l8cY+6sp6vR0/2WIq/sZQ4hPRZlq8ppZp8TQPTrus
         nKIKgaxCkFl+4NyzheMgYZHjCefVAlz9F7FTDpM+mSLFfi+tEBJizt1oq7yZagKOQD1W
         fN3H+kfDOg1iV1+hfYrVBqJBWzk2KN4SIIFtin6WkYUtVgebWcm/JAugUkJSVKPfHlER
         ebWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mV8+vPmfMI4oaxRr6mir0SYItmBF6ALWGaAPMKSCBqI=;
        fh=lBPmdbGtIqLcrOfOHWor4SBa+dA9MPlYNnuFeiowut4=;
        b=hyNul93spPFcuFzNd5kyjzk+I1JPhKp5DocnsGMl/ynTpM56SALwBFRyuK808XYMRj
         TnErbNUY8UGpXvQNMFKlEj0khKWAcOeoZiqeVJNIrt0Pl7UE6OCyMn1rW5Nm6v9YcUs9
         7kfyJSvOfvON7zuYXpdRu9ciywbzHl5eF3ciWZ1eaw1wTAm0y/6udpmE3UTId4OsqGOP
         bsr5h1A9KnfDQhu/HRWjeh0tLdXDZ1cbnciB9JXwyWe+IXfpnfFtmb6I1PoOYxyEBsSH
         apvhVZrImGSNbWwvLIGwdXL5bZlnbEG8Ex2gGeJsmq7Id7kDAIYGTbH3vDiqtSWd6LmP
         Ty+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776177175; x=1776781975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV8+vPmfMI4oaxRr6mir0SYItmBF6ALWGaAPMKSCBqI=;
        b=OENzl2L2P8tHvTJDI4k92wqwk9/uftKBi1qqlscZZrJTwxytANOdpJU3TzeSDIkmNY
         cnPXlVbey6v5pHuUu9wkNCPUNY3IXgCISSWdRKTTU8C0P7R30tVGUVHZXSpmjkEjIePh
         TaaWvUxw/T7fRNmIiRz7b12PiS7wiIul5yGVfxS1PQAVWvPsXscpiQQqLDG4cwAYpBV/
         NVAaOcM0NFX7KN4dKRaoqcEEu1Rjpc6tLDo01KlH41YvkQkhLpM7O0PtHUlA8PwngsMV
         SinhJSi9QfPhvsCwZ0z0chFLbAlkybLA50FANf6cI6xKZbO/+Rf/80IhbcWlBvx3pVDo
         h5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177175; x=1776781975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mV8+vPmfMI4oaxRr6mir0SYItmBF6ALWGaAPMKSCBqI=;
        b=phPL6oRzXiCF4XOqN5oL9dbqTbj3hD3S5lo864hAxS73YJCwo6a84kf9vS16Bt3ryJ
         UWWzu12Uj2/Z8XpHdd+HIW54STDV3Lnf410axGRoKJK/ju7C5dPla1mKanx/EEuEz9hs
         wYPUmutlLTEoFjQPeQN8iC3dl8lSJzSqp1kC5K9xw660cAB5Ww+KraTnavM8vKuSpRyF
         6EkNxyTtI1SYWK8j2+dkX+7HHS0l9r+N94GtNl2PwSna/1MN0kzDSgwMGAjru9+4EcI9
         HuEcYbi5Dab3FOcn7ZHE7AROYSeCbTWAMuXcty7KUnK+0EdcF+MQPUrWvUzEDd+WTkJD
         H/FA==
X-Gm-Message-State: AOJu0Yz4gdlPh094kL5Ox2U5bqnipOibdnnATp7xdzX/qJ+zevoFLo7e
	MoIh7DfV/t7eU6aQ9D/3WxwKA9JnDf+qOJ44Ao5f+ugLN2mkLpLN9c1ynZy13Hhmq5x1Hg5c7A9
	A+qCcbXTl5OOiSTfZtD33YfT26VWIbnU=
X-Gm-Gg: AeBDieuyPmf3Z7/aWvoZ/zjzjhj8g2+0As7e7vNqRAT/pga0Zf4trm34zkkb5BRhCXf
	mJkykBCkpu3lpy3ZprUvpmtQFF62rv86Fn2HU+Ywh8RKYJI/baTbFuo6q2sQOfWvaNDVCa3PvAt
	p1QQfEPpwL+mp5chSZTSzrUZLB9/KO/ZxfUx4Ddavwf7kE1h7j6siG1P8eCv/V3Slb4aLmILZqK
	ojOr4ljPpDHUtJFu6F5jj6jri6hn1sziZOlyTzLb+8iWgSndcKhcnqFw9H4QqfU8lokpIDEGYsS
	bpkqI879dPeXTrycpVTtAzt6gdPDok9M7KvH6jIJktXDAZmBV09LvbHtBsbxq5prua9RsI2+Ray
	L
X-Received: by 2002:a05:7022:eac7:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-12c34edefddmr10639829c88.17.1776177174577; Tue, 14 Apr 2026
 07:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324123750.157143-1-belkid98@gmail.com> <20260324123750.157143-4-belkid98@gmail.com>
 <CAOLa=ZRexa+uYj=F2++=vijBb760MgjdTwq3REPpxcwk02caHg@mail.gmail.com>
In-Reply-To: <CAOLa=ZRexa+uYj=F2++=vijBb760MgjdTwq3REPpxcwk02caHg@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Tue, 14 Apr 2026 15:32:43 +0100
X-Gm-Features: AQROBzC3m50XD0jBs--VY93PFN2AlpOaKVqMMQaQgC9Nb4ocXQvXS0a3DoR7uIE
Message-ID: <CAD=f0L-ckZUpcvjB02V=ebDgSQ2XeNG8pwHfUqOgeoJF67tLGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] environment: move `zlib_compression_level` into repo_config_values
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, gitster@pobox.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Apr 2026 at 09:58, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > The `zlib_compression_level` configuration is currently stored in the
> > global variable `zlib_compression_level`, which makes it shared across
> > repository instances within a single process.
> >
> > Store it instead in `repo_config_values` so the value is associated
> > with the repository from which it was read. This preserves existing
> > behavior while avoiding cross-repository state leakage and continues
> > the effort to reduce reliance on global configuration state.
> >
> > Update all references to use repo_config_values().
> >
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> > Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> > ---
> >  builtin/index-pack.c | 3 ++-
> >  diff.c               | 3 ++-
> >  environment.c        | 6 +++---
> >  environment.h        | 2 +-
> >  http-push.c          | 3 ++-
> >  object-file.c        | 3 ++-
> >  6 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index b67fb0256c..dd82eed76f 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -1416,8 +1416,9 @@ static int write_compressed(struct hashfile *f, v=
oid *in, unsigned int size)
> >       git_zstream stream;
> >       int status;
> >       unsigned char outbuf[4096];
> > +     struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
> >
> > -     git_deflate_init(&stream, zlib_compression_level);
> > +     git_deflate_init(&stream, cfg->zlib_compression_level);
> >       stream.next_in =3D in;
> >       stream.avail_in =3D size;
> >
> > diff --git a/diff.c b/diff.c
> > index 501648a5c4..4bc0297873 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -3365,8 +3365,9 @@ static unsigned char *deflate_it(char *data,
> >       int bound;
> >       unsigned char *deflated;
> >       git_zstream stream;
> > +     struct repo_config_values *cfg =3D repo_config_values(the_reposit=
ory);
> >
> > -     git_deflate_init(&stream, zlib_compression_level);
> > +     git_deflate_init(&stream, cfg->zlib_compression_level);
> >       bound =3D git_deflate_bound(&stream, size);
> >       deflated =3D xmalloc(bound);
> >       stream.next_out =3D deflated;
> > diff --git a/environment.c b/environment.c
> > index 8542ac3141..5b0e88b65c 100644
> > --- a/environment.c
> > +++ b/environment.c
> > @@ -52,7 +52,6 @@ char *git_commit_encoding;
> >  char *git_log_output_encoding;
> >  char *apply_default_whitespace;
> >  char *apply_default_ignorewhitespace;
> > -int zlib_compression_level =3D Z_BEST_SPEED;
> >  int pack_compression_level =3D Z_DEFAULT_COMPRESSION;
> >  int fsync_object_files =3D -1;
> >  int use_fsync =3D -1;
> > @@ -377,7 +376,7 @@ int git_default_core_config(const char *var, const =
char *value,
> >                       level =3D Z_DEFAULT_COMPRESSION;
> >               else if (level < 0 || level > Z_BEST_COMPRESSION)
> >                       die(_("bad zlib compression level %d"), level);
> > -             zlib_compression_level =3D level;
> > +             cfg->zlib_compression_level =3D level;
> >               zlib_compression_seen =3D 1;
> >               return 0;
> >       }
> > @@ -389,7 +388,7 @@ int git_default_core_config(const char *var, const =
char *value,
> >               else if (level < 0 || level > Z_BEST_COMPRESSION)
> >                       die(_("bad zlib compression level %d"), level);
> >               if (!zlib_compression_seen)
> > -                     zlib_compression_level =3D level;
> > +                     cfg->zlib_compression_level =3D level;
> >               if (!pack_compression_seen)
> >                       pack_compression_level =3D level;
> >               return 0;
> > @@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_val=
ues *cfg)
> >       cfg->branch_track =3D BRANCH_TRACK_REMOTE;
> >       cfg->trust_ctime =3D 1;
> >       cfg->check_stat =3D 1;
> > +     cfg->zlib_compression_level =3D Z_BEST_SPEED;
> >  }
> > diff --git a/environment.h b/environment.h
> > index 1d3e2e4f23..93201620af 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -93,6 +93,7 @@ struct repo_config_values {
> >       int apply_sparse_checkout;
> >       int trust_ctime;
> >       int check_stat;
> > +     int zlib_compression_level;
>
> Nit: applies to existing values too:
> 1. Perhaps it would be nicer if these were sorted alphabetically, I
> assume we'll add a lot more fields here.
I=E2=80=99ll reorder the fields in `repo_config_values` alphabetically
to keep things consistent as more entries are added.
> 2. Have a comment stating the purpose of the variable?
I=E2=80=99ll also add comments describing the purpose of each variable
>
> The patch looks good to me otherwise.

Thanks, Karthik, for the review.

Olamide Bello
