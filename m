Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424273;
	b=mpHswDlc/aSBS5V9sBIHO4iOMAYL9eiRqgqtIjy+5nWQSst5p7hX81pT/vImdM6xLsgN
	 qOKQpYTVF+/1VeQ+5UQcsbKM82xkVq/1q/B9PMxHHyhCLX4PdeFTZi4j3jwXEyIG6XAf6
	 Tv/0B97No2ES0RN7NlgUTWfQfV/w/aE9prgZ6TB/mdjZVpF5Q6//F1HEucVPnsTgBdYaf
	 po4LleTP/J7paK+4X7vR0EwmL10PFVtoAi3yuhDFH0QEt6VYbV+AdpBSPXZe28PL0ibNZ
	 L2Sxa/9aazreWuFyKW6m4bdkE+NF4NmDso+3tBf0cociQZxIyEsw/CmiI01L4MPFaZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424273;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dr33wJzexDYlHXm0so3IpEn736D/eEO970oinR2dneA=;
	b=jX6jk2r5qpzcfulpk07n6AB7DoArAb3WiAKOGvJq/RaACXC+omL+ltHc+f13GHuceeDU
	 +xgZbZmSjyhQlZejmzdKvPmzEH1a7cXq0a6huo0U5ORtu53Kv0adDkoW4GW94h34Xfg20
	 vY5+TkAsp6NH+VczJ2jcpX45iFvDxNLzDI+qpnCiJ1RYVJ9olsJqS+GZAjYcUX9pV/+8F
	 tEKqPMAH5NbKFL8DpiinkCs6R5rk8wkb8hIBuHd8rJN6qBEHgw/WH5L8kP4Rg3aKfU7Uy
	 1LfthjE6j4IN80fF3kG+uQ6JmsCAnSylZbm+bVbts0vtugbDJL678p68nw9kCL0BIgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UfPCmL0g;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XHn9Heo6;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4E6080AAD
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 15:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CC4E6080AAD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UfPCmL0g;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=XHn9Heo6
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C7BCEC00AB
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 11:37:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 19 Oct 2026 11:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792424267; x=1792510667; bh=dr33wJzexD
	YlHXm0so3IpEn736D/eEO970oinR2dneA=; b=UfPCmL0g+z2buGcZ2TduVsZNSA
	bYPyiiNE6eTrPmCn6SBe8FKll9T9m4x+vVzhEsCQQJmUk2YdXRkzIVg9hf1cKIqX
	aFzIixC9bziB81P07QwhoNXTIiIlY/qf6tqBJnDraOillqbca5DUk5Ein7wd6HFN
	PibaO4B65JffhJ7n/lnC3b6E3HmfwfS07Xmp8JILJnXyF/CMi2TNdqml6LVcBwep
	P6bpFurD35E1xtRypUSkQhLwbZv9fHOkVZ2kkbkt7/CQ3u0UiwjrrkKZYa77LHh+
	AOYyOIsYb6C2jhA6DnT9T6DLSYzy9R6N6WI/6vSPO246pPMYQlCO/Cmplwvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792424267; x=1792510667; bh=dr33wJzexDYlHXm0so3IpEn736D/eEO970o
	inR2dneA=; b=XHn9Heo6QvReCx0AF8oDwa/rxyN3vxobItn/IdwaH/bjhPW2LlN
	r5J7Kdg392sqr8jjzt5sxTWvRzYtopcAOs6Q3Tk6FYKkkH69IWn9lruf9928eF34
	Low1/jMm/PYIqJ6HzEYSn60m+UEAs6mE7fcq1nEttATAITuWzq5t4c9K8MKwDCwq
	hhdS+OD8l8CiRbGyQq5wrH4xDaBbY5FGmC/iX0TOdZ6SZtIC4dq+3qbAoNKmU/l8
	c0w27bjNl5BWhZm3ss1S6Eyoq2RvUQSJDkrd8I6Dvll9yCmt3+OMHCfAyoES+B+K
	QuMa/vVo+srwgjMoz+6VIKV1mqIsz7X816w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792424267; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:aETHCLi3ghk7rORMRf4VeXzpp47Y54Fq0Zc/OAkKEWk9Eda
	5qbTlFasifmtAmP4TzxrySRK+PziZ9nmk0O/T/O9fuz/BNA7P52t1V6L7+HcmzmF
	ZFV1ykq7j/do/Xv0p4de8+fYqNODpU0Qe/6P/T/BweqPOo8ZQ/aYLP5Zf9fOlF6h
	KQpbACm4xmQaNxi+UlYmIa1tkQ1X8nxqemKXfMJ7zKZ85Cx+XVBjHGubxNtEiaWN
	s5WL5XhJ3LXQJQJuxsMIDi4M+nZLJiIiQlF8kCCfocEndR9iYbhOsDa/39lD+nPt
	sS3kagSZymIUhYdN9nBCIzh/qcqXm9LdTC6UhhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:7i0DneUBpmEpVieBW19+fumu5iB2UUJFuMb/LwTHkdo=:WB5Okw9rp9cQkx2E8Btay2moQz8HTTuwSsW8JHk15uQ=;
