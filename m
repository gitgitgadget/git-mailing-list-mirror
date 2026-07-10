Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526C430CF0
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722068; cv=none; b=sfRkwQDsYXQ94Tk3vUCv68g1hpElREhu1hWuHdQF+tGKWsIL9LOwlOT1beerDWnttXRRexrmkm9R6t8sS3f3M1dkI0PhFxFkaRJS3GVg4qFtmE1C+KbONcoHs6shHi5YwXZ79FV+UDc5a2nOOwMOEZQdKH91J3zNC7hFl4/aXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722068; c=relaxed/simple;
	bh=9yaY92ul8o9QrU5NJoT7JAdmHRecjC7PBvaBvcNGzHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PR4+6fuH1mSVFOomfXdjQ0J5x4AMOaOt1MpQmfWOaKbQ5X2RsddFVhymAcFwUUbu02CIhQLQRwHn2CFCKaN5NeASyNy4slPInWAiAqgnG4cmpzyCJke8RK7x0HGo0vYnuKqSpO8MH4iabRVhd82M0q0tJJnDjSf8CfO81t51XRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RotH6mmq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W50CsQ3i; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RotH6mmq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W50CsQ3i"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 27EC4EC01EB;
	Fri, 10 Jul 2026 18:21:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 18:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783722065; x=1783808465; bh=OM3+Kps5UG
	2ZVOfL4z8YUVcGZlYK9YlgCgwlTiPNG1E=; b=RotH6mmqoaAjYkSt4Abbs92xuj
	OF5wFeqa6hpfsqpAupmTI2wvaBAdX6hO8KN/p5F9Nl3qD8IYKu2AZPhLwoOG3+ey
	gr6aARpXOkA3tSWEogEZ5mKOIpIw6DCsiLPpQlceD36aLTT1i+ZWmCYpbOVLa0dc
	q8G7c70lXhKhMmCiVmRpxdxZWpXoEpDLR4SF5CJbtRu5pACTVHJFxAxy8fUWE3a4
	pIy+yn0EwGCoEpYdhTd988xtFj7bHAb9IkU0hcTk8f0BQbBFjwsT46Fv8CKoukYm
	riC5oJt/eLBdcmGSLvAVYYDsKJ79kUYYs/uIqFB84KsU5HUUNuGdlMQdT1ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783722065; x=1783808465; bh=OM3+Kps5UG2ZVOfL4z8YUVcGZlYK9YlgCgw
	lTiPNG1E=; b=W50CsQ3ihPEUj+PTQle8+YiC0RnS04VR6Zz3CEV48WiG45M6FnA
	8YrJGsaEarp6naVoxzspKm33MSTdC8qEnqO3UYA58WRaHTKNo98XZ8855yoKQlqz
	vCrK4WIy1wP09LXX1iVjh1R7UOCbNdQWGeXNcoxzR8+T2n/ob5vcRZVVnmLcqoMB
	a3eYktsqj0lKjz+SM7l/KkpASiix5CcT1JNNMM/e3AM4ypj0oaHpOZgBok+d2NXu
	8svlcAugoGt7JDZ9WeTDjbZbjDn7dFkLdeC0whIxo8coqKxORHkip7wHtKcLcFsa
	89RaDoFv+XpEYt4OfK234r5mukjk0inhakg==
X-ME-Sender: <xms:UHBRapN9iXJ-4N0lqLxFV5h5H2IayLWJVW5uLe1qE10QR9RuAuwTxA>
    <xme:UHBRavrKUYCXlKXsqiarbyJtc9UDB3IsUTtG3BXfLOb5SZxGsdCZsdSvKh0URGiRM
    6vBz-cyRnz_UcvNkklMH_LlrZRevhVF6M-rHdvrlVw4S42EKpSigg>
