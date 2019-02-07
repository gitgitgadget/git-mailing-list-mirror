Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657F31F453
	for <e@80x24.org>; Thu,  7 Feb 2019 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfBGSyu (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 13:54:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37867 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGSyu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 13:54:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id c8so1016362wrs.4
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 10:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=78OT3HQCjQsNbnUkFeRj6rNGdrziL8N+9MNuJXYxmAA=;
        b=YAU/x+0atq7MWmp2uqmPx7HIT72bCUzS1GlPDGLrhlAsZq/e+y7rNq7J8uLBNSb3Lt
         5JkAdVuIoiwFsoMjCgXT0vz5SeqF1Y6B+coe3Cknoy78gq/ZJEJjjyrLryISq4VyGkHF
         3eCEA7hW9kbGlfKOq7dWslQ9eUZNvbrLoZUoR9T4hfDqvAw5LoK2Rp3bQ0cm4xHwezak
         iU/Q+N9JRHyXr6Yy7/PN5uC6R7bZUM2rIW//73tHt8MYVSvmJDqWqqZ/tHjTNcOBdhpd
         l14uz/aaRe+jllN7quxcIyw2BmaAtNfx53oiQKP7oCaU/LOw+ukv3GUo4ZGcOCJb+vlS
         0N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=78OT3HQCjQsNbnUkFeRj6rNGdrziL8N+9MNuJXYxmAA=;
        b=hQObhDq5r6NtS4XXXar6oEEPQrcF57rolVEm1oknYj0JND7M0WgT+tMU1pQk1g7U/c
         DntZHYxkUQm27vIrveUu+Mjf9b1Fbm4OOW0Uy5Hgx03NtN1xccFssDReSGWdnqz0jEw/
         vEZSyhmT4Wl+SoV7aEdfDKB2tRk3BIzDlskYIn/PWOU1GbO0IfkBPSvt5RacksyWDX4N
         AEPHDO5eQbbnp3405VZ1saqLViddaeKSogB2P9Dg64A1TvlxtWVgsPxHY8CH1oxG67Rd
         w9ii+DCEtfn2pzyFb6GJil9mCFShW+DGFslTF7r4a43QhfkO7M2V69u6cFmwimNi4oeR
         weHQ==
X-Gm-Message-State: AHQUAuZpjhfqRQ0SmF9yxbV90CntK6hu+NXGXBttcWl8Q/XdxRPtcfEU
        bieqd5OBLYg3P3sBEQ5Hn2M=
X-Google-Smtp-Source: AHgI3Ib+q+sUAyDJleKsm/LRABX8WcLpXdWPXIXfxZHLMajhQGy2CKtxgNiEy/j2/mO41HkTACdyGw==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr12874451wrp.80.1549565687373;
        Thu, 07 Feb 2019 10:54:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y139sm127580wmd.22.2019.02.07.10.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 10:54:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     apenwarr@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] contrib/subtree: ensure only one rev is provided
References: <cfd86853cce8a2cd5fae9e6fb9a84f1e3d6daaf4.1549538392.git.liu.denton@gmail.com>
Date:   Thu, 07 Feb 2019 10:54:46 -0800
In-Reply-To: <cfd86853cce8a2cd5fae9e6fb9a84f1e3d6daaf4.1549538392.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 7 Feb 2019 03:20:46 -0800")
Message-ID: <xmqqftszpgy1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> @@ -185,6 +191,7 @@ if test "$command" != "pull" &&
>  then
>  	revs=$(git rev-parse $default --revs-only "$@") || exit $?
>  	dirs=$(git rev-parse --no-revs --no-flags "$@") || exit $?
> +	ensure_single_rev $revs

This applies to anything other than pull, add and push, so certainly
'split' is covered here.

> @@ -716,9 +723,8 @@ cmd_add_repository () {
>  }
>  
>  cmd_add_commit () {
> -	revs=$(git rev-parse $default --revs-only "$@") || exit $?
> -	set -- $revs
> -	rev="$1"
> +	rev=$(git rev-parse $default --revs-only "$@") || exit $?
> +	ensure_single_rev $rev

There are two callers of this helper.  cmd_add passes "$@" but it
does so only after making sure there is only one argument that is a
commit, so this conversion is not incorrect.

I am not sure if the other caller is OK, though.  cmd_add_repository
can get more than one revs, and uses the first one as $rev to read
the tree from, expecting that this helper to ignore other ones that
are emitted from 'git rev-parse --revs-only "$@"'.

For that matter, one of the early things cmd_split does is to call
the find_existing_splits helper with $revs, and it seems to be
prepared to be red multiple $revs (it is passed to "git log", so I
would expect that incoming $revs is allowed to specify bottom to
limit the traversal, e.g. "git log maint..master").  The addition of
"ensure_single_rev" we saw in an earlier hunk near ll.191 makes such
call impossible.  I am not a user of subtree, so I do not know if
it is a good change (i.e. making something nonsensical impossible to
do is good, making something useful impossible to do is bad).

> @@ -817,16 +823,10 @@ cmd_split () {
>  }
>  
>  cmd_merge () {
> -	revs=$(git rev-parse $default --revs-only "$@") || exit $?
> +	rev=$(git rev-parse $default --revs-only "$@") || exit $?
> +	ensure_single_rev $rev
>  	ensure_clean
>  
> -	set -- $revs
> -	if test $# -ne 1
> -	then
> -		die "You must provide exactly one revision.  Got: '$revs'"
> -	fi
> -	rev="$1"
> -

This one already was insisting on a single version, so it clearly is
a correct no-op conversion, but wouldn't this have been already
caught upfront where anything other than pull, add and push are
handled?  I do understand if the new call to ensure_single is made
to the other caller of cmd_merge in cmd_pull, though.

>  	if test -n "$squash"
>  	then
>  		first_split="$(find_latest_squash "$dir")"

In any case, I do not use subtree, and the last time I looked at
this script is a long time ago, so take all of the above with a
large grain of salt.

Thanks.

