Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794684409;
	b=cEbjZycQ1rvQlfFtdCBGTr0DEyNr5bDf+2LtHk8TkB/3vv/zthqwszshYhtclG2GQzNA
	 IKu4aeibsXmjaRMraPgTNT0diQe/nUAjhKwdCyZcnp6YnEKOylnSI4SZXG2IBlB9bqtqw
	 YDYSqzLGiYllYs1PUoSwgYbkhugb29tlsxYnW9Ywsmf7LmDISQQY8HWxwG1+dpUCbf8ZT
	 GIpXQU3kLHuJQdtN+deZppUNYBJyfOe7eHMClaBhrrXaONJYorcDs0mY1Oe+w+MtTnyAS
	 R38RDeCfseGcTykZbhhqdU/HE6Kzdv50uRQZfMT+DbIEu3Sfx/LT00CUDVPwDa33XnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794684409;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=CvHijOxuIsLak3aYbraXL2cHokqrtQh6ERGuOkwV1Ko=;
	b=VMvPSMVS7b9Li3ZuJw1n3swXiuDPa18uRJ0LxNrdFSKCF7AoYvjzpbbRctpVDv98NSYG
	 oft7ywj20NsCOlzDtoXfRtMIOtB3syizgbkVVT49N7Unrm9Fcu7+rRDHwfRK4UEzsL3+3
	 EbMDvzJsuXDr8zkoUIqePpC8jr2gHKY8Edjg6iFvdyWMIjmlmz4udFXdbDiGUifgZixY7
	 Ns7icC/iex//bWUVNY7PQtMxObTURaIFD11daWfr9aVunOD85IAFXwydPD8xJoEVMdzlh
	 yuDP3c2E4cT2rbu3Nd+2RhV5uPH+6fQKEaK9H2DFtiqjz/1vDW6EwS0Ek3lG16zeyIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=fMDgLR6b;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38955606A32D
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 19:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38955606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.a=rsa-sha256 header.s=s29768273 header.b=fMDgLR6b
DKIM2-Signature:  i=1; m=1; t=1794684406;
 mf=PGwucy5yQHdlYi5kZT4=;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:TCfmdH3l9NwLiYHfkI22T6Cmv5AJ
   4yDdBucxGp90vBQt/7CanIni47WJ4/mzqCyDYRykoe+ENEV6ZRVJ8TDoSRaGySNjA5UOa37r/AB
   vEPFaLDz5YPHbo7Mcu6COnqv5lJ2l5arr7U1lCCZpDZbnfqqpc1QDvhvNTErV1dOQlCaPPwyFB1
   wk0Qb4jwL8Ij0OpxA/aGvUhsc/NcuJ01rZqRcqhqFeRouhoCvqc3ao0UngEv7vH7+qn4oOaL1BR
   YInr7ggkkCuVY+bFB1Q5z0GLmVhZXbcA/mCfWEHnW15kCWadr8aF97AXKBjw12pBIdlB0mLDffX
   d0OmtyOnKMWAbw==;
Message-Instance:  m=1;
 h=sha256:
   wmHp0pTBC+PrPH7j3H9TeZvQXK37sguSv6F/phTe79Y=:
   CoLG1LJUTGOe+jLTCJESBsNHC+QSkfwgF8It7uaA1F4=,
  sha512:
   0mJtOx9cGwgTFpCS5rlCy0kODUiptT75pijJuXimCtA6RC5YKDOcZFI4rGqiUtz0YVfomBznxyzgZVmU1rE44Q==:
   /Nzay90+SfGIIHAKbjp7C84UAYtWdne8S+uU4PAyoB4EJpc5U+hnQDzdg+L26dK3gadzddo6FVUMV5Y4Ip+fYQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794684404; x=1795289204; i=l.s.r@web.de;
	bh=CvHijOxuIsLak3aYbraXL2cHokqrtQh6ERGuOkwV1Ko=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fMDgLR6bCY22IFFGPBHPMsRzJi6l3utUONoM3PsfWSLKDszVlR6OPEAb+1f2Hg0I
	 1pSbyzhV4PHZ7LCck1TpUuFvkG+xXd6HgPPrP+pE8rO6ZRla+FYysurViQBrlXGdZ
	 ZKlkBp4RnOuJUGuigL+bMCKJ+Chb8J5+exFBw7Q58+skuQ9WGeRrtRMoUHKwaGjrS
	 YqRqppR51S6EtPu42rZCxIPqcOcftw0mXHCFUrottKsTrQSoBDdo9IPZQcvxXrFcZ
	 Ue03VQQi7t+Dr7BzVGF/7qKD3mvAxqMQPR2VaPfXjN0PcL1Ec6ai+d2U88BJDX1wR
	 qCbzLmZ0PhZDF2mKfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWor-1wpNwN2zdz-00lMKx; Sat, 14
 Nov 2026 20:26:44 +0100
