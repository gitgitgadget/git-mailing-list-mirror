Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E7CE1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 16:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJHQY7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 12:24:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42438 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfJHQY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 12:24:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so8663653pls.9
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S7cAAZ2rCfQuxBYIJLWgwyAfZuHE03cXIBm7obGkqNg=;
        b=sIFNrh/gbmScQDu/4jaaO7B7bW5HW3tydVe0PcQo/T9Cx5EPA5Oi7WMMlumGSh6iqP
         z3ROS1TKf1x/ju400l57yqxSy+FppH52luvTizQe6vgqbSqppqm8XGkctvyj9SEDtHKj
         deXvziv78aWtUbuTcgaxUW0QUqnB4MRfklJCerVFscvq2We6CQKmUBMvY/uJRrLbaXE1
         +39GyLXvLoHjwyYZv5/xjLsOVQXGk3lLvUydLmqQCIIC4C6Qn6CtzZ9kbBVOTmM9Iad0
         0M0rrZK9482m4zyapfEaFds/aS3iEkfq2pjqEyRmPAgUKu4hTtsHzowl2QlUAIrb6E0Q
         f9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S7cAAZ2rCfQuxBYIJLWgwyAfZuHE03cXIBm7obGkqNg=;
        b=FKr7OLePE7r6NrIc6l+dVAkDfomsu7q51OayW7IEUxzWawaVkITBtRrj5a0Rz8t9T2
         76PvRy+ZYLDb1rnTHjmqzBEd6bgxk2hPFy2cprV8OV6sG8qWkrDhOXwRl6lw1E1Q82uH
         3bEaMfjl8EalvlANdO0+HFBFkxRvbhVcnjbqCXpftvdux3hz3ewWw6jKmO8fi27f+DWN
         57F24t7UagOdIhwVmN96czAtLpHASFpbLqTw7s4TQlWIMnILbl7+9miZGIPEqmzvVAf9
         v7ZgMjA6L3NpVsvDmdgkwlrm43ijw+mT+GwIIJ0v+UDttFNRON3YorlKZ1UtKdNo0ov7
         k/iw==
X-Gm-Message-State: APjAAAUS+c4M4MjBkqQniYozFSgfuMTjTW7zkG4O/Zvi5VbSwPyYwCad
        r25fUcjMFVHmXJs7YygM7/E=
X-Google-Smtp-Source: APXvYqxwRL2gsfRuBVhZmBRq5e8xUNaZM6LRWAqFPm8Um/yQoWxWdV3JJP3go020jOVnzr7e8aNvqQ==
X-Received: by 2002:a17:902:fe04:: with SMTP id g4mr36783901plj.241.1570551898794;
        Tue, 08 Oct 2019 09:24:58 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:2:6a:c7ae:f62b:1205])
        by smtp.gmail.com with ESMTPSA id g6sm17052445pgk.64.2019.10.08.09.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 09:24:58 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
 <20191007172951.GC11529@szeder.dev>
 <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <202ed2c5-9729-120f-fa0e-cee9ecec3b77@gmail.com>
Date:   Tue, 8 Oct 2019 09:24:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqk19fn9jp.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/7/19 9:30 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>>> 		func(PROGRESS | REGRESS);
>>> 		func(PROGRESS + REGRESS);
>>> 		func(PROGRESS * 3);
>>> 	}
>>>
>>> how caller came about to give 3?
>>
>> No, they tend to show (PROGRESS | REGRESS), at least both gdb and lldb
>> do.
> 
> OK.
> 
>>  If the enum has only constants with power-of-two values, then that
>> is the right way to write it, and the other two are asking for trouble
> 
> If the programmer and the debugger knows the constants are used to
> represent bits that can be or'ed together, what you say is correct,
> but that is entirely irrelevant.
> 
> What I was worried about is that the constants that are used to
> represent something that are *NOT* set of bits (hence "PROGRESS * 3"
> may be perfectly a reasonable thing for such an application) may be
> mistaken by an overly clever debugger and "3" may end up getting
> shown as "PROGRESS | REGRESS".  When there are only two constants
> (PROGRESS=1 and REGRESS=2), we humans nor debuggers can tell if that
> is to represent two bits that can be or'ed together, or it is an
> enumeration.
> 
> Until we gain the third constant, that is, at which time the third
> one may likely be 3 (if enumeration) or 4 (if bits).
> 

I tried to see how lldb would handle the "PROGRESS * 3" scenario
but I was unable to get lldb to display the "PROGRESS | REGRESS" format
even when ORing the flags:

(lldb) l 399
   399 		enum test_flags {
   400 			TEST_FLAG_1 = 1 << 0,
   401 			TEST_FLAG_2 = 1 << 1,
   402 		};
   403 		
   404 		enum test_flags flags_1 = TEST_FLAG_1;
   405 		enum test_flags flags_2 = TEST_FLAG_2;
   406 		enum test_flags flags_both = TEST_FLAG_1 | TEST_FLAG_2;
   407 		
   408 		if (flags_1 || flags_2 || flags_both)
(lldb) p flags_1
(test_flags) $0 = TEST_FLAG_1
(lldb) p flags_2
(test_flags) $1 = TEST_FLAG_2
(lldb) p flags_both
(test_flags) $2 = 3
(lldb) fr v flags_both
(test_flags) flags_both = 3
(lldb) fr v --format enum flags_both
(test_flags) flags_both = 3
(lldb) version
lldb-902.0.79.7
  Swift-4.1

Is there something that needs to be adjusted in the config or with
--format to display "TEST_FLAG_1 | TEST_FLAG_2" in this example?

Thanks,
William 
