Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117DD202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 20:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbdJZUFR (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:05:17 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:47749 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbdJZUFP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:05:15 -0400
Received: by mail-qk0-f175.google.com with SMTP id m189so5826366qke.4
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 13:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OqJ/uOgTMykucRYCUcv2Wbab7WupfIJi9C6Bqu9DE24=;
        b=ukuwl5j/wsB1JJYXgxpZAc9NhRMgrPpPgghOS/OENvDGsHqrlisE2uL/fAM5W7bazz
         gC0/mjQIwuyTJYrLu0XSDjljXwcnvmQrthLEfZKhPsWil0Abe+yFCeXC6PrmMizHGpN/
         Fu6lmPUJTbY5CvASlcIdjYqRBZe5AUa4Gs4OzosoIkB/H0DusS04OtjcuQSaKzYebsPf
         MIQtYbAKD8GpkYNY5ByzGdE/hgJNmsA5zaFc2B87msSFjVd/KgkRp9RS2agL9WXREm18
         0PbDp8aeLI4Hg0rjKO8BshenJhr4xA8G5ZVyjGZQv9cOvryEyxgYe1C96uJ4jzbDXxzj
         sv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqJ/uOgTMykucRYCUcv2Wbab7WupfIJi9C6Bqu9DE24=;
        b=OmJWHKfRSDXOpOcZCjhQZ1uGP5CWfifK2wr/Hz8FocoD0bsWw8VG5lSPvh2153PQ6F
         QrlA3P3ShK+F6aJrO7SMgYN6U3B7p7ygL24epn1pl81XlpD/v77GYd0n2skUIv6wrHT6
         gu1Q5TVzqOShcHv0jxQd1F8c7uEURRjFwqulU2e2/7vPqRWfmh3V6KusKIfIdyxkd51a
         7PtVkHuqjjPqbhV0njv2jCqdfBmKdTfhGgnKMl/ihgFvYWwdJMXE7E1ju7L2Fvl3ilxz
         i0oapkADwmGBhnc6cXMlOhwU07U74OJ+gY/zD3D6BvRC2lLs2fZ519aVtySDxxsjQPnr
         XiUQ==
X-Gm-Message-State: AMCzsaUtv8eDM42reoBdvnVpr0s4mdPtwn/rs51Gr+W3vMju2tGRaLz7
        hKJxfSaAFZrR8bE+NwU/m4o=
X-Google-Smtp-Source: ABhQp+QOwgfTtY6kK0lHLi4GlHkjRlr+G8iBYNsJI9uze7K+6BRK4PAmvFW9CaOcPgYkGPttY9MkNA==
X-Received: by 10.55.128.134 with SMTP id b128mr895493qkd.159.1509048314176;
        Thu, 26 Oct 2017 13:05:14 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z75sm3843626qkb.30.2017.10.26.13.05.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 13:05:13 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] fsmonitor: Don't bother pretty-printing JSON from
 watchman
To:     Alex Vandiver <alexmv@dropbox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20171026013117.30034-1-alexmv@dropbox.com>
 <42fd8bccb78992a2894e711e057230a673891628.1508981451.git.alexmv@dropbox.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9bd24b15-6232-1afd-abbe-02870c51c7ad@gmail.com>
Date:   Thu, 26 Oct 2017 16:05:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <42fd8bccb78992a2894e711e057230a673891628.1508981451.git.alexmv@dropbox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/25/2017 9:31 PM, Alex Vandiver wrote:
> This provides modest performance savings.  Benchmarking with the
> following program, with and without `--no-pretty`, we find savings of
> 23% (0.316s -> 0.242s) in the git repository, and savings of 8% (5.24s
> -> 4.86s) on a large repository with 580k files in the working copy.
> 

Given this patch series is all about speed, it's good to see *any* wins 
- especially those that don't impact functionality at all.  The 
performance win of --no-pretty is greater than I expected.

>      #!/usr/bin/perl
> 
>      use strict;
>      use warnings;
>      use IPC::Open2;
> 
>      my $pid = open2(\*CHLD_OUT, \*CHLD_IN, "watchman -j @ARGV")
>          or die "open2() failed: $!\n" .
>          "Falling back to scanning...\n";
> 
>      my $query = qq|["query", "$ENV{PWD}", {}]|;
> 
>      print CHLD_IN $query;
>      close CHLD_IN;
>      my $response = do {local $/; <CHLD_OUT>};
> 
>      my $json_pkg;
>      eval {
>          require JSON::XSomething;
>          $json_pkg = "JSON::XSomething";
>          1;
>      } or do {
>          require JSON::PP;
>          $json_pkg = "JSON::PP";
>      };
> 
>      my $o = $json_pkg->new->utf8->decode($response);
> 
> Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
> ---
>   t/t7519/fsmonitor-watchman                 | 2 +-
>   templates/hooks--fsmonitor-watchman.sample | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> index a3e30bf54..79f24325c 100755
> --- a/t/t7519/fsmonitor-watchman
> +++ b/t/t7519/fsmonitor-watchman
> @@ -50,7 +50,7 @@ launch_watchman();
>   
>   sub launch_watchman {
>   
> -	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
> +	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')

Since this is a test script performance isn't critical.  This version of 
the integration script logs the response to a file in 
.git/watchman-response.json and is much more human readable without the 
"--no-pretty."  As such, I'd leave this one pretty.

>   	    or die "open2() failed: $!\n" .
>   	    "Falling back to scanning...\n";
>   
> diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
> index 9eba8a740..9a082f278 100755
> --- a/templates/hooks--fsmonitor-watchman.sample
> +++ b/templates/hooks--fsmonitor-watchman.sample
> @@ -49,7 +49,7 @@ launch_watchman();
>   
>   sub launch_watchman {
>   
> -	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j')
> +	my $pid = open2(\*CHLD_OUT, \*CHLD_IN, 'watchman -j --no-pretty')

No human will see this response so the faster --no-pretty option makes 
sense.

>   	    or die "open2() failed: $!\n" .
>   	    "Falling back to scanning...\n";
>   
> 
