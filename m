Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112927;
	b=cRqQdR4+835rvuuHxWHUqkm5IPBcsrdkWp1v+a9BNCuMkQzrgKokTUxxxuMjrtoc3+6s
	 YHxeiNCVv1V/D8TIOkchJrVpSZ16El4qo0+CQh3sPkyPEIfdcfiVfiNUjs9TIKjQxiESm
	 0hGtsFMEx48G9MpNZgS+hY9D4NsK6mCliR83o19jG43g+2LdvV13uDAt1TFFBIPUlnJkU
	 CNYDthoQlw1RKD41jRkv+tZOY4AAg8M5OJIW0lBd4lsIQKUYSIeU34dufvgDS5dhShVoj
	 irD160VQZuUW2Cq0q6y68h7tf104iHwrJNbuuMDXyEOOgOtZx6eSsVf/uDHPfyci1WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112927;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4fxAo2X462BOpmRBRooPFcU0JgdwINfhHHd3lk4J4DQ=;
	b=PARRAhZScaSw7CQb323xVY1qguUN/xPdrhn+3D9VW/6QCHVL+KC3QVa7K6ouOYqNdt/6
	 1d5CwQsQzEG/elbvlB0unEV6hU6xgZwp+xueMS57r+Uj921ikKcSAO8hVFRZYzp2I2Hgn
	 4sbqlAzvBx5BgCGUN2e8j8V4MeP7W4tCUyKwxEQN/2xqsLm70aySgGuTBoa+WftTwmMZ+
	 I/Oa87WKm6cW438SRgUdjuFRfgXWY4+uTWXAm4P1VNIvOWNP2/QAXv/meS3gjdxafHuIu
	 uR9/fkmHJ/BAI8hzzmmnUYQhbX0mp0mzt647/aJOOvFFofknq6KE4HEivzuWK/r2e1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="AIFcbL/r";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iNBOX25I;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFC606A31F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1EFC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AIFcbL/r;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=iNBOX25I
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AEE761400081
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:55:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 10:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793112925; x=1793199325; bh=4fxAo2X462
	BOpmRBRooPFcU0JgdwINfhHHd3lk4J4DQ=; b=AIFcbL/r7rp7MgM3ZRYLtwk0Wc
	Bc5JOenytLBODJt/1IY+o+7EaKYrMEHvf75fXSaBiHeCBzb1HYWKmV4PtvUgIMzj
	w0dOOwXorof7w92uSR2rHEEZD/uwuqSKl2XFyRtPxLLXjZageR6ad/4oz4e8xJtq
	nKwwyigQ5k68WBQV4EOnLpGs17fTOs5JjlqCX8FU2peB3F5TQry0HdoZZTdNg64Y
	vpXcaMIn3YvhE+yL2OyT0azm0fPOIhs1leEJOEY6CwOOtw4qDPHcDusDMMLA0ap4
	ss0OX0Qj0XS9hyNN1+zbjKMXoUZBA0crcOE37zYNCK/N7DjpO/5KbzuGpPdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793112925; x=1793199325; bh=4fxAo2X462BOpmRBRooPFcU0JgdwINfhHHd
	3lk4J4DQ=; b=iNBOX25I1HS2xS750dwVP9PP7xuCepfXdFIkzvzHljX+bQVzI26
	/VXG276OfORcUgSowY3M9DUTdQNrI98OlIn8Rt3o245HwKDH94H3CujXai6G7O3Q
	6cIzIHX4Gclzw1bG90MKr1SFv9SDhomUqJWrOWREhc5EaAm7NbJJsNJdvwZuRebt
	tlGvycKV8ptLY3h9k1vtJZQrSwSeXuD6lH6uYdzF8TsN/AAhaOzcslvjF1lkazr/
	W1PXS2FTq1qvZ2b0umW/PNkkmWETjV17EkNuiv/VRmkPSAGYUn9whNaK/T7B9+9Z
	Zh13DDq8whfK7S09HffHRiTjETU7yzcfBGA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793112925; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NkbKpJqMu6YhKN0gkXGOZwbD/HvjSXS4UA2JZQfMR7Q92ml
	aMHa0qp7ubgoTribo3dZdHM1XHIE9NeE4irUPw9vZ3qvsL0M22uthAp/lqKVuldG
	FNN8+hGGKkt+cx20cYqKL4MDJ+8go2NDzCPleTf7yJABsRfnBX1/76BOuizxWK2F
	YmCoTFpQFgfVOHU6s55gsy2MB2ceRHSpdiLd1Kns3p2PUuJcShHaqS8ZrwEuPVv1
	tcTyxflhni5kb0nc46nI17XmPcMzU58eEqBSg6hCTzG1ZOc4Z4JMSeW96iKVLKNs
	xFmom5IaP/RQXHy5zEztvh2U2iE/ytrkZGFaaFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8jARaIxsY1PGjf0p8RxVh4xsLtuhtEcCiiEZg+bgl54=:FW/J5H8ZtbVLbhsONZGtmjdtQ+EoB2Yc9KgtPdopq/M=;
