Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC03C2E
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785715722; cv=none; b=LUyMjlUpfM6yavjN+4iSnlDjjMwjDVDl2hP5aNjCMZCk7/f8T38aHgVKWEc6WXowxUvDGmKliQpDfm9RJ8aP9maQ0msUWva7UNdP8JTvm7ctNNjmLXvJEREWKO2dDzsv0zvIrIJotFC36QkTUXPVATpUtQfuKQ9TU360MJSaehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785715722; c=relaxed/simple;
	bh=CXr8X9uTFuXfDFANogLoz8qp+0wxS6QQEGG9YMunqKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tMhwYFrEtZ9t4DvxaHUkgbCnZGvWt0HAtCkq3VHmXvlEl4uEI0iZEOt2uC/Qtc208Cd56NGNWC9dlGnqXtdEIkZkIRIhCHjAwqtwG/SHnryC7x68Njx/s4o+z4LZkMlzud6OXobm0i0htB32XUzf4v4gnn7O6tZxHwgW5tqCel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KLqGpxlo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OJ27c7i3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KLqGpxlo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OJ27c7i3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 12EDC1D00072;
	Sun,  2 Aug 2026 20:08:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 02 Aug 2026 20:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785715718; x=1785802118; bh=fFcSk6lU8n
	pUSCY+1wVjGfsM/2QG/6VqugMGGLVlYWw=; b=KLqGpxlohy+unIfZ+ZnXb0O30W
	PYfevGPH0Jj3g+xbS+1izOJaTGSeG4Sdp/TBAWtyZ8DjlMZHTBZFH9QLGAW9fVSL
	ayfTymHJ1FDrUH97ENWe3cg/RJ8SH3wRQCR0zaNo6WJodcPrYcGbqV33mat6ux0F
	Iuihv+WfnJq7V1DFjpOc2Nlrfy2kwB5ho8NaXyYw4IHCHagOOKpk6u1V0SzEFlAx
	1kLoSoOf5jSKnV21OazO9hNI3pvvdD66y/E+vga8uChvRhGYu5CwNSbr28OtuCKN
	bkSCrjErcuK1P4qOeDMhzosFlbFmSNcUnBhfzwjW+hvjuM4W4TYeh8hUzaDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785715718; x=1785802118; bh=fFcSk6lU8npUSCY+1wVjGfsM/2QG/6VqugM
	GGLVlYWw=; b=OJ27c7i3VFw1prmpajWCFIlrZj6f16Kv9fd41fUTQ4hSgmWHhhD
	RsRtbV2YsqECYWFbAxMtua8uY7+MxhnQDHjEnAMqZTBs/5Qwe5RobycgeQLZ3UQx
	FMM+cpX5HQtrw1ltqyy8at7NO4V5D4Nx/K6guyw7FqqdsrM6O2MAn1kw+uj+3+nd
	AXUTlRaVS9EcD/UYyAviNfpWPQ7rgJBNZmc9tat8e8F5c3rX76gS7cBgznxcGjQi
	MnVdzp1VS8Xw98e2+Xh/lUe0H+HB72TygHYDihJjrELlwXp2b6KEY+zZ7F6VyD9O
	sWvq9pig2cHwTy6VoiFEsGBy8hbcoFNshjw==
X-ME-Sender: <xms:BtxvapmzcvqFqPcA-4v5tfGiI6MaKdO94_7HpmIMC6xne8CSH2tqcw>
    <xme:BtxvarvUagq1EY7m4benmjpLDEkD0ML_3DCkt4be5D4j76eyDno_wNq9kj5skHwko
    UTctD6vQXyQyx5r54B8MonjjM_ZDKHIlJwiQJ2ekFTDJqgD0hIZvQ>
