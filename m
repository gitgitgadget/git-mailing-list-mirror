Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89AE2027C
	for <e@80x24.org>; Thu, 13 Jul 2017 22:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbdGMWoL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 18:44:11 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32971 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdGMWoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 18:44:10 -0400
Received: by mail-pg0-f54.google.com with SMTP id k14so36379774pgr.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 15:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lS0N+cHZvDZyPJmxm+M1diZimM5T0HDH45eGl7wSIGM=;
        b=cTAB5+G/OZTtXBvt00p/hIUwwR9sN59MAWfy6jpgp+Y4M+NA1cZXGE+Hw1R9Qd6ptJ
         iNm8+/sKGBWliGKBhEaPHMuPFfWP2IrX24xwz4MantwPajeDU4i/R3qiJjF0zoHIxSt6
         f7PhbmAAJXRAUy5hsbEoYvtBioF0mPNyHQMo/3NioUdsAImbfhdhuvh+IZQOXm0CdC7K
         mQLKf3nwK/hf62cDkJy02Ty1CcLqX29501qoluePyjaAaXEhE4LSJhIqRse420BSnFPM
         ng5dC9DQpPuXIG7gqG/OslK1bUQrj26MQrU8mxzoeS2Wmg8SSYvmYIE/U2el4mN3AYmM
         4HfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lS0N+cHZvDZyPJmxm+M1diZimM5T0HDH45eGl7wSIGM=;
        b=EEn3mw6fcWVJ/f9mFOv8L6YrsUB6ybcS3sJTrX4mXfi8x+a/ZGsiSxW/PJotDMKc2N
         MaTjtji9wjY3YKyK0HToTVtWpKmy9PkZg3R49tIhq8KCOkFld2mOH+r6cGuF+Crq7pGk
         xOuZxQqObptgMwZueWK7sKvdR6uddwcbirL+6Mzgolrs2WzQVr075W//D/kQnU723awy
         O/jEyQVnd+JBiDNHDb75LjcVYaaTbqWkPupXu22HMEAZGNUURb5tkCHlWzvqBs1eGtg7
         Rfo7zyypmWtg7/JKn1pfQzCMaZJr1ro2U+fdpC5agoD5VeRMZ3CQZonFQQEbXNmlJ0Hf
         eLBQ==
X-Gm-Message-State: AIVw110oXFkSVA85Mjjbqjtb9QywHXBWMmLOV4zBUNPBy7x4wEbJQJCC
        BRa5rGNq9SYTotozCcBd/+M4gxaBWVan
X-Received: by 10.84.215.197 with SMTP id g5mr12520137plj.297.1499985849991;
 Thu, 13 Jul 2017 15:44:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 15:44:09 -0700 (PDT)
In-Reply-To: <20170713200538.25806-4-pc44800@gmail.com>
References: <20170630194727.29787-1-pc44800@gmail.com> <20170713200538.25806-1-pc44800@gmail.com>
 <20170713200538.25806-4-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 15:44:09 -0700
Message-ID: <CAGZ79kb18z5zc9iu3Vv5aVZWJmoZzmwbMVpy89VC-t-ei2M+bw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 4/5 v4] submodule: port submodule subcommand
 'status' from shell to C
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 1:05 PM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> This aims to make git-submodule 'status' a built-in. Hence, the function
> cmd_status() is ported from shell to C. This is done by introducing
> three functions: module_status(), submodule_status() and print_status().
>
> The function module_status() acts as the front-end of the subcommand.
> It parses subcommand's options and then calls the function
> module_list_compute() for computing the list of submodules. Then
> this functions calls for_each_submodule_list() looping through the
> list obtained.
>
> Then for_each_submodule_list() calls submodule_status() for each of the
> submodule in its list. The function submodule_status() is responsible
> for generating the status each submodule it is called for, and
> then calls print_status().
>
> Finally, the function print_status() handles the printing of submodule's
> status.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> In this new version of patch:
>
> Instead of using cmd_diff_files(), the process is optimized
> by using ce_match_stat().

Apart from this I have reviewed the patch and found it a faithful
conversion.

I am not an expert in the diff area  and wonder how
the cmd_diff_files functionality is achieved with just a stat call
and then comparing it to  ce_match_stat. 'Using "dirty" ignores
all changes to the work tree of submodules, only changes to the
commits stored in the superproject are shown.' So I'd have
expected ce->oid to be compared (is there an index entry differing,
i.e. more than one stage?)


> Also, the child_process running the command 'rev-parse --verify HEAD'
> is removed for optimization reasons, and instead head_ref_submodule()
> is used with callback function handle_submodule_head_ref().

Cool.
