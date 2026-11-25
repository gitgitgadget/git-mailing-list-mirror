Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639060;
	b=nxYGqx8y2bwuGFHRy2od1nkthynftxjxObC66n9DYFlKI19+GhIbnTruY5QxB3o+btGR
	 UJHK1vYcuCeBjTbmd5UU0KaZRrxe1kR2LcrnLygBPZJrqm1vakcZQZ6wBmwiy1pwNoHie
	 gdxE0DNqVW3EAP9cJjWmLYGSn+Kv2eKf7RXFOoFZVwr/IXQUP6G9mnWLtzOIIDcyDYQsX
	 FBbdx1g+7CiBuHEjmDR5JogH1WcIBMS92hm4JxajqEpqKpjoyh4RKTw1SWR8qd202XAEC
	 RBVqd048RZ5NxS3JHWHKXJO+W7RKLHFX7l6qJfBhay5yefxm9obL6ZOzwCVHyhVi8sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639060;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/cB+MILQAI/sGBQGQ12/jJg89GdZyQLGnrEmKcxDZ44=;
	b=JGJP6Xrt5SzGpfaNH74szMMt+Mi11zCZtC2P5tAcwxBYKKC9crBQykVuud68Tc2xHeuw
	 i5WhWjFpSZDa7BQgtwgtubqcarvknCT5Mqb9VIcEwoOqU5UU3O8jzasBapMEjanGZlCTQ
	 /5ukt0BP9I8l8y9Dl5wmJUyqETFR+GTR0r2Wlh+7XOZmVxEVk0Qryf1Ieo32WmxYi9uCf
	 NxKyBfvkw91NmfrebMUz+4sj9fCIBaMzPB45MLpqG8tWtxUg5Dl3/faspVfrGjQeGf+7r
	 RNnW43RScpWbpHXAmj2XsFsHZhtOKGsOBIBE2zEK/4eqDefEfOPSXYaiOAMAsl/XKbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=N0kTsSjx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fOGAnnrc;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F71606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 20:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60F71606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=N0kTsSjx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fOGAnnrc
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 844E01400305
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 15:37:39 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 25 Nov 2026 15:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795639059; x=1795725459; bh=/cB+MILQAI
	/sGBQGQ12/jJg89GdZyQLGnrEmKcxDZ44=; b=N0kTsSjx5zpSnT5Ot4RittkBJx
	XBT8lTvwxm0pbrvL9LcuY+NsYdo+K1X4T2Yg9MWZcNuD8a8/RyB6qki5Vdiust7U
	+cy6fXior5SigiCnTK6peHGT+u8Tar55rK1z0kHJI5h8A/+iOdskS/zdXxfyoZ17
	IaxT4rxDdUj78WtZ0WumuXsJhpdGlbqVLDE/dWXSysqSS66iO/mMkp82BhZR6Ln0
	+lA6+GtNgR16JWYsYlagjQIib7D5jSx0d4iS/uiMb3xwfC4lgZpuCjDjyUGk0psH
	egup9IfnwmPCSufC/mUsWYySJPesIg6kiLMzkpYo4Lo+rohHSzeNb/8NYFag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795639059; x=1795725459; bh=/cB+MILQAI/sGBQGQ12/jJg89GdZyQLGnrE
	mKcxDZ44=; b=fOGAnnrc59gw/n59n52dGHgW8Pe74yUqN+H9hpSQXqo6eUkkBER
	nG7V1fyHuSmxsvwBD7zconuHAlWQeApsuMyEeDD2WUeDUFkU3KPK2xenFNt8tiOH
	piRUgVbAJXADr21uPw/NhyTVY+TMO7nNe+5PiBByBiz/nCe6ll35Lg8tzp5mcyie
	3aTJBAjZ9aprwMNcfa9m7QbqhpKjZvspVb7/AK2Z1lZIJqKuaCG/GKDYftvj3laS
	Rnhq46zvNVTzemG/GalG2ZUwXkwkE1L8HegvqdEHucSkncczgv5XqdRFnrrqABUd
	ZYHc1N87t4MSZf40JvMCIaAWTFGxdADXIiw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795639059; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mWjKQGudn0FOlaPzRt9HTQMqV6/o/VDbmJArkDJuRDp13M+
	lMqHCcbYZrO6WopWYXXQVTFbZ3xmo9WoiaIYkNb2tEFoqICj2sVQU9X9PNrnjsAZ
	Uqer+W0XpXeewQB4fl/kbB2456W0iV18IskHd54s9lx5JvP7Kl1ktx7dM19CiWQc
	I6iStr/iIyndP6uJ2zXbUL0EnxcGSkHg/P7WV4vgASqezqTY71b/jLACPqU1MFkD
	WD/Mv7fzB45qbSHKGgpe213oqonXrjXsHzjzE40dZSMQa6ucC+C1ByjlHb/cEerv
	ok2g5pTr6mydPmkJV0vdamPV3yUXius5nKSYs7A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:M7Zv9ZhyIJ9Og56VqQLqsKHN9fsyo9YvwBx+Yyh6y1Y=:buMPkrPMb5Fh2OTYLbRHtaqP8ymgSqh59QVU4V1RbpU=;
