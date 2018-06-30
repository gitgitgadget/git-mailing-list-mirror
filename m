Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B422F1F516
	for <e@80x24.org>; Sat, 30 Jun 2018 14:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751185AbeF3O64 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Jun 2018 10:58:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39377 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeF3O6z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jun 2018 10:58:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id t7-v6so9456141ljj.6
        for <git@vger.kernel.org>; Sat, 30 Jun 2018 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WpxigODR1cMz2IR3tUvPrBRTceaPAkBKPurrtgb8ZaQ=;
        b=cp8GcaN8gRZbRuL4TyEyyvP7fkQKUfglhuw8xY033uJ5OtBhdRc4r3j0y4YByxWBQV
         nRudRne2XTOedD5gmY1RXe7+gLde9A/+dQiRCRbX+Nwbu6nCYgoCvSmepZEt7gWYPstR
         gqWWXAkbLRAQMLphiHWOMnw4AroT6cf/L7yv19B4JpHZI3l3HIclA+LjYfIEumEbd+U4
         XHCLGEh3B1vEXi/SG5OvfNlhTWCBbUjmZk2V7orNE7phY8VwhuyU22TEdpBbv9Nifs7J
         51QmkxInd6NP6+cmMBmQJVBymDooOJgPV6CvdiLf/6M4JgoTQbUOK7du13Up6kchNN+E
         KiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WpxigODR1cMz2IR3tUvPrBRTceaPAkBKPurrtgb8ZaQ=;
        b=TPqFZ8j7O+ZtcqdLXkhgslRxmvOwtEb7mh2moMYa6LJuvGXeOa/MLNAxG/FHFMOBcY
         p0WhAI2NjFwqHbG8B/CLGR4gtUSfvNddwl5dWsAZunklesRx6GZwMdNeqFvaIvkbRStz
         XikM1KxNLiW0ZtYCaMYo87D892q99JY5Rr9TWRjXD0XQScERkMJG77tRzK4zvfqkOhOJ
         PfBdazSYcboeIWkAdmAIxfFLBCSUYI9xiAJyKy+Not7HA0LPbAw7G0Gu+DJCdtNTANK6
         aZJeV3K/hwykIAJ4oENJpLFjoNvU5Y4/GI9ZcAhADpEVINcAQYzZ4WHemDgprRC32WNi
         UTdg==
X-Gm-Message-State: APt69E3BaAJvcH0Em8HA10MWyvp5E0Gd31a81+REQbQalAcoDpbR5UQT
        Q/X3p10kX6Gpn5T1jzv2m9U=
X-Google-Smtp-Source: AAOMgpe6DeL1S2Z1ULGrJOBRvKz1/5dVll0FlUiQqXrk/+C74PCN7Iecg8yyKmgOr1WNFPZ0zw71BA==
X-Received: by 2002:a2e:6e0a:: with SMTP id j10-v6mr5292391ljc.61.1530370733902;
        Sat, 30 Jun 2018 07:58:53 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y74-v6sm2206938lfi.61.2018.06.30.07.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 07:58:52 -0700 (PDT)
Date:   Sat, 30 Jun 2018 16:58:50 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Kim Gybels <kgybels@infogroep.be>
Cc:     git@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] gc --auto: release pack files before auto packing
Message-ID: <20180630145849.GA9416@duynguyen.home>
References: <20180630133822.4580-1-kgybels@infogroep.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180630133822.4580-1-kgybels@infogroep.be>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 30, 2018 at 03:38:21PM +0200, Kim Gybels wrote:
> Teach gc --auto to release pack files before auto packing the repository
> to prevent failures when removing them.
> 
> Also teach the test 'fetching with auto-gc does not lock up' to complain
> when it is no longer triggering an auto packing of the repository.
> 
> Fixes https://github.com/git-for-windows/git/issues/500
> 
> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> ---
> 
> Patch based on master, since problem doesn't reproduce on maint,
> however, the improvement to the test might be valuable on maint.
> 
>  builtin/gc.c     | 1 +
>  t/t5510-fetch.sh | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ccfb1ceaeb..63b62ab57c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -612,6 +612,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		return -1;
>  
>  	if (!repository_format_precious_objects) {
> +		close_all_packs(the_repository->objects);

We have repo_clear() which does this and potentially closing file
descriptors on other things as well. I suggest we use it, and before
any external command is run. Something like

diff --git a/builtin/gc.c b/builtin/gc.c
index ccfb1ceaeb..a852c71da6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -473,6 +473,13 @@ static int report_last_gc_error(void)
 
 static int gc_before_repack(void)
 {
+	/*
+	 * Shut down everything, we should have all the info we need
+	 * at this point. Leaving some file descriptors open may
+	 * prevent them from being removed on Windows.
+	 */
+	repo_clear(the_repository);
+
 	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
 


>  		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
>  			return error(FAILED_RUN, repack.argv[0]);
>  
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index e402aee6a2..b91637e48f 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -828,9 +828,11 @@ test_expect_success 'fetching with auto-gc does not lock up' '
>  	test_commit test2 &&
>  	(
>  		cd auto-gc &&
> +		git config fetch.unpackLimit 1 &&
>  		git config gc.autoPackLimit 1 &&
>  		git config gc.autoDetach false &&
>  		GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
> +		grep "Auto packing the repository" fetch.out &&

Not sure if this should be test_i18ngrep

>  		! grep "Should I try again" fetch.out
>  	)
>  '
> -- 
> 2.18.0.windows.1
> 
