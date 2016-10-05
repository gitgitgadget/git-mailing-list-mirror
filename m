Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D50921F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 19:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbcJETCP (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:02:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33869 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbcJETCP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:02:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so61257wmb.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 12:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2ttz/wPnMcFBzzV9VZM4z1+bsHjlSfNvCBht+ti/Brs=;
        b=gM2MG61S9Dcggq94lFehBUjRhHdcK53q4ZrALlVDTfAmhJBd+2KSE5OP3aqYdpWiPu
         PlX14tGKUK2CwxgQbW7DCKQ1VKxOKJM4iQ5wzsZFKHRPwPlxKq0CZNk/c1NDQvxv/lme
         mWEKclu2HZ1qzfmY6Ag0qn2cw6VWtlWROaHKHu1tRkH03bgP5oghokPRZYguB4sn3ELO
         Gewwpd1X/nxxLRSOk0VdCdrZbZOt/3N8lSt821Ia3jRMCyQuBo6YWT0ugq1hwpqtNtsJ
         8r+N/ntfoYvnn69ulUrRyiobBDi7fPrgqLYK608EpAcqO1CW6NeulkkFsYv0JU2VCsD9
         T1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2ttz/wPnMcFBzzV9VZM4z1+bsHjlSfNvCBht+ti/Brs=;
        b=UBXqV3KCoi4tqr4JlOKDAUOkbb481vFkoGqUA+0zYfA64r+rXe18Zarn4Hzrh9/fEL
         LSllq62WZLqFO6RMWFdX6r8hr8x3KyoEN2LR8QEEnSPg3Jz3GKFGAk9uE9rjIEFn52sI
         d6eubxwND7HhLTsvGu15Smp1CslKI70sgEislfpyBHUP5zupJVIcHhd/S/j6HMx6RSpx
         JcJkWAtbH+s3WLaLyD42eJCrzTtPCiFWHsbhaoSpg9GEKwetKQNz/uefelWQZyzupO+A
         snB2dKvd5pnxSjIOxJ+3bX0ErnW80vmV2hdIBjgHYffD/Es1G+dhKHrpsg+b9y+U0cA2
         DYXA==
X-Gm-Message-State: AA6/9RkdXplWuL5vseEk5hXAwVfYiQGM3XSzgXRU0A95XJs4drfjiGKjuv4y+K6x3iFO9w==
X-Received: by 10.28.87.16 with SMTP id l16mr9871908wmb.75.1475694133789;
        Wed, 05 Oct 2016 12:02:13 -0700 (PDT)
Received: from [192.168.1.26] (acte13.neoplus.adsl.tpnet.pl. [83.11.58.13])
        by smtp.googlemail.com with ESMTPSA id w71sm10943319wmw.17.2016.10.05.12.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 12:02:12 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] check_connected: accept an env argument
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20161003204851.klwspo6agykx6s3q@sigill.intra.peff.net>
 <20161003204908.3nlg6xq2whg2senj@sigill.intra.peff.net>
Cc:     David Turner <dturner@twosigma.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <6ed4670d-6835-a45e-2842-cfe65b0e2981@gmail.com>
Date:   Wed, 5 Oct 2016 21:01:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161003204908.3nlg6xq2whg2senj@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 03.10.2016 o 22:49, Jeff King pisze:

> diff --git a/connected.h b/connected.h
> index afa48cc..4ca325f 100644
> --- a/connected.h
> +++ b/connected.h
> @@ -33,6 +33,11 @@ struct check_connected_options {
>  
>  	/* If non-zero, show progress as we traverse the objects. */
>  	int progress;
> +
> +	/*
> +	 * Insert these variables into the environment of the child process.
> +	 */
> +	const char **env;
>  };

Just a nitpick, but I wonder why one comment is in single-line form,
and the other uses block-form with a single line.

-- 
Jakub Narębski, bikeshedding

