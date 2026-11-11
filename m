Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794370686;
	b=IABj/fgEnYpFiGfjHQ55gi38c/HOUY321ez9gjApnPZiUEvkxlxj0lYjjycWnJVVxAOO
	 m4qxsv/M2NvnmcDERq/JM7Kj9DZTkn9qWufpd2A5UFQZVI8+ZR9JXKRYsWCurjZdDVN78
	 upsgBARfcp4N4apGSlx4lXoCe/CSEQDhzvtraPdYJJ8+lzSLiH9BVK31BsNciJRCm/UEd
	 Z33VeJCQPUZRMSjRv4pHFj0A675wsrVb997hQ9zWEY0nnDD6zBS/ERYSYkSdV8N4KJiUo
	 37G6t63kMzI33/ci+Gc7EVnF06RXkChhzqaSiLD5w3rjLW5P2IuNx14yGqHOBuHdKjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yDs1n1mZBpdWReyMTqOE29/ep+4DRDTqmDAno+7R43I=;
	b=aEA3PdC0V3NJ/azTxA9U5qoMa7zEmUhUtLA9AiJoRsZe2EWjLc8x41cskik/W5clGhyW
	 xRMf8zg0jQ0//P9G1g4s3Rdi+iKLabbjkdOiF6Wtefd0Y96M1jYT8Lm5b1DmItxqMeXnV
	 3PSdSPt+IFLtOj7fqC+EFGcjkHJpC3/PvbdkspTvuhN46LjpoNEjq7kae0QZKBiitELvu
	 CfQ3Lbvv+a/JO9zDjMNo4WezSOtDlsSf2/+xfVZcEt7tFR+kDDZQ7WUD5VhjImhYu8nkx
	 38s+Tmk4X7ivMBoiD6rI8cVHJHT6DhehUiav7dFzApPgEg7yFMHj1uXK6DBK+ltxa6A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HE6UZ66/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2A7606A32A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 04:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A2A7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HE6UZ66/
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91eb53957cbso36555436d6.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794370685; cv=none;
        d=google.com; s=arc-20260327;
        b=fZ292ag+ngdqAr2sXyLy6LH0OT6NzDIsURZorEuY05Bc/n0ARQE3R70FYoOkY5l4mL
         J7Ji/JIL4OI3tiIMB26wOsALXoTSYjLNWkdRQwpBDEQwO6OR7VmRRroUotpKbM9Rkl9P
         6DsKapaLQQboEcGOP3/zc+KxWOVGVG+WvxS859i5tW1nmahNjMYslf16qc8eY/Rm9V/v
         W1fc0Cpu4SMcY39RmKmkGemQkOHbwTdNS/ISRV1FGjLHrzRWsqnn+0PYrnrLezX58Vej
         F9KuNTmjaJI02bz0bFtUs52r76xVS7lXyik2J/msYvwdQnljPDYHOCnFL2aig7IIREdU
         ZNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yDs1n1mZBpdWReyMTqOE29/ep+4DRDTqmDAno+7R43I=;
        fh=qy140r7Cgn+DWbY5OSGjaZrx9JECGENB77P+etxJVxI=;
        b=kLp+GZLtmy3/z7QxQu0RXOSe0k85JjmWOgues03MaaQ+LBzvpv5sgV4qCkNCgONObx
         opWRxZ7worPFjdqVXoo20rDYNiXlZNqEpDKj4TewCbNk3F7jnNK1WZUFaKB99fzJENAD
         bYc8/XVGVXCc/xB1HjLmHzsgBcmVTIrNbwy8Fm1xw4quIHVQKSgSYgXf8s8gDSz5ydEm
         VxRy4Qrlr3ZlLjCp4IpT11HWluHKKSlJFoSo8Vq2wOoq389Ifj/nzR9JD5358TraowJj
         jzSZVuv/SJoItJBYFJCf/WKU4jEYw4/xtDlXK7JN3BCGmpWifKyW2zAUJrrM3DFyJuw+
         n34w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794370685; x=1794975485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yDs1n1mZBpdWReyMTqOE29/ep+4DRDTqmDAno+7R43I=;
        b=HE6UZ66/jJGBntLnPLZICmYHkYO8qBI9f0OoTXUl19HEL+Kfxc7wVhHM4N6rXhuXEH
         OqCQcA6Yr78v6FY7KMzxPlkpTE4gjH0fbyiI8w9bgAA840iLKCj17MCE8Bkbj5356C6n
         EI4kYleCauC5lrHEUQvnW96oPzqNXxzsW9aOs1gACfosyZR3lK/XLkVFSa9ORkvr11Qx
         DymRyaRGOtUDEqSiBoLM4IouS0jdhy4c29Wxgqh5It16XVhzz3MQD0MEwjeRe2PrHi8g
         wIOsicvDKcoq4W5Mg9alRzqnyWKPoevSYWxXeVknj6Y8K9yt5Y2/utGQauWlmlLpWQnD
         9rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794370685; x=1794975485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yDs1n1mZBpdWReyMTqOE29/ep+4DRDTqmDAno+7R43I=;
        b=cu/St3/VDjpSwS7PSmjNGzy0chaT/0PZ7/FUqPBNsthtlTrkHVNNGUZnH7Jh2K3nPv
         FC3jT5CpR+xxtpQFROrPkWn5NQmvMIASOfOecdwX+y6rEYIWijCPR5aEDc195kl+nb+y
         s1YS85n/COey8voPI1BAuw/PmL1/UTJ3B9mUEGZzXUet3NDL+3qav2FLaJ/mw7ILPHIq
         p3+wqccyGykkQljJnttoC9p1ypuaYO5wThc08WrdH5mDXm1+MTXtxTOGvoKZwjQSCh2+
         SkaloBFoQqOmqWdbuowTg7ogbKU/QGDXlD0ir5hjyT+755rtkd1nSUgNjdVJ/6GRsZYH
         MbLA==
