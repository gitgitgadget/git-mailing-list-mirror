Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA11820357
	for <e@80x24.org>; Mon, 10 Jul 2017 14:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753704AbdGJOkS (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 10:40:18 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33270 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753426AbdGJOkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 10:40:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id c20so12878744qte.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=je/6aeaP3ytWVgQNbG54iAhYELI3mzT+kXg38qYWwHw=;
        b=GiGr0XGwLQOCtcOLpEgF7luYGTVh838gvVvwusn+U9b09R7v2tao7khDhcVO3josA0
         PSSQtI72L1M9eUfVL2T+IO0gBedXCCS6oiYP7TpRqZsXhJ7LXMhwGjMOZ6rPVltUG6iL
         iFNhBZByJ+LdmGtv5ojW4MaXNTl5JErN74ZnRf/O9kpwHP06CJFHtfxbn/uwPMkbHAUM
         VmbK8TLrVjji5nIc+rZ6ZJ9ttEFbKpTKEqalYrkO/474Waal6j6OqDvchIDCkPiAl+bA
         efthnZyFzSYWTer3DCzemxEHN+Wc5cjXyPzzKWBqT0vn99xq7z9Ni9TXNrUl+OhsjPkv
         574w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=je/6aeaP3ytWVgQNbG54iAhYELI3mzT+kXg38qYWwHw=;
        b=fuIjgRr5p8uth0xy8XKJ7toilWMRlJlIB2A0pIHVKMCGGrvJkEFPT5mU/Bv8e3lwBV
         1hhFv2Ki/hWRXMzFHatYC6jyTpuCuktKwtgT3ssoWESGCZ8AB3pqqpb9lQhwdd05tUak
         LhN7WnXBGbXCoEdkiRtUIA5NSz8reeFS4dDlHySuT/ymz2ROLopJd/g3/6Af7Zlvs5U8
         vDW7zP1xkEqmQhqpIuJmnHnvIcFkO44TsyhV23wQnL94gByVbwZnn/GgNMvnXWWy498Q
         e/eQwlxOyohb87VGeIzQgT6EX0MTQxXcCR6DmWecz4IT1DDaovXFSe+oaxiLhqNdi8jb
         Hm8Q==
X-Gm-Message-State: AIVw113LSreFcvu+EiumL27RbaQKNL5Y/b8w34fyRV6rPUwAxwlkTckT
        DRVlu0WsFXA/Hg==
X-Received: by 10.200.46.100 with SMTP id s33mr5178083qta.48.1499697615779;
        Mon, 10 Jul 2017 07:40:15 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id i8sm8979034qtb.40.2017.07.10.07.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 07:40:15 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] Fast git status via a file system watcher
From:   Ben Peart <peartben@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <CAP8UFD3LA1WvjOZN9WgzMQhuTTXNX7yKgChgAJsLFHX0Ag17JA@mail.gmail.com>
 <9b1af00c-2451-501c-5315-7ed2b81f3f18@gmail.com>
Message-ID: <97342e22-c2ca-9c09-4db0-24cac014b689@gmail.com>
Date:   Mon, 10 Jul 2017 10:40:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <9b1af00c-2451-501c-5315-7ed2b81f3f18@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/10/2017 9:36 AM, Ben Peart wrote:
> 
> 
> On 6/28/2017 1:11 AM, Christian Couder wrote:
>> On Sat, Jun 10, 2017 at 3:40 PM, Ben Peart <peartben@gmail.com> wrote:
>>> Changes from V4 include:
>> ...
>>
>> I took a look at this patch series except the last patch ([PATCH v5
>> 7/7] fsmonitor: add a performance test) as Junio reviewed it already,
>> and had only a few comments on patches 3/7 and 4/7.
>>
>> I am still not convinced by the discussions following v2
>> (http://public-inbox.org/git/20170518201333.13088-1-benpeart@microsoft.com/) 
>>
>> about using a hook instead of for example a "core.fsmonitorcommand".
>>
>> I think using a hook is not necessary and might not be a good match
>> for later optimizations. For example people might want to use a
>> library or some OS specific system calls to do what the hook does.
>>
>> AEvar previously reported some not so great performance numbers on
>> some big Booking.com boxes with a big monorepo and it seems that using
>> taskset for example to make sure that the hook is run on the same CPU
>> improves these numbers significantly. So avoiding to run a separate
>> process can be important in some cases.
>>
> 
> Using a hook is the only pattern I've seen in git that provides a way to 
> enable OS specific calls.  I used a hook so that different file 
> monitoring services could be plugged in depending on the OS or tools 
> available.  The Watchman integration script was mostly intended as a 
> sample that could be used where Watchman is available and works well.
> 
> I had not heard about the taskset issues you mention above.  If there is 
> something else that can be done to make this work better, please let me 
> know the details.
> 
> If I'm understanding you correctly, you are suggesting that someone 
> should be able to configure a setting (core.fsmonitorcommand) that gives 
> a custom command line that would be run instead of running the 
> query-fsmonitor hook.
> 
> I'm not entirely sure how that should work.  There are command line 
> options that need to be passed (currently the interface version as well 
> as the current clock in nanoseconds).  How would those passed when using 
> the custom command?
> 
> Is it OK to just append them to the given command line?  Does there need 
> to be some substitution token to indicate where they should be inserted 
> (ie "mycustomcommand --custom --options %version% --more-options 
> %timestamp%").  Are there any other tokens that should be supported (ie 
> PID or processor mask?).
> 
> Is there a design pattern already used somewhere in git that I can 
> follow or is this all blazing a new trail?
> 

My co-worker reminded me about git difftool - is this what you had in mind?

> Thanks for continuing to look into this. Feedback is good!
> 
> 
