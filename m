Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A711E9B2D
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806171; cv=none; b=sY2I4LrXo9QP7LYjm+kaim41zP2UQ/UvzhWEq3n+9w3ELQOrgiaToc7EHmXRkNnqthPCt8L/k6LHye7PoU197K5nMiPWEHD0v6e509OqhLnlIjYS5VO2ZGXcSqXoZnMtUWcjxjdA4yILX7NYCMQ5SymHrBxB/UwdCiMbhuqBsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806171; c=relaxed/simple;
	bh=gCzvoOP3L32DLCX1rY//TuRD4vp/g5nSd7nFNP8FSfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTOsRlCkbPJ8QEtkfjypd23SNiq4+e1/gcTrgkhyA9UOcL4vVXcGhBWmdzyUwtdWVK+guDMQJ4bwNm2aPFOfG+hEoXr5uAaHfoLBPQXsrBUqqC9J1s80CDMersquEgSJfNHpgHX+ftHzGDFc4KfUfpclychmivqO+BgEiOfU1uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex5InwCO; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex5InwCO"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce872d9cso943392fac.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758806167; x=1759410967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Sqg1iSNgzJ1RVVQiVjp7LIs70fyPzhAIppjGZEg3U=;
        b=ex5InwCO01Vbd5QIu29uH7bzhwCTIimDLZ2eT+2WBhZcsYY9JDVXFcR9hMMtqo8skC
         GrtboAH2oDdLWtPtbbDLZZ4w2CLEu2NoUW6QLvkNozDbM20hqml5MaNiKpVRBXqzPfUb
         8FnS8f4G8Cff1v712PyeVnPji+FpqgXuOytGh+sLevEX98Gcf75EjxQcDj+iNw0TsW4A
         k10TzhtPZkn5Qcn+8Hj8j/wz+bBb7E5SDWFlPopCh4dEt2tydJL7IPdHmqEYKD9PrJIT
         gVmDvtt8kc3dfp7YAuA2pTmu/uzwizKJtIqmsp7dQeYNgTuwNTj8O7EOlU5PzCKk60Nf
         R1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806167; x=1759410967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1Sqg1iSNgzJ1RVVQiVjp7LIs70fyPzhAIppjGZEg3U=;
        b=h5606rualocQEK9mohRfyjy+6CQCjD6xGGBaM4BGgn8FCfVFRF8oqii6fBm0/W5q7S
         NixBtCDyd4+rgpa0eUb6IqHFtxVebDSYZeYxlxvBwAK85tuwSbq8Yt0HGJDlYxqs1wY4
         La9yKaVCofu8U3Z8+OBOvnuDoaqs16D6WUv4tur8kXmDhU6s0Cs3pu7T38UIuHbffVMX
         fnguxFVBjQqvKhpvKFzHTqXMDhClY7VG260mOjbi3wgvWnULjXpyM5P1SzBs6VjfNGJz
         92iRofWz0aBj1H7GS2U7uXKVv4jPAwYIg7prNHp+MPlpgNSgcsARZwiMjP8ify8mMsCP
         fHbQ==
X-Gm-Message-State: AOJu0YydGuUFebpqc2oxxbPixsNiz4flu4H9sjLgHWMLw0jbTjJ34lVm
	MDwIE9Xa5E+2Wrp+xEphLUKZVs6R52uUVSip1SXXMwT7Enxc3ZEo19cj
X-Gm-Gg: ASbGncur9zKPqyEconxwQRc+xNRtO+bTlZdWBDHM+HOgQD/767gYgC+CowMyvEFFH7c
	430bc5ZiyVQqNFyZcEITmCpK5hJP6ywxaCLsU5P9LD6LnZKntAcYAahRVBctA+q3qpfrkHCx0uJ
	kekHdW3+lmzA7k5KUoke17g4WRwtOC4lVkQOg2CRSAjQ5dhNn+efWuiieqe03pGJnEjBGHsO4qV
	we7z4Uyjfq3JnCAM1f0WTEVHXtSneeIzAHPr1zstTCIiHn1uSPg/laKruil+3vAMKfIr0rwLUMU
	Jazxzf176sUqFangVLbpYF4tBL0JHK+HM4gIwFizBAO9ttnMq+tE1ZYsJ5swTHamwKY+CqN39Y+
	w+3ljlQVwRgCwKJu9
