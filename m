Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5371F404
	for <e@80x24.org>; Fri, 26 Jan 2018 13:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeAZNOE (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 08:14:04 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33496 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeAZNOD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 08:14:03 -0500
Received: by mail-qt0-f182.google.com with SMTP id d8so1131858qtm.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 05:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rF43PRzueqFV0Xc9gZFs/SNUvKKfKNcWtR68aCFs/bE=;
        b=FWFnPLEP1n0WTj2HmbAxNdSJjKzVpIGg4l5GWi5kyeDunz6+QfJ2kY2oJqFXZxuyaW
         TvXf1KDsT+INtmtVY8Ov49/L7CWY0wKJ2mxfYj9DKJmqiY8MbUiR2XFNpyp/L+hc8vDX
         mphWH5vpejnhZUVSyaUS1s2U7HBMkxPdHP+XLtgCpe1MVTxSLdbYMPedVD6JtzZwXz5c
         wwt0nRMrHwlqGhDzuX9pwWf8sGNfPg6UEqfc95OptFOp6ME+T53yrI2V8mLuu7xL4nfz
         rVq+uzQ3MNMifZTaXjg7TxcKIuF+/YXrco4Fx86DATzwRCz+/lftloRbusExX12dnETw
         fvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rF43PRzueqFV0Xc9gZFs/SNUvKKfKNcWtR68aCFs/bE=;
        b=CFpkML4a/hq0FqKMhHvjgFGWGh/bR1oxfNkyHOa745GZq0YUZsO7TRsxiV6eP/fb8H
         vU5FFBj5pGoklIymK70t3U/eI9sXY0BEHMgqYyoW3HXlcJ5cOoZBiXvL/j90HzozHlyz
         OxFH0xRrPr163stMxgkvC12lvsXjEqJmpWC2Ndle7tvfcZwDptlL2P7DF9uhMbvUSMFH
         rrBZZiG+bkHLGfGaQMWcGSOXU7CzRMgnI3Ce6QERVigXCn157QvKn2UAgXLGEj+yRt17
         PAs5O97hvI0a1Kn57vENtyCR1ivq/b3MWghoCwJHr4HGd4goIIz9J3pmOSngitxkybTD
         I+8g==
X-Gm-Message-State: AKwxytdyONmAVLtGeTCvJluCvsY0QovtUj3nsuABShXT1DfLwfqNf4gn
        NNcuIYs9SdjBik4xcKrDRAiE7C0OOqA=
X-Google-Smtp-Source: AH8x224jL5n+RaZuXGNB7NWjqJoZ+OC8hYDWSSpO55u3UTScqgL1SAXMI54t/0kI2N5xrJ2uqtGj3Q==
X-Received: by 10.200.46.69 with SMTP id s5mr23627307qta.205.1516972442832;
        Fri, 26 Jan 2018 05:14:02 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id k7sm3736229qkk.70.2018.01.26.05.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 05:14:02 -0800 (PST)
Subject: Re: [PATCH 03/14] packed-graph: create git-graph builtin
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-4-dstolee@microsoft.com>
 <xmqqinbp8rw3.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <37d84775-174f-02fc-159c-0810df458b5a@gmail.com>
Date:   Fri, 26 Jan 2018 08:14:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqinbp8rw3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 6:01 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> Teach Git the 'graph' builtin that will be used for writing and
>> reading packed graph files. The current implementation is mostly
>> empty, except for a check that the core.graph setting is enabled
>> and a '--pack-dir' option.
> Just to set my expectation straight.
>
> Is it fair to say that in the ideal endgame state, this will be like
> "git pack-objects" in that end users won't have to know about it,
> but would serve as a crucial building block that is invoked by other
> front-end commands that are more familiar to end users (just like
> pack-objects are used behind the scenes by repack, push, etc.)?

That is my hope. Leaving that integration for later, after this feature 
has proven itself.