X-ME-Received: <xmr:UHBRaiFja1IgUs-byeE93BXpckRNmt9gSWrDkIdO8JrPlmGZmKWcP1DbbenRrEFzbN6HMekMtcgFGB27M6daZU6RCuvd93LgEEkkFyI>
X-ME-Proxy-Cause: dmFkZTECIamXwRqe4FD2QPsxaPvfL+2Y8ynSqs99Fojka9Ism2AGEbEx2J1EJCrU59rSoE
    UknrDVpAyB9VQtY8CcTYLe7CsE+V4e/n70X3KcvSuknIaNzewPVhiCbSjEDRqWQp/sILXu
    W/IGH/aLEOdCK5pz39tNqkS7+oM0JCit2j7gi8O4M614QS8hqyIVSKsxfiiTQ7Uecq/iUP
    qDFySORFTKUddnSmSNB2YzizBahAm9ObGxRKfVXkSc31cZIbIP+1kqUBHmrGduA3Oi356T
    dNcMdhV5rfDcqbnQMk2bKSnVuFrBcUPEwPZ5D1KoHVyvMMgbF1vj7R7BB90dWln48DxfDv
    qW1TfnWEH2zjMN6VhMzLD57mNKLfVurvIqQ2fQ0s364+GoinOs5xYBOwiF/Ac1zhj1n7m9
    Bb/r2Pa4yvH9z/od/dTsVCMWx5/kJOtOoJKI2RO9VnhOI9xku/N2DwQemNGo2dWmsMXqvW
    5oZ7q+K5+zNwuCYAfRW05otyrDrRjdCp7pdSklpyh5bHA6h2r/RdsKbnmG4IexZRdlKN36
    8sZDpFfSHhSFMBsDDLCBt4fJsy8EsKs4S26xjJ77pAeui4N9Lt3lga/Uab2NtUJh87OweB
    FS42evdCV/KKAO774fx/qujytaiZEhE1+mjxnQj8LSH28h3W8AW08xJzj8Eg
X-ME-Proxy: <xmx:UHBRaspKIne2eFZGESyQ6UNgKh_3hpsX_sCgrW6ZU_22wRXbysWpyQ>
    <xmx:UHBRajYjeQ08IXjg4ykOzG-_60jN906GqO6l760BMq8WKf6iZjEWVA>
    <xmx:UHBRatWgLmtnpsww4GdNaoZSvj_f3sRnz6FFVJJJDo_3un9lMQvMxw>
    <xmx:UHBRak9Pvo-Tv1X4ZqZcQhNllQ4Dvs9RP8jnfDhaMZxNKkReVnpTbA>
    <xmx:UXBRakMR-NyXXyJO8ph2caDWrRV8yDGgtGhmwHV-aa0RcoDIvLSus2YX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 18:21:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: git@vger.kernel.org,  Glen Choo <glencbz@gmail.com>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 2/2] fetch: add fetch.submoduleErrors to make
 submodule fetch errors non-fatal