X-ME-Sender: <xms:XbvgavwPenogeMuHHT4Z0gbYaMMJzYR99sdyX-E4Q-z0n0FAd-hQ-g>
    <xme:XbvgatTVOO2-5qRuzGwmyh_HdmhXU7QpWLnF0leUGDNeKEBMw0bteLISvAWV_UiqS
    h3-Ui_UgIxTvm0mzBC9s59aKDTPGv45RCAQulg6zpTxoNjXbre94Q>
X-ME-Received: <xmr:Xbvgam95CD2nuwoxiylQFIEIG-2L7yYFjm-gxTMMt7PGMrzGcraLdg>
X-ME-Proxy-Cause: dmFkZTFtW5N5GRtFQZdyyoIvJX4mPq8Se0LtbnzJNpc4T3CpPUZkG9LuLlO0Abc5bppnMG
    YLwiaV9wml1X7YtLVWNsAxcLrHN2Gy8lukaoyfsyadREQWcSW/NdyjKx+9mXyM0vuEJKgk
    Bu7IdBC1/r2HLcFtHXyvCPTTNqYJOWuFrzKFU8DJGclfSXMCLFRivWdnzCfJjOUTce8d9f
    7Fz/YVsQMzlESECtpCuA9oEhToQtTf5xE5XnfcT635r1wd/HhdannL7siIcQgx682pvQwv
    oKZO2sxoYaR1NDyeoSkOfTDmQwf9cObCAyKFHjI7EzwrNdeZnj2hsTuVGP+KmpRZJxbDnS
    LBGoKx15Nt4EKC8pZNTR8ur7GJXqUM85Bb139o9/zdy+lzybb+rife13z3s+2IfQBFPCqf
    QdFVEIE8Bpwtk7hstPuwwtJTL7/nssIXIsUKEx5DU5Voa6Cm6QvaGd+ghCOWFlqcpZZaKh
    uEuPjX6N4VU1ZjK5L5jRoJPrGGr1Cg/j94u3d42WeZ3HymcrOYE6hbDZEOQ1d0XtMV+0Lq
    tfFKOxtkQvBRCgL/oXenFXe20kI2Tfyj+/YQ58rdtI4/GTBmMPORIWpJffFE31GQEir6j8
    Bcc/9XWa3Xdyin6b84EDB/4/hsMOgITHiH1Li9gQgLCRGlo5FXMi6maLfoGg
X-ME-Proxy: <xmx:Xbvgakq34_VXndlJ8dvI3H3Bt9WaRMGBRwNZn3-FZI6W3uagVyHzOQ>
    <xmx:XbvgajkEoFZ0XsMHDSArUPlrd990P9M2R1kuXEU9NGYLfeHAcnkvRA>
    <xmx:XbvgarLtEJbX1iUSRO3YtW-lAk-MPlyM0R04a_VubvRZV-JFAOjHCA>
    <xmx:XbvgaozTb3L7C7v3jxtkv6Jto8uQkjrNsC2n5056MCtnBFEnyQJdhg>
    <xmx:XbvgajLMYotivXsRYEzUXoSYOkMSvJ4StUhlvMONWJQYnQcmHf5B9Epf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:55:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4c81fd28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 14:55:22 +0000 (UTC)
