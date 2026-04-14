Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0F1A38F9
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157625; cv=pass; b=TloK5lcYAe61JwWPeYmii0ttUwey3JqgLPeDNutltPPqQChk2ob5yIXQDG4gsS9OWG7DFmD0uVItQxW6pVEq9v+tbNCgmI53sajaPasWK4BkzUZX36Jlt//aqU4GVgy1aERi9Uum9YTQ0VD+CoIHNpS3k0To07Jgxhtrfkv+ihs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157625; c=relaxed/simple;
	bh=Ar1zN7LkfLtPlicdPPw0Hc8MzKupAU1ZOqrEt/rP4Zk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsFW863GT3SHlpjD0bx3mbkcuktv+CZIws9XNjT7C4EaUo3CcAVJ3KLHsbBv/7YFKuy1eXtzBxI3FqS1ZSF7guue4m2BwJilXC3wdBmdefAkqJR5Y8ZYFDS3DsfXe8Ex8GwqDNrSN3hQoL5oWD7adVVSRK0TvohzJCc8vsp+6QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QasY6jpx; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QasY6jpx"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-953b0a7ee18so1365645241.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 02:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776157623; cv=none;
        d=google.com; s=arc-20240605;
        b=F75Xc3UGHdMdljaRh5XZqli0fP3DpvWZC9oIOlpbI8ScEKcwRDSEgCAK2TKk+toXfE
         N4VcHWKHDWZp8ABIoGv/NZ7NYgeYaCpItkbC9/At3EisCOtJKLZoRRtTkgCxeCp8g/SW
         Z4WQN8q3BX1E6WMxWinLu3A4H+bULfpFxtQgheQNUn9XDaA9rL38FWtCC3RTOrcACsw6
         vXYmOtK0o7VuCWw3R9V3m0aYKSI9wS26xj+frWCdleWdETU39QN9oIZw5MwpNGtVJp7W
         MNTuaa3+3ExOAW9++f5c1Qo2JWik98GR1fzs3QQ1MJMAMVfvqD+D0gQIvt3gUji4BvEr
         +xQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=kTMYPCLDXI1AJ9cacqb8NOpz9tlLJA1gTW66qLOqCuU=;
        fh=dEDWhiTuzBSNrUm4Vm0GCLrCA/gN9k+KXHGR4+Q5ReI=;
        b=B86YF2ZCHhYtE8sr1AoKE7Is76zXpzYTwL+f1Bq7+yuRhsOJsb5b9Xh6G0CF2EpZlS
         iXmKTlwH0x6ybqApCZvHKXFUZQytemz8YyOTQMocLwHBzpGElild/2w96tgfrsKWFd4j
         DvBLmtwe9/6mXR1dyMUCjpuOvbLUGn+8sd0d4Hq9qPaewMtatUo39wfsSV11cyq+lmCv
         Ed58e8Zzbfd6Nr6B/EGWOW8Q/htjzg5gOkaCwTwnRos21YqKJJ0Irsfue9DH+Lh/+SW8
         D735xtQlw4zZ76nh9p3KI6GRwNVhOiBcHderfKlYz6atnwVYnSB57kcr+fqQMlb1lX2A
         4Etg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157623; x=1776762423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kTMYPCLDXI1AJ9cacqb8NOpz9tlLJA1gTW66qLOqCuU=;
        b=QasY6jpxIae16zBwZusgCIKXaqn24473fQqZsXYspDfwkuFdkKJBMG+VKtQ7Vl4K7k
         qwsylfBreG/YtNJ9CNWnk6zraSKuFo+1E5NZxjzDnrb3wPVGXBA7M7/mLbgrs5InVXWE
         gm+ZCW1EasTz5Aw8NljSP/GfQzhvMvFaupZ6R6c7hMH7EImqTgsNfzNNDxD61MNhA43b
         cF1oQdTa9JUpmF9bB9IMhnTUQ7mIFAgqZh8iwlpikLYF5w8XYc8JHtMVX0xvq2CowX5l
         nFkvIYpDFB0Rq68tOa3DwWtvs9ZGmTgz2redxWM0FAWD2GbuK/V2kJIYnQL8g67i/zA+
         anbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157623; x=1776762423;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTMYPCLDXI1AJ9cacqb8NOpz9tlLJA1gTW66qLOqCuU=;
        b=hfeVnA6jZknxBsyqOveqMs+Yhz3T7jzFnJDPodh8egtR7IV1QEJCKoD0H3DLmkbReq
         04kPGOu4hTujzZ4XQbveXGBZ+7qLy4gYoV8UgWixVv0T9jtAmRjOCL+rbtNe+PYWwnVi
         Ew4w/WVgv1ka3O1+x2GKSv4iLTzpaSdu4vmP/3/SbsuCwiw/i8tJD8HoapHqh6HjcnvC
         n/NHR0tk9hsakhwFIEhKdn8ey4mQbkQfGod8u7GZcRSvDVhRGsFc8AY0TohqdyPFn7cV
         qs9rUhSHaJWLHhFwA6Kz6EqlMudKQNhUXkOD1sDA/SId6zGcdhnfJSxNO7DZVkUzOInb
         i5gA==
