Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253EB2021E
	for <e@80x24.org>; Wed,  9 Nov 2016 22:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbcKIW2b (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 17:28:31 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36646 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbcKIW2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 17:28:30 -0500
Received: by mail-wm0-f68.google.com with SMTP id c17so31963806wmc.3
        for <git@vger.kernel.org>; Wed, 09 Nov 2016 14:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Xm4b8h2/H/MJMnQRnMsqIGZTH7Y+BYH6/K/0uZn8RxE=;
        b=PPQx3gwOXkMpEaY4R/lp3semuIQF4AE1C/XxdvecJ5FZIkmvERWUKai+zBOrSrkFk3
         p7RBILV3wgen3rJjY0ynBZ4wIhXGx93EunM85m58cHIbz86YBovDJ77seynOblz2Z2wU
         jMjDAyMtLWfTyR8VsvcVPe4RXK66sS99VjkH26qYcqOLXVICXJXPgWExr25JCeKMuSJT
         0kwXAyQzrBKdL+fmpk6f1SAJryrtD+msUsbKrJhUdTiPV2t52j4eMkUyIUISJN7LpuEH
         YlgqGsGeBss8BasRFpEE+2uz7REQzKDNt5JupNVfiE38hNabGwKLt3rd6aXnPtjOMMQY
         YcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Xm4b8h2/H/MJMnQRnMsqIGZTH7Y+BYH6/K/0uZn8RxE=;
        b=FfZJ8pwqWavXMDT6fFRkErnnlkv5oFmXqOKvFhRFgRiyl+tow/Mxipn5U3B+b4MAMN
         ELxvtHcO9e0Cmlt74XTULLBoKAcrTweqYpU4+TYwdzof/fail5s/t9mIeIAAbHStlbTu
         FSCmemHQEFx4aaFEDDsZelsY+rP1+d/AyulftllbBUOsyQaFkpbKiY8ABzkd5l66N4Db
         sQ5oz4ni8rC9Q6E5W5HjKFhCZvqC1g48a9ioqqw+nwbj7iMABqRIH5V0DWWJsSLrNrTE
         QpSorSrvvf34UfsRXB0FLgwbzlk4fOEFsSXmJb41BO5IH5n7AiYcTuOga4IzKV7THuXf
         Podw==
X-Gm-Message-State: ABUngvdAMbykn89scwufVyWL1VjBYE1f9sjHsDCjrd8B6H2uOFwhE/4w8+N6GenTWJlPNA==
X-Received: by 10.28.111.70 with SMTP id k67mr21973764wmc.32.1478730508673;
        Wed, 09 Nov 2016 14:28:28 -0800 (PST)
Received: from [192.168.1.26] (abpn127.neoplus.adsl.tpnet.pl. [83.8.55.127])
        by smtp.googlemail.com with ESMTPSA id u81sm1542851wmu.10.2016.11.09.14.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2016 14:28:28 -0800 (PST)
Subject: Re: [PATCH] sequencer: shut up clang warning
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <efbba4b32515fed7096c1c81dbe97eedd44083b0.1478699713.git.johannes.schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <11e953de-956d-d4eb-8117-ebbfc410676b@gmail.com>
Date:   Wed, 9 Nov 2016 23:28:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <efbba4b32515fed7096c1c81dbe97eedd44083b0.1478699713.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 09.11.2016 o 14:56, Johannes Schindelin pisze:

> When comparing a value of type `enum todo_command` with a value that is
> outside the defined enum constants, clang greets the developer with this
> warning:
> 
> 	comparison of constant 2 with expression of type
> 	'const enum todo_command' is always true
> 
> While this is arguably true *iff* the value was never cast from a
> free-form int, we should keep the cautious code in place.
> 
> To shut up clang, we simply introduce an otherwise pointless enum constant
> and compare against that.
> 
> Noticed by Torsten Bögershausen.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

>  sequencer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 5fd75f3..f80e9c0 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -619,7 +619,8 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
>  
>  enum todo_command {
>  	TODO_PICK = 0,
> -	TODO_REVERT
> +	TODO_REVERT,
> +	TODO_INVALID
>  };

Why not name it TODO_N, or N_TODO, or something like that?

-- 
Jakub Narębski