X-ME-Sender: <xms:SznWaniLGNgTSU5zvQiZOvvMA4yWeNVkffl4bG5u3IyhJd19HfIZaw>
    <xme:SznWarDyjxX40gU9D_5tkBITsY7uSjoxRBehRWyCnaV-ZoQsXBJ6bBgzqxasrGYF8
    PGnePW4h5ppkxPToIBDDpYGDdHtNcyGPq7BJ9ECVnRv1Q5ke_LWyEay>
X-ME-Received: <xmr:SznWasGCfkpJT16n2f-VdZb0lgwYylByDNwGJmmlVb0sIMcxnRQIkLNQITTXmRFxEl2qCZCt7MYOrCOSnCs5TyWbcNa39IxJAfM6>
X-ME-Proxy-Cause: dmFkZTGgqyBx0k0LsibJDjJEqGhm0HaG1Ji0a8n9j7y6GLlAMt0MASwQu46EY8z+THHwTb
    l3I0mz+NNs1DrmxeNZtqe/crOH47M9Ms9DFhFl8jRJNh5bJ6DwQCPX/PsusTd/b0Etd5cy
    f1rvhkx+4qmdyXdxUXe/jKO6xuCvz4MOuVXwvzu7Xtcqd2XARQZu3rRg4I7ogOfrCrteFz
    PQ2l1GehWkIo2oythQbRa9656zgKhzr/weP2O5XkvDkb5pDine+w//LobNQS1sIhbv89Z/
    LLcGqx2rS027PbvTJS2VrNLey00LkZqY05G3m4sPvmPHUoki7RWwvzWlwC8+0U+xLoXVAs
    eLc230LZ7hW/afGs1eI+bI+4n+NTJLe8MNc9x6lqS/uAP8FX4NY41zC91asQvgrwkPNV74
    R9do6P6SsXtbHFO/kgXIXqgdJlto96gxlxZgL+mTzELUYcd4AbDyAHwXCIFE++CvMQQ8uR
    7XBGSRFevZQUDioJzeymZJerF4SlVu0VCK/ufgQswHgOycwbCZsOAMOgYdWY0xjmxdeSIB
    B63S3TVTeoUcYkC/X4MF8EKoixBXeKPZiBlDwNICna+crASw5Q3a4iJ0+kouEytROd0Kha
    0daoPaL1RFS0kBgVGkRCFbxyS5RJiBD1n2CbjZjqEn+3jDlmPpYyDk0PUOdg
X-ME-Proxy: <xmx:SznWajIgYyKjeNhi34c91OyiA9bUL_sSNsBMU2C5FqWTMp1o8uGNZA>
    <xmx:SznWagnXemo5syOscFT8w1fpX44QO5RW5ukW_s3FDz86QheEBmldfQ>
    <xmx:SznWarTyYQzp9iLgki8J2JsDDeiIPNlLatQZjJfXu4M9Qp6Uz7PPcw>
    <xmx:SznWaiIinaO-vf0YiFuTVRrLpFMxjwN9Qk5hnUOi8yT6LEi6P02xyg>
    <xmx:SznWajX24d5d5-vvwKTW0nojUa2kXn94oOz0p_aiNym0Or7dEEZJBIOM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 11:37:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v1] remote.c: defer remote.<name>.followRemoteHEAD
 validation
In-Reply-To: <20261018235508.848-1-colinlewishinton@gmail.com> (Colin Hinton's
	message of "Sun, 18 Oct 2026 16:55:07 -0700")
References: <20261018235508.848-1-colinlewishinton@gmail.com>
Date: Mon, 19 Oct 2026 08:37:45 -0700
Message-ID: <xmqqbj8p66ra.fsf@gitster.g>
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

Colin Hinton <colinlewishinton@gmail.com> writes:

> Continuing from 86129fd (fetch.c: defer fetch.followRemoteHEAD
> validation), apply the same treatment to
> remote.<name>.followRemoteHEAD, which is still validated in
> handle_config(). That emits a warning for any command that loads the
> remote configuration, such as "git push" or "git remote -v", even
> though only "git fetch" ever consults the value.

Yeah, I remember that topic.  Making these two sources of the
setting that controls the same behaviour consistent is a good thing
to do.

> Store the raw string in struct remote instead, and resolve it lazily
> in do_fetch() through the get_follow_remote_head() helper introduced
> by 86129fd. This replaces the parsed follow_remote_head and

And the approach does sound familiar ;-).

> no_warn_branch members, and the NEEDSWORK comment left behind by
> 86129fd is removed. "git remote set-head" now compares against the
> raw string to decide whether to rewrite "always" to "warn".

