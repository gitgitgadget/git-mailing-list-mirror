Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794717394;
	b=t15ruDd+XYpYk3EpAvCUW6N+HNCPZtjUSPuldUe5gKpemjhg5umgbjn0uvhTuiqlqUib
	 dNTJRMDcPelgQYpnq9DQR+H/RKGfW2pUXXrVLuRsRRJqx8GJ5ZJ/vPEbjisuIRS9D9PRc
	 mKX6wFPoCIKsz3pnXQOtp4fbt6klvl6btfII7BKRB6CqOa+ZHYJKq6m2DZmXlIgOMtfAL
	 3f8C1ST0A69DvbVK7Fi/U9qZ4k07v8hvH+g6PTBLbMwcZdYhOa1yonbb1SfSmqIF18ISC
	 s+R6AlahgvzGcMl29xF1D0W4wazplSUgKjuZUn63C7Utxd78E+sQHwAw6nEfRQ3MLMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Lw4PafUNpBefejUL5dsPS1p8GMKZRfK/xKo7rtimXWA=;
	b=WmcnSykBfgZlrVSt3Iw285yCxqVGCZRVB6yPlmQO+muedNH7cSQuv1BUePmspaRYKHUG
	 y0FCPsyvUehqq7doZaUTQgsysB80uPJSk5mxFQmKmv+2MyJY6+rbAYIPYlP1jkz+bECJ2
	 JfClHevlobDFUB4hOBiVGTSyh1IPbmcqHVdFexenPmEvNOlIBCEzODx0C13XB9did2Qvc
	 xOfrLcha7jSmZDqfB8O/Wu//llAkDZSG+3LoS14gB3cqqDpuyitdFl5HPkK7YrrtI3rbN
	 gBLgswapzDsLDPwdWTt936AHKDP70RK7dJKePc6g+0nOdtUKFRT2lWGugBAAYqqRORw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PEOxrgg4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECF606A32D
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 04:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AECF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PEOxrgg4
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-949589c1495so192341485a.3
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 20:36:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794717392; cv=none;
        d=google.com; s=arc-20260327;
        b=Fneh4Faylz4/WxD8T5QTqeyZzefAQrM665YHqN85cmipLXbv2bKOPzyCY/nN/qxa94
         Jh8w0HAumPHi7pzc6ACQPzf1SZ6f7de4zAs1dL5aHktC2EoVfg86iTLLBFgnIfVUF6UE
         BDrQ++3hjE95QCN7NSCXK9Yzi0F+sdOGvCh0x+k+Ph4YYexm4YCHrsmQBnCR61iZFkKJ
         Ao97hf2HyuVWPBUCGtKT2pkvkt6dTIlEGimCBkKboQb0aY6XXIEnlsSVNOhK74m8n0RE
         V2LL2155KhkXP+R7YpLUGrj+Jc814Ge7BOaq9mTw1K2mXIuuERfas1Foij8NeUyKjNtW
         EykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lw4PafUNpBefejUL5dsPS1p8GMKZRfK/xKo7rtimXWA=;
        fh=u8/43O7elqLXLcN3YRqiXWwNZfngBL/j2RJKJu/eJvs=;
        b=i0/XmeCYlsXELv9IiCaokN4VS2LTTsNJR6r26PK1OjUgNl2UulXEcUF0oC4ZdZcYTE
         fIkcoi6XogRxiSFJ26w2hcbpbMerpBKbz/dJU1cTJkGxsGOB5TW1ND1zI/JYDzM91yKM
         sD6ZH6ojgJ5u6MzjajZA4Sxfc7aU+eRTMeAT/SHAbwlVTaysgKAcLEhhpyDuG7VgHelu
         lJq9A+3FXGKZR5QJLqlJpsK7wFgcKoqImXiyuHcZcqj8kBw+I8ER22b6oJVdo/mm/HDL
         kd5NM6z0S1EuI8gbEyVYpTHVTvSRmtTdx/YPjNbZkgcBeBocwKfoghPek9eyLO6lqnai
         Y5qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794717392; x=1795322192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lw4PafUNpBefejUL5dsPS1p8GMKZRfK/xKo7rtimXWA=;
        b=PEOxrgg4UHYY4c3wcr64IbxYp6HMiyeNNfgRU2s02gH1wBCLPC433NrmNYWVxnMQae
         +/BMIb0ga7q9TDk9qJLUpY25AhfKkfdiu6NH2Rcbpv0XXRryzwmmqbU1E0Sd6fYqbfir
         4hZR95pVXYNYx1KaXFIkfwVctC0f9iet4BPjOaYz/QBOuZ7jbXVfhvsOj6B6pCb/OTAR
         cou1QWRIRf84LVyAgZyQjg9Kjpb1C0u4K/J+Sg3BRdYqeK8aYYb0Ag93JbdndLMZEFA+
         3yv+5id5Ur5MAkhNDGzVUfZ9c4yNLREwJTfSah4a3jtWgu/G3Wp4/oZTfqRItUFws53l
         FJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794717392; x=1795322192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lw4PafUNpBefejUL5dsPS1p8GMKZRfK/xKo7rtimXWA=;
        b=tcNVBhV4hZX6ajSyf6Gw12vJXs+8FyOKRpyP9kVNkHkdadfeO+w/zw6bFGbweUAMJr
         gRHtyK1zhSzf6XAwqQ+/AwEipQUcQTPVThcIx7agLtFPpXxlaXAa4Py013yMH/u/cUmR
         Y77T3WpWhTvQdDrQVEyfBiW8cVbqsInEpWmhTo+eXqArCwTdSR8r2O/o5/vBTFki/fqu
         a5m86X4Dg1L9pXcO5amuRtcuhIQ1oL34nSoCqtDii3buym44iwSI5Ga67Ju7N3oGjn3s
         Rfc4CkxBeYGjxQbJnUGiu+SsIZ6oPMDC15PqA2KzJql45H9uj7ovAcLOa/Yvz1tXnXYu
         PSxA==
