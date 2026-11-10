Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794298446;
	b=uqeoYMJYie637cXzRE1D7YBnc4ugYZL2ElMmoYEjC6zdX3+cvxYrOuqUb0plXBTxhnPy
	 vhz08LAXjHfCtSRR6j/o34WyupViAXM2v8PkV/aO3d9d88XJBQfkmiOuAYwuJCguasZ9q
	 u5q2r7fdWN20bHReJdOFkY/DvejQ9/IgnKaR63wj1iT78zrbzO/RtNbkbQ6ytRpR3qPj9
	 qLUgOr+0mTKtaA6+vKVOEJGI7c4xFl0t7dLE7V9RKTyKgt8OXf1ERIgECrR41EdnTq4un
	 BL2dlWr3Hj3Im1vUmKzwBIPI9x/iWwhElJbW2QvaAZfmrSsuE8obkKnmGxMdCBpF/xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8RBJcCjaETz8aRilM+DdIbAT2PW3rcqi6jEvsE91f50=;
	b=lKLTUVau6Ek4zyFCRI/YNCeVdkqxkdd0ppYidF3KoUxxuLwNjZ/9oVD5hkc8yfv2fKqK
	 P0TXiSPOeXLg9wVWEY0Vbgwve4NLWDUjnSs61rOAhZAddMVQ2XZVAQKnMbi/KHDflMJCF
	 PkHDgI/czIvLWzfDTl1aiDPuznNJ4PKezR00HeuHdFX76ue8/aPoWWaqtI+SATxh1XsyG
	 LlxZL4pZICK8oBkuzXztxrbOFJ7sjKJhGZu8otPC5mI5yfdw69BAB5Cy6RQN2UMljTls+
	 jO+Zekx6v/qYk9p5LCcyheChn7mhoQAGaOVWaF8+qeglQKxDWGprp+FWsIXa5d3jDCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DN4Wfkgg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AF606A321
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E4AF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DN4Wfkgg
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53664b4860bso16519641cf.1
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 00:14:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794298444; cv=none;
        d=google.com; s=arc-20260327;
        b=s94JJpvbsyHyutvP1cTYrbhqpqime7+xcx0ijhD2fKhtkWRWmiJKWNR1waCL4VHk0R
         rV0zvvCqv++P/rIX+b2LEYg0Aens+xjho7s03OeLgjtS1WnGrrvrEcOLQVIwCvvVvsQp
         oFSMAYAunhiEClMAdYyNNvuENXo1URikun5H3BkgmRoqfC5QkVNQaVcsUcR8UZj6rNVt
         K/TYFo4AJk0bZ5W2dDkfc587QcFrLefNsJDeRNIRzxpfHxRo7U9iegAe5UAwkXtUfDjU
         ZiK7w7E4cijqF62aL1wf8ZXiSHgdCaIjqflKi9m1gPL8zVQjhMxtB+mVfu7Aon15eQPz
         F9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8RBJcCjaETz8aRilM+DdIbAT2PW3rcqi6jEvsE91f50=;
        fh=yrBMmmbm1H9PwKOa3Y3pN/WOzP189qp9ptaEQXkUkm8=;
        b=dHA/DqkF4DT/i0V0dHKjBdimpT0ZAHyA7H2saZvzWDn1g8iEN1OcwYkKP7JoEd5EXY
         xaryRDhAfnMfNNcNxwgBuDmMJpCDekMA/r0Dtcvm1zEHQEwL7B8OWWzhnrqH7CjILJyz
         CA6AZVxpYzjrIJHY/Xd14DfkVK1oahAyCUeZEizcUD5pDt9JnHwuI5gLMGlSvoKAunuB
         9cgxrwDjPGhmhsg26A5JNHC9Swut47bcxoit/Uj98HH+btgoH3htpgZPrcaQIwFRMcli
         cN0JmoOaUg74jEA2K+IgnkMGyj+Ng7zwKk7SSlnIle5TlOqjD+p25K1aRecYChf+jfHx
         SkCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794298444; x=1794903244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8RBJcCjaETz8aRilM+DdIbAT2PW3rcqi6jEvsE91f50=;
        b=DN4WfkggVh+qV6zijtpXltwcXvSwRxhFbsJBM8WL8je62fkYM6D0RQHHFv0F1w0j5a
         L7KBFO4DqJwDdlSINVv7YJYBDZzfMoS0PDWZ0BXDdOWbm0+b5OU37DF2tLxkaUN1GIld
         wJDxcICve/hgua0HLqNodGESV2xxsJwB8dmJQAJ8un9mdKOUhCqFciM4Jlvi9AsCdYRM
         EIcDiH7r8FlmshpUp8v4L612SSto0shIgmScCwu5Ikccr4uLq1wVh/HCN72qe3kqnBOC
         ktuLRAJVXJT+m0sAP1mwyl1R74Al8flSzKZVA2lBAKYFRpDlr7O4Nocp9PN4IsnAX9QS
         7I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794298444; x=1794903244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8RBJcCjaETz8aRilM+DdIbAT2PW3rcqi6jEvsE91f50=;
        b=qhtwM5sVt5GiEYvzMNK/Wt8IV1u09TqOkxMDG/EHGD3BS9PoVaxiBxGCgNCLAdnKhY
         3Tkm8nEMb/qJ2Quh3TdZVGsZbIFWDaaGmO0eT4Nuo0bNbtlsaYz+fk6wEAaXyPBH49hl
         ic8hLxcwcCzPY/kdEhjY6289mOhIptijL1lM3arj96ULX0yQ6ydFjIBvBRoZVP+RYxgq
         1j8OdUwAO8dMA6KfNiIqFWDNM/RUB+fHjbwmQIyy06JV+fvHdKegwGgkwNznNiuLwAYJ
         8lau5VGVxwOekS0bhQdGGwciX/csCRchlDvJndP4WTZv6wPbGxBhWshKi9ADNW1feFHp
         U1Kw==
