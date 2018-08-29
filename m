Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF90D1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 04:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeH2IAl (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 04:00:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36729 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeH2IAl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 04:00:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so1728393pgo.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 21:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kAOz8g7SPj6FhZBlFunTn2cH+c+qlYh+wNr3MAzIO/k=;
        b=RYLWmHyCmnPK8EMCXD0MCsRlxXdbic4DkLjabmJh3YK46gn0u+PqBl3qszx6p7uMqi
         Q2QsHracipAoZEwy7YJmyb2x+gphBU3IaCK3LNjC/e0qBT+KEhSBn9oHgbguBVhOW+Z6
         l6IvNKuaAu7AZPh8eTryFC8F8YDFK1Oay4SR/afrH+aTOwUCAaE0pTIk8W9dkNaH6X0E
         xrBL4SqdQwBR8sQ8Qiy1XMdwgVOLH/h6xU2dvhaj7oy2ba1I7Phdap0HJc8rp7jUxE5Z
         Q9WWvN4YRR5BUCwMYEYtr1b7cV0Tm0TdT1kBRAa4iNoQoUmUNhpHdLqDflHWDa1a30LC
         V8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kAOz8g7SPj6FhZBlFunTn2cH+c+qlYh+wNr3MAzIO/k=;
        b=F+nGjcGYkJkGWmeRuir015HElyHEuFg6/8XoWmmnc4AWNtWnXJqmJBZizC926dD3Hi
         bEgrsUDXO3h+OEhPD+BZ7q//begHHxbHUU/nSXMc2j8vP7zq234KVRrIXimJwHYNJ6lx
         rqvT5FMamJrYmZL32pThZ0mQbPbUVqwRJ1XmDKGQ1MXEOGzGC68gvuPc1tNWqBS2pMMO
         w2pZkk0Uib0/DN9K/0olMP81G/nY99PmuWEdW1qh/Dn1Gwd1ZxQBTSF4vv4S55YuO+3R
         ehBDzt6QsaP0LXfoZke4vgzWRw4TfY7tnl4co4uMI+y4uJb5swOJNlyjaLmcs0LLiPom
         NqRA==
X-Gm-Message-State: APzg51DwapVVmcGu7CXg4jEPhnB2MtkJOxhfTMiQVUrAVLlVAoWAx1Yx
        bvpOPqjE1eboWmj4qcCP548=
X-Google-Smtp-Source: ANB0VdaMD6Sv0d75LysW0pFWRaTpRYm8tYt7g/wp9GVZTuQghjFZFGXU+K7+ioUntPzv2e/e7b2G3A==
X-Received: by 2002:a62:6781:: with SMTP id t1-v6mr4187136pfj.200.1535515550872;
        Tue, 28 Aug 2018 21:05:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i1-v6sm6745225pgj.38.2018.08.28.21.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 21:05:50 -0700 (PDT)
Date:   Tue, 28 Aug 2018 21:05:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 01/11] t: add tool to translate hash-related values
Message-ID: <20180829040548.GB197350@aiede.svl.corp.google.com>
References: <20180829005642.980617-1-sandals@crustytoothpaste.net>
 <20180829005642.980617-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829005642.980617-2-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> Add a test function helper, test_oid, that produces output that varies
> depending on the hash in use.

Cool!

>                                Add two additional helpers,
> test_oid_cache, which can be used to load data for test_oid from
> standard input, and test_oid_init, which can be used to load certain
> fixed values from lookup charts.  Check that these functions work in
> t0000, as the rest of the testsuite will soon come to depend on them.
>
> Implement two basic lookup charts, one for common invalid or synthesized
> object IDs, and one for various facts about the hash function in use.
> Provide versions for both SHA-1 and SHA-256.

What do test_oid_cache and test_oid_init do?  How can I use them?

