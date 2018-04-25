Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8071F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeDYOrQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:47:16 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34837 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbeDYOrN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:47:13 -0400
Received: by mail-qk0-f171.google.com with SMTP id b131so18519021qkg.2
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XClQUYys+Jl0vT0wB19rPfcAEluwJkiHJ1K+YFD6qXE=;
        b=lvmjWLurTAF0Kxy6ZIChZp8jRESYmcrrwz8rkSNytAxX2VFXijjwQgzYdVLf7pLJup
         TNKaCBdyzHLl2MqKU9cGuiAQtuG6MzzmePxZ+1vE/vDEOYSOR3zxAuVNLc/nIsvK+3vv
         jMerFnINLV/+3INVrrSbWV2DebfiN3WudotvpQGzHy37dq4w0qTJS3L7hYGPIdG9SteJ
         2xvFRMhfG/ohr6SjkP2LSJiF90Do/yyMsny3zrw097Uhs2SxgWdx+4jpJ2/uzpku8Yjc
         BjksGooOGE9LQDlAhcGabFOtq1EPkfP5/iOiEYHXAbJxeoJC/ryO23M0og1vMZjineZL
         v6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XClQUYys+Jl0vT0wB19rPfcAEluwJkiHJ1K+YFD6qXE=;
        b=lyclu905eTQO+cTGhkQRMdKFIHpev2hUSZa5D/3Wu4E4wHAYaWijEz+OtiBjHMe8a9
         eBy/xJPUEZCAP6rlehzcHq7w3ekw5PiZg7nAZMDIQkQs/WJL6p34OqxcKa2oPruloiyH
         mkgTbx5VEFTxuQwgOHUixLbcbNoRyjCjzr7CzX2DiJ/MCl29zAmC4Kkr3mG70LXQZOSg
         mEyQVJk003MJeoLf5fdRQuQIM6xGtoAIdTuMT+KaxqtxwxlUNb3bifcBg11CNBsfdYrQ
         v0HKpHidbgAci2+GTIvwviYvHsSNwCElOXU38pLJL7golPMsqiMW3HFV7Msbdngr8xjg
         5X/A==
X-Gm-Message-State: ALQs6tC7QwsSkJ1Q0NUJJUhcx9oQm80xtWXbIiA7+Fj2/eXHNglHw1bk
        Lfce5la1unpLFMFp8TyYHf0=
X-Google-Smtp-Source: AIpwx4/VU6REYWQXIY5ww5fjlYAMZB5tkvMwR9BsiNX/YujzEixB2gsk8V8/vduqfEgYUkfAQA2ivw==
X-Received: by 10.55.52.138 with SMTP id b132mr31939117qka.398.1524667631849;
        Wed, 25 Apr 2018 07:47:11 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d88sm15142051qkj.25.2018.04.25.07.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 07:47:11 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] merge: Add merge.aggressive config setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-3-benpeart@microsoft.com>
 <CABPp-BFXwbZfFe0bZYMwWxz_Qxw=KQ6XE5SEBmgiE+TzaSycuQ@mail.gmail.com>
 <a34144ff-b91e-6f00-93e8-b472ad5887d0@gmail.com>
 <xmqqlgdc5fa2.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <87cb6954-05ee-1e9c-43ec-30157b6e08f5@gmail.com>
Date:   Wed, 25 Apr 2018 10:47:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqlgdc5fa2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/24/2018 7:57 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> That said, it makes sense to me to do
>>> this when rename detection is turned off.  In fact, I think you'd
>>> automatically want to set aggressive to true whenever rename detection
>>> is turned off (whether by your merge.renames option or the
>>> -Xno-renames flag).
>>> ...
>>
>> While combining them would work for our specific use scenario (since
>> we turn both on already along with turning off merge.stat), I really
>> hesitate to tie these two different flags and code paths together with
>> a single config setting.
> 
> The cases that non-agressive variant leaves unmerged are not
> auto-resolved only because marking them as merged will rob the
> chance from the rename detection logic to notice which ones are
> "new" paths that could be matched with "deleted" ones to turn into
> renames.  If rename deteciton is not done, there is no reason to
> leave it non aggressive, as "#1 = missing, #2 = something and #3 =
> missing" entry (just one example that is not auto-resolved by
> non-agressive, but the principle is the same) left unmerged in the
> index will get resolved to keep the current entry by the post
> processing logic anyway.
> 
> In fact, checking git-merge-resolve would tell us that we already
> use "aggresive" variant there unconditionally.
> 
> So, I think Elijah is correct---there is no reason not to enable
> this setting when the other one to refuse rename detection is in
> effect.
> 

Thank you. I understand this description and it make sense to me.  I'm 
unfamiliar with the merge code so have to rely on you who are the 
experts for a sanity check.

I will remove the separate merge.aggressive config setting and instead, 
set the aggressive flag when the renames is turned off (whether by the 
new merge.renames setting or by the -Xno-renames flag) as Elijah suggests.
