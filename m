Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB5AB1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 12:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbfFSMsM (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 08:48:12 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39831 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfFSMsL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 08:48:11 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so10767991qkd.6
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IMFjFmvZi6F087u88pxbllbS7U/WAZpEmiUisSECXO0=;
        b=HRIRvQavTs5cwuqtGI3vfBEQc1VyU12b6/ZhuBTnDK5Grylh6MIFAG+WFb2shUdbRx
         bc2Whgg8W2U34dE+YK3AVjKbG/7DVINk76DOveUWZLFLsar3qok6pijQAWDITkaP2sNq
         YY0lDMiaeWDEUGtm99dit9FfguYKe/YVf4YiaBP2T5/d3el8/nlpUxf+N/FJiOlGvBuY
         nfhbZOS0sVnH7YwGzCLe4RB9LVFU+u8CRMVOJVBkWLUuorGifVlMIC/7bk4gZfVHnsrX
         HMmLrx08Kx7mxhhas30gYpkGLopUPYwCCx4nURG65vcbQkzHeRYrqyOM5EH2WjLPakIX
         GM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IMFjFmvZi6F087u88pxbllbS7U/WAZpEmiUisSECXO0=;
        b=rMpARy+ZQW3vjHMYMEc+jaDyXhkP5dJaLZW7ugNra+18O5LBzSPPEWTDYZ/CK7A7q5
         shoW3BLZkRmEpjt7Zj39gFjh7ejv8i1T3hAthLm1cgRxuzB4JgDGpuBXslsBEIQyQYFv
         SUBLlajlte5ydPRWrKwMIF6hN9TNPjEeffvMxgXE2nOWn04AXO/V+GKjj7cynGsl9GDY
         XA16dffWoxFWRoTQBcpV6ZmZr5ilLaTGQ7eiYKd5wQiS2KN2RTVKFUhWR9j2znRHJQ9U
         Ivle+Ov6NJ9bwvI3UuC6pnTxausoyk5MMfrxVH8ZG8z+AAGquimeZq+VQype/jTKEVWF
         JBPg==
X-Gm-Message-State: APjAAAVQ8XFjFMUbyzv9GucVmPxWeNK92TZECfxcRPJTrha2AwlvFsQ3
        vq2sEk066grzyrS1WZR3oEJ3YcbG
X-Google-Smtp-Source: APXvYqyfTkHNOrmdqg0Ir+JIr5ih0U5Z1xWbfMd4TluFYH1ipXZanIp9aZdmFpYWuEnI6g5NpGO3ig==
X-Received: by 2002:ae9:c208:: with SMTP id j8mr98892266qkg.264.1560948490442;
        Wed, 19 Jun 2019 05:48:10 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id t80sm9400960qka.87.2019.06.19.05.48.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 05:48:09 -0700 (PDT)
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
 <a5d2d2e9-a22f-9ab8-f88f-9c8c8520735d@gmail.com>
 <CACsJy8BkAPRQNgMQnCkOy3Wrdaj25uK8g-fQ3okpc3BZ33kzrQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <45e49624-be8e-deff-bf9d-aee052991189@gmail.com>
Date:   Wed, 19 Jun 2019 08:48:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BkAPRQNgMQnCkOy3Wrdaj25uK8g-fQ3okpc3BZ33kzrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2019 8:42 AM, Duy Nguyen wrote:
> On Wed, Jun 19, 2019 at 6:58 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/19/2019 5:58 AM, Nguyễn Thái Ngọc Duy wrote:
>>> This is probably just my itch. Every time I have to do something with
>>> the index, I need to add a little bit code here, a little bit there to
>>> get a better "view" of the index.
>>>
>>> This solves it for me. It allows me to see pretty much everything in the
>>> index (except really low detail stuff like pathname compression). It's
>>> readable by human, but also easy to parse if you need to do statistics
>>> and stuff. You could even do a "diff" between two indexes.
>>>
>>> I'm not really sure if anybody else finds this useful. Because if not,
>>> I guess there's not much point trying to merge it to git.git just for a
>>> single user. Maintaining off tree is still a pain for me, but I think
>>> I can manage it.
>>
>> I think we (Microsoft/VFS for Git engineers) would use this tool, as we
>> frequently need to diagnose something that went wrong in a user's index.
>> Kevin Willford built a tool to search the index and figure out what's
>> going on, but I'm not sure it parses all of the new extensions or was
>> updated to parse the v5 index.
> 
> OK I suggest you try it out and see if it really fits your internal
> tools. I wanted to balance between manual inspection and automation so
> the output may not be the best for tools. I also try not to freeze the
> format for more wiggle room, which would be fine for one-time scripts,
> but if you want to have real tools depend on it, we may have to look
> harder at the output format and make sure it's good enough for some
> time, and have some documentation.
> 
> Also, I don't suppose it matters, but just for the record I don't care
> at all about --json performance. I suppose Jeff's json writer does not
> cache the entire json output in memory, so dumping giant index files
> is fine. But some other things, like reading the index with multiple
> threads, are also disabled.

Performance is not critical here, and in fact would become slower for
sure because of the extra parsing details. However, I think using JSON
as a translation layer will make any tools that consume the JSON be
more resilient to future index format updates. That stability is
valuable. Even though the JSON format is not guaranteed to stay the
same, it is easier to update an object model to the JSON format than
a new binary parser.

Thanks,
-Stolee
