Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894B26E96F
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697409; cv=none; b=lzEJM3Ca9qckgG5GVUnu9igZaYsmQ91aYR0z9u7nOe9IqQPDslstMQcA7YRRgHq9F7ip8q28D0S26GszmYuuMI3KLdd4NCu5+4W26QjXnzqZtigKS66D4foRhj6u+GS1FVwzUpSvzD5MWJZfjetly5zEG0Omz+BYxAgFcjfwxoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697409; c=relaxed/simple;
	bh=/JL0HhCTLm544ff14rj78Hwm/3r1nwiOcBr3O9JcPB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJSxy8olWZ85cogD7vayea9++Z4VPUB29hgZzKsSbdzHXHoCpR8890+S6POgrj6Lwyp59aj2GDZYXCfaFh2nGEZ4G7Pb6DnOn66tfkgsVZwEXVyk0ha10b0xBGgHQ/bkxoo1aYFnt0muUCUC2kee2Ci2E00kSFhtiptYGNV3L+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3eThmde; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3eThmde"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso1383760fac.2
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740697407; x=1741302207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eqM72DJ1LwP7d8XcQCdwgGO+l7FRoY9LnmMAflbKfdY=;
        b=O3eThmdeqlO5zeldqkHF+W2TUVFaW7R2ZadNyP/UM6NRadHys1nT17K4nPLqPztd5p
         sowKmfPrJUKrkz9fXML71RHsf6lm2potAjEzVzQ0N4099dVeFC7A+yurNoehZnLGNvyC
         2Lx9HhdoGPoErhhwc8dk7qQ3ldlHlt5RRKUbk+HscVkVWCu2am9g1Ht/3yKi9tn01Yr+
         H6GHwcodt53YDJa5N+uAhPhwGnXrIwrcgEheMgP+Th0m2Ro9PsJQkkxlpsNfkFccs/6y
         P6Zomy0N79D5IYJ/AgtDkiF/bwLR18A1rXs+iMAlzaEi/ytHZPJkPSxnxyG9OrTWiN8N
         tj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740697407; x=1741302207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqM72DJ1LwP7d8XcQCdwgGO+l7FRoY9LnmMAflbKfdY=;
        b=pM0rs+cYR/epYnX/TrzSn6Kir73BsLBlYfxc30GkTO0dp1ccpkFI/bYHYlp0VQBQBk
         yeKiFRmu+wk9I0PmAqY1PTOpv+NSucIpDlS2SwevRbzgtR47NSkiCNFQjkvukhau0vvb
         qAo8HukKB4AZg6xUFNlbuHNbtUJbbnE817K3eW+RYgX3GJgx1c+6WqK2BBQyG5U663R0
         6KcOWsd9b7P8WHrxvoHK06cnmbh0UJ1GlO8kW3e0DoMQQbID5F1RGrjjmWFQm6sQYy6+
         3TRD5cvvecNxVzuHmMf+PwSiFEv4jk1fRRAkIoNciJxZepYqbzwa3n1mtdgeDo+PsQ2J
         EGxQ==
X-Gm-Message-State: AOJu0YwQwg7eFDdDAWSopqCz2GikcRcGKYWu8hQYU2o/K1xMX58e5jbB
	qjTcRs2mJRKzRCCDE92+RSSVUyPTWtVJrbf6hJObXQyh0Xxk32xVBGJWfsB4
X-Gm-Gg: ASbGncuklOIq2egpakP5w+jrP9BGgYXVL1AS5ZuASv+aApSwq4GZPt7pFdc6Mi5u86V
	bjurHwVQztUGS3mWknN06PbkZ7Q35u6UXjwwrOO4Q81RrVOI83Xga5UO0ypHfh4CV4iVsw30h2i
	ZSUbWc7YXhp0YbnuZm3j7SB5gyVW6eLHO8gwxqZZjI6g7Y6VEoBAm4+B4XCep3Uti33wAxRNFtE
	tMbp1N8GMlyS7//isju4A6sVoC3jlReh7ZWr8p3f7u/w8Blykl37urv77E4xlsJNcA5yHAkocZ5
	vuaxxRMmMEwcGfQ1L+U=
X-Google-Smtp-Source: AGHT+IF4GfSMadSILpJaslSlRWOQ+GPs7f8xe7g4NfKCP3Nb3DU6+qUuB7tLSboWuSbUHw9DYxQZbA==
X-Received: by 2002:a05:6870:ae8b:b0:2b8:e4be:fd2 with SMTP id 586e51a60fabf-2c177e7a05amr659279fac.0.1740697407285;
        Thu, 27 Feb 2025 15:03:27 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c15c125362sm478537fac.17.2025.02.27.15.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 15:03:26 -0800 (PST)