X-Google-Smtp-Source: AGHT+IE8zSd7HHZLbhRfTL4tGw3SnsB4wsLKgHs902hADTM3q17b7DL9IZ37BJiQ+iR5ClPgx5Tmyg==
X-Received: by 2002:a05:6870:b529:b0:347:bd94:8d12 with SMTP id 586e51a60fabf-35ec0b32902mr1505972fac.19.1758806167321;
        Thu, 25 Sep 2025 06:16:07 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-363a3d46f3fsm557935fac.9.2025.09.25.06.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:16:06 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:16:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 5/6] builtin/repo: add keyvalue and nul format for
 stats
Message-ID: <lqzdrznf6kynr35eo74zodbfeofj6hnmskm2wqk6ty3o7wwaci@nyytil34eyzq>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
 <20250924212426.2930029-6-jltobler@gmail.com>
 <aNTVdy4hhLDlMpVT@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNTVdy4hhLDlMpVT@pks.im>

On 25/09/25 07:39AM, Patrick Steinhardt wrote:
> On Wed, Sep 24, 2025 at 04:24:25PM -0500, Justin Tobler wrote:
> > diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> > index 0b8d74ed3e..db21b75522 100644
> > --- a/Documentation/git-repo.adoc
> > +++ b/Documentation/git-repo.adoc
> > @@ -52,7 +52,26 @@ supported:
> >  * Reachable object counts categorized by type
> >  
> >  +
> > -The table output format may change and is not intended for machine parsing.
> > +The output format can be chosen through the flag `--format`. Three formats are
> > +supported:
> > ++
> > +`table`:::
> > +	Outputs repository stats in a human-friendly table and is used by
> > +	default. This format may change and is not intended for machine
> > +	parsing.
> 
> Let's mention that this is the default format.

I didn't mention that it is "used by default", but I think the wording
could be more clear here. Will improve in the next version.

> > +`keyvalue`:::
> > +	Each line of output contains a key-value pair for a repository stat.
> > +	The '=' character is used to delimit between the key and the value.
> > +	Values containing "unusual" characters are quoted as explained for the
> > +	configuration variable `core.quotePath` (see linkgit:git-config[1]).
> 
> In the current state there is never any quoting, so this statement here
> is a bit misleading. Should we maybe drop that part?

While there are currently not any values in the output that would
require quoting, I'm inclined to leave this note in the documentation.
That way we set the expectation regarding how parsers should handle the
output from the start.

[snip]
> > +static void stats_keyvalue_print(struct repo_stats *stats, char key_delim,
> > +				 char value_delim)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +
> > +	strbuf_addf(&buf, "references.branches.count%c%" PRIuMAX "%c",
> > +		    key_delim, (uintmax_t)stats->refs.branches, value_delim);
> > +	strbuf_addf(&buf, "references.tags.count%c%" PRIuMAX "%c",
> > +		    key_delim, (uintmax_t)stats->refs.tags, value_delim);
> > +	strbuf_addf(&buf, "references.remotes.count%c%" PRIuMAX "%c",
> > +		    key_delim, (uintmax_t)stats->refs.remotes, value_delim);
> > +	strbuf_addf(&buf, "references.others.count%c%" PRIuMAX "%c",
> > +		    key_delim, (uintmax_t)stats->refs.others, value_delim);
> > +
> > +	strbuf_addf(&buf, "objects.commits.count%c%" PRIuMAX "%c",
> > +		    key_delim, (uintmax_t)stats->objects.commits, value_delim);
> > +	strbuf_addf(&buf, "objects.trees.count%c%" PRIuMAX "%c",
> > +		    key_delim, (uintmax_t)stats->objects.trees, value_delim);
> > +	strbuf_addf(&buf, "objects.blobs.count%c%" PRIuMAX "%c",
> > +		    key_delim, (uintmax_t)stats->objects.blobs, value_delim);
> > +	strbuf_addf(&buf, "objects.tags.count%c%" PRIuMAX "%c",
> > +		    key_delim, (uintmax_t)stats->objects.tags, value_delim);
> > +
> > +	fwrite(buf.buf, sizeof(char), buf.len, stdout);
> > +	strbuf_release(&buf);
> > +}
> 
> Same question here regarding the buffering. Can't we print to stdout
> directly, or is there a reason not to?

