Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50C3720C31
	for <e@80x24.org>; Fri,  8 Dec 2017 17:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbdLHRX2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 12:23:28 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:38284 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdLHRX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 12:23:27 -0500
Received: by mail-it0-f66.google.com with SMTP id r6so6235915itr.3
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 09:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uMB31IHVz3xpMvT8UKYBzZgbR4XS/zNpEcCmuRvp7nA=;
        b=ndT5qLzILa75kZT0dCZms9AWSy4COh8i3/hegJA1k+l8kyeEEOR/P5JXFCC1Q1lQCP
         Mas6QxRu5auDRV7sVAGwoW7K4yA5ULCcjvrtym8JnBpTAhK7I5d6RLt/Py//tyeHsmXQ
         f6pM6kX1tfumKTptPWVStbza9km+1HAnO4D+d1cAMyVZ1CvaLd3vATm9d3CYaY6xhzZd
         t+J0syX8ZCKA31426tlBh74og2tGuWfMUb1mVRbwhUwn3Ojk9C9PCtqxXrZ6AH5y99cE
         S3bstFUuIuE/Z2nRrG2pkeMG6DSHxWVwtFciduqFpD45EDWBE/EWq6Zb5Gapsznlbs9R
         GzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uMB31IHVz3xpMvT8UKYBzZgbR4XS/zNpEcCmuRvp7nA=;
        b=YEYY7BbacfVFEkBGbZLrZcTn1OG5opE40ypJIJ86gvIQw4BbabWIuUMp6sVnOb1o3U
         eZlwde2i37ue457Bw15CAiktv7KvDo6IktzRBl7hPCTV6fdyvxKUQkEq/IEMoPq8irKZ
         kIAu8Z95yFxDPTKkg0KjneA3/V+cm7dwkr3FRXmB7G/1OW7mhflpPF/dAxE8PTOZ8HSf
         4SVICMu4ZsX1qJWXabu/4Toml1ZjvSJaVuVi7sEoLb0czJ/ywQhHsQW03g98ttt2R1aY
         8amCnR1i75X0xr9W/ksrfMStFhbuZzsA3v6MnmgDvpWzx9mwQtQjmjYf6DsVMR7eo+jZ
         xtrQ==
X-Gm-Message-State: AKGB3mLJP9pLCwJ98O+1/l4nHxuG4ZYMddjcQ4Ay2nLqk2qjavoVtiii
        vntGO2Pgc8o3mZSalWFIKpI=
X-Google-Smtp-Source: AGs4zMYiOlvb6fBbOB9AiRhv9ZmD+rwKDutiTefFkPw0koW64Apcf3HAwSB+uwAKbzpO9N6ccBOmZw==
X-Received: by 10.107.172.4 with SMTP id v4mr16261414ioe.234.1512753806732;
        Fri, 08 Dec 2017 09:23:26 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v9sm1017353itv.35.2017.12.08.09.23.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 09:23:26 -0800 (PST)
Date:   Fri, 8 Dec 2017 09:23:24 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Adric Norris <landstander668@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git version --build-options: report the build
 platform, too
Message-ID: <20171208172324.GB14261@aiede.mtv.corp.google.com>
References: <cover.1512752468.git.johannes.schindelin@gmx.de>
 <978adf12e85ec6c4d407ba09da82945a08ee1f8c.1512752468.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978adf12e85ec6c4d407ba09da82945a08ee1f8c.1512752468.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> From: Adric Norris <landstander668@gmail.com>
>
> When asking for bug reports to include the output of `git version
> --build-options`, the idea is that we get a better idea of the
> environment where said bug occurs. In this context, it is useful to
> distinguish between 32 and 64-bit builds.

Neat!

The cover letter gives a clearer idea of the motivation:

	In Git for Windows, we ask users to paste the output of said command
	into their bug reports, with the idea that this frequently helps
	identify where the problems are coming from.

	There are some obvious missing bits of information in said output,
	though, and this patch series tries to fill the gaps at least a little.

Could some of that text go here, too?

[...]
> --- a/help.c
> +++ b/help.c
> @@ -390,6 +390,7 @@ const char *help_unknown_cmd(const char *cmd)
>  
>  int cmd_version(int argc, const char **argv, const char *prefix)
>  {
> +	static char build_platform[] = GIT_BUILD_PLATFORM;
>  	int build_options = 0;
>  	const char * const usage[] = {
>  		N_("git version [<options>]"),
> @@ -413,6 +414,7 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>  
>  	if (build_options) {
>  		printf("sizeof-long: %d\n", (int)sizeof(long));
> +		printf("machine: %s\n", build_platform);

Can this use GIT_BUILD_PLATFORM directly instead of going via the indirection
of a mutable static string?  That is, something like

		printf("machine: %s\n", GIT_BUILD_PLATFORM);

>  		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */

What do you think of this idea?  uname_M isn't one of the variables
in that file, though, so that's orthogonal to this patch.

[...]
> --- a/help.h
> +++ b/help.h
> @@ -33,3 +33,16 @@ extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, stru
>   */
>  extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
>  #endif /* HELP_H */
> +
> +/*
> + * identify build platform
> + */
> +#ifndef GIT_BUILD_PLATFORM
> +	#if defined __x86__ || defined __i386__ || defined __i586__ || defined __i686__
> +		#define GIT_BUILD_PLATFORM "x86"
> +	#elif defined __x86_64__
> +		#define GIT_BUILD_PLATFORM "x86_64"
> +	#else
> +		#define GIT_BUILD_PLATFORM "unknown"
> +	#endif
> +#endif

This code needs to be inside the HELP_H header guard.

Thanks and hope that helps,
Jonathan
