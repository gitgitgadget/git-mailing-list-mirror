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
	by dcvr.yhbt.net (Postfix) with ESMTP id 53F1A20248
	for <e@80x24.org>; Sun, 17 Mar 2019 13:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfCQNFs (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 09:05:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43327 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfCQNFs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 09:05:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so14078855wre.10
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2M2FxHfdy1SVZ75Spb5CEbbw7wAE5gq+daBHOVYVGiE=;
        b=cprOIbj4DTLksJhSIrX97FGMaxNqyMz7Gr8uTGn9xO4s4mZ6E7AFmcxJKSpwI/09g8
         8Ng2ILNwz0dsfdq2hwHcT8+b9+Yc9UP6uOvd6OAeZpw7ZAozQsmoAovnk16Zq0Irttkb
         d/qRDzW/DQLoddyCXfmkwe3JpVTAJyWqi5pkRSZjMcFs6bOZiKyuMgiveni4LrRUXqC9
         7YOrT3vBahKDlZDWnbzr4tAoG0s3KuDql4B85j4qIgtzgLmHYssaAeaTxO1RJDfOj1RH
         uK/08V1h1ZX3Q0Av7uyA/1j8a8KgfJBzta2TKekObkLe/uz/Bbfxu03TJ51DjsIpmsUt
         jeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2M2FxHfdy1SVZ75Spb5CEbbw7wAE5gq+daBHOVYVGiE=;
        b=MOsUlao1EUiUok4xNdCw6Ufj+ITS7UrcHOeMJ1qvMyT+8UNXLGcc+5FYnKHq5eusiH
         zJ/6s8NOgMJ2V+9Xw10KelaOCR0cFVVDKskn0E0dld6ieUq/RO5V1sfrPGhi8LtECtm9
         1Fbj62anrQ2qC3b2LlX2Kn4FZWjTIayPwoaHxDD8pjIrtj++FMw2js4/pmdLaMvW1dGb
         XGOTnPZCulW9Y8e/LUgwK+gNVLcsctl6gsAamppMyiHhu0lEfdQE8E3Ygsk6kFWjqyMz
         y6/154nJsId0XhzXC4AQciK/6ooi0ZV8uCwdwwbNctIb4rjl4IP3HYS+NpZFOdhcOwPt
         aaIQ==
X-Gm-Message-State: APjAAAUOwY6mCircB5xAiBHj6xYj6AWSsNJC5zkU9pMoK9iJM+qvlVmr
        5UQRpYJ0xv50VqnpfITvmfPe0E83
X-Google-Smtp-Source: APXvYqzUNFTwlVJ/LHt0jgnzYpOTR0j7eLiRQVGOwOcORetzIN5OGQEiQCVucgoXelYrqyZWhHitqQ==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr8875108wrm.36.1552827946438;
        Sun, 17 Mar 2019 06:05:46 -0700 (PDT)
Received: from szeder.dev (x4dbe9ef8.dyn.telefonica.de. [77.190.158.248])
        by smtp.gmail.com with ESMTPSA id u134sm3493767wmf.22.2019.03.17.06.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 06:05:45 -0700 (PDT)
Date:   Sun, 17 Mar 2019 14:05:39 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v8 00/11] Fix scissors bug during conflict
Message-ID: <20190317130539.GA23160@szeder.dev>
References: <cover.1552275703.git.liu.denton@gmail.com>
 <cover.1552817044.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1552817044.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 03:15:50AM -0700, Denton Liu wrote:
> Sorry for taking so long to do a reroll, I've been pretty busy this week
> and I've only been able to find the time now.

No problem, and thank you for sticking with it!


> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index ca4a740da0..f035e4a507 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -16,7 +16,9 @@ commit_msg_is () {
>  # Arguments: [<prefix] [<commit message>] [<commit options>]
>  check_summary_oneline() {
>  	test_tick &&
> -	git commit ${3+"$3"} -m "$2" | head -1 > act &&
> +	git commit ${3+"$3"} -m "$2" >act &&
> +	head -1 <act >tmp &&
> +	mv tmp act &&

Here you could swap the order of when you write to 'act' and 'tmp',
and thus make the 'mv' unnecessary, like this:

  git commit [...] >tmp &&
  head -1 act >tmp &&
  [...rest of the test...]

Note also that 'head' (or 'sed' in later tests) can open its input
file on its own, there's no need to redirect its standard input.

This is a recurring pattern in patches 1, 4, 8, and 9.

> @@ -142,8 +144,8 @@ test_expect_success 'sign off' '
>  	>positive &&
>  	git add positive &&
>  	git commit -s -m "thank you" &&
> -	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
> -	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
> +	actual=$(git cat-file commit HEAD >tmp && sed -ne "s/Signed-off-by: //p" <tmp && rm tmp) &&
> +	expected=$(git var GIT_COMMITTER_IDENT >tmp && sed -e "s/>.*/>/" <tmp && rm tmp) &&
>  	test "z$actual" = "z$expected"

May I ask you to go one step further in restructuring this and the
following tests? :)  Instead of using 'test' to compare the contents
of the $actual and $expected variables, use 'test_cmp' to compare the
'actual' and 'expected' files, something like:

  git cat-file commit HEAD >tmp &&
  sed -ne "s/Signed-off-by: //p" tmp >actual &&
  git var GIT_COMMITTER_IDENT >tmp &&
  sed -e "s/>.*/>/" >expected &&
  test_cmp expected actual


 
