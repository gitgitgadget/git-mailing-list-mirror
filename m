Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3812367AD
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 05:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778762; cv=none; b=sLGqR5sS3BdC81DSposLso6lIzxRCiY0Z+Z5j+eQu42AWHy2G5JtMZJ0ZoWr5gMd9Uu47kgWHD5l1LSdT9ufVF5RAQSADyzCwU6V7tP/7u7IV2QpAt7oWnE7M3Bpf7UvmX1zPO1FKqF/4MmDVUjBjpCHzpl+YneJJaBDKuBU85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778762; c=relaxed/simple;
	bh=ub2GJkt97a9QywsR6tstcRAehi1FkIwUzbGEhWekU48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+lN3sm4x4k/9JWYXGhakvsQKvazFpojP/8dsneTYKC6IB6eTHuhHW6Em1AT7u6fgY/zH5nkjI7WoQ2QDTNofwsv+d0Lz8WjsCPaEiovFCQNMUgSpMIRYZpzR2hCFgyYyKzr5Z//GdCL7CRepO3xPYOiUeI/8zR9o4egkmQDpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZ67t6MD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/yJcuYC; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZ67t6MD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/yJcuYC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79DFB1400123;
	Thu, 25 Sep 2025 01:39:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 25 Sep 2025 01:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758778759; x=1758865159; bh=oYUQAbfG+u
	9QLLY17U8KAmpTM2sQmw8bHEXU41SrIoc=; b=bZ67t6MDs0k/9/NkloK43do/sm
	6a639y+B2mNwiDvYE8SXaZaN9oPLi1E8kZzcYMK9/BLTUXn5ROq+0YTb982pT2eU
	uMD405wFS10Va5UlB4voWA+sFWX54rBYgviRuQVoS0qbjl16oeeR7ClzCYgvxQUQ
	NfNfI1tY18oo2nHRVBMejI26KYQ6WiPG9Wgvvf75d4nfeOf6Q1SGv5cAADWz3z9Y
	Xtqg6mshcXlrtWak+gA+ZBzpkOp/bkv4QDzaS/BZXxEjEqcqc3gLC5ueEHhTlmd0
	XGke0F1u2ppJcU+UJ0HndZs3c7lNObIHLqJvihk72bWgFFVQSx4VZKq+vCiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758778759; x=1758865159; bh=oYUQAbfG+u9QLLY17U8KAmpTM2sQmw8bHEX
	U41SrIoc=; b=R/yJcuYCVhHH66cDs2jJgbJW7gQOVCWN47gBsNHP2TnOIDvOd6s
	SzIPUan5dzZOTUEqicatxY0mwXXkarikEDqeUNZP1Wtj/yUhE+hC/g7Q6ft4zPmF
	CoQJs5xYm0xmL9aProwtf5Dv6q8Kp4biIJqM2gTlyduzQdq7gwz6T3mJnrQ82Qav
	VCGIDZCO3FHLSRKW0hnmo8PwSlhx0dLMioX6vIFj6nyRK385cjlL44u0Mfew78On
	ffDQkECMGQ+JQsX93Rv/1Bo7DCwMov6GzLomgUrwtzHNrZXf8Xlxmn7bpWwfBSXU
	iNv3eHIILCVZN+77+mh70GaV8vdvXtCEZrw==
X-ME-Sender: <xms:h9XUaBHE_lJz2yFaosPoSxqrigFNe6A_EZbzyiFrx_o2hrOP3DOnUw>
    <xme:h9XUaNy4Hmr70Itp6RRa8zfn8haSA0uINjEOPjS9vSuPMl0YhLY4LHL0aJ90IsyOn
    BU4SJi3lgYWfi9XvEgur_EAAnQxwwEofRITt6d6c7KyzOi-9ShX-g>