Date: Tue, 27 Oct 2026 15:55:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] repo: add level of concern reporting
Message-ID: <auC7TjiE_KdoTGyO@pks.im>
References: <20261026-b4-repo-structure-concern-v2-0-e0df34228dc8@fastmail.com>
 <20261026-b4-repo-structure-concern-v2-1-e0df34228dc8@fastmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-b4-repo-structure-concern-v2-1-e0df34228dc8@fastmail.com>

On Mon, Oct 26, 2026 at 01:43:54PM -0400, Mark C. Chu-Carroll wrote:
> "git repo structure" computes a set of statistics
> that are useful for diagnosing performance issues in
> a git repository. But for a typical user who hasn't
> encountered any issues yet, it can be difficult to
> interpret the data - when should a value be considered
> concerning?
> 
> Add an option to "git repo structure" that adds a "degree
> of concern" column to the structure report, which indicates
> when a stat values has reached a point where it might be
> concerning, and indicate how severe the concern should be.

Missing your Signed-off-by.

I think the commit message should also mention git-sizer(1) here, which
is the direct inspiration that we have for this additional data. To the
best of my knowledge, the level of concern is essentially the last item
that is missing for feature compatibility between these two tools.

Another interesting thing to document here is how you picked the level
of concern in the first place.

> diff --git a/builtin/repo.c b/builtin/repo.c
> index 84e012f83f..a450497d4e 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -348,8 +348,118 @@ struct stats_table {
>  	int name_col_width;
>  	int value_col_width;
>  	int unit_col_width;
> +	int concern_col_width;
>  };
>  
> +/*
> + * For computing level of concern about a stat, we need to have some
> + * baseline values. For each of these, we'define a minimum level
> + * of concern, which will appear as 1 star. Then we scale exponentially:
> + * each time that value doubles, we add another star.
> + *
> + * The threshold values for concern are expressed as log_2 values of the size
> + * at which the statistic becomes concerning. The default values for the
> + * threshold were selected based on observed values from a collection of
> + * representative-ish repositories of varying size, by finding the mean log_2
> + * value and standard deviation (sigma) for each statistic over the collection.
> + * The threshold for each metric is then set at mean(log_2) + sigma.
> + */
> +struct concern_stat_threshold {
> +	const char *name;
> +	size_t threshold;
> +};
> +
> +enum concern_stat {
> +	CONCERN_STAT_COMMIT_COUNT,
> +	CONCERN_STAT_TREE_COUNT,
> +	CONCERN_STAT_BLOB_COUNT,
> +	CONCERN_STAT_TAG_COUNT,
> +	CONCERN_STAT_COMMIT_SIZE,
> +	CONCERN_STAT_TREE_SIZE,
> +	CONCERN_STAT_BLOB_SIZE,
> +	CONCERN_STAT_TAG_SIZE,
> +	CONCERN_STAT_COMMIT_LARGEST,
> +	CONCERN_STAT_TREE_LARGEST,
> +	CONCERN_STAT_BLOB_LARGEST,
> +	CONCERN_STAT_TAG_LARGEST,
> +	CONCERN_STAT_COMMIT_INFLATED_SIZE,
> +	CONCERN_STAT_TREE_INFLATED_SIZE,
> +	CONCERN_STAT_BLOB_INFLATED_SIZE,
> +	CONCERN_STAT_TAG_INFLATED_SIZE,
> +};
> +
> +struct concern_stat_threshold repo_structure_concern_thresholds[] = {
> +	{ .name = "commit_count", .threshold = 19 },
> +	{.name = "tree_count", .threshold = 21 },

Nit: missing space.

> +	{ .name = "blob_count", .threshold = 22 },
> +	{ .name = "tag_count", .threshold = 15 },
> +	{ .name = "commit_size", .threshold = 28 },
> +	{ .name = "tree_size", .threshold = 27 },
> +	{ .name = "blob_size", .threshold = 36 },
> +	{ .name = "tags_size", .threshold = 18 },
> +	{ .name = "commit_largest", .threshold = 18  },
> +	{ .name = "tree_largest", .threshold = 18 },
> +	{ .name = "blob_largest", .threshold = 26 },
> +	{ .name = "tag_largest", .threshold =  15 },
> +	{ .name = "commit_inflated_size", .threshold = 28 },
> +	{ .name = "tree_inflated_size", .threshold = 32 },
> +	{ .name = "blob_inflated_size", .threshold = 34 },
> +	{ .name = "tag_inflated_size", .threshold = 25}
> +};

