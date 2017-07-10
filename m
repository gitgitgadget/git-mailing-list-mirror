Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C53E20357
	for <e@80x24.org>; Mon, 10 Jul 2017 13:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbdGJNgh (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 09:36:37 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36376 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbdGJNgg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 09:36:36 -0400
Received: by mail-qk0-f195.google.com with SMTP id v143so12779718qkb.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4njvWQQgk3DXhOKgMUhkdFNSVBAPXHYbLVuvu7bNq9w=;
        b=ufBme4GnTLCWZ/87noXU2kDZziD0i56YvvU1HDLHW4mFF769/bFEj34c8GLD2WWDtu
         rMuELCW3FVeYIuccLoebObhpSGv4mPb0LgrmbPZdlZWlCPW2g35wDncmC4r1A3k4fUBb
         5ljBg7ZyZXG4COPzDGNigsUQ+kROf0TyJnQZ8pX5GYyVOOR2mIZyQwAZKG8N6pZcrerL
         5ImKsyuyRbBZVBnOhmegbiows6ZgwwR9Lx055Iq45zO2YGYs+evpdVzfid1zGuVbfEYD
         y+m1oaLUVqsS+qqJqM4cz8VsDzJAb6eMgwgzIs8aby4NdNxQNviTNxo/56M6ayekslZn
         LWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4njvWQQgk3DXhOKgMUhkdFNSVBAPXHYbLVuvu7bNq9w=;
        b=sjgmI152SEBAYHZoSS/2Lj46haRd2wReriSaE+X9FbgsX4I9lyGfz0NlodE9SWqCLI
         owuZTG0yx7oPDt1phRD2N3J9oj727Hv0r+yxl+bvR49+fewSi346cK7R8Ye53FQmPilI
         fTY8+HEAyngXCPwCvC6lFMEAyvqMJseFOorOGZWQVgjsN0fLUEZPwW/yRW0PF4TLB8tc
         bxMfklsxVtRH3adQEVtj9qHypkyc4m35ddDhkvuL1lZ4apqFXimWS7GOFDE+YZXEaNTy
         OGfv/AmzUhnLuxDZxIZrd9kFPOP754zg/YghOJ1QdMDOil/zKB2ZnmWNhIJXM3FbTn9x
         HeUQ==
X-Gm-Message-State: AIVw111gdfRqD+fA8ivtqN08GiBANuyvip6P60/oMSow3Wj0Y9O4q+WT
        SLMXtyJy7+uZ8w==
X-Received: by 10.55.75.210 with SMTP id y201mr4409953qka.80.1499693795176;
        Mon, 10 Jul 2017 06:36:35 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f16sm9510609qte.18.2017.07.10.06.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jul 2017 06:36:34 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] Fast git status via a file system watcher
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
From:   Ben Peart <peartben@gmail.com>
Message-ID: <9b1af00c-2451-501c-5315-7ed2b81f3f18@gmail.com>
Date:   Mon, 10 Jul 2017 09:36:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3LA1WvjOZN9WgzMQhuTTXNX7yKgChgAJsLFHX0Ag17JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/28/2017 1:11 AM, Christian Couder wrote:
> On Sat, Jun 10, 2017 at 3:40 PM, Ben Peart <peartben@gmail.com> wrote:
>> Changes from V4 include:
> ...
> 
> I took a look at this patch series except the last patch ([PATCH v5
> 7/7] fsmonitor: add a performance test) as Junio reviewed it already,
> and had only a few comments on patches 3/7 and 4/7.
> 
> I am still not convinced by the discussions following v2
> (http://public-inbox.org/git/20170518201333.13088-1-benpeart@microsoft.com/)
> about using a hook instead of for example a "core.fsmonitorcommand".
> 
> I think using a hook is not necessary and might not be a good match
> for later optimizations. For example people might want to use a
> library or some OS specific system calls to do what the hook does.
> 
> AEvar previously reported some not so great performance numbers on
> some big Booking.com boxes with a big monorepo and it seems that using
> taskset for example to make sure that the hook is run on the same CPU
> improves these numbers significantly. So avoiding to run a separate
> process can be important in some cases.
> 

Using a hook is the only pattern I've seen in git that provides a way to 
enable OS specific calls.  I used a hook so that different file 
monitoring services could be plugged in depending on the OS or tools 
available.  The Watchman integration script was mostly intended as a 
sample that could be used where Watchman is available and works well.

I had not heard about the taskset issues you mention above.  If there is 
something else that can be done to make this work better, please let me 
know the details.

If I'm understanding you correctly, you are suggesting that someone 
should be able to configure a setting (core.fsmonitorcommand) that gives 
a custom command line that would be run instead of running the 
query-fsmonitor hook.

I'm not entirely sure how that should work.  There are command line 
options that need to be passed (currently the interface version as well 
as the current clock in nanoseconds).  How would those passed when using 
the custom command?

Is it OK to just append them to the given command line?  Does there need 
to be some substitution token to indicate where they should be inserted 
(ie "mycustomcommand --custom --options %version% --more-options 
%timestamp%").  Are there any other tokens that should be supported (ie 
PID or processor mask?).

Is there a design pattern already used somewhere in git that I can 
follow or is this all blazing a new trail?

Thanks for continuing to look into this. Feedback is good!


