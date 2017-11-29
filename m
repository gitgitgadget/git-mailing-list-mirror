Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D4B20954
	for <e@80x24.org>; Wed, 29 Nov 2017 02:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdK2CLi (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 21:11:38 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:41633 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdK2CLh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 21:11:37 -0500
Received: by mail-it0-f47.google.com with SMTP id x28so2252906ita.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 18:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0m0m8YoayH4sL6WAulcj0FVGuDbg2qfy7Con6MQyCDo=;
        b=UpdKlQ8fS/QBeZQApTdKqI3yS6Sf8D6Ns/5MUPU9/5t4YxhRYsQqe39xM7MHlblKA/
         CbKRB+h01kDrJb3mkE32rcICwY0X1CwupSJMPfm50QXchxGggjPQuK4R1wAj2r8aRim0
         sJ8vg7spPRnTIi8HYpvZXZaCyiOHT/8gyPKFZqeg/vIFaEzsk+dRkPYhTaK72ksOPUcM
         LnpagAQ8xGM1wK0+eRN5yyAOPc9PAYaDnS5EAYjaEVp00/YLpz1mXl9RVavWVRQ4svo5
         g112VUWErHc+XQlCFuJw8i7sTYzdNX14T79hjKM2WBOz+tIYEgOSer/NlX7fM4nTgmFm
         g6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0m0m8YoayH4sL6WAulcj0FVGuDbg2qfy7Con6MQyCDo=;
        b=e3rtNThAtv7o5jqpbelZmRyloRYzHqbnOaoq67yfYWtkpdZn59SpGcpaagG7/fRHO9
         gok6MGaNc+QJkEKGf/9pP24+RQIKsyKvVfukgAFdcLJBHahng8ONFsE5hbskaPshPLJu
         CrNW04p39ZFmg13YtnJG17goa+MAc4gsbq90iYBxQTkxmTXBay+r/DBdVK0BTpXt7Xp8
         veIyTfYqTQFpfOUS9idPA1xORKN6ERo2/uDgKyMXHU7hHlJKvPIk9gUgVUky79RniwPs
         tg+GNiCkRr5/FLkYz6uS4pfBwPTy80rDatrKapIiDOPjVG6ugREfMZmp0tVFeSz4FKeh
         l8Ww==
X-Gm-Message-State: AJaThX6nDiwqPBzjknD8ejSasumjWX/Y4o0u0v9HTWsM4Tf08FS26xt9
        Al037Sp5A2xV37eWw/I0tgE=
X-Google-Smtp-Source: AGs4zMa0rd/gewJSFluVceuS/R4bEBb636kjHWhOUKhURNDIj0HwMFA5K0NlqAAFrVaqoswEhP04DA==
X-Received: by 10.36.147.193 with SMTP id y184mr5016411itd.64.1511921497118;
        Tue, 28 Nov 2017 18:11:37 -0800 (PST)
Received: from [192.168.3.104] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id e142sm488948ite.28.2017.11.28.18.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 18:11:36 -0800 (PST)
From:   liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH 4/5] rebase -i: learn to abbreviate command names
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171127045514.25647-5-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1711272344290.6482@virtualbox>
 <20171127231131.GB29636@sigill.intra.peff.net>
Message-ID: <79720807-9e00-af34-b42a-03fd65c58a9e@gmail.com>
Date:   Tue, 28 Nov 2017 21:11:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171127231131.GB29636@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Thanks for taking the time to test this, I'll squash that patch in v2.

On 27/11/17 06:11 PM, Jeff King wrote:
> On Tue, Nov 28, 2017 at 12:04:45AM +0100, Johannes Schindelin wrote:
> 
>>> +rebase.abbreviateCommands::
>>> +	If set to true, `git rebase` will use abbreviated command names in the
>>> +	todo list resulting in something like this:
>>> +
>>> +-------------------------------------------
>>> +	p deadbee The oneline of the commit
>>> +	p fa1afe1 The oneline of the next commit
>>> +	...
>>> +-------------------------------------------
>>
>> I *think* that AsciiDoc will render this in a different way from what we
>> want, but I am not an AsciiDoc expert. In my hands, I always had to add a
>> single + in an otherwise empty line to start a new indented paragraph *and
>> then continue with non-indented lines*.
> 
> Good catch. Interestingly enough, my asciidoc seems to render this
> as desired for the docbook/roff version, but has screwed-up indentation
> for the HTML version.
> 
> Fixing it as you suggest makes it look good in both (and I think you can
> never go wrong with "+"-continuation, aside from making the source a bit
> uglier).
> 
> Squashable patch below for convenience, since I did try it.
> 
> -Peff
> 
> diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
> index 0820b60f6e..42e1ba7575 100644
> --- a/Documentation/rebase-config.txt
> +++ b/Documentation/rebase-config.txt
> @@ -34,18 +34,19 @@ rebase.instructionFormat::
>  rebase.abbreviateCommands::
>  	If set to true, `git rebase` will use abbreviated command names in the
>  	todo list resulting in something like this:
> -
> ++
>  -------------------------------------------
>  	p deadbee The oneline of the commit
>  	p fa1afe1 The oneline of the next commit
>  	...
>  -------------------------------------------
> -
> -	instead of:
> -
> ++
> +instead of:
> ++
>  -------------------------------------------
>  	pick deadbee The oneline of the commit
>  	pick fa1afe1 The oneline of the next commit
>  	...
>  -------------------------------------------
> -	Defaults to false.
> ++
> +Defaults to false.
> 

Liam