I think this is a tiny bit unwieldy, as you now have to remember to
update multiple sites whenever you add another metric to this command.
Ideally, we'd have a single structure that knows to track all
information that we're about to print so that we can define this in a
single, central location.

For example, we could update `struct object_data` to have a configurable
threshold, and then do the same for other such structures. But that
might also get unwieldy by itself.

I think what bugs me a bit is that we have not only two, but three
locations because we have the enum, the thresholds and then also the
data structures themselves.

I'm not quite sure how to fix that myself though.

> +/*
> + * Concern thresholds aren't universal. We try to set reasonable default
> + * values, but projects may want to set these thresholds differently. To
> + * support that, they can set the thresholds for their project in the
> + * project's git config, in the section "repo.structure.concern".
> +  */
> +static int config_concern_thresholds(const char *prefixed_var,
> +				     const char *str_val,
> +				     const struct config_context *ctx,
> +				     void *cb UNUSED) {

We should probably use `cb` to pass around the structure that you
populate so that we can avoid global variables.

> +	const char *config_prefix = "repo.structure.concern.";
> +	if (!strncmp(config_prefix, prefixed_var, strlen(config_prefix))) {

We have `starts_with()`. But also note that if this is a config key then
it should match case-insensitively, so it should rather be
`istarts_with()`.

The config keys are also a bit off as our format only has nested keys up
to three levels deep, not four.

> +		const char *concern_name = &prefixed_var[strlen(config_prefix)];
> +		for (int i = 0; concern_stat_thresholds[i].name != 0; i++) {

We typically don't compare with a zero value directly, and indices
should be of type `size_t` when iterating, so this should rather be:

        for (size_t i = 0; concern_stat_thresholds[i].name; i++)

But the loop condition is a bit weird, because you don't have a final
entry there that has a guaranteed NULL name. So shouldn't we rather
iterate through `ARRAY_SIZE()`?

Also, I may be blind, but where is that struct getting defined? I can
only see `repo_structure_concern_thresholds`.

> +			if (!strcmp(concern_stat_thresholds[i].name, concern_name)) {
> +				int value = git_config_int(prefixed_var, str_val, ctx->kvi);
> +				if (value < 0)
> +					return -1;
> +				concern_stat_thresholds[i].threshold = value;
> +				return 0;
> +			}
> +		}
> +		warning(_("Invalid concern threshold name: '%s'"), concern_name);
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static size_t approx_log2(long value) {

We have `log2u()` in "wrapper.h". Can we use that instead?

> @@ -681,12 +887,15 @@ static void print_object_data(const char *key, char key_delim,
>  }
>  
>  static void structure_keyvalue_print(struct repo_structure *stats,
> -				     char key_delim, char value_delim)
> +				     char key_delim, char value_delim,
> +				     bool show_concern)
>  {
>  	print_keyvalue("references.branches.count", key_delim,
>  		       stats->refs.branches, value_delim);
> +
>  	print_keyvalue("references.tags.count", key_delim,
>  		       stats->refs.tags, value_delim);
> +

Nit: stray newlines.

> diff --git a/sideband.c b/sideband.c
> index 374187402e..0e75ab2317 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -1,4 +1,4 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> +define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
>  #include "git-compat-util.h"

This change probably shouldn't be here.

Patrick
