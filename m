Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222395;
	b=CsUk25GLq8jn4VVmkbloIC34mPvanP5K4FJESEtsyB0jodWjkjnMRaFhiTS1CaqNeUCt
	 +FHWXdal4xVzE6EFm1yiXM/1PSyJNgQF7twGNCjq30iehos7AshnLZ5ho6CmDFPywiuAZ
	 VA+vAJTge1489IOvxUpt28tr7ma+WUyai0bXVuIxzsfyu2kNyWct5cJM6YoW9EF0P0txQ
	 3Z3DjLv3PwRfZ2rG7Qr/xkp7Qnfe8PPIPDl3OxDeo73AqyTsQrrRYXjCzeMxeRGu/NXqt
	 ccChqJFa4yVlnsLv8c8gLXzC6ay2RJHQaGhxyOMxJ4Y6uYoBziC3b+PhqXmA9P8INOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NIl3bQI6qKPNAO8PBylak/nU11zw3CoqmkWBt5Mb0is=;
	b=Ge4LmSXT4mIQWs1WIZ3gsptK4AVdjfLL8KYDOQaNb8wuBrW7KP8kosWNL4uyRHit2EUR
	 oXYDOMaHBL1QHh5dUwXQlXSrc+uDRg5YLQ9b05hVtzyK3C3NiEGkQQJrZ6Vw9jxmfvyn5
	 OuHdMX6oTUKBNcKULoewZcvge8Sh+pamea2cx11DT+Np9OxAr5U9L4fG5rGQ3g7HxF9YM
	 V30g6SlnA53SGp4NY3XNOkO/ZQtAdAW8u2Lgb93sxliZxRZZ0uTBP/+Fn0TYqmiQVd8pI
	 un8IoZwSutkGFO+5PrN4+ukfHecd1KN5Q4rLfAIjm1cA3sChAy+kCvwIyLeQXwnm44g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Zeg/1cpX";
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08E9606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 21:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D08E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zeg/1cpX
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so12140115e9.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793222393; x=1793827193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NIl3bQI6qKPNAO8PBylak/nU11zw3CoqmkWBt5Mb0is=;
        b=Zeg/1cpXIvNPXPv3jIyRMEgBsGSUVlioISG00doNVGzyi0wmWRwKB8ATb3613ukMQn
         FBbuRs/YBIdDeDrWeUluOdhKwBrtCqzUVXSsW05jM47tIqyTw3ztUfzBQMcWu6aqRZUp
         8drGQEC1iZ9LHYclO2+fEfBoeq0JoTjaQI/URWH49onshiBxrbYZld77l+Uc1VdFWXIb
         zgGqrpXS8cvCdVA14PvyFLS2VEZbyvPx6RU9c3mA3K9Il0iFl21b8GNBSke/XZ8oISB1
         M/xtVaunAAjRbAxaxxjHX70GXjtYUH2ZDQ9/dMIbCmsW86GHVHYky3vZkGpH2Y35FgQK
         0Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222393; x=1793827193;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIl3bQI6qKPNAO8PBylak/nU11zw3CoqmkWBt5Mb0is=;
        b=AB+NTE8boycnwxsi3f7xXVKFWa7WYXsPpr+CJzxTvmYRZWWozTRbzFPejl+GxVUP0D
         v1bn8Yhi1mHGMeGgWyFLl4IXcXOMmP4+Vs0vnp+astM4AYt+yQsZBdYwnWsjav44T6/q
         rKEP/vn/QeR6olOl+cFwvjFoQBNMOMjo32EX0CIOZLajJWF8ZuKfk2uYlZwAUmKdDk05
         /yMLAeo7wYu1EPuoHDVwUOghVZsu5rFj/V50DYryNrjwjuU4FiU7l1BrLTahWed1PfyD
         ZpsJ7Bpe7AuFtlCM141Swice9F+GQtR2W5nt28t9/VwO+PsAu54XYERY5Ek5KMg1G85W
         +olQ==
X-Gm-Message-State: AFq9FYKO0LPJf3tr7ezFCwpQhv6ATe/nXsrFe6Bs1sdqf57dLygPlH/H
	ToKopyqRx2T/5kiWCFiQmskeH9k0w0fqfpIPEPHnaDkha7cd/yBxSb4UgPG//w==