X-Forwarded-Encrypted: i=1; AL+hErGnpMYBc0p0Tq0AtAM8hPVGNb13BGVXSNLivP5b5+y4t0PbvILKfnn4gbpwBZX/ATdTQTg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oX2fT4zphT48GfxpzS4+sHzo4EvKd+kMK1NWcYkK47uQYwywU
	2DgZ5syli15ir2n53xNqEFANsNOoQS13hOjqspYioSCE6sQALSEBtbJ+OjuUEveI/yJ2nJjbh2U
	nshU29ZOG2b0kznct4LONVXjBXYuCElU=
X-Gm-Gg: AYBFou0w65Pl3SNIfRgyEyyPCP/45WAAVag8fv7lKgR4aZrEmZTNHVK2WmGW1B8/7v2
	30WkUj7LQaArdS0ADfWw9T8FQmmK/YWUheb85i67rbGQnJMzEu9zfpjRWuo/8W0cJ60PlR41lz5
	I8qS77LF/dmsu05YxnrVTsAiDmQ+3BcuSyTvkwiEWamUApbc9Tjpw5+/BgZRfBa2n/9sel3BjCG
	L8hn4rmrRSwkRfWZCIPn6mScNRWCLf55vILsUxpugasP4N4SdIlrel2o9XtvTaJaB9Xae34cynt
	kr6LS/9VOjUeQgQkQws8XWrka/YX9BqX4+pGkyiIZCRUDK9IDcC6V1Wf8HpwSjJNu4PNeRoNH8p
	eUEf7nW7ahA+PIt0FaLp2V2lsl5Fgm2HLAd+/0+4venyl0U+4zY2sZ0pRbtu0YnUlTaVK756WdZ
	mjoZeS37im2nbmGIc+5PEJzUVx9+hHBOIudi3fxi4BkpbT4dxLniABouXQ
X-Received: by 2002:a05:620a:2805:b0:93f:1ed3:a9cc with SMTP id
 af79cd13be357-9494bbdd1e6mr1203445785a.17.1794717392488; Sat, 14 Nov 2026
 20:36:32 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2308.git.1794465188325.gitgitgadget@gmail.com> <71280528-f044-49ab-b746-4f680f220627@web.de>