X-ME-Sender: <xms:E0cHa4QEHVJZEluNyG5YiablZVhT2s93IpjwLkhG6JO8cq_VcK5AnA>
    <xme:E0cHa5fFiqGzRZrycOsbouYIKoSbDcv2AlVN448226rfmcIkmV0QxVPlYUpVCLqEw
    IYEQ2BglCGd1mWXmBX_qBVjIdPAsCjTeisgQx2Nj59MZKE61YhUWQ>
X-ME-Received: <xmr:E0cHa_olk9cazVK2meoB4eIOqz4gl1Tcpy9QmrSdqsNwHpoPwTzZXTEGANYW1DpYMwVy7rsCtLP9nI_N2aPdVISBFXztH-v8A5PqsQ4>
X-ME-Proxy-Cause: dmFkZTGrF6uvhD6CbxR7J6JI2y6QA42Jm9oJJumfI4jNDwLlxAIn6nxTOXTHoE7CfYrym9
    2YMEbsnil8yeChL35rt4NECWt9rf3i8o4YHWf+EbXHjbaEqHOnR67brQxizEY3ucZD4cgM
    +SNXhuZXiEa1iWtJhY67L3aCHEZLxA6KlJ9otcvwOmofFi6iL/ob1aidW1c2CbBpF4xOS7
    d2L8O08xIplRotWkHkcMZ8R/D7lgTHC14AXRKCyf6rnydh7xTKqC503XY4N7ew2UhVAe+J
    AX6cgIHLm7TrA52kXnCzu1H+/i22smucGgf6ISU5odhobn2yqsMQZvejEsRmFJippWXVbp
    D9GsDCQ2MKIyJx/XaaSwM5Im/nSgN56Wpt+r1LzgDfyZ8+0GSxwTHAGi/NxXWHPLrUytWu
    uEKWakWkIFCm/jx2i01Dmepz1BbkAX6glC07NRsM+srLGcW4aQARYvVsZLkxxXHal2mypl
    uRgnfovLBYC44KMeXXn3yMe9+uO+GLqsk4EToWDcMqyeDF3HM8PnKlLr31FQQDKrrNQlnp
    Bdj1j8LUM0icjOJmShGdkl0u41UISwQyTODcxlVKiJ0aKnyCRsmgNTspeUdC6RxhRHbiyN
    B4ZzMTp3UrXqIwhW85eHQOnyb0SmCZeef9MYzTVzHR8my1HdiIejpvnKfmJg
X-ME-Proxy: <xmx:E0cHay83K7BLzU80yDeugaCXvvihdwHKgqUB0AN1RQego_7YlkffUg>
    <xmx:E0cHazeIxN2-HnyX47B4Y0tFNCVEBu2cDmKRTnyiEHQVAufLVG6RQQ>
    <xmx:E0cHa0KI89L68zoNGmyemCPiDjKnXGL2qxXYflZX4VBRNCeOuYVGiQ>
    <xmx:E0cHa7jG_IQ1FmgoLcdwGZGzJpXUT9YLhTMd0vcED9wCF99bJNFcdg>
    <xmx:E0cHaznWPuJ5Ex2bu3NAAFaqcqwkQlF_thGSZ0BA5nyCCpVYhnLqPkpO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 15:37:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abhishek Agarwal <agab0323@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jacob Keller
 <jacob.keller@gmail.com>,  Matthias =?utf-8?Q?A=C3=9Fhauer?=
 <mha1993@live.de>
Subject: Re: [PATCH] submodule--helper: check 'update --jobs' like
 submodule.fetchJobs
In-Reply-To: <20261120113233.783523-1-agab0323@gmail.com> (Abhishek Agarwal's
	message of "Fri, 20 Nov 2026 17:02:33 +0530")
References: <20261120113233.783523-1-agab0323@gmail.com>
Date: Wed, 25 Nov 2026 12:37:38 -0800
Message-ID: <xmqqtsl4zlyl.fsf@gitster.g>
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

Abhishek Agarwal <agab0323@gmail.com> writes:

> "git submodule update --jobs=0" aborts:
>
>     $ git submodule update --jobs=0
>     BUG: run-command.c:1574: you must provide a non-zero number of processes!
>
> "git clone --recurse-submodules --jobs=0" passes the value on to it
> and aborts the same way. A negative value fails with a confusing
> message:
>
>     $ git submodule update --jobs=-1
>     fatal: data too large to fit into virtual memory space

Ouch.

> Before 51243f9f0f (run-command API: don't fall back on online_cpus(),
> 2022-10-12), run_processes_parallel() turned any value below 1 into
> online_cpus(). That commit made 0 a BUG() and moved the fallback into
> the parsers of fetch.parallel and submodule.fetchJobs, which already
> die on a negative value. The list of callers in the commit before it,
> 6a48b428b4 (run-command API: make "n" parameter a "size_t",
> 2022-10-12), describes "submodule update" only as a reader of
> submodule.fetchJobs. But its "--jobs" option is read with
> OPT_INTEGER() after the configuration and is used as is.

Good archeology.  builtin/submodule--helper.c:module_update() does:

	update_clone_config_from_gitmodules(the_repository, &opt.max_jobs);
	repo_config(the_repository, git_update_clone_config, &opt.max_jobs);

	argc = parse_options(argc, argv, prefix, module_update_options,
			     git_submodule_helper_usage, 0);

Both update_clone_config_from_gitmodules() and git_update_clone_config()
calls down to parse_submodule_fetchjobs() to parse these values and barf
on negative settings, way before parse_options() has a chance to kick in.

Also "--jobs" parsed by parse_options() is not validated for zero or
negative values.

> Signed-off-by: Abhishek Agarwal <agab0323@gmail.com>
> ---
>  Documentation/git-clone.adoc     |  1 +
>  Documentation/git-submodule.adoc |  1 +
>  builtin/submodule--helper.c      |  6 ++++++
>  t/t7406-submodule-update.sh      | 20 ++++++++++++++++++++
>  4 files changed, 28 insertions(+)
>
> diff --git a/Documentation/git-clone.adoc b/Documentation/git-clone.adoc
> index dd3b44817a..a64084488c 100644
> --- a/Documentation/git-clone.adoc
> +++ b/Documentation/git-clone.adoc
> @@ -375,6 +375,7 @@ repository uses a non-default object storage.
>  `--jobs=<n>`::
>  	The number of submodules fetched at the same time.
>  	Defaults to the `submodule.fetchJobs` option.
> +	A value of 0 will use some reasonable default.

As the proposed commit log message said, this is deliberately left
vague, but matches how "git fetch --jobs" is described, which is good.

> diff --git a/Documentation/git-submodule.adoc b/Documentation/git-submodule.adoc
> index 57a21bc8d9..8abeb69cb2 100644
> --- a/Documentation/git-submodule.adoc
> +++ b/Documentation/git-submodule.adoc
> @@ -465,6 +465,7 @@ NOTE: See the NOTE above for the `--reference` option.
>  	Clone new submodules in parallel with _<n>_ jobs.
>  	This option is only valid for the `update` command.
>  	Defaults to the `submodule.fetchJobs` option.
> +	A value of 0 will use some reasonable default.

Likewise.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 461b682d0d..e06a724ad9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -37,6 +37,7 @@
>  #include "wildmatch.h"
>  #include "strbuf.h"
>  #include "url.h"
> +#include "thread-utils.h"

Hmph, we need this for online_cpus(), OK.

> @@ -3079,6 +3080,11 @@ static int module_update(int argc, const char **argv, const char *prefix,
>  	argc = parse_options(argc, argv, prefix, module_update_options,
>  			     git_submodule_helper_usage, 0);
>  
> +	if (opt.max_jobs < 0)
> +		die(_("'%s' cannot be negative"), "--jobs");
> +	if (!opt.max_jobs)
> +		opt.max_jobs = online_cpus();
> +

So this makes sure that negative and zero inputs are reacted to
appropriately.

One related thing I noticed is that builtin/clone.c:cmd_clone() forwards
the --jobs=<n> to recursive submodule update only when max_jobs != -1
because -1 is used as a sign that nobody set an explicit value to it.
So --jobs=-1 in 'git clone --recurse-submodules --jobs=-1' is ignored
silently (because it is not passed down) but --jobs=-2 would be passed
to 'submodule update' and will be caught by the above check.  'fetch'
might have a similar issue around this (I didn't check).

If anybody cares, it may want to be addressed after the dust settles
(#leftoverbits).

Looking good.  Thanks.