> Because both settings now go through the same parser,
> fetch.followRemoteHEAD accepts "warn-if-not-<branch>", which
> previously was only recognized for remote.<name>.followRemoteHEAD.
> Document it under fetch.followRemoteHEAD, drop the remote-specific
> paragraph, and add tests for the new fetch-level form.
>
> Messages for an unrecognized or missing value no longer name the
> fetch. prefix, as the helper now serves both the fetch-level and
> the remote-level setting.

Obviously, when remote.origin.followRemoteHEAD has a bogus value, it
is wrong to report that the user has fetch.followRemoteHEAD
misconfigured (and vice versa), so not hardcoding "fetch." is of
course the right thing to do.  As long as it is clear to the user
what exact variable has problematic value that needs fixing, it is a
good change.  If not, the two calling sites should pass what prefix
to use so that the user sees the variable name in full.

> -static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
> +static enum follow_remote_head_settings get_follow_remote_head(const char *setting,
> +    const char **no_warn_branch)
>  {
> +	*no_warn_branch = NULL;
>  	if (!setting)
> -		die(_("missing value for 'fetch.followRemoteHEAD'"));
> +		die(_("missing value for 'followRemoteHEAD'"));

This needs to be corrected, if we are reusing the function to report
for both fetch.followRemoteHEAD and remote.origin.followRemoteHEAD,
by having the caller pass what prefix to use, or what variable name
to report.

>  	else if (!strcmp(setting, "never"))
>  		return FOLLOW_REMOTE_NEVER;
>  	else if (!strcmp(setting, "create"))
>  		return FOLLOW_REMOTE_CREATE;
>  	else if (!strcmp(setting, "warn"))
>  		return FOLLOW_REMOTE_WARN;
> +	else if (skip_prefix(setting, "warn-if-not-", no_warn_branch))
> +		return FOLLOW_REMOTE_WARN;
>  	else if (!strcmp(setting, "always"))
>  		return FOLLOW_REMOTE_ALWAYS;
> -	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
> +	warning(_("unrecognized followRemoteHEAD value '%s' ignored"), setting);

Same here.

>  	return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
>  }
>  
> @@ -1760,12 +1764,11 @@ static void warn_set_head(const char *remote, const char *head_name,
>  }
>  
>  static int set_head(const struct ref *remote_refs, struct remote *remote,
> -			int follow_remote_head)
> +		    int follow_remote_head, const char *no_warn_branch)
>  {
>  	int result = 0, create_only, baremirror, was_detached;
>  	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
>  		      b_local_head = STRBUF_INIT;
> -	const char *no_warn_branch = remote->no_warn_branch;
>  	char *head_name = NULL;
>  	struct ref *ref, *matches;
>  	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
> @@ -1955,6 +1958,7 @@ static int do_fetch(struct transport *transport,
>  	struct strmap rejected_refs = STRMAP_INIT;
>  	int summary_width = 0;
>  	int follow_remote_head = FOLLOW_REMOTE_NEVER;
> +	const char *no_warn_branch = NULL;
>  
>  	if (tags == TAGS_DEFAULT) {
>  		if (transport->remote->fetch_tags == 2)
> @@ -1978,14 +1982,10 @@ static int do_fetch(struct transport *transport,
>  		if (transport->remote->fetch.nr) {
>  			refspec_ref_prefixes(&transport->remote->fetch,
>  					     &transport_ls_refs_options.ref_prefixes);
> -			/*
> -			 * See remote.c's handling of remote.<name>.followRemoteHEAD
> -			 * for the analogous, still-unresolved case.
> -			 */
> -			if (transport->remote->follow_remote_head)
> -				follow_remote_head = transport->remote->follow_remote_head;
> +			if (transport->remote->follow_remote_head_seen)
> +				follow_remote_head = get_follow_remote_head(transport->remote->follow_remote_head_raw, &no_warn_branch);
>  			else if (config->follow_remote_head_seen)
> -				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
> +				follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw, &no_warn_branch);
>  			else
>  				follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
>  		}
> @@ -2195,7 +2195,7 @@ static int do_fetch(struct transport *transport,
>  		 * Way too many cases where this can go wrong so let's just
>  		 * ignore errors and fail silently for now.
>  		 */
> -		set_head(remote_refs, transport->remote, follow_remote_head);
> +		set_head(remote_refs, transport->remote, follow_remote_head, no_warn_branch);
>  	}
>  
>  cleanup:
> diff --git a/builtin/remote.c b/builtin/remote.c
> index fb7e5b114f..92eaffb4a0 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1606,7 +1606,7 @@ static int set_head(int argc, const char **argv, const char *prefix,
>  	}
>  	if (opt_a)
>  		report_set_head_auto(argv[0], head_name, &b_local_head, was_detached);
> -	if (remote->follow_remote_head == FOLLOW_REMOTE_ALWAYS) {
> +	if (remote->follow_remote_head_raw && !strcmp(remote->follow_remote_head_raw, "always")) {

Overly long line.

>  		struct strbuf config_name = STRBUF_INIT;
>  		strbuf_addf(&config_name,
>  			"remote.%s.followremotehead", remote->name);

Thanks.