Ya, we can just write to stdout directly. Will update.

> > @@ -389,17 +421,25 @@ static void stats_count_objects(struct object_stats *stats,
> >  	path_walk_info_clear(&info);
> >  }
> >  
> > -static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
> > -			  const char *prefix, struct repository *repo)
> > +static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
> > +			  struct repository *repo)
> >  {
> >  	struct ref_filter filter = REF_FILTER_INIT;
> >  	struct stats_table table = {
> >  		.rows = STRING_LIST_INIT_DUP,
> >  	};
> > +	enum output_format format = FORMAT_TABLE;
> >  	struct repo_stats stats = { 0 };
> >  	struct ref_array refs = { 0 };
> >  	struct rev_info revs;
> > +	struct option options[] = {
> > +		OPT_CALLBACK_F(0, "format", &format, N_("format"),
> > +			       N_("output format"),
> > +			       PARSE_OPT_NONEG, parse_format_cb),
> > +		OPT_END()
> > +	};
> >  
> > +	parse_options(argc, argv, prefix, options, repo_usage, 0);
> 
> I think it would be sensible to introduce this call to `parse_options()`
> right in the first commit that wires up the new subcommand. If we don't
> do that we otherwise accept arbitrary arguments without raising any
> error, and neither do we know to output help.
> 
> So we should move the addition to a previous commit and probably do the
> following:
> 
>         argc = parse_options(...);
>         if (argc)
>             usagef("too many arguments");

Good point. I'll add this in the next version.

> > @@ -407,8 +447,20 @@ static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
> >  	stats_count_references(&stats.refs, &refs);
> >  	stats_count_objects(&stats.objects, &refs, &revs);
> >  
> > -	stats_table_setup(&table, &stats);
> > -	stats_table_print(&table);
> > +	switch (format) {
> > +	case FORMAT_TABLE:
> > +		stats_table_setup(&table, &stats);
> > +		stats_table_print(&table);
> > +		break;
> > +	case FORMAT_KEYVALUE:
> > +		stats_keyvalue_print(&stats, '=', '\n');
> > +		break;
> > +	case FORMAT_NUL_TERMINATED:
> > +		stats_keyvalue_print(&stats, '\n', '\0');
> > +		break;
> 
> This reads much nicer now. The newline as key-value delimiter is a
> curious choice, but you simply do what we already do in `git repo info`.

I agree that the key-value delimiter chosen is a bit strange. The
command is still experimental so we could maybe change it if want. Not
sure if it would be worth it though.

> > diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
> > index 315b9e1767..d2c1b6e307 100755
> > --- a/t/t1901-repo-stats.sh
> > +++ b/t/t1901-repo-stats.sh
> > @@ -73,4 +73,37 @@ test_expect_success 'repository with references and objects' '
> >  	)
> >  '
> >  
> > +test_expect_success 'repository stats with keyvalue and nul format' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		test_commit_bulk 42 &&
> > +		git tag -a foo -m bar &&
> > +
> > +		cat >expect <<-\EOF &&
> > +		references.branches.count=1
> > +		references.tags.count=1
> > +		references.remotes.count=0
> > +		references.others.count=0
> > +		objects.commits.count=42
> > +		objects.trees.count=42
> > +		objects.blobs.count=42
> > +		objects.tags.count=1
> > +		EOF
> > +
> > +		git repo stats --format=keyvalue >out 2>err &&
> > +
> > +		test_cmp expect out &&
> > +		test_line_count = 0 err &&
> > +
> > +		# Replace key and value delimiters for nul format.
> > +		tr "\n" "\0" <expect | tr "=" "\n" >expect_null &&
> 
> You can do this without the pipe:
> 
>     tr "\n=" "\0\n" <expect >expect_nul
> 
> Also, let's call the file `expect_nul` (with a single 'l') to match the
> format.

Thanks. Will update.

-Justin
