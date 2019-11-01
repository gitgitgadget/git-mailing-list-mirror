Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E74241F454
	for <e@80x24.org>; Fri,  1 Nov 2019 22:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfKAWFm (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 18:05:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45974 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfKAWFl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 18:05:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so7270854pgj.12
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZvMvkE+2H/J+Oed0BKH5JFzeFN+etyEZQL6KhxnBP8=;
        b=MLipLvAsItq3gk/Nb3cxMUFu4TyojbtTQoY+bIxtyWOUulh+FNp48Vm6DH4cxE3F00
         o0TZkEi44CD02qwd/nNsePFXIQPqK7cgIpuDrSr7PTG81PTIWUqDjUfLqjPDYsPrJLMX
         yEzZX0j+PsnkAWNQ9+XAlvmwGDU/6J/0f/KvainLcNu/uyvWHQirjL1VJZ/F7rHOC/2L
         HQQvMO5V37CoVUVQ7vDYh9GaTVBwi4brG4NAWVomOOr+wTDNQM+fh89ZOPxZtLDFqv1q
         beGvbIbaoWf+c9YZtBuRwEdbRm1JayxVaLnWRMC8yu2d9pjHyUfcWO5J/V9xGIPDoYcU
         G4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZvMvkE+2H/J+Oed0BKH5JFzeFN+etyEZQL6KhxnBP8=;
        b=YCGJbU9d/lxGG1Cgoj6PI0Ua2YjxrttK63BZmypdYmUamr8ZHuUrsdVBgDz1iqr2zD
         2w0Lv/nI58+qaWb6DiYm8VfLFwIi2sS2FfHtv17NwxYfnmKXbnMdgkBbixVFry1UGdoB
         QSt44o7Uqidxb7s9c6XaLQxRCwM0CIGRf8veuLq5G6KGz2fKs08be7r6VRDtfQiYuEqn
         QWyTchs0MtuN7oBX2dZwYmIB+BlvR2HgR1sULmZATk7FvsmkgFum8E8+Ind5x03JywRk
         6zKbi98pt/OWEvGzDEDbxjtI+FywaXg28Nwju+b88dH9++xOFhqp8uiWDf7GhU6uTZww
         G9cg==
X-Gm-Message-State: APjAAAXtytbooepjhZid/lPQeH4/t1c4ILcreuCjZUDVQNXn9OahhFO5
        eksagE1A5yl1G+vNC6hPzJQ=
X-Google-Smtp-Source: APXvYqylEpAU/B9BqnrIC3XzEZ+YtvSCSh3QxI2yzqYiVo5yjOme3HSIAD5Kobwi1AsZNP9rdLjlWw==
X-Received: by 2002:a17:90a:195e:: with SMTP id 30mr18431772pjh.60.1572645940436;
        Fri, 01 Nov 2019 15:05:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id b18sm7362433pfi.157.2019.11.01.15.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 15:05:39 -0700 (PDT)
Date:   Fri, 1 Nov 2019 15:05:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] fetch: remove fetch_if_missing=0
Message-ID: <20191101220537.GA249573@google.com>
References: <20191101203830.231676-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101203830.231676-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> In fetch_pack() (and all functions it calls), pass
> OBJECT_INFO_SKIP_FETCH_OBJECT whenever we query an object that could be
> a tree or blob that we do not want to be lazy-fetched even if it is
> absent. Thus, the only lazy-fetches occurring for trees and blobs are
> when resolving deltas.
>
> Thus, we can remove fetch_if_missing=0 from builtin/fetch.c. Remove
> this, and also add a test ensuring that such objects are not
> lazy-fetched. (We might be able to remove fetch_if_missing=0 from other
> places too, but I have limited myself to builtin/fetch.c in this commit
> because I have not written tests for the other commands yet.)

Hooray!  Thanks much, this looks easier to maintain.

> Note that commits and tags may still be lazy-fetched. I limited myself
> to objects that could be trees or blobs here because Git does not
> support creating such commit- and tag-excluding clones yet, and even if
> such a clone were manually created, Git does not have good support for
> fetching a single commit (when fetching a commit, it and all its
> ancestors would be sent).

Is there a place we could put a NEEDSWORK comment to avoid confusion
when debugging if this gets introduced later?

Even if not, this seems like a sensible choice.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I've verified that this also solves the bug explained in:
> https://public-inbox.org/git/20191007181825.13463-1-jonathantanmy@google.com/

Might be worth mentioning the example from there in the commit message
as well, to help explain the context behind the change.

I would still be in favor of applying that more conservative change to
"master", even this late in the -rc cycle.

[...]
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1074,7 +1074,8 @@ static int check_exist_and_connected(struct ref *ref_map)
>  	 * we need all direct targets to exist.
>  	 */
>  	for (r = rm; r; r = r->next) {
> -		if (!has_object_file(&r->old_oid))
> +		if (!has_object_file_with_flags(&r->old_oid,
> +						OBJECT_INFO_SKIP_FETCH_OBJECT))

Yes.

[...]
> @@ -1755,8 +1756,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	packet_trace_identity("fetch");
>  
> -	fetch_if_missing = 0;
> -

This is the scary part, but in an "uncomfortably exciting" sense rather
than a worrying one.  Thanks for adding a test.

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -673,7 +673,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>  		struct object *o;
>  
>  		if (!has_object_file_with_flags(&ref->old_oid,
> -						OBJECT_INFO_QUICK))
> +						OBJECT_INFO_QUICK |
> +							OBJECT_INFO_SKIP_FETCH_OBJECT))

Should we make OBJECT_INFO_QUICK always imply
OBJECT_INFO_SKIP_FETCH_OBJECT?  I would suspect that if we are willing to
avoid checking thoroughly locally, checking remotely would be even more
undesirable.

[...]
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -296,6 +296,75 @@ test_expect_success 'partial clone with unresolvable sparse filter fails cleanly
>  	test_i18ngrep "unable to parse sparse filter data in" err
>  '
>  
> +setup_triangle () {
> +	rm -rf big-blob.txt server client promisor-remote &&
> +
> +	touch big-blob.txt &&

Tests seem to prefer spelling this as

	>big-blob.txt &&

because that specifes the content of the file.

> +	for i in $(seq 1 100)
> +	do
> +		echo line $i >>big-blob.txt
> +	done &&

Should this use test_seq for better portability?

nit: can avoid a subshell:

	test_seq 1 100 | sed -e 's/^/line /' >big-blob.txt

[...]
> +test_expect_success 'fetch lazy-fetches only to resolve deltas' '
> +	setup_triangle &&
> +
> +	# Exercise to make sure it works. Git will not fetch anything from the
> +	# promisor remote other than for the big blob (because it needs to
> +	# resolve the delta).
> +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
> +		fetch "file://$(pwd)/server" master &&
> +
> +	# Verify the assumption that the client needed to fetch the delta base
> +	# to resolve the delta.
> +	git hash-object big-blob.txt >hash &&
> +	grep "want $(cat hash)" trace

nit: can avoid using cat:

	hash=$(git hash-object big-blob.txt) &&
	grep "want $hash" trace

Thanks and hope that helps,
Jonathan