X-Forwarded-Encrypted: i=1; AL+hErGGmEvm3etMM43uqrkph+47mJSrqShGDk3xzmW7GAOlrjHu5WUcd4xH+qQNC9e+oO0z0hg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qFNGs/+zBn09h86Sx7Kro2d656OIziTK9YIFyN22nqdS9zxZA
	GV7Ke0CnHaF30j7ZKJjE3Isi2u4k9ApdR/3E5clcCQ0aX3UzoWCWWmLdBEhRGAadDtE45og4Dec
	tp6DG3RsS5Svjm+9kOEcD0L4Ng00lxX0=
X-Gm-Gg: AYBFou33qRBBDiYQOEG133kBrMpa5eROWz0n/J5dJpSv27i8g78f2BdOXPkBAAJ2TOb
	CGaI/F4Cw+eTvxzW/tCuhT3xu2/TlB/dA5Ne1mjGtuQQa/Zut+OfpluzbhLk+3XOTyMld0LGqa3
	U3/UW6xchoLjmgl/AOBka35cUxePrC1mX5KNwFZSHVgCG/0y2mcNfF6BUzYNnwC8mtabYk+pboJ
	HDcm9fWpaEqsHW60kTctVnkt8H9jfdqfQQ8HiApR8WOuTqIxI3xfA6kXfHh29GKCoW5dPUxq0OC
	PwDajW/cWQbLXU/JT/DWEajajPVmHoYI1avepZ4ZFRBlNH763cg5uYa3Dbp4w0nlmdxt3GYWttY
	z0noctFuilQsruyPNv/XT0QXQz4Z1487j7kk9xc3PNk9M845tjN5iBTuscSwMg2XlkH5+p/9WmG
	jTwA6jAce9oa62G9CbBsCQfpMYuK8/puJ83HAYbmV8di3FYn6EyROoVmHc
X-Received: by 2002:a05:620a:2903:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-947afff281cmr198218385a.22.1794370684984; Tue, 10 Nov 2026
 20:18:04 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
 <pull.2305.v3.git.1794335969.gitgitgadget@gmail.com> <398b54f00a1278f22fef456384c6c4ebd1a1f576.1794335969.git.gitgitgadget@gmail.com>
 <xmqqse18pgin.fsf@gitster.g>
