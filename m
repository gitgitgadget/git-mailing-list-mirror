Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6AE520248
	for <e@80x24.org>; Wed, 13 Mar 2019 02:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfCMCEi (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 22:04:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54879 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfCMCEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 22:04:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so236401wmj.4
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 19:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L4Q1nIJXTb0iz+6cS7Thr8TMl3QDzKjiTTL4my7jYss=;
        b=AX6+ZKWZ7pJwpkREjU8LI3V0ZXYt24R0sV3jaezivqB1pBfjjwh29SKpijJaeIPaoe
         xIXOL+MrsQkwLH65ezyyDLxWiFql28eCEwZ7IS3AxlbF98h5V+MSkg1icFCrGTrlotox
         gcfrwzBcvQQRfEDjI4iJege0TAyJIlAuxunpBvuxYoFl/rBD7TKEoP7UHsgOQMJKTaAv
         qs/YgAsJbZzsZ06E8YDi4jyTnFj5v4G8EpqjSF/KONCU8sOKa97V4juLYCQbLjRnFe3f
         fj5ikbWjsOcf9p523pPZfmEhiNK3lDMl/nA69JFtFW0wOyuohawPoudLcmrdyGAwQDkC
         gdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L4Q1nIJXTb0iz+6cS7Thr8TMl3QDzKjiTTL4my7jYss=;
        b=drmjipTmO83r0A3ZsagcKiH/9D2jPKL72QGPII180kbcXA2TyyVi9benkIKh7pMLxh
         sdqH0TBwX9kI1o2x1pYveGnT3S3p5fu+DNAvjdMjc4/XDUoPkLi/r1IQYFX4usoQF6FE
         jFAe4yWo4qan/4iNf6XohneQ3j6wfMTXGQBxh49JSTCp4XOfOI6ory6ltXssDdcguCv1
         D4S7Zx5dDV11RwttUgkvocBjH9yH/nyVm+7PwXV3Rj5aDzNuCW+QWIfa5QOK9p6hrJZt
         DK+P9gMllAtM9+dwm1+uuBVzLLvqA3zhHvFQyAp2xDfTL6hPBTadazkNpZ66oI56RWQj
         FpJA==
X-Gm-Message-State: APjAAAUqeLq3rVrClx9pVtfOB5FDV9+YMYbTjHXXED4f4lhtv/fBu2HE
        PLi2nIy/jl4JiMb5j9LRU9I=
X-Google-Smtp-Source: APXvYqzBCTEoaF4qizMZbk3+DOWSps/+r2QMQiNDXJb05gUo1+V8SGVIf/H62Edv4AjC2oMKVK6Lzg==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr401652wmj.108.1552442675047;
        Tue, 12 Mar 2019 19:04:35 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id a2sm14055796wrr.60.2019.03.12.19.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 19:04:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: explain first attempt failure clearly
References: <20190312174522.89306-1-jonathantanmy@google.com>
Date:   Wed, 13 Mar 2019 11:04:34 +0900
In-Reply-To: <20190312174522.89306-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 12 Mar 2019 10:45:22 -0700")
Message-ID: <xmqqimwnfs25.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When cloning with --recurse-submodules a superproject with at least one
> submodule with HEAD pointing to an unborn branch, the clone goes
> something like this:
>
> 	Cloning into 'test'...
> 	<messages about cloning of superproject>
> 	Submodule '<name>' (<uri>) registered for path '<submodule path>'
> 	Cloning into '<submodule path>'...
> 	fatal: Couldn't find remote ref HEAD
> 	Unable to fetch in submodule path '<submodule path>'
> 	<messages about fetching with SHA-1>
> 	From <uri>
> 	 * branch            <hash> -> FETCH_HEAD
> 	Submodule path '<submodule path>': checked out '<hash>'
>
> In other words, first, a fetch is done with no hash arguments (that is,
> a fetch of HEAD) resulting in a "Couldn't find remote ref HEAD" error;
> then, a fetch is done given a hash, which succeeds.
>
> The fetch given a hash was added in fb43e31f2b ("submodule: try harder
> to fetch needed sha1 by direct fetching sha1", 2016-02-24), and the
> "Unable to fetch..." message was downgraded from a fatal error to a
> notice in e30d833671 ("git-submodule.sh: try harder to fetch a
> submodule", 2018-05-16).
>
> This commit improves the notice to be clearer that we are retrying the
> fetch, and that the previous messages do not necessarily indicate that
> the whole command fails. In other words:

"additional" is relative to something.  Is it additional to status-quo?
>
>  - If the HEAD-fetch succeeds and we then have the commit we want, no
>    extra messages are printed.
>  - If the HEAD-fetch succeeds and we do not have the commit we want, but
>    the hash-fetch succeeds, no additional messages are printed.

For example, the user would be helped to be told that we succeeded
doing a pointless fetch and we now are going to make a more specific
"give me that commit" fetch to see if it helps.  These may already
be given with the current code, or may not be (I don't know
offhand), but "no additional messages" does not help me in knowing
if the code with this patch would give such a hint to the users.

>  - If the HEAD-fetch succeeds and we do not have the commit we want, but
>    the hash-fetch fails, this is a fatal error.
>  - If the HEAD-fetch fails, we print the notice, and if the hash-fetch
>    succeeds, no additional messages are printed.
>  - If the HEAD-fetch fails, we print the notice, and if the hash-fetch
>    fails, this is a fatal error.
>
> It could be said that we should just eliminate the HEAD-fetch
> altogether, but that changes some behavior (in particular, some refs
> that were opportunistically updated would no longer be), so I have left
> that alone for now.

OK, that sounds good decision for this patch.

A more fundamental question is why these submodule repositories do
not have HEAD to recommend from which branch to fetch by default,
and if we can do something about it so that HEAD-fetch fails less
often for the users.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index 514ede2596..2c0fb6d723 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -594,7 +594,7 @@ cmd_update()
>  				# is not reachable from a ref.
>  				is_tip_reachable "$sm_path" "$sha1" ||
>  				fetch_in_submodule "$sm_path" $depth ||
> -				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
> +				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'; trying to directly fetch \$sha1:")"
>  
>  				# Now we tried the usual fetch, but $sha1 may
>  				# not be reachable from any of the refs

Obviously good ;-)

Thanks.

> diff --git a/submodule.c b/submodule.c
> index 21cf50ca15..b16c0ecc95 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1548,6 +1548,13 @@ static int fetch_finish(int retvalue, struct strbuf *err,
>  	struct oid_array *commits;
>  
>  	if (retvalue)
> +		/*
> +		 * NEEDSWORK: This indicates that the overall fetch
> +		 * failed, even though there may be a subsequent fetch
> +		 * by commit hash that might work. It may be a good
> +		 * idea to not indicate failure in this case, and only
> +		 * indicate failure if the subsequent fetch fails.
> +		 */
>  		spf->result = 1;
>  
>  	if (!task || !task->sub)
