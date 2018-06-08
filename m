Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601FF1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 21:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753185AbeFHVwL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 17:52:11 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41701 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752889AbeFHVwK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 17:52:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id a11-v6so7261967pff.8
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mSe+ygLyLdu7IPWNMx6M6BUnzg5mT4Vi5GX0k8WVxMQ=;
        b=lKVqlad6RHWrEome6fdv/7ScaWYrRNNBZyqnwdNLLAe9O5V046HcslK9qf73/vPZCA
         3IuKr5upWzBWG70guO0cpaT/nMXDZ1F9/dG5yM7eSaf8qdnV9EjzjkqBHhyDtEqTthZ/
         Z7cnSwvFtfvmeZ7C2ndXQnIWalM8rqeLoyNJ/1SOX39nY+ntcC0AjYBgyz/f3yr+NuM7
         YWCUyQsD61uWiyuSh0Qcgpr4QxRw9M0CflW7wCU0I+4aRx4fK8LYFAz6G4NJJUnpp14K
         d5TDf7D7Y0GurJNaLgyeeM2HNf0UhQ/ZQXIXTzpeYl/xQSSum9ceTIkngZwxwHi8a83p
         yN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mSe+ygLyLdu7IPWNMx6M6BUnzg5mT4Vi5GX0k8WVxMQ=;
        b=kt2FBvZTlA8h9ZCO3aQgx930/8rAkPyufm6xKdGIjsoOLCRbUeEaE9da8WCi0uvny1
         pQeVcCJ6L0h/M8k9vq85oAzVQiRaKbh1kn2H3ERbrjcuEtMQh2KTQX9lX6FMSdJZcjrt
         hvYqzoI4F4Cxin4gtMGMNlhK/GfjHusCcXLaSeNeF1yxiSgRZrVdPMszbG/YhbTNEo9R
         wplM2d8uI/sr7O7JSz8GfggSMfN2kBNHCbjtYbS+7Mp1y55t5T5GlHXC06Nh84h4k08S
         vZ8hUugrfIX6d7lGUvzywZIkoyb12MPHAbb0UkUCFsXyxUyHlqdApZ+UKAwnHFjw86/T
         UQPQ==
X-Gm-Message-State: APt69E24MVT7oLrIaNpHseFdmhnR31/FNaBnUbEVtgpQh4bzTFA//aZS
        h7OYZwosnRxkI8pYnnPnKXs=
X-Google-Smtp-Source: ADUXVKLT/bvzhin542TaopaGhy9b4odC6rD/3EesZ3DEU4qonqR3AX1KYzhC/hpjnpNCfyQT5mP1bQ==
X-Received: by 2002:aa7:84cf:: with SMTP id x15-v6mr7651927pfn.220.1528494729715;
        Fri, 08 Jun 2018 14:52:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h27-v6sm87887566pfk.160.2018.06.08.14.52.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 14:52:08 -0700 (PDT)
Date:   Fri, 8 Jun 2018 14:52:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Rick van Hattem <wolph@wol.ph>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v2] completion: reduce overhead of clearing cached
 --options
Message-ID: <20180608215207.GB42503@aiede.svl.corp.google.com>
References: <xmqqmuy2wz4j.fsf@gitster-ct.c.googlers.com>
 <20180417220219.30445-1-szeder.dev@gmail.com>
 <20180607054834.GB6567@aiede.svl.corp.google.com>
 <20180608211639.7611-1-szeder.dev@gmail.com>
 <20180608212348.GA42503@aiede.svl.corp.google.com>
 <CAM0VKjkWkUmU9LGyKKFyvkOCFh1s+JJK4aZLPfoOJj26OkNQVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkWkUmU9LGyKKFyvkOCFh1s+JJK4aZLPfoOJj26OkNQVg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:
> On Fri, Jun 8, 2018 at 11:23 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>>> +   [[ -z "${GIT_SOURCING_ZSH_COMPLETION}" ]] ; then
>>
>> Needs a - before the } to avoid errors in a shell where the user has
>> chosen to use "set -u".  See v1.7.4-rc0~159 (completion: fix zsh check
>> under bash with 'set -u', 2010-10-27) for more details.
>
> Right...  I did remember that, but by the time I finished typing out
> that long variable name I forgot about it... :)
>
> However, I'm not sure it's worth caring about, because the
> bash-competion scripts don't work with 'set -u' anyway...

I'd be happy to see these '-'s go away (it would make the code both
easier to read and easier to maintain), but as a post-2.18 topic,
please.

Alternatively, if there's a real need for them, I'd be happy to see
the completion tests start using 'set -u'.

Thanks,
Jonathan