X-Forwarded-Encrypted: i=1; AFNElJ9RDvU+tWYd/UCjiCDocg4tbJ2wlu9rn95BusHoL/3HYQfU586ldXT+xaWVJerml4GulDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt5HVO00e651w2IQ6c0ToDfo6vf9Zj+K2OuQ/s90MjoMFEcb75
	c1b2+DRVblZf2WFjiNTyViF+B+1ihrWaoo4J4zSERoONU1EbkXnBh1QBqiiWl9t1/evOxyPXv9w
	VwwMbFwngL+sX/L2UKGIYQKKAKMd7XyAAsw==
X-Gm-Gg: AeBDieskGvivIWdNr74+LW6ANPdZzRRe184RwvmsAWzxFkcMNqlJVj9k4nAP8a7j2tO
	Wu2tdQviWZpDrxunQAVQ89aRZM3C+MUzK//fiPSBnlHq86UwogRqqIwUAXjBTHtsRSK8TgFOBMy
	eN6Zk/RhH0jZ+s0qPr+IEp6PyiavAUQ3zkTIQX3mtSi9FZY7WTaZPyyBjcrYKCqxjS66Fy9vvTq
	Dwdx166VZLbJksLTgETtmVIpJbW30A1gYyhoY0QaB0Qz1sXkZxodqJBVeA08/eZExjzYPQAliC8
	EuY767rvXuOql9TU2bhUYoy13tAc+gAq1YT4Q5Ljqg==
X-Received: by 2002:a67:e7c1:0:b0:602:a9f3:74d8 with SMTP id
 ada2fe7eead31-60a00f49ca2mr6691202137.25.1776157622799; Tue, 14 Apr 2026
 02:07:02 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 02:07:01 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Apr 2026 02:07:01 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260324123750.157143-6-belkid98@gmail.com>
References: <20260324123750.157143-1-belkid98@gmail.com> <20260324123750.157143-6-belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 02:07:01 -0700
X-Gm-Features: AQROBzAzQpAEz-GB42K7eJi2tvfrdxVARv6YQY_q--VE7bpeLQFFVDOeI-1dFxk
Message-ID: <CAOLa=ZRE8O7UANkzr4p9__ReV1OX3KBBpqbKpfCJ+EvyziwtTA@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] environment: move "precomposed_unicode" into
 `struct repo_config_values`
To: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="0000000000002c4420064f67ec1c"

--0000000000002c4420064f67ec1c
Content-Type: text/plain; charset="UTF-8"

Olamide Caleb Bello <belkid98@gmail.com> writes:

> The `core.precomposeunicode` configuration is currently stored in the
> global variable `precomposed_unicode`, which makes it shared across
> repository instances within a single process.
>
> Store it instead in `repo_config_values` so the value is associated
> with the repository from which it was read. This preserves existing
> behavior while avoiding cross-repository state leakage and is another
> step toward eliminating repository-dependent global state.
>
> Update all references to use repo_config_values().
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> ---
>  compat/precompose_utf8.c | 20 +++++++++++++-------
>  environment.c            |  4 ++--
>  environment.h            |  2 +-
>  upload-pack.c            |  3 ++-
>  4 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
> index 43b3be0114..0e94dbd862 100644
> --- a/compat/precompose_utf8.c
> +++ b/compat/precompose_utf8.c
> @@ -48,16 +48,18 @@ void probe_utf8_pathname_composition(void)
>  	static const char *auml_nfc = "\xc3\xa4";
>  	static const char *auml_nfd = "\x61\xcc\x88";
>  	int output_fd;
> -	if (precomposed_unicode != -1)
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
> +
> +	if (cfg->precomposed_unicode != -1)
>  		return; /* We found it defined in the global config, respect it */
>  	repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
>  	output_fd = open(path.buf, O_CREAT|O_EXCL|O_RDWR, 0600);
>  	if (output_fd >= 0) {
>  		close(output_fd);
>  		repo_git_path_replace(the_repository, &path, "%s", auml_nfd);
> -		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
> +		cfg->precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
>  		repo_config_set(the_repository, "core.precomposeunicode",
> -				precomposed_unicode ? "true" : "false");
> +				cfg->precomposed_unicode ? "true" : "false");
>  		repo_git_path_replace(the_repository, &path, "%s", auml_nfc);
>  		if (unlink(path.buf))
>  			die_errno(_("failed to unlink '%s'"), path.buf);
> @@ -69,14 +71,16 @@ const char *precompose_string_if_needed(const char *in)
>  {
>  	size_t inlen;
>  	size_t outlen;
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
> +
>  	if (!in)
>  		return NULL;
>  	if (has_non_ascii(in, (size_t)-1, &inlen)) {
>  		iconv_t ic_prec;
>  		char *out;
> -		if (precomposed_unicode < 0)
> -			repo_config_get_bool(the_repository, "core.precomposeunicode", &precomposed_unicode);
> -		if (precomposed_unicode != 1)
> +		if (cfg->precomposed_unicode < 0)
> +			repo_config_get_bool(the_repository, "core.precomposeunicode", &cfg->precomposed_unicode);

So if the variable is unset, we parse the config again. My question is
why doesn't this flow already have the config parsed, or in other words,
is there a way we reach here without the repository being setup. Would
be nice to add this in the commit message.

> +		if (cfg->precomposed_unicode != 1)
>  			return in;
>  		ic_prec = iconv_open(repo_encoding, path_encoding);
>  		if (ic_prec == (iconv_t) -1)
> @@ -130,7 +134,9 @@ PREC_DIR *precompose_utf8_opendir(const char *dirname)
>
>  struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
>  {
> +	struct repo_config_values *cfg = repo_config_values(the_repository);
>  	struct dirent *res;
> +
>  	res = readdir(prec_dir->dirp);
>  	if (res) {
>  		size_t namelenz = strlen(res->d_name) + 1; /* \0 */
> @@ -149,7 +155,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
>  		prec_dir->dirent_nfc->d_ino  = res->d_ino;
>  		prec_dir->dirent_nfc->d_type = res->d_type;
>
> -		if ((precomposed_unicode == 1) && has_non_ascii(res->d_name, (size_t)-1, NULL)) {
> +		if ((cfg->precomposed_unicode == 1) && has_non_ascii(res->d_name, (size_t)-1, NULL)) {
>  			if (prec_dir->ic_precompose == (iconv_t)-1) {
>  				die("iconv_open(%s,%s) failed, but needed:\n"
>  						"    precomposed unicode is not supported.\n"
> diff --git a/environment.c b/environment.c
> index d0d3a4b7d2..739b647ebe 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -72,7 +72,6 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
>  int grafts_keep_true_parents;
>  int core_sparse_checkout_cone;
>  int sparse_expect_files_outside_of_patterns;
> -int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  unsigned long pack_size_limit_cfg;
>
>  #ifndef PROTECT_HFS_DEFAULT
> @@ -532,7 +531,7 @@ int git_default_core_config(const char *var, const char *value,
>  	}
>
>  	if (!strcmp(var, "core.precomposeunicode")) {
> -		precomposed_unicode = git_config_bool(var, value);
> +		cfg->precomposed_unicode = git_config_bool(var, value);

We parse a bool value, but....

>  		return 0;
>  	}
>
> @@ -723,4 +722,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->check_stat = 1;
>  	cfg->zlib_compression_level = Z_BEST_SPEED;
>  	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
> +	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  }

But set -1 to showcase that this is not set. We should add that comment
here.

> diff --git a/environment.h b/environment.h
> index 514576b67a..508cb1afbc 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -95,6 +95,7 @@ struct repo_config_values {
>  	int check_stat;
>  	int zlib_compression_level;
>  	int pack_compression_level;
> +	int precomposed_unicode;
>
>  	/* section "branch" config values */
>  	enum branch_track branch_track;
> @@ -174,7 +175,6 @@ extern char *apply_default_whitespace;
>  extern char *apply_default_ignorewhitespace;
>  extern unsigned long pack_size_limit_cfg;
>
> -extern int precomposed_unicode;
>  extern int protect_hfs;
>  extern int protect_ntfs;

--0000000000002c4420064f67ec1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a7327fd15cb67283_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1uZUE3TVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0xuQy9zSGZsVzYraVR0MmJCVjBuZms2ZEx1b3VsLwprZ2c3Qy9CQmZ1
Y25HYnBXajdDY25wVUZBV2tXOHdZMmdENzMrZDlXMC8xa3FJVnlZaGFlN0RxcCtLKzcyeFc0CjNk
c2FFa2pYNU01c0VwNGFFcjYyOW5KZ2pBN3BBdEM4clArcmQrTlJXeTYvNHNpRTY0UFVoUmQ3ZmZz
U2NXdlMKZSt3R1QweVFJQUJ0YzdwVEIvWkh3ZU5CRGdIajBzaUp5aVJvY3NLNm1GRWFLTkUvWHNT
RmNVSTlVTGNKNzl3NQo1bXdnaFVVZ2dieU0zV0lBWkhSSk9XcHliVC9VWTY1eXJzcVNNbExzZ1dv
bXJYRllWNlJFRDgzd2syREF2RUJMCnd0d2Zvcm56RTZHSFh4K3RIYjZzT2xrY05qVEdDN0MraSt0
aHZEQlBzajVXU1VyeS8vNmFCRVFLUHAyeVdEKzEKWjcxTVFCR2doUnhEakxpeVgweVR3WUVtY1dt
T0tqU1FXSFIySVE4ZHFLL21rVFFDa25FWm9oVnpPcjJhVnBBZQpLbTF2T3lJRWJRTEs3T2YyenUz
enVudlEvNE1EK1hxQi85b1UxZzJZUHB4RnpuY25CL2hYK28wUy82UUdlUnV2CmZXUDB5SFBTek1o
R0R1OENwL1dWSThMTlMrYmRIeXVyajl4ekJCVT0KPVVSUjYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002c4420064f67ec1c--