X-ME-Received: <xmr:Btxvan8oE1RlxsGjz4jMqqCTwCiWoCNekvj366qDo4JwGffqhq6VBt18-Q6hBZZo1mBxyn9HpxFu2LlyQNpKrGp09xbK-dbT3w>
X-ME-Proxy-Cause: dmFkZTFucCiK2YtTLEChXFdoj7ffxH+k61ZqSclLfVxkqx4U1il1lSm3Y19DucRaTAOiI8
    1oAgoqb34Xlk/Zmr099XHkC7fuNg/1ZRxlkuWKy13qVjzfK1b2ttPUPCpPIztNRNIjdLNU
    gS2hHXDvaL6X8tXQibclCYlJwDjKYBxSZDQk6xXmopz7IuYyFRTLDUvkNmufVcdk6g/hgt
    DBHaHOZfx0PgKRF+diG32vJwSPNU/rDf//IER5Ilc2Xxu2v309b+A9GzAK/9GlzL0sg55e
    XR1WBojOVnkLU8yRvBuKMVM4mq7+v+UYybsWsxm7oM7sAEgShxarX9ES/s3oyjgvcG6iNK
    gL9WARGupQ25IjspJmDklG9RtCEhic8Tu21X0b3bzC60rwT/HNo28trso854ZHTuBZA6NN
    H/tNSnZVIr2KVl7CB4IsZdTJtqcu/MUv34krmjpwsB0qKJWdF1ZQ+tMuRhH9y1XacKyHFJ
    33FWXx3UkwrkMGk1h4NtUIcGltuvN/h5T8nfnI9ik05p/A8K4WwIBpLimOZ0ptPfbyI2Vf
    NcKBMAKXbksXlM7iEf3O3bwI/kxz7FE2FmoKIkvJ42RoTgtKtZaXBzCgLDn2rN0AM44oIz
    w5lLCi57xUMMGthOrX879s8SMhtLTu89PJydFuT0bcvErbBdfBU6WeiepsTA
X-ME-Proxy: <xmx:BtxvalOCP_-S81RKy1hiIzX3mXifuDEWSMWeOh9BQai7cZMOa_xTlA>
    <xmx:BtxvalHMuhDPfuECFgbGIositM37WWjSpgYvm9XhHh7mZLUhM52K2Q>
    <xmx:BtxvajQewo81XjRStLx5JQh7JFSs1ubeWw02YR7a9EevoLA62Pjicw>
    <xmx:Btxvaivc8uLZsIYPit5YevNYEm6TTuwziL6a4gOhIQkHkfP9KxBlIg>
    <xmx:Btxvag9nkZCtml5J_TWgsyFvnmhiJTVJUmvZ5DoKVfKshScZB3usnc3X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Aug 2026 20:08:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v6 2/2] bisect: add --reset-when-found to leave when done
In-Reply-To: <97a4da55374c6dc52e6e990b3cadfaaa86a57640.1785705860.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Sun, 02 Aug 2026
	21:24:20 +0000")
References: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
	<pull.2335.v6.git.git.1785705860.gitgitgadget@gmail.com>
	<97a4da55374c6dc52e6e990b3cadfaaa86a57640.1785705860.git.gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 17:08:36 -0700
Message-ID: <xmqqjyq812wr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -269,7 +276,79 @@ static int bisect_reset(const char *commit, bool quiet)
>  	}
>  
>  	strbuf_release(&branch);
> -	return bisect_clean_state();
> +	return 0;
> +}

Let's make a mental note that the intenral "bisect_reset()" no
longer calls bisect_clean_state(), so those that call this function
would eventually need to call it to compensate.

