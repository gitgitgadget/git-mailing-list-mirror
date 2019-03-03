Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E99020248
	for <e@80x24.org>; Sun,  3 Mar 2019 14:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfCCOT4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 09:19:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42188 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfCCOTz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 09:19:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id r5so2658144wrg.9
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 06:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=StB2Y1LG1k8EUIh+WPIE9FXX0jcfq8Sq2XdQHOL/H8M=;
        b=kyHXbJru39u0AlJP+P4LvIeQU3W2MovOr7TCvC80IEXTrecMoRY/xTHxF2WgoGD00b
         dDI/I9HISkmFzNXPx6YkAj7+CCaQQMw7gY0lENxW9RgK0NVKG7PMtEssghM5whVdbBNF
         agRdcJuvl6lIQ2vNlhQLWybDEXeT8VmqoKumyOmqy7X5aOiO8cyrzPv6Rbljd53SDSF1
         shtaPBjtQW9zwmQv0mus7cpbF6iPwnfRVMmJ0foTQLpHRO+3gDKuteSLsJ8jJfgF1oHc
         M58gWFZ+1LAR132dIIeQga+0jybx7qUkSlrGDgoByckGgmQc5aHufxNt8AyEXIE1PNfc
         2rdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=StB2Y1LG1k8EUIh+WPIE9FXX0jcfq8Sq2XdQHOL/H8M=;
        b=mZOkPdPm3f2wg96U4sLpU8QmlxSPPw260jY6PBUv2svRF3m8hYdVLGWPgHGn/yYqUH
         yMPLctNn+M+vgLtL6mSANIx7yhlWpsvTpvm5VtUkhUtPITk9r8ku8RPrDI8c5uYt1QBP
         TaNH3qVrRahMgCY7XjMm5Eawn34VE3IHOEeS+UOUNoxPDG6YV3GlVIqKKsmL4WibFcmc
         am6glDoNvBMt9PH7VYXPtXbdJDDS0+uTqyJiraMG+Qx93S4FMnVL43VA+DkX7jh1eq/2
         TcaPbiEX+TbEQw2K0x94pr9xfgtS1M+OKQmPt9XENfyVSwzE9/G4sjuHdG3T/ppxme+v
         gHng==
X-Gm-Message-State: APjAAAX0Sr3wBVJe0Hk7M/bHx441nEDwntjW6z2wqKNa5hfTU8r2J1Qb
        dvx6a1cD/S+qy9UOk27A+aI=
X-Google-Smtp-Source: APXvYqw6XKlMjGoRR8rometw+fOsI4AHVRaqX778OCWBi2TcjJ/fSv/nDDocrMozBKxn+P4MKEvv3g==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr9476455wro.255.1551622793800;
        Sun, 03 Mar 2019 06:19:53 -0800 (PST)
Received: from szeder.dev (x4dbe14c7.dyn.telefonica.de. [77.190.20.199])
        by smtp.gmail.com with ESMTPSA id 93sm15630651wrh.15.2019.03.03.06.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 06:19:52 -0800 (PST)
Date:   Sun, 3 Mar 2019 15:19:46 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] tests: introduce --stress-jobs=<N>
Message-ID: <20190303141946.GA28939@szeder.dev>
References: <pull.155.git.gitgitgadget@gmail.com>
 <281d3f1d19d1c93e8d1e66ae16fe3fb286554c0a.1551561582.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <281d3f1d19d1c93e8d1e66ae16fe3fb286554c0a.1551561582.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 02, 2019 at 01:19:44PM -0800, Johannes Schindelin via GitGitGadget wrote:
> The --stress option currently accepts an argument, but it is confusing
> to at least this user that the argument does not define the maximal
> number of stress iterations, but instead the number of jobs to run in
> parallel per stress iteration.

Well, these options' description in 't/README' is quite clear on what
they do.  If the lack of updates to 't/README' in these patches is any
indication, then you haven't read that :) but doing so might very well
have avoided your confusion in the first place.

According to my Bash history, I used '--stress=<even-more-cpu-cores>'
about 20x more often than '--stress-limit=<N>'.  That's not surprising
at all, since the main point is to try to trigger rare, hard to
reproduce failures, no matter how many repetitions it takes.  And even
if there is an upper bound, it is usually not the number of
repetitions I know in advance, but rather the time I'm willing to
sacrifice on it, e.g. how long I'm on lunch break or doing groceries,
or when I need my CPUs for more important things, or simply when I
give up, and hit ctrl-C.

And with --stress-jobs=<N> I will have to type more :)


> Let's introduce a separate option for that, whose name makes it more
> obvious what it is about, and let --stress=<N> error out with a helpful
> suggestion about the two options tha could possibly have been meant.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ab7f27ec6a..6e557982a2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -142,10 +142,16 @@ do
>  	--stress)
>  		stress=t ;;
>  	--stress=*)
> +		echo "error: --stress does not accept an argument: '$opt'" >&2
> +		echo "did you mean --stress-jobs=${opt#*=} or --stress-limit=${opt#*=}?" >&2
> +		exit 1
> +		;;
> +	--stress-jobs=*)
> +		stress=t;
>  		stress=${opt#--*=}
>  		case "$stress" in
>  		*[!0-9]*|0*|"")
> -			echo "error: --stress=<N> requires the number of jobs to run" >&2
> +			echo "error: --stress-jobs=<N> requires the number of jobs to run" >&2
>  			exit 1
>  			;;
>  		*)	# Good.
> -- 
> gitgitgadget
