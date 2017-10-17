Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B7E20469
	for <e@80x24.org>; Tue, 17 Oct 2017 17:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757835AbdJQRmp (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 13:42:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:50952 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754736AbdJQRmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 13:42:44 -0400
Received: by mail-io0-f195.google.com with SMTP id 97so3154345iok.7
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FMcGK7k/YNwoDQiXTAI9iLV73IfXJrAUFLagVEu32Ps=;
        b=RbZIStDNhRSAWhfc0AuKKQORKOcbKaFIoR3Ti3i5U9r9jyW1JY9+nzicxepffDm6ok
         9vvakUHWbelD/Eopv/hFziW9jPm90fM9cpPKHeZb13eIimim/nZavwb0bfq10iu2FLu8
         MKQGDp+8iLPzBlvz9+uB2RFsA3qzNQ/S8ea2B8EeV/3Tgz/VLiuaaO7fkgJf4in27l9S
         VUEtrtI8IEedRhdf6YG9cgyiMI1eFSgc+y6o2gdlsb3hn/DGk1Nc4swa7bI5raPralvC
         67OSyJwX5vfgb/ANA4gn59rsVwBr68o8JCcdM9t5uMAfvUCFinTdmA5MtjWrL6yJ0t/t
         aLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FMcGK7k/YNwoDQiXTAI9iLV73IfXJrAUFLagVEu32Ps=;
        b=ArJHnXRysXqdBN4WkQRMOB16uhcuJgTysuMRkm0hcUg71BTzcenNuYVzO8+pd94mm4
         y7nwJTzRGfH0vqFeEllmV1SgXmd6w6xFkhdu420twmPuBXHkhn2oJO5Hm/rowkXSPp/V
         O14Pba26Ukm1XHifn4EnqM47d+lX7hep6eA2cpY1ciFFuKpKvz7R4mJS/C8AXJmQ05sj
         zMinnTkh0TEevpLr3yGHJhJN3I4rwNKujMoy90SQkmKauFIxW8unkBqusR89QCeVm3nW
         AXDBygXp+mxUbvaoMPxen9U5hm7D4hmKass+HZ2TFX4XnvNaqWpaJI3JoF8zW1z2QsmI
         DgUQ==
X-Gm-Message-State: AMCzsaVXKUCCB0a1kXaMZWQRgqO32pMK5tyFbQ6gYdjOxMAszsTNgrCR
        XVb/f7BvhUSWbRTRjt0OJnw=
X-Google-Smtp-Source: AOwi7QDlXtosUpfizPtbDW7pTzLRiwwxkv9CfV/gPnh2pqBsR6tGplW6pdlW9092XAm9OlhXDe79vA==
X-Received: by 10.107.168.205 with SMTP id e74mr16405137ioj.42.1508262163668;
        Tue, 17 Oct 2017 10:42:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id e69sm4948121ioe.20.2017.10.17.10.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 10:42:43 -0700 (PDT)
Date:   Tue, 17 Oct 2017 10:42:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] ls-remote: use PARSE_OPT_NO_INTERNAL_HELP
Message-ID: <20171017174241.zph32u74k6bmir7v@aiede.mtv.corp.google.com>
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
 <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
 <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
 <f66f3fc2-8f51-03f5-c242-cb6d776af585@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f66f3fc2-8f51-03f5-c242-cb6d776af585@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe wrote:

> Since ba5f28bf79 (ls-remote: use parse-options api) git ls-remote -h
> without any other options has shown the short help text of the command
> instead of acting as the short equivalent of --heads.  Fix this
> regression by turning off internal handling of -h for repository setup,
> and option parsing, as well as the corresponding test in t0012.
>
> Reported-by: Thomas Rikl <trikl@online.de>
> Analyzed-by: Martin Ågren <martin.agren@gmail.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/ls-remote.c  | 1 +
>  git.c                | 2 +-
>  t/t0012-help.sh      | 1 +
>  t/t5512-ls-remote.sh | 6 ++++++
>  4 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> --- a/git.c
> +++ b/git.c
> @@ -421,7 +421,7 @@ static struct cmd_struct commands[] = {
>  	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
>  	{ "log", cmd_log, RUN_SETUP },
>  	{ "ls-files", cmd_ls_files, RUN_SETUP },
> -	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
> +	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY | NO_INTERNAL_HELP },

There's only one other command that uses PARSE_OPT_NO_INTERNAL_HELP, and
that's "git archive".  Does it need the same treatment?

More generally, is there a straightforward way for parse-options or
some compile-time analysis to catch if we forget to add
NO_INTERNAL_HELP to a command in the commands[] table?

Thanks,
Jonathan
