Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3C71F597
	for <e@80x24.org>; Sun,  5 Aug 2018 04:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbeHEGXH (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 02:23:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42662 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeHEGXH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 02:23:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so4670702pgp.9
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 21:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U4zgiEhiHAYeKMdUt14as5atyiKUak6WhPTUjpjWhaU=;
        b=ZnUc7+btzjE98vzsPMNOerxC5Lreq8gOQANBiSZVCgyZCJ6KZ45fsI+wwiorkAm4R7
         po+y6Q6LoUB0Y04uTkAuMK/jKHZ/2dGkm/Ka4I78/IDpU1s/eboD+Z1E/O5S/T2/tFpC
         9O689YTtohTs7FpfsO864MwWCa1O2ZhHqzBgRusT9E0F+feAklFMPUTOQgXNpeDfBsRp
         xvHImaM+ThmoNRZpPKS5gDAYz/fFN0292AeXQV5OztbwS++PI5Bso4hQID0Ts2Io0Mdj
         FHafNuP/PQpNz3tB5HnS+SYtOd8t7mOqa5fJoJtiptb31WQ0yawKswK2u4HsgkOovP3F
         3s+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U4zgiEhiHAYeKMdUt14as5atyiKUak6WhPTUjpjWhaU=;
        b=rmb+fFaEMSsyKCetFLKURRxVff9xIw4xZGLxlqKyMravTqamdOhOpx0M4FefzBRIr5
         zb4wO+3YxtLhp6YFPnqppDGqQj1UEEQWqe2EoD956+Jx/dVpvKmqj15S5zoXF34no3ps
         ndc47MoigPadXsrW0wRneJgKdEn2SSEIAr0eEHRpzh+xyikmqVjDiZu13wAU0wUKqnOJ
         4BnoGy7Rl7+wMVmUCKGiCZENN/VmbLa7dymtxVrh59iaielyqagbU8rcZdZdDXZvsiFL
         rl1tyZDCPh8qab9iFZYQ1Rgkpp6CARv7wrOM9O7KMA96W7O2RW/1WRIKOeke/xw3p0Z8
         aUzQ==
X-Gm-Message-State: AOUpUlEFJxNNpnLlDBAihVguFuoMjjGaWNGqbcW1NaXD32Bf3POy9v9i
        wuLWoUBoMtnA0OAfa6BR4xs=
X-Google-Smtp-Source: AAOMgpf8vEjgb+CHwKz5IkvrQdSz5C6iDBn0o9bHz9bgwIMdb/wxRY/BywVoDP/GT4ccpkeTjK4Twg==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr9501580pgh.175.1533442798009;
        Sat, 04 Aug 2018 21:19:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v89-v6sm8570066pfj.22.2018.08.04.21.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 21:19:57 -0700 (PDT)
Date:   Sat, 4 Aug 2018 21:19:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     William Chargin <wchargin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
Message-ID: <20180805041956.GI258270@aiede.svl.corp.google.com>
References: <20180805022002.28907-1-wchargin@gmail.com>
 <20180805022002.28907-2-wchargin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180805022002.28907-2-wchargin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

William Chargin wrote:

> Subject: t/test-lib: make `test_dir_is_empty` more robust

This subject line will appear out of context in "git shortlog" output,
so it's useful to pack in enough information to briefly summarize what
the change does.  How about something like

	test_dir_is_empty: avoid being confused by $'.\n.' file

or

	test_dir_is_empty: simplify by using "ls --almost-all"

?

[...]
> +	test_expect_success 'should fail with dot-newline-dot filename' '
> +		mkdir pathological_dir &&
> +		printf \"pathological_dir/.\\\\n.\\\\0\" | xargs -0 touch &&

I don't think "xargs -0" is present on all supported platforms.  I'd
be tempted to use

		>pathological_dir/$'.\n.'

but $'' is too recent of a shell feature to count on (e.g., dash doesn't
support it).  See t/t3600-rm.sh for an example of a portable way to do
this.

Not all filesystems support newlines in filenames.  I think we'd want
to factor out the FUNNYNAMES prereq from there into a test_lazy_prereq
so this test can be skipped on such filenames.

[...]
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -568,7 +568,7 @@ test_path_is_dir () {
>  # Check if the directory exists and is empty as expected, barf otherwise.
>  test_dir_is_empty () {
>  	test_path_is_dir "$1" &&
> -	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
> +	if test "$(ls -A1 "$1" | wc -c)" != 0

Another portability gotcha: wc output includes a space on Mac so this
test would always return true there.  How about

	if test -n "$(ls -A1 "$1")"

?

"ls -A" was added in POSIX.1-2017.  Its rationale section explains

	Earlier versions of this standard did not describe the BSD -A
	option (like -a, but dot and dot-dot are not written out). It
	has been added due to widespread implementation.

That's very recent, but the widespread implementation it mentions is
less so.  This would be our first use of "ls -A", so I'd be interested
to hear from people on more obscure platforms.  It does seem to be
widespread.

Can you say a little more about where you ran into this?  Did you
discover it by code inspection?

I do think the resulting implementation using -A is simpler.  Thanks
for writing it.

Thanks and hope that helps,
Jonathan