Judging from t0000-basic.sh, the idea looks something like

	Add a test function helper, test_oid, that ...

	test_oid allows looking up arbitrary information about an object format:
	the length of object ids, values of well known object ids, etc.  Before
	calling it, a test script must invoke test_oid_cache (either directly
	or indirectly through test_oid_init) to load the lookup charts.

	See t0000 for an example, which also serves as a sanity-check that
	these functions work in preparation for using them in the rest of the
	test suite.

	There are two basic lookup charts for now: oid-info/oid, with common
	invalid or synthesized object IDs; and oid-info/hash-info, with facts
	such as object id length about the formats in use.  The charts contain
	information about both SHA-1 and SHA-256.

	So now you can update existing tests to be format-independent by (1)
	adding an invocation of test_oid_init to test setup and (2) replacing
	format dependencies with $(test_oid foo).

	Since values are stored as shell variables, names used for lookup can
	only consist of shell identifier characters.  If this is a problem in
	the future, we can hash the names before use.

	Improved-by: Eric Sunshine <sunshine@sunshineco.com>

Do these always use sha1 for now?  Ah, t0000 answers but it might be
worth mentioning in the commit message, too:

	test_set_hash allows setting which object format test_oid should look
	up information for, and test_detect_hash returns to the default format.

[...]
> --- /dev/null
> +++ b/t/oid-info/hash-info
> @@ -0,0 +1,8 @@
> +rawsz sha1:20
> +rawsz sha256:32

Can there be a README in this directory describing the files and format?

[...]
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -821,6 +821,41 @@ test_expect_success 'tests clean up even on failures' "
>  	EOF
>  "
>  
> +test_oid_init

Can this be wrapped in test_expect_success?  That way, if it fails or
prints an error message then the usual test machinery would handle it.

> +
> +test_expect_success 'test_oid provides sane info by default' '
> +	test_oid zero >actual &&
> +	grep "^00*$" actual &&

nit: can save the reader some confusion by escaping the $.

> +	rawsz="$(test_oid rawsz)" &&
> +	hexsz="$(test_oid hexsz)" &&

optional: no need for these quotation marks --- a command substitution
assigned to a shell variable is treated as if it were quoted.

> +	test "$hexsz" -eq $(wc -c <actual) &&
> +	test $(( $rawsz * 2)) -eq "$hexsz"

Makes sense.

[...]
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1155,3 +1155,47 @@ depacketize () {
[...]
> +test_oid_cache () {
> +	test -n "$test_hash_algo" || test_detect_hash

Should this use an uninterrupted &&-chain?

> +	while read _tag _rest

This appears to be the first use of this naming convention.  I wonder
if we can use "local" instead.

> +	do
> +		case $_tag in
> +		\#*)
> +			continue;;
> +		?*)
> +			# non-empty
> +			;;
> +		*)
> +			# blank line
> +			continue;;
> +

unnecessary blank line here

> +		esac &&
> +
> +		_k="${_rest%:*}" &&
> +		_v="${_rest#*:}" &&
> +		{ echo "$_k" | egrep '^[a-z0-9]+$' >/dev/null ||
> +			error 'bug in the test script: bad hash algorithm'; } &&
> +		eval "test_oid_${_k}_$_tag=\"\$_v\"" || return 1

This is dense, so I'm having trouble taking it in at a glance.

I think the idea is

		key=${rest%%:*} &&
		val=${rest#*:} &&

		if ! expr "$key" : '[a-z0-9]*$' >/dev/null
		then
			error ...
		fi &&
		eval "test_oid_${key}_${tag}=\${val}"

> +	done
> +}
> +
> +test_oid () {
> +	eval "
> +		test -n \"\${test_oid_${test_hash_algo}_$1+set}\" &&
> +		printf '%s' \"\${test_oid_${test_hash_algo}_$1}\"
> +	"

I'm also having trouble taking this one in.  Maybe splitting into two
evals would work?

	var=test_oid_${test_hash_algo}_$1 &&

	eval "test -n \"\${$var+set}\"" &&
	eval "printf '%s\n' \"\${$var}\""

What is the initial test meant to do?  Can this function get a
documentation comment?  Are we relying on "test -n" to return a failing
result if the variable is unset, or could the test be omitted (relying
on "\${$var}" to evaluate to "" when the variable is unset)?  Should
this call 'error' when the variable is unset?

Can t/README describe the new test helpers?

Thanks,
Jonathan
