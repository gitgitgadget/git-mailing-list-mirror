Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5180C1F41E
	for <e@80x24.org>; Tue, 12 Dec 2017 09:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdLLJgm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 04:36:42 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:43707 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbdLLJgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 04:36:39 -0500
Received: by mail-wm0-f46.google.com with SMTP id n138so19393545wmg.2
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 01:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9GVylMLf9iupamQhUv605jrthr7sKVT34o/VXpqXGTQ=;
        b=c4Hch+4rxb/XpoaV7b+4UzRJG8BFOFM9AhzoyRCNPiV56ApchTz8hJYAqlBx3DYFme
         fJF1zb/UiSypsrVPec0g18Bjf0BlgGrpXQsiINRZv73nUjh2pGWDTj/Y1fckx0vvCyVL
         mADyTFKm+afPwquJleDzAazw0Y7Zh+3olFPeQpqkv0DOWiWs2wTbwKAjq/hzlvaI4tHT
         8wK7lkYkalBHM80tD53rjMDJBAjCA1y7vsOwMMXzCi2ddqUS/R7DSjFJGF2Up0y/pFD3
         YV2N+UY2qmfmvUszPoT8c8hqBUr2rzD0bSsUAImBkYxMCv1Zo8g/hKd11ehYCD24dIcP
         AoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9GVylMLf9iupamQhUv605jrthr7sKVT34o/VXpqXGTQ=;
        b=PryG4F6m6YZtB0WHlpvRJNQwZr+fNYuP3qJD5QFjC0Bur6/z9NcElowUFCU+RFLhhU
         aHlEyiD5dZ688PZldcG8tbA2/M1o2I9fb+sAVgBBstEUm7h8Xlgdqnua4eaoEYwLtgtq
         M2g7dNf/pCF6KMerP43YGOgezytb1c8mssB3JkWx6svA6UoFNKVSLztDvVZfv6g74EwS
         7UB6E6xfqCyUalbMem9WUOO+/DOPJIMMvRBV9qD8E+mk1r8WRdspSvJXsI5yMWtreI0N
         hFz68oC2IQy4dBTK31qkdHuth/zbYOq3iIQ62+L6OXvx2+pZFsQ8J1TYSEYfLq78701n
         Jx2w==
X-Gm-Message-State: AKGB3mLUwd8x+YVg0xDBG/075UjdNKwjrCoNu9ufNaYSnXR0a0Jxe1e/
        zUTmV9SOwV8auQyoST0WGZS+2GvNtmGHqNx0lmI=
X-Google-Smtp-Source: ACJfBotUMqXJnzhqRSZaOi9355fABSufb4SfRP4a788VJjZroZDgcM7Bl4uHORBd0gT4UVydEi6fkzDZy4cpZPDzaWg=
X-Received: by 10.80.217.6 with SMTP id t6mr2014018edj.217.1513071397856; Tue,
 12 Dec 2017 01:36:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 12 Dec 2017 01:36:17 -0800 (PST)
In-Reply-To: <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
References: <20171211211102.rrxqd6yscnd33efd@hopa.kiewit.dartmouth.edu>
 <20171211225615.GC214273@aiede.mtv.corp.google.com> <xmqqtvww3gea.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Dec 2017 01:36:17 -0800
Message-ID: <CA+P7+xpH6M-FqRJcvsbv=mjj1T04GR6pxz-4NkTmGZUgUKU6wQ@mail.gmail.com>
Subject: Re: Q: rational for $XDG_CONFIG_HOME/git/config to be "non global" or
 just a bug?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Yaroslav Halchenko <yoh@onerussian.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, kyle@kyleam.com,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 5:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I think the documentation
>>
>>       ~/.gitconfig
>>               User-specific configuration file. Also called "global"
>>               configuration file.
>>
>> should be clarified --- e.g. it could say
>>
>>       $XDG_CONFIG_HOME/git/config
>>       ~/.gitconfig
>>               User-specific configuration files. Because options in
>>               these files are not specific to any repository, thes
>>               are sometimes called global configuration files.
>
> Yeah, I think that makes sense.
>
>> As for "git config --global", I think the best thing would be to split
>> it into two options: something like "git config --user" and "git
>> config --xdg-user".  That way, it is unambiguous which configuration
>> file the user intends to inspect or modify.  When a user calls "git
>> config --global" and both files exist, it could warn that the command
>> is ambiguous.
>>
>> Thoughts?
>
> I actually thought that the plan was "you either have this, or the
> other one, never both at the same time" (and I think those who
> pushed the XDG thing in to the system made us favor it over the
> traditional one).  So as long as --global updates the one that
> exists, and updates XDG one when both or neither do, I think we
> should be OK.  And from that viewpoint, we definitely do not want
> two kinds of --global to pretend as if we support use of both at the
> same time.
>

It appears that we actually prefer ~/.gitconfig rather than XDG_CONFIG_HOME..

And at least based on current cursory testing on the command line, we
do both read and write to the proper location, assuming that
~/.gitconfig is preferred over $XDG_CONFIG_HOME.

Thanks,
Jake