X-ME-Received: <xmr:h9XUaAhmeDCCkDLnN-WFLYOyD0YF6hyYMVRXdsBEuCcQXMJGR0YPZjRj97b0Zr2b1v2vdfrfi2EvcseZIJP6YYKH369jtR8qestqkfkUga0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:h9XUaAwlGbdgJ04GP5sN9ISY4Pw6Tz70UV9bNJ_x0_tnk2ELkmzMCQ>
    <xmx:h9XUaLIJb4aNFbdcBj-HySgt-rzVJyWRaAL9DvlfoV4q6KPPyEXXsA>
    <xmx:h9XUaPSNplaRF4RvKUnFGs74O3GIxYh7ZfAIdRkzCf6bzgn60kxGxQ>
    <xmx:h9XUaLqyNmsSG7bBPlot9CEbs_6ddhAZhAQ_mcSTY0NJarLvzRLUvQ>
    <xmx:h9XUaOO-hTcStbw6Si3vmyMxnY8qSOhiSVzJsvRMAJ-IRnlM6QAj8ElZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 01:39:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 436ec8f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 05:39:18 +0000 (UTC)
Date: Thu, 25 Sep 2025 07:39:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 6/6] builtin/repo: add progress meter for stats
Message-ID: <aNTVgnEGE2qUwZwK@pks.im>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
 <20250924212426.2930029-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924212426.2930029-7-jltobler@gmail.com>

On Wed, Sep 24, 2025 at 04:24:26PM -0500, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index fe7d43f78e..fdc8af92dc 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -344,8 +345,14 @@ static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
>  	strbuf_release(&buf);
>  }
>  
> -static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
> +static void stats_count_references(struct ref_stats *stats, struct ref_array *refs,
> +				   struct repository *repo, int show_progress)
>  {
> +	struct progress *progress = NULL;
> +
> +	if (show_progress)
> +		progress = start_progress(repo, _("Counting references"), refs->nr);

We tend to use `start_delayed_progress()` so that the progress meter is
not displayed when the action takes less than a second. The delay can be
disabled in our tests by using `GIT_PROGRESS_DELAY=0`.

> @@ -365,13 +372,24 @@ static void stats_count_references(struct ref_stats *stats, struct ref_array *re
>  		default:
>  			BUG("unexpected reference type");
>  		}
> +
> +		display_progress(progress, i + 1);
>  	}
> +
> +	stop_progress(&progress);
>  }
>  
> +struct count_objects_data {
> +	struct object_stats *stats;
> +	struct progress *progress;
> +};
> +
>  static int count_objects(const char *path UNUSED, struct oid_array *oids,
>  			 enum object_type type, void *cb_data)
>  {
> -	struct object_stats *stats = cb_data;
> +	struct count_objects_data *data = cb_data;
> +	struct object_stats *stats = data->stats;
> +	size_t object_count;
>  
>  	switch (type) {
>  	case OBJ_TAG:
> @@ -390,17 +408,24 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
>  		BUG("invalid object type");
>  	}
>  
> +	object_count = stats->tags + stats->commits + stats->trees + stats->blobs;

We have this computation in two locations now. Maybe we should
deduplicate it via something like:

    static inline size_t stats_get_total_object_count()
    {
        return stats->tags + stats->commits + stats->trees + stats->blobs;
    }

> @@ -417,8 +442,12 @@ static void stats_count_objects(struct object_stats *stats,
>  		}
>  	}
>  
> +	if (show_progress)
> +		data.progress = start_progress(repo, _("Counting Objects"), 0);

s/Objects/objects/

> @@ -432,10 +461,12 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
>  	struct repo_stats stats = { 0 };
>  	struct ref_array refs = { 0 };
>  	struct rev_info revs;
> +	int show_progress = -1;
>  	struct option options[] = {
>  		OPT_CALLBACK_F(0, "format", &format, N_("format"),
>  			       N_("output format"),
>  			       PARSE_OPT_NONEG, parse_format_cb),
> +		OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
>  		OPT_END()
>  	};
>  
> @@ -444,8 +475,11 @@ static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
>  	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
>  		die(_("unable to filter refs"));
>  
> -	stats_count_references(&stats.refs, &refs);
> -	stats_count_objects(&stats.objects, &refs, &revs);
> +	if (show_progress < 0)
> +		show_progress = isatty(2);

Makes sense.

> +	stats_count_references(&stats.refs, &refs, repo, show_progress);
> +	stats_count_objects(&stats.objects, &refs, &revs, repo, show_progress);
>  
>  	switch (format) {
>  	case FORMAT_TABLE:

Should our tests be updated to verify that we know to print progress
depending on whether or not `--progress` is passed?

Patrick