Message-ID: <71280528-f044-49ab-b746-4f680f220627@web.de>
Date: Sat, 14 Nov 2026 20:26:44 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] archive: remove USE_THE_REPOSITORY_VARIABLE from archival
 modules
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>
References: <pull.2308.git.1794465188325.gitgitgadget@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <pull.2308.git.1794465188325.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mkPLQ61jdGVIlMpbkaeaVILN1DUDJVGDlRG3tmPZQQ5dxCptSBn
 oY0Bg/yTCnod2v2maTNS5n+9asHt+IHzbfKRimtyU/RFuEDH30eCuJ6w5QUv41KpvIntZzk
 HR9WyfSzM0IlZg4jQMHyhHjDTE2M1XesXh5oSfslpoMU++9IwYy96x+boMgvn8Mbe0jzBt7
 gaMFlL/O8XR5eb1XBPOeg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NzmUQBrqO0k=;FbO9alGCug6eMtzqG710T9wPJuI
 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

On 11/12/26 7:33 AM, Srujith A Poojary via GitGitGadget wrote:
> From: Srujith A Poojary <poojarysrujith@gmail.com>
>=20
> Refactor archive-tar.c, archive-zip.c, archive.c, builtin/archive.c,
> builtin/upload-archive.c, and diagnose.c to accept and pass explicit
> struct repository pointers instead of relying on global repository state=
.
>=20
> Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> ---
>     archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2308%2=
Fpoojarysrujith%2Farchive-refactor-clean-v1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2308/pooj=
arysrujith/archive-refactor-clean-v1-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2308
>=20
>  archive-tar.c            | 7 +++----
>  archive-zip.c            | 3 ++-
>  archive.c                | 6 +++---
>  archive.h                | 6 +++---
>  builtin/archive.c        | 2 +-
>  builtin/upload-archive.c | 2 +-
>  diagnose.c               | 2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/archive-tar.c b/archive-tar.c
> index a1c66024d4..5243446701 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -2,7 +2,6 @@
>   * Copyright (c) 2005, 2006 Rene Scharfe
>   */
> =20
> -#define USE_THE_REPOSITORY_VARIABLE
> =20
>  #include "git-compat-util.h"
>  #include "config.h"
> @@ -337,7 +336,7 @@ static void write_global_extended_header(struct arch=
iver_args *args)
>  	if (oid)
>  		strbuf_append_ext_header(&ext_header, "comment",
>  					 oid_to_hex(oid),
> -					 the_hash_algo->hexsz);
> +					 args->repo->hash_algo->hexsz);
>  	if (args->time > USTAR_MAX_MTIME) {
>  		strbuf_append_ext_header_uint(&ext_header, "mtime",
>  					      args->time);
> @@ -526,7 +525,7 @@ static struct archiver tar_archiver =3D {
>  	.flags =3D ARCHIVER_REMOTE,
>  };
> =20
> -void init_tar_archiver(void)
> +void init_tar_archiver(struct repository *repo)
>  {
>  	int i;
>  	register_archiver(&tar_archiver);
> @@ -535,7 +534,7 @@ void init_tar_archiver(void)
>  	tar_filter_config("tar.tgz.remote", "true", NULL);
>  	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
>  	tar_filter_config("tar.tar.gz.remote", "true", NULL);
> -	repo_config(the_repository, git_tar_config, NULL);
> +	repo_config(repo, git_tar_config, NULL);
>  	for (i =3D 0; i < nr_tar_filters; i++) {
>  		/* omit any filters that never had a command configured */
>  		if (tar_filters[i]->filter_command)
> diff --git a/archive-zip.c b/archive-zip.c
> index 279c3a2d72..b02fb9be38 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -655,7 +655,8 @@ static struct archiver zip_archiver =3D {
>  	.flags =3D ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE,
>  };
> =20
> -void init_zip_archiver(void)
> +void init_zip_archiver(struct repository *repo)
>  {
> +	(void)repo;
>  	register_archiver(&zip_archiver);
>  }

So repo is not actually used here.  Why pass it in?  It's not like the
init functions all need have the same signature.

Not shown here: archive-zip.c still sets USE_THE_REPOSITORY_VARIABLE.
Perhaps dealing with that is better left to a separate patch, but the
commit message should reflect that only the tar format handler is
treated here.

> diff --git a/archive.c b/archive.c
> index 59790be986..e9e2e241c3 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -43,10 +43,10 @@ void register_archiver(struct archiver *ar)
>  	archivers[nr_archivers++] =3D ar;
>  }
> =20
> -void init_archivers(void)
> +void init_archivers(struct repository *repo)
>  {
> -	init_tar_archiver();
> -	init_zip_archiver();
> +	init_tar_archiver(repo);
> +	init_zip_archiver(repo);
>  }
> =20
>  static void format_subst(const struct commit *commit,
> diff --git a/archive.h b/archive.h
> index bbe65ba0f9..8ec59b22e9 100644
> --- a/archive.h
> +++ b/archive.h
> @@ -48,9 +48,9 @@ struct archiver {
>  };
>  void register_archiver(struct archiver *);
> =20
> -void init_tar_archiver(void);
> -void init_zip_archiver(void);
> -void init_archivers(void);
> +void init_tar_archiver(struct repository *repo);
> +void init_zip_archiver(struct repository *repo);
> +void init_archivers(struct repository *repo);
> =20
>  typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
>  					const struct object_id *oid,
> diff --git a/builtin/archive.c b/builtin/archive.c
> index 3c1288a123..2c01d7b6e7 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -97,7 +97,7 @@ int cmd_archive(int argc,
>  	argc =3D parse_options(argc, argv, prefix, local_opts, NULL,
>  			     PARSE_OPT_KEEP_ALL);
> =20
> -	init_archivers();
> +	init_archivers(repo);
> =20
>  	if (output)
>  		create_output_file(output);
> diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
> index 718e74b3ac..3cfc7ffaf3 100644
> --- a/builtin/upload-archive.c
> +++ b/builtin/upload-archive.c
> @@ -34,7 +34,7 @@ int cmd_upload_archive_writer(int argc,
>  	if (!enter_repo(the_repository, argv[1], 0))
>  		die("'%s' does not appear to be a git repository", argv[1]);
> =20
> -	init_archivers();
> +	init_archivers(the_repository);
> =20
>  	/* put received options in sent_argv[] */
>  	strvec_push(&sent_argv, "git-upload-archive");
> diff --git a/diagnose.c b/diagnose.c
> index 2c1bcfe431..c642dde351 100644
> --- a/diagnose.c
> +++ b/diagnose.c
> @@ -212,7 +212,7 @@ int create_diagnostics_archive(struct repository *r,
>  		goto diagnose_cleanup;
>  	}
> =20
> -	init_zip_archiver();
> +	init_zip_archiver(r);
>  	strvec_pushl(&archiver_args, "git-diagnose", "--format=3Dzip", NULL);
> =20
>  	strbuf_reset(&buf);
>=20
> base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2