Date: Thu, 27 Feb 2025 17:00:10 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com, phillip.wood123@gmail.com, 
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/3] builtin: introduce diff-pairs command
Message-ID: <qnd5cou3mhareqvxhndgwkomn7t3kwdn3xd55wqn6vidly33uk@5yq4cv2yfnbh>
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
 <20250225233925.1345086-3-jltobler@gmail.com>
 <Z8Bg5EAArZVGPaAc@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Bg5EAArZVGPaAc@pks.im>

On 25/02/27 01:56PM, Patrick Steinhardt wrote:
> > +static void flush_diff_queue(struct diff_options *options)
> > +{
> > +	/*
> > +	 * If rename detection is not requested, use rename information from the
> > +	 * raw diff formatted input. Setting found_follow ensures diffcore_std()
> > +	 * does not mess with rename information already present in queued
> > +	 * filepairs.
> > +	 */
> > +	if (!options->detect_rename)
> > +		options->found_follow = 1;
> 
> It's a bit weird that we set this over here. Shouldn't we have set it up
> in the main function already?

Everytime diffcore_std() is invoked found_follow gets reset. This was
included here to ensure the correct value is always set.

In the next version I am going to move away from using found_follow in
favor of a new diff_options field to avoid some of this awkwardness
altogether.

> > +	diffcore_std(options);
> > +	diff_flush(options);
> > +}
> > +
> > +int cmd_diff_pairs(int argc, const char **argv, const char *prefix,
> > +		   struct repository *repo)
> > +{
> > +	struct strbuf path_dst = STRBUF_INIT;
> > +	struct strbuf path = STRBUF_INIT;
> > +	struct strbuf meta = STRBUF_INIT;
> > +	struct rev_info revs;
> > +	int ret;
> > +
> > +	const char * const usage[] = {
> > +		N_("git diff-pairs -z [<diff-options>]"),
> > +		NULL
> > +	};
> > +	struct option options[] = {
> > +		OPT_END()
> > +	};
> > +	struct option *parseopts = add_diff_options(options, &revs.diffopt);
> > +
> > +	show_usage_with_options_if_asked(argc, argv, usage, parseopts);
> 
> Don't we also have to call `parse_options()` even though we don't have
> our own options yet? Or is this all handled by `setup_revisions()`?

In the current implementation, the diff options that get appended are
only really used so that the usage message prints with the diff option
info. It still relies on setup_revisions() to actually parse the
options. Since there are not any real options that need parsing,
parse_options() was not invoked.

This is fairly confusing though. I plan to instead parse the diff
options upfront with parse_options(). The diff options parsing through
setup_revisions() becomes effectively a no-op. I think this makes more
sense to read and still lets us print the common diff options is the
usage message.

> > +	repo_init_revisions(repo, &revs, prefix);
> > +	repo_config(repo, git_diff_basic_config, NULL);
> > +	revs.disable_stdin = 1;
> > +	revs.abbrev = 0;
> > +	revs.diff = 1;
> > +
> > +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> > +		usage_with_options(usage, parseopts);
> 
> I think it's discouraged nowadays to use `usage_with_options()` as it
> generates a ton of noise while hiding the actual error message. It is
> instead recommended to directly call `usage()` with an error message.
> 
> In this case here we would say e.g. `usage(_("unrecognized argument:
> %s"), argv[0])`, in the cases below we'd use the error messages you
> already have.

Good to know. I'll avoid printing the usage options message in all these
failure scenarios in favor of what you suggested.

> > +	if (!revs.diffopt.output_format)
> > +		revs.diffopt.output_format = DIFF_FORMAT_PATCH;
> 
> Instead of setting this conditionally, can we already set it up as a
> default before calling `setup_revisions()`?

The diff output format is set via OPT_BITOP() and thus can have multiple
values at the same time. For example:

  $ git diff-tree --raw --patch HEAD

will render both patch and raw output. If we unconditionally set
DIFF_FORMAT_PATCH, it will always be included in the output which is not
what we want. We only want to set DIFF_FORMAT_PATCH if there is still no
value after all options parsing has occurred.

> > +	while (1) {
> > +		struct object_id oid_a, oid_b;
> > +		struct diff_filepair *pair;
> > +		unsigned mode_a, mode_b;
> > +		const char *p;
> > +		char status;
> > +
> > +		if (strbuf_getline_nul(&meta, stdin) == EOF)
> > +			break;
> > +
> > +		p = meta.buf;
> > +		if (*p != ':')
> > +			die(_("invalid raw diff input"));
> > +		p++;
> > +
> > +		mode_a = parse_mode_or_die(p, &p);
> > +		mode_b = parse_mode_or_die(p, &p);
> > +
> > +		if (S_ISDIR(mode_a) || S_ISDIR(mode_b))
> > +			die(_("tree objects not supported"));
> 
> I assume submodules aren't supported either, are they? If so, do we also
> have to check for `S_ISGITLINK()`? It would be nice to have a test for
> them.

Submodules should actually be supported as I believe all the info
present in the raw formatted input should be enough to properly display
patch output. I'll add a submodule to the existing test setup to
validate.

Thanks
-Justin
