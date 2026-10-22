Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695093;
	b=LGaMWsp7IVkJigDt0c/rMcsjDQND2LNppb/Fpm5ZT9OQ9IrczBd0c9csvFv1J6RKtO7d
	 QEFx264DCEXrqTAyUmNn3vSRFB4gmeBKoD4HxyrcrdHuX5BDs1vJWmcKzuAaKzJjC5wVr
	 LyRZO6Db2IJZpsSzzSiVkIRRXvJQhodsxVVrmFnvhtMEw840S73n9OeDXcEC7iYBgWmaS
	 Gn0EOKVm1kxUbmEdWcYnG/trFeZtCMWsq16KXs11oUzVeXdZHr6NuSTa3pN65t9ijyw7Y
	 PidcbdP/pctb/0/0Zmtl72bKZJa0KNiM+pNR9C27JT9Sa0/0ZuZ/46+5m8wyHIFdjqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695093;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=4Ra8Tx24DxZ9VurPff97TMIAPPZH14f57PwBdgHZSqo=;
	b=ZjVhTX5NJvYxXqTCLNwYYK8XPW44XEwM5MdLft2nDDSEjTv2y4OT7YtL40wdC13bLC3A
	 zQXhfKomCgIOkivuTOMoDUAa4LUS+TGtT8C5wXcOFe8/F1gK3qNcttE5iKQi8o2zYaj3t
	 NkL6Emy5h6+0TSmoPZXt/hVRekf0EYph0Mn0OhBB8pcdYSfG+b4MBFY9Af0gJYhb/IdDK
	 w33Ly0jspA0WcuTEMt8bDsY+L0cVsOuADNhPo916wKqj1jAlX5N045Yhzg36IleuoT63G
	 MqDckUy0rY+fGZn6huJH89dN7n/3gc8ffPpObI6lSfOCexFSL+CfhXpjX4c2P6CzgBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mYM72a3X;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vLHBksbW;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338AF606A31A
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 18:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 338AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=mYM72a3X;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vLHBksbW
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 45DD87A0127
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 14:51:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 22 Oct 2026 14:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792695091; x=1792781491; bh=4Ra8Tx24Dx
	Z9VurPff97TMIAPPZH14f57PwBdgHZSqo=; b=mYM72a3XpVj5sQo0b1dweXHos+
	9qhKx5zEjgz7oviFBMKLgHRrRYm3FNPPAlp9J4U4+65tGT7Bm3f9TRzR8PO3AhPX
	nDvUYyh7pSfgYQVaoyOx7nQrgXlfvB4oyrZh5hK9ifOL5yjG4wzcHspYXIR9s9Ec
	scenIHBWyq/04XTwQn8cs+8qBzpUcYmZyr5Jw5U5J1KTPIn7SHR5GLpr57MB7m9u
	3UJkfMQ39bVcHI6bO7JQcsVrHD66ZpG9gvgJ2cAdjYy0GDMrOchhsNiFYV5Z6tjX
	U50cbg7pim8HjwaOqTF1ytgEZ2cg69/xEVJd8HVflEkKT3XuhQyJB80nBwrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792695091; x=1792781491; bh=4Ra8Tx24DxZ9VurPff97TMIAPPZH14f57Pw
	BdgHZSqo=; b=vLHBksbWZe/ByjRnLUDyNE/VUOoZ8p5bcFjgPStBRwgqH9sp5U9
	+ZGiKjw0wxtZmuP5MQeYy7Bug+uaE1DvAqLv1JMSoKOES/akZ+K5PIKEM4KAH69Q
	o4ZPat/duB5HjyI5Na6ON/smQUcKt4oQo5wfrShJuEV9AzRsdMgM211V786wms/w
	J0w1YZ1StW7D+WAEcAb3ZAPO9XQzOQY0Taaf6KedHnEf/1WSCQgEWkMHgITNlPyL
	5yFhIjb55UQiC0VL3S6+/P54Y/vHPMoFQXBRTbHASclDQBH0I+EGxnabiA0xcjbN
	ZYBpRXMwpABDrCB0MUiJpo4H0P24w1ekFdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792695091; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cZFAOc5JKBkbLrSltWVxpsB7nyPhKUAfA13c1jTYMxpdGHU
	sXAJ/RFdmNGcFV6Doty3e1J+z3dDOqaLtpatG9jSogxzS9iNQWVnNbR5LN26FS2F
	k5xQ/KdGo68cBBL6nokdNxTa1iup88sdN2zvN/VS8tuzbL53D9RZJW/GHxT2CGsu
	CEiDvKBHvbj+zC5qy+2GN77bTGWKpBGeI5g6OHR+uZZqgKNJuVvPUJlklhDhIcmd
	KtTBYqq7OMNfzgLiRWzsG6l0uQn08yrynGzlddWGxfn3XnAodZEznwKuzWGu0nqe
	KXSATuQ3JSBknw3n9rFcakw2vANwZextDW9csxA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XHyBZ8cWH8PJ32q/cahJgPFOzOxWCaYBRp6NHJLePog=:x/hhdxj6aNXnmQzzJdbiRGH3NlhU4lpKrxyNyATz4YE=;
