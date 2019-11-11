Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D471F454
	for <e@80x24.org>; Mon, 11 Nov 2019 14:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKKO1o (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 09:27:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41239 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfKKO1o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 09:27:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so14843968wrm.8
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 06:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OICddMaS+RYI1gOcoxQ1dDT2S40kj3yfWokCfssQSKI=;
        b=L5WGQ6nKEEkbw7LX5TkrU5vGR08JleF3FCJ0eYCq1Cw4cuHrD/DDTrIEzAlgh4AvPE
         CERwBCNKm8mZY7X8f/PQHEkusIIGhzniwnWo3eFtOKGt+pKZu2HU+mSOOJerrCX95zOF
         g/JHEo0RFYNIm4dhxvOd2CtKYAKK4MxvYczxR4jjk/aCrUINXVCsCGJs8YftNwZ5yp5i
         7QbbEa3SqS46S/RHPrLQbI5saTjFI2I2UvmTG80HONG1zq0tPjZPKmfgy9yErgIe3boZ
         rObX34+g/Yk25VW6Bn5rnYXVMgH/DhSDZLXfGgyI0HSo+RLsvIS5Y946WpxJ9Kv9fibV
         zNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OICddMaS+RYI1gOcoxQ1dDT2S40kj3yfWokCfssQSKI=;
        b=MIOm61Im2cF5MM+Xnvg32EOGlmiTvSeJtXY2Hg/5kHQinOWIxV+nNwOt9P/W6hF9YH
         9BYrNDHo4NiqPC92FQxSDUmQmcQKdRG/JDMayTmn1v38PkNWAzweY6bH0yEupX7NhkyM
         OCU6o0HssMhEE4Dk4sLG5n8E8TRGn2TItbKMLHq1Znsz3ynufjrskW2U/UcPes6FtOSW
         h321IXq9J8Wq0vzAqtE10o8g/mPbpQrqzpeqwHvSQZKgKjvSFCm+nqwOHcoFAfyO4sOn
         tFu9iHbPY6nTbU7gVdPLqagxXrzNSAYwi8bQJriOtP8gtgTEe+JATzoFfn/hxNxA32DG
         pEMQ==
X-Gm-Message-State: APjAAAXRbJF0DvEoUI5mRjF/WUhaqogcuZkicxG4Oy2SPEfCIHFR36op
        vNVv/ht1Q515YJbysdk8uks6NUe9
X-Google-Smtp-Source: APXvYqyPN6W5N+XxscdKP1Rh0Fs/Kl7bWOZ4opD/gRiSqoUeCh2v5i4UppGHNPhAYc6roOFCnl/lkQ==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr20107351wro.325.1573482462087;
        Mon, 11 Nov 2019 06:27:42 -0800 (PST)
Received: from szeder.dev (x4db606e5.dyn.telefonica.de. [77.182.6.229])
        by smtp.gmail.com with ESMTPSA id 36sm20889876wrj.42.2019.11.11.06.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 06:27:41 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:27:39 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus@gmail.com, stolee@gmail.com,
        peff@peff.net, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] progress: create GIT_PROGRESS_DELAY
Message-ID: <20191111142739.GL4348@szeder.dev>
References: <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <pull.450.v3.git.1573148818.gitgitgadget@gmail.com>
 <656dba5afb818d0caa7616d0e58c9728803f8d04.1573148818.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <656dba5afb818d0caa7616d0e58c9728803f8d04.1573148818.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 05:46:57PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The start_delayed_progress() method is a preferred way to show
> optional progress to users as it ignores steps that take less
> than two seconds. However, this makes testing unreliable as tests
> expect to be very fast.
> 
> In addition, users may want to decrease or increase this time
> interval depending on their preferences for terminal noise.
> 
> Create the GIT_PROGRESS_DELAY environment variable to control
> the delay set during start_delayed_progress(). Set the value
> in some tests to guarantee their output remains consistent.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git.txt   | 4 ++++
>  progress.c              | 8 +++++++-
>  t/t5318-commit-graph.sh | 4 ++--
>  t/t6500-gc.sh           | 3 +--
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 9b82564d1a..1c420da208 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -544,6 +544,10 @@ other
>  	a pager.  See also the `core.pager` option in
>  	linkgit:git-config[1].
>  
> +`GIT_PROGRESS_DELAY`::
> +	A number controlling how many seconds to delay before showing
> +	optional progress indicators. Defaults to 2.
> +
>  `GIT_EDITOR`::
>  	This environment variable overrides `$EDITOR` and `$VISUAL`.
>  	It is used by several Git commands when, on interactive mode,
> diff --git a/progress.c b/progress.c
> index 0063559aab..4ad1a3c6eb 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -14,6 +14,7 @@
>  #include "strbuf.h"
>  #include "trace.h"
>  #include "utf8.h"
> +#include "config.h"
>  
>  #define TP_IDX_MAX      8
>  
> @@ -269,7 +270,12 @@ static struct progress *start_progress_delay(const char *title, uint64_t total,
>  
>  struct progress *start_delayed_progress(const char *title, uint64_t total)
>  {
> -	return start_progress_delay(title, total, 2, 0);
> +	static int delay_in_secs = -1;
> +
> +	if (delay_in_secs < 0)
> +		delay_in_secs = git_env_ulong("GIT_PROGRESS_DELAY", 2);
> +
> +	return start_progress_delay(title, total, delay_in_secs, 0);
>  }

Note that there is the similar start_delayed_sparse_progress()
function, which should respect GIT_PROGRESS_DELAY as well.

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index c0f04dc6b0..7f79eedd1c 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -103,9 +103,8 @@ test_expect_success 'auto gc with too many loose objects does not attempt to cre
>  '
>  
>  test_expect_success 'gc --no-quiet' '
> -	git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
> +	GIT_PROGRESS_DELAY=0 git -c gc.writeCommitGraph=true gc --no-quiet >stdout 2>stderr &&
>  	test_must_be_empty stdout &&
> -	test_line_count = 1 stderr &&

Good, I'm glad to see this "how many progress lines did we print?"
check gone.

>  	test_i18ngrep "Computing commit graph generation numbers" stderr
>  '
>  
> -- 
> gitgitgadget
> 
