Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A8871F453
	for <e@80x24.org>; Fri, 28 Sep 2018 07:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbeI1OHW (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 10:07:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44975 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1OHW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 10:07:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id g24-v6so4228110lfb.11
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lauy/b2dd8AldzWcyXaLiiasvk0FI2n5mny15bEhffc=;
        b=TizAQzhxZUSW6WuiWRlYiq3gQYph4bRI1LV0zfIlsOuH0vUdcRONS+rcQ9PdOqH/ev
         obBZntvvThJYKGmUycUKZGj3XsCYHvz3ngsmCt7QH/0stbxUMQstI1dt37fM8KYqa29f
         sd1HJRGB2Z3Sy8SfgNbftXKFhwUI70tSm3GN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lauy/b2dd8AldzWcyXaLiiasvk0FI2n5mny15bEhffc=;
        b=H89f+yKLOv0Iet8OexCUNARnRCZM7D43q9SRvydu06IAquq/oLvDeak9Ms65EEYViX
         HDDmmjS6n5UAQc1SrEkrmc8FvDsjpJMYgZkdpeFylxsagOp/m3dS5F8+9BCezyvHf/0A
         lSENbhJp4Fpt2A9S273HnqqcR/CUIo3TkRhMYGvQbeK/Wc01qHJ8i0+5ph1fTb+MVDVn
         UWz+66PLbKoRmjyj1RYcu5dZ2Jj5hh6q78HY9mAMSxD5cSNam//NOUH5NzjDfBgjTY+t
         Bltf92RPTqGlAzE7sAH/KjbFq3vsQRv4nnNiM/fmVQyVpG2LWZznoRPdNLhSKxadXhXk
         LDhA==
X-Gm-Message-State: ABuFfogrNbTSeGkpYJTgcROvO5LzMQ6HBOc1K84mbIHIKyT35aA19Byt
        YQ0+F1PDzeuMzVKjEJP5EN4zcXmoekGdyxX8
X-Google-Smtp-Source: ACcGV61WmFU+x9j2aElox0rUw2stLrjQR/TsQPc8wMy3J8XNiaB5blJUYCr/0QUPaY1ow0apNAaPww==
X-Received: by 2002:a19:2043:: with SMTP id g64-v6mr9378171lfg.66.1538120693463;
        Fri, 28 Sep 2018 00:44:53 -0700 (PDT)
Received: from [192.168.43.23] (77.241.135.131.mobile.3.dk. [77.241.135.131])
        by smtp.gmail.com with ESMTPSA id j10-v6sm870514ljb.33.2018.09.28.00.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:44:52 -0700 (PDT)
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
To:     Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20180926143708.GD25697@syl>
 <CACsJy8AQbJPVNtcVEsLH-iiXw2TPABr3LsgZ779h3KMvR98yZQ@mail.gmail.com>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <e59fd7e3-7755-79b9-4b73-1da991db39b6@rasmusvillemoes.dk>
Date:   Fri, 28 Sep 2018 09:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8AQbJPVNtcVEsLH-iiXw2TPABr3LsgZ779h3KMvR98yZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-26 17:19, Duy Nguyen wrote:
> On Wed, Sep 26, 2018 at 4:42 PM Taylor Blau <me@ttaylorr.com> wrote:
>>> +
>>> +             /*
>>> +              * We use split_cmdline() to get the first word of the
>>> +              * alias, to ensure that we use the same rules as when
>>> +              * the alias is actually used. split_cmdline()
>>> +              * modifies alias in-place.
>>> +              */
>>> +             count = split_cmdline(alias, &argv);
>>> +             if (count < 0)
>>> +                     die("Bad alias.%s string: %s", cmd,
>>> +                         split_cmdline_strerror(count));
>>
>> Please wrap this in _() so that translators can translate it.
> 
> Yes! And another nit. die(), error(), warning()... usually start the
> message with a lowercase letter because we already start the sentence
> with a prefix, like
> 
> fatal: bad alias.blah blah
> 

I'll keep these points in mind, but this was pure copy-paste from git.c.

Rasmus

