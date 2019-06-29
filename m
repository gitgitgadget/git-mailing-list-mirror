Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 306231F461
	for <e@80x24.org>; Sat, 29 Jun 2019 17:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfF2RXk (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jun 2019 13:23:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55256 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfF2RXk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jun 2019 13:23:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so11940246wme.4
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8A7rhKxjABJ6q+ygMDlFPAFl4t/indN9hKUco/1qp7A=;
        b=gOSf1yJhSNGc/tyleUTDfDQVpX7Ba7/BsFjyBlpQJ6S8Bd/KWh1ILJy+PN1yPBJQrI
         xAF5+PQaa8FoxduM8izUBMqGYxFesdlagX31h8KrrKBq1lutnXqQLX4AReHA9W3hQ8dr
         MXm1dcLX0qDxSKV5wjAFCjnqp6v49iwsHmjd8q7R7JY9CzYjTNvrRCfvBFr169yjVebi
         L7SCYeI9WuOeOjs9HUnw/dL8ZzgyZBdUEBny6IcUVuusSNC20XPTJ2Gt2Lnmi1vYPZ4M
         ieGUaXERVRpC70GJhFvjGnUJ+Z/smdtuB9YNzdLvBX5Dd7eq0jZSfNtTHwEx78aU7ePx
         6iXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8A7rhKxjABJ6q+ygMDlFPAFl4t/indN9hKUco/1qp7A=;
        b=XgPHhTDNjhGD3sZHVcBpt1if2hnbAjBqtd0GZ5iqjvL02BwajH0kLzIqmF83fqUL6Z
         oLtG1R2gG29HpoUNTu+3bosPWpr0CkiF6FqnnCpx/Vycbpy8we8IwVT06SuqGHyqV4lw
         8BaeCYpglurF4D1tmUcuHsHqdVBi9F4VoIOPN9ZDTuVgZOcJUT6fOveDKxP78kKhcMS5
         nAgdoBj9hWi21FyBMpuhTUztG+DOyVP3zN0tMYMC5kQsvC9e/qH/bbG13BwOvOWO2ldn
         aOK6lyJwVY1QZBeeZ1sLvDlRy2DJR3aQwTUXg8kJoqmI/3MH605p0fMtPgeLYQW/dnEa
         gb2A==
X-Gm-Message-State: APjAAAUKvXlLx+KeLQWurwFZPRc/RuQle9oDPpG5BV02HUgM4OTz36l5
        swkVdEY3tmyHCLPs8LGkZ1I=
X-Google-Smtp-Source: APXvYqzjyI9ZA0HO8gFxTm91ba2RF+Nr0tNHNwSejuuGB7tRRF66/kmQPT2HT/YfNCXRHBGpBTS2hg==
X-Received: by 2002:a1c:5f87:: with SMTP id t129mr11921869wmb.150.1561829017906;
        Sat, 29 Jun 2019 10:23:37 -0700 (PDT)
Received: from szeder.dev (x4db511ea.dyn.telefonica.de. [77.181.17.234])
        by smtp.gmail.com with ESMTPSA id h133sm4930953wme.28.2019.06.29.10.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 10:23:37 -0700 (PDT)
Date:   Sat, 29 Jun 2019 19:23:35 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 02/11] commit-graph: return with errors during write
Message-ID: <20190629172335.GH21574@szeder.dev>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
 <pull.112.v5.git.gitgitgadget@gmail.com>
 <95f66e85b2fe93a218dad4c04c16718d053fb002.1560346173.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <95f66e85b2fe93a218dad4c04c16718d053fb002.1560346173.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 06:29:37AM -0700, Derrick Stolee via GitGitGadget wrote:
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index e80c1cac02..3b6fd0d728 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -23,6 +23,14 @@ test_expect_success 'write graph with no packs' '
>  	test_path_is_file info/commit-graph
>  '
>  
> +test_expect_success 'close with correct error on bad input' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	echo doesnotexist >in &&
> +	{ git commit-graph write --stdin-packs <in 2>stderr; ret=$?; } &&
> +	test "$ret" = 1 &&

This could be: 

  test_expect_code 1 git commit-graph write --stdin-packs <in 2>stderr


> +	test_i18ngrep "error adding pack" stderr
> +'
