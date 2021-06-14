Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6E3C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 18:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BE79613B3
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 18:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhFNSUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 14:20:49 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:45808 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhFNSUs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 14:20:48 -0400
Received: by mail-pg1-f178.google.com with SMTP id q15so9297620pgg.12
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TGlNjSheZB3V36ANFsotBpw9f5P+hENIYQc/9V5TDF8=;
        b=EOa5JsWmH6j0iK3HgVGEQvukIQYY+SZK8ckGKjc3TwACZgMb0oRMubecUKVS+jOesm
         UZ0SVMwfkeYcBdrrF0ZRsJY2SK8DRu8Fzhy9r61HSz4EIcmUhfubkTWEHuxWPAslVj1E
         pWB4BnMkslhFYJv0Tjt7OxHqlPRNf+mygZ4SjkDZ+BtPLuzPk/8XNUWtZtAuF2nrx/E+
         p7qhVJ+BKIJye/7JEPYClbsZXRG9jWEomEJUydazno2MN6rFHLpNfIkHydciaqtSK/QP
         rnxyeMOkXPeesckdrhRBTtpVg234UDG5lmqm5Y+fkv6bfqn0RSwKJ5+XaYVCqj++HSGW
         /KWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGlNjSheZB3V36ANFsotBpw9f5P+hENIYQc/9V5TDF8=;
        b=AzBzG8cNTig/hINzSzmOyfbJooJJZIfmGvk7Ed1U7+uMuJ+0ERv03+rwkfMFGRkrHc
         dLav/ddC7xIIBtwc2SwPka1im/lORkLj8Pkh5e6wEMDI77Q7+K+3b/BggPy4CkI1HQ3q
         xw14D7guRVEQGLZjyI0Yd+3ClFVSVa05DzBEEMd5tkacARU061FY3UBpxTWERu/jo79Q
         cb9O/dTGGxXj8QJ8G2zB78+AtCfdth89IzjSQazMzLTa46Mp37MkeM7lHZaCwGq6YXpE
         1lZh8+nOR6O6ngHauMDzkhB3CAPk5w4r3ztG27rxnOa2/zcxM3oILfCleOhK1UJEppkJ
         qwMQ==
X-Gm-Message-State: AOAM531S7B73vZAdkcSKMKHFvN2JCBTxPDepFXTJDO0lMqVGUgg4y29P
        hz+jDA83j4J3+uD64KujO+E=
X-Google-Smtp-Source: ABdhPJw2Gw+2dMkcIuY82nXdYFF1N11GnIyDBd4Ki/I9OHyG8HbRwZG0Lh9FlXSTU7ab5ynXXwxeJg==
X-Received: by 2002:a63:d710:: with SMTP id d16mr18025729pgg.214.1623694665376;
        Mon, 14 Jun 2021 11:17:45 -0700 (PDT)
Received: from [192.168.208.38] ([49.205.81.120])
        by smtp.gmail.com with ESMTPSA id y13sm13054103pgp.16.2021.06.14.11.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:17:45 -0700 (PDT)
Subject: Re: [GSoC] My Git Dev Blog - Week 4
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <155ED50C-F11A-4ACC-A8A5-C31896449348@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <d1acf42a-7ba8-74aa-4f76-03a5a5f4191f@gmail.com>
Date:   Mon, 14 Jun 2021 23:47:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <155ED50C-F11A-4ACC-A8A5-C31896449348@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

On 13/06/21 7:08 pm, Atharva Raykar wrote:
> Hi all,
> 
> This is the fourth instalment of my blog series:
> http://atharvaraykar.me/gitnotes/week4
>

Nice blog with interesting quotes and references.

> [ snip ]
>
>   * just some thoughts on being ok.
>     (Relevant to: future new contributors to Git, but mostly myself)
>     Section link: http://atharvaraykar.me/gitnotes/week4#i-am-just-ok
> 

You have interesting thoughts in the above section and the good part is
you reach the right conclusions. From what I've observed, you're doing
pretty good. So, keep your spirits up and high and do great stuff! :)

>   * On obviousness and new contributors
>     (Of interest to: All potential reviewers in the mailing list)
>     Section link: http://atharvaraykar.me/gitnotes/week4#on-obviousness
> 
> Have a great weekend!
> 

Thanks! Hope you have great week!

-- 
Sivaraam
