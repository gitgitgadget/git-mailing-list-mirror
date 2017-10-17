Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14871202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757749AbdJQHZ4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:25:56 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:54252 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756041AbdJQHZz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:25:55 -0400
Received: by mail-io0-f173.google.com with SMTP id 189so1178679iow.10
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7uXVsVs6rHf4lIgbBvB+ed0IPv6TKdOtpT8OMFdAulw=;
        b=mMb9l5iY9ZUdq13p+KmR8XJbb9CsUD6HcIKeUeVzpXkV9da5OZ/aMwb51fIvX2uCmC
         WV2c3axZR0ZxHE7un5300d2nDqi2IBMu2Xnb6vkxRBGTyGADiskFb0bI+6VzeVeqqShM
         Duxf5kvmKqNvKEbFd42DdVczARFSyZAt4MfNCr/hA0b8pk/UlMTIsi4anAqXoepGfN6A
         rE2PxRen1BNYB5LDf04TlRh0kjpXdFQvNpLrVVu0dU9xQj7lZVYwk0jksX/erl+C0+M/
         OPvW0XaV425Cj/H5VWNetIyldMUEA3pNFPF8PBhSRNm7XWcrnrRPA2q0QN9pQn113pn+
         RCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7uXVsVs6rHf4lIgbBvB+ed0IPv6TKdOtpT8OMFdAulw=;
        b=iCPykOyXiV/8oHI6P7QHSPcpzwa5MyZlm7/EsY7YtxbOEXwqt0iNe+8EcxqMZoGsWD
         xObZ0uWFwOb+VjC3gxwnrU7egCBDumNguQHpufohy1u4GDmwK3om+oAurKrAfE52vMrv
         gs6gBli+/QZ7yVm2FhNKtVju2/1FMPniVptLLYJYOHGYYgb1UPbx9pTRZkvriaF+x1Ez
         Lk3LKAmy7w6Cj95HcY+u4gJ7N/nBT2z6xMY9yzzlljKbHYUGhziOtFeP8LQeqlO2rbP9
         tgY6EEU+tFqLNhd/K8bgd9TFpCvenTY5E3+Ebvnx+p8UeRgKXQcDYEkfouW/qoS0vyEF
         XHSg==
X-Gm-Message-State: AMCzsaW3G1sMSonu4LzUORbWKjAr4EFjt8B636oalg1jt1KaQQE3w61/
        2wefsxPF4GyjfibKnrB3/Nc=
X-Google-Smtp-Source: ABhQp+RkW5IaF29MgWY3e1TR7+2dVicpE27DPBJiEQ0IJnDmY+BIOiR5bbjWgZEGHnqkd89Guu0VRA==
X-Received: by 10.107.232.3 with SMTP id f3mr15196776ioh.156.1508225154440;
        Tue, 17 Oct 2017 00:25:54 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g196sm4980468ita.4.2017.10.17.00.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 00:25:53 -0700 (PDT)
Date:   Tue, 17 Oct 2017 00:25:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Marko Kungla <marko.kungla@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] check-ref-format: require a repository for --branch
Message-ID: <20171017072552.e72yfbnggyh6jlo5@aiede.mtv.corp.google.com>
References: <CAKY_R-uk9hpR2hbkPsw2cqoMo6bQKoyp6cWTO20L3fOWfLW2-Q@mail.gmail.com>
 <20170714180313.apsnbnw7no2nvtf5@sigill.intra.peff.net>
 <20170714181831.fvi2coppzhm747mk@sigill.intra.peff.net>
 <20170717172709.GL93855@aiede.mtv.corp.google.com>
 <20170817102217.3yw7uxnkupdy3lh5@sigill.intra.peff.net>
 <xmqqinffsibr.fsf@gitster.mtv.corp.google.com>
 <20171017044111.ahe4eiepvokecnkr@aiede.mtv.corp.google.com>
 <xmqqinfentiw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinfentiw.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> And in that spirit, I think the patch you replied with aims to go in
>> the right direction, by providing the core functionality when in a
>> repository while avoiding breaking such a script outside of one
>> (though I do not understand it fully yet).
>
> Given that, is it safe for me to ignore this earlier one
>
>> For what it's worth, I don't agree with this repurposing of
>> "check-ref-format --branch" at all.
>
> as reacting to the patch without reading what it does?

Are you saying I should have ignored the commit message?  Recording
future plans via the commit message is part of what the patch does,
after all.

>> Junio C Hamano wrote:

>>>                                        (e.g. a wrapper to "git
>>> clone" that wants to verify the name it is going to give to the "-b"
>>> option), and a check desired in such a context is different from
>>> (and is stricter than) feeding refs/heads/$name to the same command
>>> without the "--branch" option.
>>
>> Can you say more about this example?  E.g. why is this hypothetical
>> wrapper unable to rely on "git clone -b"'s own error handling?
>
> If I have to guess what you meant, perhaps the Porcelain wanted to
> diagnose bad parameter that would be rejected _before_ letting clone
> spend cycles and possibly network bandwidth?
>
> But this was my way of rephrasing an earlier example you used while
> objecting to Peff's change
[...]
> so my answer to the question in the message I am directly responding
> to would be "You tell me." ;-)

Hm.  Does the example in
https://public-inbox.org/git/20171017070808.plddffhzdobyekmo@aiede.mtv.corp.google.com/
make it clearer?

The goal of such a script is *not* error handling --- that is just a
pleasant side-benefit.  It is to be able to handle all branch
specifiers from the user (and even a default branch that is not from
the user) uniformly.

Thanks,
Jonathan
