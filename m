Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA36220248
	for <e@80x24.org>; Mon, 18 Mar 2019 12:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfCRMK6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 08:10:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43538 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfCRMK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 08:10:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so16743387wre.10
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 05:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2UpB/l9QdEJnSU3u8Vk1Ey4X5bJQIogCEPg5YSlk5M=;
        b=S3ItYseWh2d+8K98U6veGEWBgtsCtlxBQm/BrqEWsjZ6iR+O0elQImOFe31izI707F
         T+wn364vGfFbOQqhx/Eicj+lfCjPUZP1sov0PjJES3QWahrKJ2CPIjfAkKHhPVeO26Xj
         3i+gGW4UipEAOyBhAK4KWUPJLCNy5Kk0CrrAjR/3LvzphSZzG82amZ4mEE6UyyDPGzmp
         sSGBKrmlgAZCkBX/q+8MOpFncoyj8ka0gUEL5FXo0VchRKRt3RdAn539iWvpgIdEhVtO
         JSqT5YMldiQa/FF5Fdcq+31D5SMnAJ5Ojw5JRBDxMy+xfp2/Lpp0l18Bc58/CV6bCTHh
         yX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2UpB/l9QdEJnSU3u8Vk1Ey4X5bJQIogCEPg5YSlk5M=;
        b=h1N8zzqeHztQDEVD7FwaAHRkwvOJklDNXBoX3T+Bpt3oQO4LSvUk5ZxppRIpPtnEkG
         s/XmdbDZKjw9h/ez15eIqq+MI6NaRDPK3zvNlW0W19RjDBpQNnEDwl11b6h+lLB7gNWy
         /UXtieC5/XD9z6ZMj/TaA6rzyaPNha5yGpk+FLWYnegt/Dczy2gGoRPqC3VEbr6Joqzs
         vHyp+qDaoWFitwLa4OyDoEUerCORRlRNEbZJM9PxzIXEpO3leipIrWpqKC1IKiI9t/cV
         AtKCGrEl2jusOx+vnoNzO4opR2XyRt5GERYErJDkGOOpgwadDHoAdumb/Dv81sgfTPNN
         X4JQ==
X-Gm-Message-State: APjAAAVgEaK8S5NKlESQeWY6NwguwizZWwy7RS3zeoXVHlk2e6VeUKw2
        ALz8FfzI392jqPSI1VX5cQI3uLBw
X-Google-Smtp-Source: APXvYqxSoHHN32bXnJNjN4X8/LcvDDVaMSYYA+yCdxG9X17K6udYz6PHS8nkicZp6OsKpz5Sf9afHg==
X-Received: by 2002:adf:e40b:: with SMTP id g11mr1771049wrm.207.1552911056775;
        Mon, 18 Mar 2019 05:10:56 -0700 (PDT)
Received: from szeder.dev (x4db403cb.dyn.telefonica.de. [77.180.3.203])
        by smtp.gmail.com with ESMTPSA id g8sm6091948wro.77.2019.03.18.05.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:10:56 -0700 (PDT)
Date:   Mon, 18 Mar 2019 13:10:54 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        rafa.almas@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v9 3/3] branch: add worktree info on verbose output
Message-ID: <20190318121054.GC24175@szeder.dev>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190316013807.38756-1-nbelakovski@gmail.com>
 <20190316013807.38756-4-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190316013807.38756-4-nbelakovski@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 06:38:07PM -0700, nbelakovski@gmail.com wrote:
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index ceb74e0826..e5dc23e225 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -328,4 +328,23 @@ test_expect_success '--color overrides auto-color' '
>  	test_cmp expect.color actual
>  '
>  
> +test_expect_success 'verbose output lists worktree path' '
> +	one=$(git rev-parse --short HEAD) &&
> +	two=$(git rev-parse --short master) &&
> +	cat >expect <<-EOF &&
> +	* (HEAD detached from fromtag) $one one

This 'HEAD detached from ..." message is translated ...

> +	  ambiguous                    $one one
> +	  branch-one                   $two two
> +	+ branch-two                   $one ($(pwd)/worktree_dir) one
> +	  master                       $two two
> +	  ref-to-branch                $two two
> +	  ref-to-remote                $two two
> +	EOF
> +	git worktree add worktree_dir branch-two &&
> +	git branch -vv >actual &&
> +	rm -r worktree_dir &&
> +	git worktree prune &&
> +	test_cmp expect actual

... therefore here you should use 'test_i18ncmp', as otherwise the
GETTEXT_POISON test run fails.

> +'
> +
>  test_done
> -- 
> 2.14.2
> 