In-Reply-To: <20260710122655.3066377-3-paulius.zaleckas@gmail.com> (Paulius
	Zaleckas's message of "Fri, 10 Jul 2026 15:26:53 +0300")
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
	<20260710122655.3066377-3-paulius.zaleckas@gmail.com>
Date: Fri, 10 Jul 2026 15:21:02 -0700
Message-ID: <xmqqmrvybi5t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paulius Zaleckas <paulius.zaleckas@gmail.com> writes:

> When fetching with --recurse-submodules, a submodule commit that is not
> yet reachable from any of the submodule's remote refs causes the entire
> fetch to fail.  This is overly strict when the missing commit belongs to
> an upstream branch that is still being prepared (e.g. an in-progress
> merge topic): the local branch does not need that commit, so there is no
> reason to treat its absence as fatal.
>
> Add a new config key fetch.submoduleErrors (values: fail/warn) and a
> corresponding --submodule-errors=(fail|warn) command-line option that
> control this behaviour.  The default remains fail (existing behaviour);
> setting the value to warn causes submodule fetch failures to be reported
> on stderr without affecting the overall exit status of git fetch / git
> pull.
>
> Forward the option to child fetches in add_options_to_argv() so that it
> also takes effect for `git fetch --all` / `--multiple` (where per-remote
> child processes handle the submodule recursion themselves) and for
> nested submodule recursion.
>
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---
>  Documentation/config/fetch.adoc  | 14 ++++++
>  Documentation/fetch-options.adoc |  8 ++++
>  builtin/fetch.c                  | 41 ++++++++++++++++-
>  submodule.c                      |  8 +++-
>  submodule.h                      |  7 ++-
>  t/t5526-fetch-submodules.sh      | 76 ++++++++++++++++++++++++++++++++
>  6 files changed, 150 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config/fetch.adoc b/Documentation/config/fetch.adoc
> index 04ac90912d..5c9c942a70 100644
> --- a/Documentation/config/fetch.adoc
> +++ b/Documentation/config/fetch.adoc
> @@ -10,6 +10,20 @@
>  	reference.
>  	Defaults to `on-demand`, or to the value of `submodule.recurse` if set.
>  
> +`fetch.submoduleErrors`::
> +	Controls how errors from submodule fetches are handled when
> +	`--recurse-submodules` is in effect. When set to `fail` (the default),
> +	any submodule fetch error causes the overall `git fetch` or `git pull`
> +	to exit with a non-zero status. When set to `warn`, submodule fetch
> +	errors are reported to standard error but do not affect the exit
> +	status of the command. This is useful when working in repositories
> +	where some branches reference submodule commits that are not yet
> +	available on the submodule remote, but those commits are not needed
> +	for the currently checked-out branch.
> ++
> +The value of this option can be overridden by the `--submodule-errors`
> +option of linkgit:git-fetch[1].
> +
>  `fetch.fsckObjects`::
>  	If it is set to true, git-fetch-pack will check all fetched
>  	objects. See `transfer.fsckObjects` for what's
> diff --git a/Documentation/fetch-options.adoc b/Documentation/fetch-options.adoc
> index 035f780e58..78525f6848 100644
> --- a/Documentation/fetch-options.adoc
> +++ b/Documentation/fetch-options.adoc
> @@ -294,6 +294,14 @@ ifndef::git-pull[]
>  `--no-recurse-submodules`::
>  	Disable recursive fetching of submodules (this has the same effect as
>  	using the `--recurse-submodules=no` option).
> +
> +`--submodule-errors=(fail|warn)`::
> +	Control how errors from submodule fetches are handled when
> +	`--recurse-submodules` is in effect. When set to `fail` (the default),
> +	any submodule fetch error causes the overall `git fetch` to exit with a
> +	non-zero status. When set to `warn`, submodule fetch errors are reported
> +	to standard error but do not affect the exit status of the command. Can
> +	also be configured via `fetch.submoduleErrors`. See linkgit:git-config[1].
>  endif::git-pull[]
>  
>  `--set-upstream`::
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index c1d7c672f4..40daaf5cc7 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -110,6 +110,7 @@ struct fetch_config {
>  	int recurse_submodules;
>  	int parallel;
>  	int submodule_fetch_jobs;
> +	int submodule_errors;
>  };
>  
>  static int git_fetch_config(const char *k, const char *v,
> @@ -152,6 +153,19 @@ static int git_fetch_config(const char *k, const char *v,
>  		return 0;
>  	}
>  
> +	if (!strcmp(k, "fetch.submoduleerrors")) {
> +		if (!v)
> +			return config_error_nonbool(k);
> +		else if (!strcasecmp(v, "fail"))
> +			fetch_config->submodule_errors = SUBMODULE_ERRORS_FAIL;
> +		else if (!strcasecmp(v, "warn"))
> +			fetch_config->submodule_errors = SUBMODULE_ERRORS_WARN;
> +		else
> +			die(_("invalid value for '%s': '%s'"),
> +			    "fetch.submoduleErrors", v);
> +		return 0;
> +	}
> +
>  	if (!strcmp(k, "fetch.parallel")) {
>  		fetch_config->parallel = git_config_int(k, v, ctx->kvi);
>  		if (fetch_config->parallel < 0)


> @@ -2205,6 +2219,8 @@ static void add_options_to_argv(struct strvec *argv,
>  		strvec_push(argv, "--no-recurse-submodules");
>  	else if (config->recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
>  		strvec_push(argv, "--recurse-submodules=on-demand");
> +	if (config->submodule_errors == SUBMODULE_ERRORS_WARN)
> +		strvec_push(argv, "--submodule-errors=warn");
>  	if (tags == TAGS_SET)
>  		strvec_push(argv, "--tags");
>  	else if (tags == TAGS_UNSET)

If (config->submodule_errors != SUBMODULE_ERRORS_WARN), then the argv[]
would not see any --submodule-errors=<anything> to propagate down.
Specifically, this function is called when recurse-submodules is not
disabled, and prepares argv[] used to call fetch_submodules().

>  int cmd_fetch(int argc,
>  	      const char **argv,
>  	      const char *prefix,
> @@ -2477,6 +2506,7 @@ int cmd_fetch(int argc,
>  		.recurse_submodules = RECURSE_SUBMODULES_DEFAULT,
>  		.parallel = 1,
>  		.submodule_fetch_jobs = -1,
> +		.submodule_errors = SUBMODULE_ERRORS_FAIL,
>  	};

Here, .submodule_errors member is initialized to
SUBMODULE_ERRORS_FAIL (i.e. 0).

> @@ -2491,6 +2521,7 @@ int cmd_fetch(int argc,
>  	int max_jobs = -1;
>  	int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
>  	int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
> +	int submodule_errors_cli = -1; /* -1: not set on command line */
>  	int fetch_write_commit_graph = -1;
>  	int stdin_refspecs = 0;
>  	int negotiate_only = 0;
> @@ -2527,6 +2558,10 @@ int cmd_fetch(int argc,
>  		OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
>  			    N_("control recursive fetching of submodules"),
>  			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
> +		OPT_CALLBACK_F(0, "submodule-errors", &submodule_errors_cli,
> +			    N_("(fail|warn)"),
> +			    N_("control how submodule fetch errors are handled"),
> +			    0, option_parse_submodule_errors),

And command line option "--submodule-errors={warn,fail}" may update
the local variable submodule_errors_cli (initialied to -1) to one of
SUBMODULE_ERRORS_{WARN,FAIL}.   These are different from -1, so we
can reliably tell if we saw a command line override, which is good.

>  		OPT_BOOL(0, "dry-run", &dry_run,
>  			 N_("dry run")),
>  		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
> @@ -2616,6 +2651,9 @@ int cmd_fetch(int argc,
>  	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
>  		config.recurse_submodules = recurse_submodules_cli;
>  
> +	if (submodule_errors_cli != -1)
> +		config.submodule_errors = submodule_errors_cli;

And we override what we read from the configuration if we got a
command line override.

And the value in config.submodule_errors is used much later, in a
call to add_options_to_argv() we saw earlier, but this patch does
not touch the caller so we do not see the calling site.

I do not do submodules, so my expectation here may be a bit skewed,
but what happens when we configure fetch.submoduleErrors to warn,
but override it from the command line to fail?  .submodule_errors is
set to SUBMODULE_ERRORS_FAIL here?  As we saw, add_options_to_argv()
stuff --submodule-error=<setting> only when config.submodule_errors
is set to SUBMODULE_ERRORS_WARN, so we do not pass command line
override.  Is this desirable?  Don't we want to pass down not just
--submodule-error=warn but --submodule-error=fail if that is what
was given from the command line?  Or does it not matter because fail
is the default?

Thanks.