> @@ -682,7 +761,8 @@ static int bisect_successful(struct bisect_terms *terms)
>  	return res;
>  }
>  
> -static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
> +static enum bisect_error bisect_next(struct bisect_terms *terms,
> +				     const char *prefix)
>  {
>  	enum bisect_error res;
>  
> @@ -705,7 +785,8 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
>  	return res;
>  }
>  
> -static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
> +static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
> +					  const char *prefix)
>  {
>  	if (bisect_next_check(terms, NULL)) {
>  		bisect_print_status(terms);

The above two hunks are pure style clean-ups.  When having others to
review a 500+ line patch, you would want to omit them or move them
to a separate preliminary clean-up step, to avoid distracting them.

> @@ -1246,13 +1344,36 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  {
>  	int res = BISECT_OK;
>  	struct strbuf command = STRBUF_INIT;
> +	const char *reset_when_found_arg;
>  	const char *new_state;
>  	int temporary_stdout_fd, saved_stdout;
>  	int is_first_run = 1;
> +	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
>  
>  	if (bisect_next_check(terms, NULL))
>  		return BISECT_FAILED;
>  
> +	if (argc && !strcmp(argv[0], "--reset-when-found")) {
> +		reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
> +	} else if (argc && skip_prefix(argv[0], "--reset-when-found=",
> +				    &reset_when_found_arg)) {
> +		if (parse_reset_when_found(reset_when_found_arg,
> +					   &reset_when_found))
> +			return BISECT_FAILED;
> +	}
> +
> +	if (reset_when_found != RESET_WHEN_FOUND_NONE &&
> +	    refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
> +		return error(_("options '%s' and '%s' cannot be used together"),
> +			     "--reset-when-found", "--no-checkout");
> +
> +	if (reset_when_found != RESET_WHEN_FOUND_NONE) {
> +		write_file(git_path_bisect_reset_when_found(), "%s\n",
> +			   reset_when_found_mode_name(reset_when_found));
> +		argc--;
> +		argv++;
> +	}
> +
>  	if (!argc) {
>  		error(_("bisect run failed: no command provided."));
>  		return BISECT_FAILED;
> @@ -1327,7 +1448,6 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  			res = BISECT_OK;
>  		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
>  			printf(_("bisect found first '%s' commit\n"), terms->term_bad);
> -			res = BISECT_OK;

Now whoever called bisect_run() can react to 1st-bad-found but it is
their responsibility to report that overall bisect was OK to their
callers.

> @@ -1344,10 +1464,15 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
>  static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED,
>  			     struct repository *repo UNUSED)
>  {
> +	int res;
> +
>  	if (argc > 1)
>  		return error(_("'%s' requires either no argument or a commit"),
>  			     "git bisect reset");
> -	return bisect_reset(argc ? argv[0] : NULL, false);
> +	res = bisect_reset(argc ? argv[0] : NULL, false);
> +	if (res)
> +		return res;
> +	return bisect_clean_state();
>  }

Everything contained in this patch to enable --reset-when-finished
are exactly as expected and very understandable to me, but this bit
was a bit hard to grok.  Let me think aloud to see if I can explain
it.

 * Lower level bisect_reset() used to almost always called
   clean_state(), but except when it returned error().

 * Now bisect_reset() never calls clean_state().

Hence, somebody has to call it in the new code.  The above change is
an example of doing exactly that.  If bisect_reset() returns an
error, we refrain from cleaning the state.  If it succeeds, we clean
the state.

Earlier we saw that bisect_reset_when_found() does the same thing.
If bisect_reset() did not fail, it called clean_state().

Both make sense.

>  static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
> @@ -1489,7 +1614,8 @@ int cmd_bisect(int argc,
>  		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
>  			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
>  				       options, argv[0]);
> -		res = bisect_state(&terms, argc, argv);
> +		else
> +			res = bisect_state(&terms, argc, argv);
>  		free_terms(&terms);
>  	} else {
>  		argc--;

What is this change about?  We used to see if the given terms
(bad/good) are sensible and otherwise barfed with usage_msg_optf()
that never returns, so we did without "else".  With "else" you are
making it more explicit.  The value of such a change is debatable.
Some would say that, just like 'if ... die()', it is already
explicit enough that 'if ... usage()' never returns and does not
require an "else".  Some would say new readers may not know die()
and usage() do not return, so "else" makes it more explicit.  My
stance is that we should not optimize our code for total newbies
[*], so I may have a mild preference for the original over the
updated version, but it is minor.  In other words, I would not mind
if an author wrote this either way in new code.

However.

If an author is adding a new feature, I would recommend against
making such a change that would only force reviewers to read more
and think more about the change.  Do not waste reviewers' attention,
which is a precious resource, to something much less relevant for
the goal of your topic.

> @@ -1497,5 +1623,15 @@ int cmd_bisect(int argc,
>  		res = fn(argc, argv, prefix, repo);
>  	}
>  
> +	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
> +		enum reset_when_found_mode mode;
> +
> +		if (read_reset_when_found(&mode))
> +			res = BISECT_FAILED;
> +		else if (mode != RESET_WHEN_FOUND_NONE &&
> +			 bisect_reset_when_found(mode))
> +			res = BISECT_FAILED;
> +	}

Are there "dead end" states, other than '1st-bad-found', in which we
can no longer make any progress?  One thing that comes to mind is
"you said this one is good, but that contradicts what you said about
its ancestor that you said is bad".  I wonder if we want to do
anything special here, just as this part of the code handles the
'1st-bad-found' state, for such "dead end" states.

This is just for my own education, as I am pondering possible future
extensions.

>  	return is_bisect_success(res) ? 0 : -res;
>  }

Overall, the patch looks very nicely done, except for a few minor
nits that made my reading hiccup while I was reviewing this round.

Thanks.
