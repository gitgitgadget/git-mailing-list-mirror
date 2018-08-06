Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 220D8208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbeHFR0X (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:26:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38633 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbeHFR0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:26:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so12747638wro.5
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7TvTEPgF60GeSuq9E3WULyHcLFauNRWg7OjBs0WZq3U=;
        b=DF6KrbVwAoxATgrTwUQ+Ia5WmJieflHbVN9wmyq+QPcvTvM0x+XBE89bwFDKd8ip7H
         JlVXp/jCOUCKPEQFW3oJhtsxbxy55N4L6hKhIZshaHDeeQFdWGrR1zO1Aa7zTVZfV4ys
         9DCSfmJ0Zvwns6BlYfZFdZlJTzgvFR/bEGav81RCgBcH7thBQplPILVqafRT0jof/9v7
         3c+WgmJlBouRr1n/Ew2Hxnr+HPLlqi92DfplRhPMEIzYD3q8yzYSO9OgBYVdKRFmWn29
         IktvuaWi7BoudXglE8pI7Ibo54Rj6yYqdzYrhT47k4flTMRM1Ou/wXIbhRilgXwNQJ3J
         2qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7TvTEPgF60GeSuq9E3WULyHcLFauNRWg7OjBs0WZq3U=;
        b=c/DX6niyxXHRnz947D7ZGmgt9i1ZfpbWHVWY4VWa8Ixqsn1QkH4AGJ3ZFW7BG2gKGl
         Teh6IAq0NUnzOrqWJXOloZjgZuTOKosWQcgHvMNn92yVIj75SGCBAxaqk7B7/7WvXp31
         MzClLHxaSjGrg5I5zQiRbFOz8lKw79pqe2zdsLeYCBSS6/ZJllPQxdzIii66CN8IcLYB
         mhmXGMfySGpKLfcHhDNgi+T812DQr9GdBGNnBP+/nu1rtgfv+RnEtbm1HHspXRDbUWTm
         ePluncDtw8AQhsI4xe1wb+kqkfYm+Ur3OS3lxtuNIGQVfREf9M1NHpE0GA1zngr322uz
         Wm2A==
X-Gm-Message-State: AOUpUlFmr+f9Gp5NktSmNLZVI+TN42qpcljqaNuRQGzF/infIwu4PgGJ
        5xjUYYYMc5pw9iHMic1jt+up+v7j
X-Google-Smtp-Source: AAOMgpdxVvK8jQ3ao6vb6N4orO4w1fKyDRSVUXw0Pf14j44i4j1VM1GI/6ax7pwsWUeR1ZxOKTJNjg==
X-Received: by 2002:a5d:51cf:: with SMTP id n15-v6mr9883384wrv.107.1533568608330;
        Mon, 06 Aug 2018 08:16:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y11-v6sm12847582wrt.4.2018.08.06.08.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:16:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] add a script to diff rendered documentation
References: <20180803205204.GA3790@sigill.intra.peff.net>
        <20180805204930.GA202464@genre.crustytoothpaste.net>
        <20180806133954.GA31282@sigill.intra.peff.net>
        <20180806134237.GB31282@sigill.intra.peff.net>
Date:   Mon, 06 Aug 2018 08:16:47 -0700
In-Reply-To: <20180806134237.GB31282@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 6 Aug 2018 09:42:38 -0400")
Message-ID: <xmqqd0uvr0dc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 06, 2018 at 09:39:55AM -0400, Jeff King wrote:
>
>>   3. Default to number of CPUs, which is what a lot of other threading
>>      in Git does. Unfortunately getting that from the shell is
>>      non-trivial. I'm OK with $(grep -c ^processor /proc/cpuinfo), but
>>      people on non-Linux platforms would have to fill in their own
>>      implementation.
>
> Is this too horrible to contemplate?

Chickens, eggs and a kitchen sink.  Sounds like a title of a movie.

It's a bit dissapointing that we cannot express personal preference
in config.mak ;-)

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 0f09bbbf65..fa8caeec0c 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -635,6 +635,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  			continue;
>  		}
>  
> +		if (!strcmp(arg, "--online-cpus")) {
> +			printf("%d", online_cpus());
> +			continue;
> +		}
> +
>  		/* The rest of the options require a git repository. */
>  		if (!did_repo_setup) {
>  			prefix = setup_git_directory();
>
> -Peff
