Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA2EC1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389731AbeG0WpZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 18:45:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40688 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389718AbeG0WpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 18:45:25 -0400
Received: by mail-pl0-f68.google.com with SMTP id s17-v6so2827320plp.7
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7xV//cApyjmq5+YQ6QLNxKyVjhvOD5G547uH8Uk/6z8=;
        b=haRNDHu803EB1bkvdQ3MW80bhGEl6LDdxYL6RM0ufsCSF3113MVKVErxYZupI09l92
         zAy4qMwPFM6/Vq0eVZiZsGZkCZTAnClei4bco0014Fy+bUyv3xM9Vdo+uTcnA+d/I8c9
         w3x4RV9gQLQFDya81IB3RDrSF9QU6yM8ZzPBWOhNK7bqfZtD9FOgHoj/dood54GZjLYV
         aO0Xb+G+hyiKy+CVUdVoesqO+zf32TZ9jFeBhtwPCNrde/gM5Z3xg61lOaFckJqMZ6hu
         /MOEUMLBthIooVlJUQYv+UR6qm0znygny1bA8tMsl7/80NJSL8bXyOiAiO3xTOvFlZbz
         R1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7xV//cApyjmq5+YQ6QLNxKyVjhvOD5G547uH8Uk/6z8=;
        b=uG/xqbIkAel4l1rQwuQXStCVfPsuHCBYnTfHAX3qgXodaZgh7wwqMjrfS6L4GrE5m8
         dRjux3GPK74xTfGbVendu1l4cOx2cvSyEYqeJVH83J/cQVYSSR8WHVprtKelklFz5mmd
         nciplNPva8dwwnkem7YtwunwdGh/Xf/jRo8nUhqWxoNW8Av4ngKfPRHgoZbLQmp6JI7E
         x3rhnXXNRBE4avFlA6+62M1R4t73xRF5O6mDQfRkfku9qrrXeKMeKAJV63Fn/ZhpP3ec
         jBjHNDHbvNq2ud3xgor3TGce6gEmjU2lJXAs/inQBV/L/Q7euqaC4tblO8EAU2qrGGS4
         tbsA==
X-Gm-Message-State: AOUpUlGNBe+R3ReAw4WyKMvafrVssEvZb6X+dOQbq3BxNz//YoRc6+MW
        jPc8T+oXdBZTw4bk8KzYBiCwPg==
X-Google-Smtp-Source: AAOMgpd2+Fgua86tekd7eY7ZSBMEyuY7FX3JdXELPiJEFefQzmFS1tz8WRHb0qdA7vihsvazZRqHJA==
X-Received: by 2002:a17:902:7106:: with SMTP id a6-v6mr7638037pll.28.1532726502083;
        Fri, 27 Jul 2018 14:21:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id v30-v6sm8794254pgn.80.2018.07.27.14.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:21:41 -0700 (PDT)
Date:   Fri, 27 Jul 2018 14:21:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
Message-ID: <20180727212140.GA54208@google.com>
References: <20180727205117.243770-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727205117.243770-1-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/27, Stefan Beller wrote:
> A use reported a submodule issue regarding strange case indentation
> issues, but it could be boiled down to the following test case:
> 
>   $ git init test  && cd test
>   $ git config foo."Bar".key test
>   $ git config foo."bar".key test
>   $ tail -n 3 .git/config
>   [foo "Bar"]
>         key = test
>         key = test
> 
> Sub sections are case sensitive and we have a test for correctly reading
> them. However we do not have a test for writing out config correctly with
> case sensitive subsection names, which is why this went unnoticed in
> 6ae996f2acf (git_config_set: make use of the config parser's event
> stream, 2018-04-09)
> 
> Make the subsection case sensitive and provide a test for both reading
> and writing.
> 
> Reported-by: JP Sugarbroad <jpsugar@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  config.c          |  2 +-
>  t/t1300-config.sh | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/config.c b/config.c
> index 3aacddfec4b..3ded92b678b 100644
> --- a/config.c
> +++ b/config.c
> @@ -2374,7 +2374,7 @@ static int store_aux_event(enum config_event_t type,
>  		store->is_keys_section =
>  			store->parsed[store->parsed_nr].is_keys_section =
>  			cf->var.len - 1 == store->baselen &&
> -			!strncasecmp(cf->var.buf, store->key, store->baselen);
> +			!strncmp(cf->var.buf, store->key, store->baselen);

I've done some work in the config part of our codebase but I don't
really know whats going on here due to two things: this is a callback
function and it relies on global state...

I can say though that we might want to be careful about completely
converting this to a case sensitive compare.  Our config is a key
value store with the following format: 'section.subsection.key'.  IIRC
both section and key are always compared case insensitively.  The
subsection can be case sensitive or insensitive based on how its
stored in the config files itself:

  # Case insensitive
  [section.subsection]
      key = value

  # Case sensitive 
  [section "subsection"]
      key = value

But I don't know how you distinguish between these cases when a config
is specified on a single line (section.subsection.key).  Do we always
assume the sensitive version because the insensitive version is
documented to be deprecated?

Either way you're probably going to need to be careful about how you do
string comparison against the different parts.

>  		if (store->is_keys_section) {
>  			store->section_seen = 1;
>  			ALLOC_GROW(store->seen, store->seen_nr + 1,
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index 03c223708eb..8325d4495f4 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -1218,6 +1218,24 @@ test_expect_success 'last one wins: three level vars' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'setting different case subsections ' '
> +	test_when_finished "rm -f caseSens caseSens_actual caseSens_expect" &&
> +
> +	# v.a.r and v.A.r are not the same variable, as the middle
> +	# level of a three-level configuration variable name is
> +	# case sensitive.
> +	git config -f caseSens v."A".r VAL &&
> +	git config -f caseSens v."a".r val &&
> +
> +	echo VAL >caseSens_expect &&
> +	git config -f caseSens v."A".r >caseSens_actual &&
> +	test_cmp caseSens_expect caseSens_actual &&
> +
> +	echo val >caseSens_expect &&
> +	git config -f caseSens v."a".r >caseSens_actual &&
> +	test_cmp caseSens_expect caseSens_actual
> +'
> +
>  for VAR in a .a a. a.0b a."b c". a."b c".0d
>  do
>  	test_expect_success "git -c $VAR=VAL rejects invalid '$VAR'" '
> -- 
> 2.18.0.345.g5c9ce644c3-goog
> 

-- 
Brandon Williams
