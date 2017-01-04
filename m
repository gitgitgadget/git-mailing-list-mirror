Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7A0120756
	for <e@80x24.org>; Wed,  4 Jan 2017 23:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969663AbdADXQJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 18:16:09 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36310 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966680AbdADXQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 18:16:08 -0500
Received: by mail-pg0-f52.google.com with SMTP id f188so232176193pgc.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nE0HgilF1OFVWVEW3jSIoJp/6h4qJ/yLcqi8EEYgYvM=;
        b=iYv1gRq6RME5/AH8QRbj39Fmq9ea6Ys0ePnor5kHJqDCSfTT20XU5hcRWart6NZmuG
         PJK8eB2mSyhYv0rjNOhmFCIWnvUoZWryAbpxCVZNLFgjUHdKS7BaAOkVyHCdKpl7FRDI
         Jq3WGw/mfM7aodIsL6bp53KwuWJAt7734T80NMiGo/m9shIc9hksq2sb68d10/1TOFOD
         DCnNwZJXrIjR2axrZE2iUWiw08GyCMr/HEj4ptQ1MIrm5JF7g/t55fWGikpBtH0EimmA
         0kxuMi9YQFG1Ufe9LLWvjEFHAl6HXhx63iHVecNCcz0YDfxDaAiiI6UjHlmpNyriPwBQ
         OrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nE0HgilF1OFVWVEW3jSIoJp/6h4qJ/yLcqi8EEYgYvM=;
        b=K1o9lk8jaomHZII0TdJNXNi8/yhsufmWikVnDrS4rEXHjKnv6vr20MHQkoUaBHWdaE
         m/GPy8nsr2egmOGNQuWrviEIZRsNGMwOXECKKnKsqbbi8vUyciR2JGigCaNVuzCbZ6eZ
         gLpnlkVH6v14E+LBasooLLCLtiS96tYc8V4M2zw66ko/qX6nEVRSkOMC1nsdT0rRT4em
         u0gc8+fVYW7p0Fdp15OOLSaeWPUu0r3zpHm4i2PBwCvtUl5wxWwseY685CB5jlQTzUy3
         JIEDJ2HtTTNKge+D1WKReglHOpJBCmhJ6GeOcBrFwsMg0d+DKVUgGVQwmIOoj7vWyPaz
         u+aQ==
X-Gm-Message-State: AIkVDXJXvqDPnwCcv2bcoVXRqPy8jIZ8zkyEPpDzwPTQpAHNAKNh6YuGzWVrgneyOJmu4RRq
X-Received: by 10.99.164.9 with SMTP id c9mr129157507pgf.141.1483571767455;
        Wed, 04 Jan 2017 15:16:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1930:3cb0:6c91:e070])
        by smtp.gmail.com with ESMTPSA id w5sm149256365pfl.31.2017.01.04.15.16.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 04 Jan 2017 15:16:06 -0800 (PST)
Date:   Wed, 4 Jan 2017 15:16:05 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCHv5] pathspec: give better message for submodule related
 pathspec error
Message-ID: <20170104231605.GB68241@google.com>
References: <20170104205346.GE69227@google.com>
 <20170104231027.7065-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170104231027.7065-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04, Stefan Beller wrote:
> Every once in a while someone complains to the mailing list to have
> run into this weird assertion[1]. The usual response from the mailing
> list is link to old discussions[2], and acknowledging the problem
> stating it is known.
> 
> This patch accomplishes two things:
> 
>   1. Switch assert() to die("BUG") to give a more readable message.
> 
>   2. Take one of the cases where we hit a BUG and turn it into a normal
>      "there was something wrong with the input" message.
> 
>      This assertion triggered for cases where there wasn't a programming
>      bug, but just bogus input. In particular, if the user asks for a
>      pathspec that is inside a submodule, we shouldn't assert() or
>      die("BUG"); we should tell the user their request is bogus.
> 
>      The only reason we did not check for it, is the expensive nature
>      of such a check, so callers avoid setting the flag
>      PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE. However when we die due
>      to bogus input, the expense of cpu cycles spent outweighs the user
>      wondering what went wrong, so run that check unconditionally before
>      dying with a more generic error message.
> 
>      In case we found out that the path points inside a submodule, but the
>      caller did not ask for PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE, we
>      should not silently fix the pathspec to just point at the submodule,
>      as that would confuse callers.
> 
> To make this happen, specifically the second part, move the check for
> being inside a submodule into a function and call it either when
> PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE is set or when we are in the
> buggy case to give a better error message.
> 
> Note: There is this one special case ("git -C submodule add .") in which
> we call check_inside_submodule_expensive two times, once for checking
> PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE and once in the code path
> handling the buggy user input. For this to work correctly we need to adapt
> the conditions in the check for being inside the submodule to account for
> the prior run to have taken effect.
> 
> [1] https://www.google.com/search?q=item-%3Enowildcard_len
> [2] http://git.661346.n2.nabble.com/assert-failed-in-submodule-edge-case-td7628687.html
>     https://www.spinics.net/lists/git/msg249473.html
> 
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> This is just rerolling the second patch of that "make the assert go away",
> asking for opinions again.
> 
> I agree with Brandon that pathspec code is not the ideal place to
> check for issues with submodules. However we should give the best error
> message possible for the user, so running this diagnosis is fine by me.
> 
> Thanks,
> Stefan
> 
>  pathspec.c                       | 63 +++++++++++++++++++++++++++-------------
>  t/t6134-pathspec-in-submodule.sh | 33 +++++++++++++++++++++
>  2 files changed, 76 insertions(+), 20 deletions(-)
>  create mode 100755 t/t6134-pathspec-in-submodule.sh
> 
> diff --git a/pathspec.c b/pathspec.c
> index 22ca74a126..41e0dac1df 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -88,6 +88,34 @@ static void prefix_short_magic(struct strbuf *sb, int prefixlen,
>  	strbuf_addf(sb, ",prefix:%d)", prefixlen);
>  }
>  
> +static void check_inside_submodule_expensive(struct pathspec_item *item,
> +					     char *match,
> +					     const char *elt, int die_inside)
> +{
> +	int i;
> +	for (i = 0; i < active_nr; i++) {
> +		struct cache_entry *ce = active_cache[i];
> +		int ce_len = ce_namelen(ce);
> +
> +		if (!S_ISGITLINK(ce->ce_mode))
> +			continue;
> +
> +		if (item->len < ce_len ||
> +		    !(match[ce_len] == '/' || match[ce_len] == '\0') ||
> +		    memcmp(ce->name, match, ce_len))
> +			continue;
> +
> +		if (item->len != ce_len + 1 || die_inside)
> +			die (_("Pathspec '%s' is in submodule '%.*s'"),
> +			     elt, ce_len, ce->name);
> +
> +		/* strip trailing slash */
> +		item->len--;
> +		match[item->len] = '\0';
> +		break;
> +	}
> +}
> +
>  /*
>   * Take an element of a pathspec and check for magic signatures.
>   * Append the result to the prefix. Return the magic bitmap.
> @@ -273,24 +301,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  	}
>  
>  	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
> -		for (i = 0; i < active_nr; i++) {
> -			struct cache_entry *ce = active_cache[i];
> -			int ce_len = ce_namelen(ce);
> -
> -			if (!S_ISGITLINK(ce->ce_mode))
> -				continue;
> -
> -			if (item->len <= ce_len || match[ce_len] != '/' ||
> -			    memcmp(ce->name, match, ce_len))
> -				continue;
> -			if (item->len == ce_len + 1) {
> -				/* strip trailing slash */
> -				item->len--;
> -				match[item->len] = '\0';
> -			} else
> -				die (_("Pathspec '%s' is in submodule '%.*s'"),
> -				     elt, ce_len, ce->name);
> -		}
> +		check_inside_submodule_expensive(item, match, elt, 0);
>  
>  	if (magic & PATHSPEC_LITERAL)
>  		item->nowildcard_len = item->len;
> @@ -313,8 +324,20 @@ static unsigned prefix_pathspec(struct pathspec_item *item,
>  	}
>  
>  	/* sanity checks, pathspec matchers assume these are sane */
> -	assert(item->nowildcard_len <= item->len &&
> -	       item->prefix         <= item->len);
> +	if (item->nowildcard_len > item->len ||
> +	    item->prefix         > item->len) {
> +		/*
> +		 * We know something is fishy and we're going to die
> +		 * anyway, so we don't care about following operation
> +		 * to be expensive, despite the caller not asking for
> +		 * an expensive submodule check. The potential expensive
> +		 * operation here reduces the users head scratching
> +		 * greatly, though.
> +		 */
> +		check_inside_submodule_expensive(item, match, elt, 1);
> +		die ("BUG: item->nowildcard_len > item->len || item->prefix > item->len)");
> +	}
> +
>  	return magic;
>  }
>  
> diff --git a/t/t6134-pathspec-in-submodule.sh b/t/t6134-pathspec-in-submodule.sh
> new file mode 100755
> index 0000000000..2900d8d06e
> --- /dev/null
> +++ b/t/t6134-pathspec-in-submodule.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +
> +test_description='test case exclude pathspec'
> +
> +TEST_CREATE_SUBMODULE=yes
> +. ./test-lib.sh
> +
> +test_expect_success 'setup a submodule' '
> +	git submodule add ./pretzel.bare sub &&
> +	git commit -a -m "add submodule" &&
> +	git submodule deinit --all
> +'
> +
> +cat <<EOF >expect
> +fatal: Pathspec 'sub/a' is in submodule 'sub'
> +EOF
> +
> +test_expect_success 'error message for path inside submodule' '
> +	echo a >sub/a &&
> +	test_must_fail git add sub/a 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +cat <<EOF >expect
> +fatal: Pathspec '.' is in submodule 'sub'
> +EOF
> +
> +test_expect_success 'error message for path inside submodule from within submodule' '
> +	test_must_fail git -C sub add . 2>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done

I haven't taken a through look at this patch but I think you may want to
base it off of 'origin/bw/pathspec-cleanup' series as the changes made in this
patch now conflict with that series.

Also I still don't really think this solves the problem of telling the
user what is wrong, which is that the submodule's gitdir is gone.

-- 
Brandon Williams