X-ME-Sender: <xms:M1vaaniukkhI-dLdYtKrI5_C6GaMHcfQkZNi29lqn3Soii6dyG5n7w>
    <xme:M1vaamQdopRIFp0f-QFnpoYU2cOiIJ0dpTwQOsPbqAvKXm-FX6C6ORo9IINna8Lgg
    hgFOZ5dMGAWlQ0EcMk3H__zlkB3abW9EGGFH-qlecTbdAmC7ENx5Ms>
X-ME-Received: <xmr:M1vaapU34qr9Iyik8F2ouukHsXRLcyKo-SJmOkBOrbQL4pEuGpCRYFUSr5YkgQEDZC8ZSIWfoG2JO191TeCMX8shR6KNB0sL9TAB>
X-ME-Proxy-Cause: dmFkZTFEfvJcJidiO20+HmYEs7Fze9OtdBC+NA7AoRpRGTPFqH5KAsSr8CCe6pl0TGBT+Y
    ltNiGVGhGK5CMYdhBHpAb0p0uJ/jfmo8b25X8QXtXVj+BcVU7xvf/0LwK1CjU5xmKnTu4a
    DqUafWaXLelLMwe0eaVA1gtoL9ogdaFZ8K6aa4WfHzpHFON45zD7nPBiy7PsqsmAELF9M3
    l4PoJihsq4V1Vk5ti9SXYGnwK5uSogIAFvHDq3OmegwZCXkE8b8ypy5CDhSO2D4I93Kykk
    4lBf/XR0L375BKfoW+XEbNzWvb7JuWmwCG7Jb6lczJvVJZqAwcLh500DW0eqNOd6zEwbfX
    8hWg1qwogy+AIHx/KzVs8eSY0kGbli53JANuTwLVEen6i+xdpsUrzQmimmCIx/d6VNPMYX
    p7+bHmPPGkPX7vr87ImZEpgHbXf18vJkYH+rVgTe69NPCljjHEpYOagmoMTcO9mZNwb9Sz
    RSsY9MJG8B77ig5s32A0cNnPoEY2MOqJPQZJphsS9ZX2xkqPSwqKNkp4PZKJvNKdSZjFzb
    Z48IzSYMWdmR5NGyQCnT6+/Ih5xPkTqKnxs6N1yMQF1GahGtBy3MqTAKElCZMibD+w07X3
    8mCCx+jjgki2o4nMY5Tphp88qprHCI8+7l6IRK5XhpHOc9l75gct5UgYsqEA
X-ME-Proxy: <xmx:M1vaaqT2TAIoa4m-jt2BmcUPgIWi8u7Ci6Qi00Coa-ymxA9n_7AnDQ>
    <xmx:M1vaajkwQf8kvUK58WJUUc1_u3jOnfFyGnS0HLoMq5KuWXnN4CuDGQ>
    <xmx:M1vaag4e7nSFXdkqDRdc-DIS_MZSUguvUWuDcr_TF9i0y_FtQOBkkA>
    <xmx:M1vaapi7JQUhYbOh5lGJvi2v9MFP3zwOOcdbi1tlcK3Q1eOt8Ltc7w>
    <xmx:M1vaatGv93n4tXzJliPP7Z8Dn6fWOPj3GhkmYKjlhEgsyNUG55xGWhNq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 14:51:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  usmanakinyemi202@gmail.com,
  christian.couder@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v2] checkout: pass the repository to
 unique_tracking_name()
In-Reply-To: <20261022105641.68963-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Thu, 22 Oct 2026 11:56:41 +0100")
References: <20261017225326.7827-1-okhuomonajayi54@gmail.com>
	<20261022105641.68963-1-okhuomonajayi54@gmail.com>
Date: Thu, 22 Oct 2026 11:51:30 -0700
Message-ID: <xmqqo6clfu19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> unique_tracking_name() uses the_repository to read the
> "checkout.defaultRemote" configuration and look up the object
> ID of a remote-tracking branch.
>
> Pass the repository to unique_tracking_name() and through
> tracking_name_data so check_tracking_name() can use it for
> the object lookup. Update the three callers to pass
> the_repository.
>
> This removes the need for USE_THE_REPOSITORY_VARIABLE in
> checkout.c. for_each_remote() still uses the global repository;
> leave that for a separate change.