X-Forwarded-Encrypted: i=1; AL+hErH3XDTzNbSVbsu4GjqjbX5T9DNEQ4zc0C3rfIK3YZ0Jm0jfluVtaigco+Aa0YVG1fb5uV4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eskIY0bCKhlHrhc0kcUoa+OtYGVrzr7CFSsfZ1hxPzG2Ufcqo
	/PsYHIH1B4F3k0g6i3ZW6YFEO4l2uWDukiK3uDI5OwAN2x+GFQiEnQJHQPoOcSxJr1qZmT+yOJO
	V0tFJNCzC8aDas0RCPHbM12naDntOElo=
X-Gm-Gg: AYBFou13lYw2cEviGfgGfcg09OdYhaujCpiULIw6CFlC3B19v9ivYSKDa1gwMAz+2mN
	F+MiVpNqJQDHI/Nd2wYAa3sUv6QbMZCBJPUHDiV2/xBtlMIpx8UnQnsYMv3nqzw/pFIUT8axyTS
	uecG1UsX7cO9jovVyiWEsB24kUVUglVaiYPzIj2XoRpcYg1jzuXZwzs6tWnThVVApi5G+9VKaEy
	Pxj+yHh9SIKWEhnquFM4F35kSUuOL8ZT7s/ReZxH67jCZTOndqrAJIeR2RC9UYOM2ja3i5djkY5
	bD2EAQLzm87g4s+XVVVSj85rMI1jD8LGBrn5Z0rIskFYI5mpykWcj6wfk7CF8BHFJez7MoZSfDl
	cr6F9J0Y/RKLTd2ovUQdG3NYSBcqe/cv8VvX60fufJ0F7148gsRjv2mwKpBJMRWkUmyWXEiemwt
	f82omk0ItzEoVpYBSDdPKw3Dy7AKMmmpB/4Z7Mnv062e9961uVCb+QzXJQ
X-Received: by 2002:a05:622a:1f12:b0:530:ea8c:1b6b with SMTP id
 d75a77b69052e-55524e0082cmr26583851cf.3.1794298443988; Tue, 10 Nov 2026
 00:14:03 -0800 (PST)
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
 <eeed27222be51590775352e5a3b7677e21d36a93.1794251100.git.gitgitgadget@gmail.com>
 <xmqqcxsdybrl.fsf@gitster.g>
In-Reply-To: <xmqqcxsdybrl.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Tue, 10 Nov 2026 13:43:52 +0530
X-Gm-Features: AclHuK_3v0wWC5F_lIvVhYAjc8czaFpXZk9yLy8CZST_r2S30CPr4t2uoIIdmz0
Message-ID: <CABh_KWh0qUoAoUKJoeM1aayNBrYFw33=KXiBvYRFTcRB0hW9WQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from
 archival modules
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:15=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/archive-tar.c b/archive-tar.c
> > diff --git a/archive-zip.c b/archive-zip.c
> > diff --git a/archive.c b/archive.c
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
>
> All of the above is straight-forward.  Pass a single "repo"
> parameter throughout the callchain and you are done.
>
> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index 3c1288a123..e35b9637ce 100644
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
> > @@ -97,7 +98,7 @@ int cmd_archive(int argc,
> >       argc =3D parse_options(argc, argv, prefix, local_opts, NULL,
> >                            PARSE_OPT_KEEP_ALL);
> >
> > -     init_archivers();
> > +     init_archivers(the_repository);
>
> This looks curious.
>
> When would the parameter "repo" an invalid repository (due to
> RUN_SETUP_GENTLY defined for "archive" entry in git.c:commands[]),
> yet using the_repository is a reasonable choice?
>
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
>
> It is correct to use the_repository here, the same repository we
> used for the enter_repo() call that immediately comes before this
> step.

Hi Junio,

Thanks for taking a look at the patch series and for the feedback.

I've updated the patch series to address your comments:

* Cleaned up the function signatures for `init_archivers()`,
`init_tar_archiver()`, and `init_zip_archiver()` to use `void`
parameters and removed the unused `struct repository *repo`
references.
* Updated caller sites across `builtin/archive.c`,
`builtin/upload-archive.c`, and `diagnose.c` to use `the_repository`
where appropriate.
* Ensured proper header inclusion order (`git-compat-util.h` first) to
resolve compilation issues cleanly.

The revised branch is pushed and ready for your review. Let me know if
everything looks good or if any further changes are needed.

Best regards,
Srujith