X-Gm-Gg: AYBFou3Ah+L72C6EJwcb4v6fTVYktDbvzHh2JZPoKx9aGkoctILMZN2Xt7WsfbVg4pO
	b7IhMLNSbqwGRrwXZ8BWjJFwErvIdhJGT7vK3Dbbmh6Om7T7ttsQiNYlojFzeQP/x7cNJA4a5Rq
	jHsDZaeYglqVA3qrydQRGI7HqaTxPApaa7hWiX3og9BVFlCTOuLnY1jM3dkp3VGI3Bl9xry1cKS
	AsJWadh/G9/AH3NH6sEJP9DXEknrqB62IctX8hdim90HmN8gUUxzTmNTOVnrYGW1/g+EWnj/I0w
	NlPttStct6ADmpESkMUmMoWciVvTl7eYf8F1Ud4DGotHk82O/3YXm8QPuoodAGfF9dMCjxYZ7Mu
	xsPHDbjY3t/7DBFroEH0TbT5rzsGzvCbtitu7bS/zbrZN/So+eT8zGUGF+l00f1a5RXd+z2NSGx
	vGNCc9sqPgYZe7PlR04lMSP5uVyZRJ7cItqeiqv6Mj9JnRFovHuZhsRQ6slMdw73iqb/DX2hBGy
	BMcVC0KC0VV24rH7qfZ9yDHuOOuIXrKE7sAKyXPOsPE7yXRt/otQ0Cw/mmEjn+n/qRQrqNOJzFx
	pi/a7Mn8cS3CFmBLzXHMwKH4Ad3LtEaQnLiB9eP/XhAVUSB22hMVQw==
X-Received: by 2002:a05:600c:a117:b0:4a2:cbe:bec2 with SMTP id 5b1f17b1804b1-4a9672f93d3mr61486715e9.32.1793222393065;
        Wed, 28 Oct 2026 14:19:53 -0700 (PDT)