The mention of for_each_remote() feels weirdly abrupt.  Many other
things still rely on the the_repository global variable, but
there must be a reason why for_each_remote() is singled out in the
context of this patch.  What is it?

Replace the last sentence with something like:

    The callers still cannot call unique_tracking_name() with an
    arbitrary repository parameter other than the_repository, until
    the call in unique_tracking_name() to for_each_remote(), which
    only works with the_repository, is updated to take an arbitrary
    repository instance.

perhaps?

And explained that way, it becomes dubious if we chose a good place
to stop.  The updated unique_tracking_name() gives an illusion that
callers now can pass an arbitrary repository to it and expect it to
work correctly with the given repository, but it does not.

So, I dunno.


> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> Changes since v1:
> - Rewrote the commit message to name the function and say what was
>   there, what changed and why, as suggested by Usman. No code changes.
>
>  builtin/checkout.c |  3 ++-
>  builtin/worktree.c |  6 ++++--
>  checkout.c         | 11 ++++++-----
>  checkout.h         |  4 +++-
>  4 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 2d575a4f57..bad49368b9 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1389,7 +1389,8 @@ static char *parse_remote_branch(const char *arg,
>  	int num_matches = 0;
>  	struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
>  
> -	char *remote = unique_tracking_name(arg, rev, &num_matches,
> +	char *remote = unique_tracking_name(the_repository, arg, rev,
> +					    &num_matches,
>  					    &matched_remote_names);
>  
>  	if (remote && could_be_checkout_paths) {
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 77ecd0f71f..203456bd23 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -802,7 +802,8 @@ static char *dwim_branch(const struct add_opts *opts, const char *path, char **n
>  		int num_matches = 0;
>  		struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
>  
> -		remote = unique_tracking_name(*new_branch, &oid, &num_matches,
> +		remote = unique_tracking_name(the_repository, *new_branch,
> +					      &oid, &num_matches,
>  					      &matched_remote_names);
>  		if (!remote && num_matches > 1) {
>  			if (!opts->quiet &&
> @@ -938,7 +939,8 @@ static int add(int ac, const char **av, const char *prefix,
>  			int num_matches = 0;
>  			struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
>  
> -			remote = unique_tracking_name(branch, &oid, &num_matches,
> +			remote = unique_tracking_name(the_repository, branch,
> +						      &oid, &num_matches,
>  						      &matched_remote_names);
>  			if (remote) {
>  				new_branch = branch;
> diff --git a/checkout.c b/checkout.c
> index a0d0229435..f0fb40d48e 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -1,5 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "object-name.h"
>  #include "remote.h"
> @@ -11,6 +9,7 @@
>  #include "string-list.h"
>  
>  struct tracking_name_data {
> +	struct repository *repo;
>  	/* const */ char *src_ref;
>  	char *dst_ref;
>  	struct object_id *dst_oid;
> @@ -30,7 +29,7 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
>  	memset(&query, 0, sizeof(struct refspec_item));
>  	query.src = cb->src_ref;
>  	if (remote_find_tracking(remote, &query) ||
> -	    repo_get_oid(the_repository, query.dst, cb->dst_oid)) {
> +	    repo_get_oid(cb->repo, query.dst, cb->dst_oid)) {
>  		free(query.dst);
>  		return 0;
>  	}
> @@ -51,17 +50,19 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
>  	return 0;
>  }
>  
> -char *unique_tracking_name(const char *name, struct object_id *oid,
> +char *unique_tracking_name(struct repository *repo,
> +			   const char *name, struct object_id *oid,
>  			   int *dwim_remotes_matched,
>  			   struct string_list *dwim_remote_names)
>  {
>  	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
>  	const char *default_remote = NULL;
>  
> -	if (!repo_config_get_string_tmp(the_repository,
> +	if (!repo_config_get_string_tmp(repo,
>  					"checkout.defaultremote",
>  					&default_remote))
>  		cb_data.default_remote = default_remote;
> +	cb_data.repo = repo;
>  	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
>  	cb_data.dst_oid = oid;
>  	cb_data.remote_names = dwim_remote_names;
> diff --git a/checkout.h b/checkout.h
> index 0b185a0fc9..25fe7dfb7c 100644
> --- a/checkout.h
> +++ b/checkout.h
> @@ -3,6 +3,7 @@
>  
>  #include "hash.h"
>  
> +struct repository;
>  struct string_list;
>  
>  /*
> @@ -10,7 +11,8 @@ struct string_list;
>   * tracking branch.  Return the name of the remote if such a branch
>   * exists, NULL otherwise.
>   */
> -char *unique_tracking_name(const char *name,
> +char *unique_tracking_name(struct repository *repo,
> +			   const char *name,
>  			   struct object_id *oid,
>  			   int *dwim_remotes_matched,
>  			   struct string_list *dwim_remote_names);
>
> base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