In-Reply-To: <71280528-f044-49ab-b746-4f680f220627@web.de>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Sun, 15 Nov 2026 10:06:21 +0530
X-Gm-Features: AclHuK-KiQnRHJl10lPytq7hWj3wXA_f9JuziiTGXaUY45Q8nGBhplZczDOKhKc
Message-ID: <CABh_KWhWZt=Ng9PTr+NcFxO=9pLx+vdvYpo6=JW8Z6WUzZ3HpQ@mail.gmail.com>
Subject: Re: [PATCH] archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 12:56=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> w=
rote:
>
> On 11/12/26 7:33 AM, Srujith A Poojary via GitGitGadget wrote:
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > Refactor archive-tar.c, archive-zip.c, archive.c, builtin/archive.c,
> > builtin/upload-archive.c, and diagnose.c to accept and pass explicit
> > struct repository pointers instead of relying on global repository stat=
e.
> >
> > Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> > ---
> >     archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2308%=
2Fpoojarysrujith%2Farchive-refactor-clean-v1-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2308/poo=
jarysrujith/archive-refactor-clean-v1-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2308
> >
> >  archive-tar.c            | 7 +++----
> >  archive-zip.c            | 3 ++-
> >  archive.c                | 6 +++---
> >  archive.h                | 6 +++---
> >  builtin/archive.c        | 2 +-
> >  builtin/upload-archive.c | 2 +-
> >  diagnose.c               | 2 +-
> >  7 files changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/archive-tar.c b/archive-tar.c
> > index a1c66024d4..5243446701 100644
> > --- a/archive-tar.c
> > +++ b/archive-tar.c
> > @@ -2,7 +2,6 @@
> >   * Copyright (c) 2005, 2006 Rene Scharfe
> >   */
> >
> > -#define USE_THE_REPOSITORY_VARIABLE
> >
> >  #include "git-compat-util.h"
> >  #include "config.h"
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
> > @@ -526,7 +525,7 @@ static struct archiver tar_archiver =3D {
> >       .flags =3D ARCHIVER_REMOTE,
> >  };
> >
> > -void init_tar_archiver(void)
> > +void init_tar_archiver(struct repository *repo)
> >  {
> >       int i;
> >       register_archiver(&tar_archiver);
> > @@ -535,7 +534,7 @@ void init_tar_archiver(void)
> >       tar_filter_config("tar.tgz.remote", "true", NULL);
> >       tar_filter_config("tar.tar.gz.command", internal_gzip_command, NU=
LL);
> >       tar_filter_config("tar.tar.gz.remote", "true", NULL);
> > -     repo_config(the_repository, git_tar_config, NULL);
> > +     repo_config(repo, git_tar_config, NULL);
> >       for (i =3D 0; i < nr_tar_filters; i++) {
> >               /* omit any filters that never had a command configured *=
/
> >               if (tar_filters[i]->filter_command)
> > diff --git a/archive-zip.c b/archive-zip.c
> > index 279c3a2d72..b02fb9be38 100644
> > --- a/archive-zip.c
> > +++ b/archive-zip.c
> > @@ -655,7 +655,8 @@ static struct archiver zip_archiver =3D {
> >       .flags =3D ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE,
> >  };
> >
> > -void init_zip_archiver(void)
> > +void init_zip_archiver(struct repository *repo)
> >  {
> > +     (void)repo;
> >       register_archiver(&zip_archiver);
> >  }
>
> So repo is not actually used here.  Why pass it in?  It's not like the
> init functions all need have the same signature.
>
> Not shown here: archive-zip.c still sets USE_THE_REPOSITORY_VARIABLE.
> Perhaps dealing with that is better left to a separate patch, but the
> commit message should reflect that only the tar format handler is
> treated here.
>
> > diff --git a/archive.c b/archive.c
> > index 59790be986..e9e2e241c3 100644
> > --- a/archive.c
> > +++ b/archive.c
> > @@ -43,10 +43,10 @@ void register_archiver(struct archiver *ar)
> >       archivers[nr_archivers++] =3D ar;
> >  }
> >
> > -void init_archivers(void)
> > +void init_archivers(struct repository *repo)
> >  {
> > -     init_tar_archiver();
> > -     init_zip_archiver();
> > +     init_tar_archiver(repo);
> > +     init_zip_archiver(repo);
> >  }
> >
> >  static void format_subst(const struct commit *commit,
> > diff --git a/archive.h b/archive.h
> > index bbe65ba0f9..8ec59b22e9 100644
> > --- a/archive.h
> > +++ b/archive.h
> > @@ -48,9 +48,9 @@ struct archiver {
> >  };
> >  void register_archiver(struct archiver *);
> >
> > -void init_tar_archiver(void);
> > -void init_zip_archiver(void);
> > -void init_archivers(void);
> > +void init_tar_archiver(struct repository *repo);
> > +void init_zip_archiver(struct repository *repo);
> > +void init_archivers(struct repository *repo);
> >
> >  typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
> >                                       const struct object_id *oid,
> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index 3c1288a123..2c01d7b6e7 100644
> > --- a/builtin/archive.c
> > +++ b/builtin/archive.c
> > @@ -97,7 +97,7 @@ int cmd_archive(int argc,
> >       argc =3D parse_options(argc, argv, prefix, local_opts, NULL,
> >                            PARSE_OPT_KEEP_ALL);
> >
> > -     init_archivers();
> > +     init_archivers(repo);
> >
> >       if (output)
> >               create_output_file(output);
> > diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> > index 718e74b3ac..3cfc7ffaf3 100644
> > --- a/builtin/upload-archive.c
> > +++ b/builtin/upload-archive.c
> > @@ -34,7 +34,7 @@ int cmd_upload_archive_writer(int argc,
> >       if (!enter_repo(the_repository, argv[1], 0))
> >               die("'%s' does not appear to be a git repository", argv[1=
]);
> >
> > -     init_archivers();
> > +     init_archivers(the_repository);
> >
> >       /* put received options in sent_argv[] */
> >       strvec_push(&sent_argv, "git-upload-archive");
> > diff --git a/diagnose.c b/diagnose.c
> > index 2c1bcfe431..c642dde351 100644
> > --- a/diagnose.c
> > +++ b/diagnose.c
> > @@ -212,7 +212,7 @@ int create_diagnostics_archive(struct repository *r=
,
> >               goto diagnose_cleanup;
> >       }
> >
> > -     init_zip_archiver();
> > +     init_zip_archiver(r);
> >       strvec_pushl(&archiver_args, "git-diagnose", "--format=3Dzip", NU=
LL);
> >
> >       strbuf_reset(&buf);
> >
> > base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
>

Hi Ren=C3=A9,

Thank you for the review! That makes complete sense.

I have updated the patch to address your feedback:
- Reverted `init_zip_archiver()` and `archive-zip.c` back to their
original clean state, keeping zip out of this patch scope.
- Narrowed the commit strictly to updating `init_tar_archiver()` and
its initialization path to accept and pass the explicit `struct
repository *repo` pointer.

The updated version (v2) has been pushed. Thanks again for your guidance!

Best regards,
Srujith