Received: from localhost (94-21-146-6.pool.digikabel.hu. [94.21.146.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a92e104d8csm44681265e9.0.2026.10.28.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:19:52 -0700 (PDT)
Date: Wed, 28 Oct 2026 22:19:51 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 03/12] refs: stop using mkpath() in refname_match()
Message-ID: <auJm92xzDos9MF+8@szeder.dev>
References: <20261009192953.81794-1-jon@jonsimons.org>
 <20261014031347.50433-1-jon@jonsimons.org>
 <20261014031347.50433-4-jon@jonsimons.org>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261014031347.50433-4-jon@jonsimons.org>

On Tue, Oct 13, 2026 at 11:13:38PM -0400, Jon Simons wrote:
> refname_match() formats every ref_rev_parse_rules entry through mkpath()
> to then strcmp() with its given full_name.  It turns out this formatting
> function dominates the client-side cost of matching explicit refspecs
> against a remote that advertises lots of refs.
> 
> Reuse match_parse_rule() instead to efficiently compare each rule
> against its given full_name.  With this change we avoid mkpath()'s
> strbuf_vaddf(), and each match is now a direct prefix + suffix
> comparison, length check, and memcmp of the refname at hand.
> 
> Timings from the test added in the previous commit:
> 
>   Test                           HEAD~1            HEAD
>   -----------------------------------------------------------------------
>   5516.3: empty:refspecs:1       0.15(0.09+0.11)   0.14(0.07+0.11) -6.7%
>   5516.5: empty:refspecs:10      0.38(0.32+0.11)   0.17(0.11+0.11) -55.3%
>   5516.7: empty:refspecs:100     2.50(2.43+0.11)   0.49(0.42+0.11) -80.4%
>   5516.9: mirror:refspecs:1      0.21(0.15+0.11)   0.16(0.09+0.11) -23.8%
>   5516.11: mirror:refspecs:10    0.80(0.73+0.11)   0.26(0.19+0.11) -67.5%
>   5516.13: mirror:refspecs:100   6.68(6.59+0.13)   1.18(1.11+0.11) -82.3%
> 
> Notes on a change in behavior:
> 
>  - mkpath() runs cleanup_path(), which strips leading "./".  So,
>    "./refs/heads/foo" previously matched "refs/heads/foo" through the
>    "%.*s" rule.  As of this commit, this is no longer true.

I was wondering whether we should worry about breaking something out
there that relies on "./refs/heads/foo" working as a fully qualified
ref, according to Hyrum's law...

>  - It's considered a bug that "./"-prefixed strings previously could
>    have been matched with refnames in this way:
> 
>    - cleanup_path() dates back to 26c8a533af (Add "mkpath()" helper
>      function, 2005-07-08), and is intended to be used for filepaths,
>      not refnames.  The leading-"./" strip itself comes from f17a1b1bec
>      (Fix up path-cleanup in git_path() properly, 2005-07-05).
> 
>    - refname_match() has used mkpath() in its matching loop since its
>      inception with 79803322c1 (add refname_match(), 2007-11-11).
> 
>    - 6cd4a8982d (avoid using mksnpath for refs, 2017-03-28) previously
>      removed other cleanup_path() spots reachable from mksnpath() and
>      notes they were "questionable when dealing with refnames, as we
>      could silently canonicalize a syntactically bogus refname into a
>      valid one."

But apprently we didn't worry about it back then with 6cd4a8982d, so I
don't think we should worry about it now, either.

> Tests are introduced for the observable behavior change:
> 
>  - t5516 now asserts that pushing a "./"-prefixed source fails
> 
>  - t5510 now asserts that fetch does not match a "./"-prefixed
>    branch.<name>.merge value, either via the default fetch refspec
>    or against the remote's advertised refs.
> 
> Signed-off-by: Jon Simons <jon@jonsimons.org>
> ---
>  refs.c                | 88 +++++++++++++++++++++++--------------------
>  t/t5510-fetch.sh      | 44 ++++++++++++++++++++++
>  t/t5516-fetch-push.sh |  6 +++
>  3 files changed, 97 insertions(+), 41 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 951db56113..9bf3bc8153 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -652,6 +652,44 @@ static const char *ref_rev_parse_rules[] = {
>  
>  #define NUM_REV_PARSE_RULES (ARRAY_SIZE(ref_rev_parse_rules) - 1)
>  
> +/*
> + * Check that the string refname matches a rule of the form
> + * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
> + * "foo/%.*s/baz", and return the string "bar".
> + */
> +static const char *match_parse_rule(const char *refname, const char *rule,
> +				    size_t *len)
> +{
> +	/*
> +	 * Check that rule matches refname up to the first percent in the rule.
> +	 * We can bail immediately if not, but otherwise we leave "rule" at the
> +	 * %-placeholder, and "refname" at the start of the potential matched
> +	 * name.
> +	 */
> +	while (*rule != '%') {
> +		if (!*rule)
> +			BUG("rev-parse rule did not have percent");
> +		if (*refname++ != *rule++)
> +			return NULL;
> +	}
> +
> +	/*
> +	 * Check that our "%" is the expected placeholder. This assumes there
> +	 * are no other percents (placeholder or quoted) in the string, but
> +	 * that is sufficient for our rev-parse rules.
> +	 */
> +	if (!skip_prefix(rule, "%.*s", &rule))
> +		return NULL;
> +
> +	/*
> +	 * And now check that our suffix (if any) matches.
> +	 */
> +	if (!strip_suffix(refname, rule, len))
> +		return NULL;
> +
> +	return refname; /* len set by strip_suffix() */
> +}
> +

"--color-moved" shows that this function was moved here without any
modification.  Good.

>  /*
>   * Is it possible that the caller meant full_name with abbrev_name?
>   * If so return a non-zero value to signal "yes"; the magnitude of
> @@ -662,12 +700,18 @@ static const char *ref_rev_parse_rules[] = {
>  int refname_match(const char *abbrev_name, const char *full_name)
>  {
>  	const char **p;
> -	const int abbrev_name_len = strlen(abbrev_name);
> +	const size_t abbrev_name_len = strlen(abbrev_name);
>  	const int num_rules = NUM_REV_PARSE_RULES;
>  
> -	for (p = ref_rev_parse_rules; *p; p++)
> -		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name)))
> +	for (p = ref_rev_parse_rules; *p; p++) {
> +		size_t short_name_len;
> +		const char *short_name = match_parse_rule(full_name, *p,
> +							  &short_name_len);
> +
> +		if (short_name && short_name_len == abbrev_name_len &&
> +		    !memcmp(short_name, abbrev_name, abbrev_name_len))
>  			return &ref_rev_parse_rules[num_rules] - p;
> +	}

Looks good.

>  	return 0;
>  }
> @@ -1615,44 +1659,6 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
>  	return 0;
>  }
>  
> -/*
> - * Check that the string refname matches a rule of the form
> - * "{prefix}%.*s{suffix}". So "foo/bar/baz" would match the rule
> - * "foo/%.*s/baz", and return the string "bar".
> - */
> -static const char *match_parse_rule(const char *refname, const char *rule,
> -				    size_t *len)
> -{
> -	/*
> -	 * Check that rule matches refname up to the first percent in the rule.
> -	 * We can bail immediately if not, but otherwise we leave "rule" at the
> -	 * %-placeholder, and "refname" at the start of the potential matched
> -	 * name.
> -	 */
> -	while (*rule != '%') {
> -		if (!*rule)
> -			BUG("rev-parse rule did not have percent");
> -		if (*refname++ != *rule++)
> -			return NULL;
> -	}
> -
> -	/*
> -	 * Check that our "%" is the expected placeholder. This assumes there
> -	 * are no other percents (placeholder or quoted) in the string, but
> -	 * that is sufficient for our rev-parse rules.
> -	 */
> -	if (!skip_prefix(rule, "%.*s", &rule))
> -		return NULL;
> -
> -	/*
> -	 * And now check that our suffix (if any) matches.
> -	 */
> -	if (!strip_suffix(refname, rule, len))
> -		return NULL;
> -
> -	return refname; /* len set by strip_suffix() */
> -}
> -
>  char *refs_shorten_unambiguous_ref(struct ref_store *refs,
>  				   const char *refname, int strict)
>  {
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 300bd5396d..941213f36a 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -1074,6 +1074,50 @@ test_expect_success 'LHS of refspec follows ref disambiguation rules' '
>  	)
>  '
>  
> +test_expect_success 'fetch with "./"-prefixed branch.<name>.merge does not mark any ref for merge' '
> +	mkdir dotslash-merge-default-refspec &&
> +	(
> +		cd dotslash-merge-default-refspec &&
> +		git init -b main server &&
> +		test_commit -C server one &&
> +		git -C server branch other &&
> +		test_commit -C server two &&
> +
> +		# The bogus ./refs/heads/main should not match the remote refs/heads/main.
> +		git clone server client &&
> +		git -C client config branch.main.merge ./refs/heads/main &&
> +		git -C client fetch &&
> +		{
> +			echo "$(git -C server rev-parse main)	not-for-merge" &&
> +			echo "$(git -C server rev-parse other)	not-for-merge"
> +		} >expect &&
> +		cut -f -2 client/.git/FETCH_HEAD >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'fetch protocol v0 with "./"-prefixed branch.<name>.merge does not match any remote ref' '
> +	mkdir dotslash-merge-fetch-protocol-v0 &&
> +	(
> +		cd dotslash-merge-fetch-protocol-v0 &&
> +		git init -b main server &&
> +		test_commit -C server one &&
> +		git -C server branch other &&
> +		test_commit -C server two &&
> +
> +		# Omit refs/heads/main from the fetch refspec so that the merge
> +		# source is instead looked up among the refs the remote advertised.
> +		git clone server client-v0 &&
> +		git -C client-v0 config remote.origin.fetch \
> +			+refs/heads/other:refs/remotes/origin/other &&
> +		git -C client-v0 config branch.main.merge ./refs/heads/main &&
> +		git -C client-v0 -c protocol.version=0 fetch &&
> +		echo "$(git -C server rev-parse other)	not-for-merge" >expect &&
> +		cut -f -2 client-v0/.git/FETCH_HEAD >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +

Testing the "./"-prefixed "branch.<name>.merge" config is a nice
touch.

>  test_expect_success 'fetch.writeCommitGraph' '
>  	git clone three write &&
>  	(
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index b982b209bf..81ad6cd52f 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -433,6 +433,12 @@ test_expect_success 'push with onelevel ref' '
>  	test_must_fail git push testrepo HEAD:refs/onelevel
>  '
>  
> +test_expect_success 'push with "./"-prefixed src does not match any ref' '
> +	mk_test testrepo heads/main &&
> +	test_must_fail git push testrepo ./refs/heads/main:refs/heads/frotz 2>err &&
> +	test_grep "src refspec ./refs/heads/main does not match any" err
> +'
> +
>  test_expect_success 'push with colon-less refspec (1)' '
>  	mk_test testrepo heads/frotz tags/frotz &&
>  	git branch -f frotz main &&
> -- 
> 2.55.0
> 