In-Reply-To: <xmqqse18pgin.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Wed, 11 Nov 2026 09:47:51 +0530
X-Gm-Features: AclHuK-b8cE5KYEicBEeMGiGzZGqoh0ua4MLD3b1s19zwClFiyijRUIp1Nr8490
Message-ID: <CABh_KWhA0bZzVrbY-bBA6i1tOqkZ-+a+m1g7tsqKyj8zK+D77Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:10=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > Refactor archive-tar.c, archive-zip.c, archive.c, and supporting files
> > to clean up archiver initialization functions and header dependencies.
> >
> > Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> > ---
> >  archive-tar.c     | 5 ++---
> >  builtin/archive.c | 1 +
> >  2 files changed, 3 insertions(+), 3 deletions(-)
>
> Where is the change to archive-zip.c the proposed log message
> advertises?
>
> The proposed log message claims that it refactors and cleans up, but
> the patch looks like a totally incoherent and unexplained mess.  All
> the places I note "What is this change about?" are unexplained
> changes whose value is dubious.
>
> > diff --git a/archive-tar.c b/archive-tar.c
> > index a1c66024d4..642a3ddfc3 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -3,7 +3,6 @@
> >   */
> >
> >  #define USE_THE_REPOSITORY_VARIABLE
> > -
> >  #include "git-compat-util.h"
> >  #include "config.h"
> >  #include "gettext.h"
>
> What is this change about?
>
> > @@ -337,7 +336,7 @@ static void write_global_extended_header(struct arc=
hiver_args *args)
> >       if (oid)
> >               strbuf_append_ext_header(&ext_header, "comment",
> >                                        oid_to_hex(oid),
> > -                                      the_hash_algo->hexsz);
> > +                                      args->repo->hash_algo->hexsz);
> >       if (args->time > USTAR_MAX_MTIME) {
> >               strbuf_append_ext_header_uint(&ext_header, "mtime",
> >                                             args->time);
>
> Here, the args->repo which was relayed by archive.c:write_archive()
> is used.  This function, when called by builtin/archive.c, passes
> the repo it obtained from git.c's dispatcher; when it is called by
> builtin/upload-archive.c, it uses the_repository (which is fine).
>
> This hunk looks like a good change.
>
> > @@ -529,13 +528,13 @@ static struct archiver tar_archiver =3D {
> >  void init_tar_archiver(void)
> >  {
> >       int i;
> > +     repo_config(the_repository, git_tar_config, NULL);
> >       register_archiver(&tar_archiver);
> >
> >       tar_filter_config("tar.tgz.command", internal_gzip_command, NULL)=
;
> >       tar_filter_config("tar.tgz.remote", "true", NULL);
> >       tar_filter_config("tar.tar.gz.command", internal_gzip_command, NU=
LL);
> >       tar_filter_config("tar.tar.gz.remote", "true", NULL);
> > -     repo_config(the_repository, git_tar_config, NULL);
> >       for (i =3D 0; i < nr_tar_filters; i++) {
> >               /* omit any filters that never had a command configured *=
/
> >               if (tar_filters[i]->filter_command)
>
> What is this change about?  Earlier, we first declared the built-in
> default configurations and then read from the configuration files.
> Now you read the configuration files, and then overwrite the values
> the configuration files specified with our built-in default?
>
> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index 3c1288a123..8b7d56f8cb 100644
> > --- a/builtin/archive.c
> > +++ b/builtin/archive.c
> > @@ -2,6 +2,7 @@
> >   * Copyright (c) 2006 Franck Bui-Huu
> >   * Copyright (c) 2006 Rene Scharfe
> >   */
> > +#define USE_THE_REPOSITORY_VARIABLE
> >  #include "builtin.h"
> >  #include "archive.h"
> >  #include "gettext.h"
>
> What is this change about?

Hi Junio,

Thanks for the detailed review!

1.Commit message mismatch: Good catch=E2=80=94archive-zip.c was a leftover
reference from my previous iteration's commit message. I will update
the commit log to accurately describe only the files modified in this
patch.
2.Config reordering in archive-tar.c: You are completely right. Moving
repo_config() above the default settings broke the intended behavior
by letting built-in defaults overwrite user configuration. I will
revert repo_config() to run after setting the default options.
3.write_global_extended_header(): Glad to hear this hunk looks good.

I will fix the config order locally and refine the commit message, and
I'll wait to send the updated patch series until we've finished
reviewing the rest of the feedback.

Thanks,
Srujith
