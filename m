Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85D5D1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 20:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeKGF1v (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 00:27:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36919 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeKGF1v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 00:27:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id p35so4114687qtc.4
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 12:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VUNyWZqkknSekFAIs0GBmsz+oHkrn3VAPu3rpS86fHg=;
        b=CL+sH25dS9GeZoOnZ8zfZe0iazdLkTCdWaUs77w8/Dp0mpqwcSI7W30BPXFIfENsk7
         sJ/vnmnVDyBjLFwI2NnsETtjqMC23aIDi4mH3uDsGSfwM9fokY5JOYELmJnwGLfsR/jN
         SUhMYsrIUuahr6vL5lRGrUUCIZmVw3RGgED77CX5DmdrodI7DvzJGCNBgl5u6o8LCh9L
         wvuRfFB/JrJSrhLP+tKwPQDoqC34r8dmp0OD+3npWmVQVQDLcpgT4DCZYMIlq85rhv9C
         p2Ts1Pgm820H1+6rSbujED5TCeIZTU5bVtD0JMyyLLc+UpkfBETbLCJCO0cZKg55Pewr
         CikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VUNyWZqkknSekFAIs0GBmsz+oHkrn3VAPu3rpS86fHg=;
        b=TgLN0i5Am2M8OE14rWg8NcT9csgR7UvdLkacnKMQDkN97tjgcyWImUCRauUhd+zC7b
         /j3F9uqTQjbMvBqODk6D5URn3jeX/iUT22iobd9eulFWQTdaBot2/FVmBPT8IbB3ae3K
         ZXUv5wZA2Cnum7jpMDy4MocJ3b9nzIWnsxSy9Tve13ghWlr4rVCSr5MT3Y5KcQanfIF7
         YbLyqrupiwFUnjSUJtwSwBeuL/FzEP6Q9fnfJrKexS3udDRVNoKQNnd3amj4xA5gar3C
         TfKlbLVTnPvQnxIeQIZcHUplkX+3pechQ/0H8wPqEqxeKOvW230MjN3iF0GdYAaOhfQ8
         NS4g==
X-Gm-Message-State: AGRZ1gIknUcBjKgt+bV13DrLzipZ/7C/DQp8/mw79LOSdwswaIVr5rxS
        QsWGN44x1w742ZR4r1KLH60=
X-Google-Smtp-Source: AJdET5fufzVGD3JMepb+blMP9ug5PfiJi4nD1UvvTHHf8Cfd4vAOHNo87EzJH6L0Q6oxrPl2GNUVbA==
X-Received: by 2002:a0c:aa56:: with SMTP id e22mr10952977qvb.158.1541534458142;
        Tue, 06 Nov 2018 12:00:58 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9183:6eb:3bc0:1bbd? ([2001:4898:8010:0:7ab9:6eb:3bc0:1bbd])
        by smtp.gmail.com with ESMTPSA id p3-v6sm28768914qtc.81.2018.11.06.12.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 12:00:57 -0800 (PST)
Subject: Re: [PATCH 0/1] send-pack: set core.warnAmbiguousRefs=false
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.68.git.gitgitgadget@gmail.com>
 <20181106194442.GB8902@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1e92f560-a5c0-2d58-5a4c-8530598d1025@gmail.com>
Date:   Tue, 6 Nov 2018 15:00:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181106194442.GB8902@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/6/2018 2:44 PM, Jeff King wrote:
> On Tue, Nov 06, 2018 at 11:13:47AM -0800, Derrick Stolee via GitGitGadget wrote:
>
>> I've been looking into the performance of git push for very large repos. Our
>> users are reporting that 60-80% of git push time is spent during the
>> "Enumerating objects" phase of git pack-objects.
>>
>> A git push process runs several processes during its run, but one includes
>> git send-pack which calls git pack-objects and passes the known have/wants
>> into stdin using object ids. However, the default setting for
>> core.warnAmbiguousRefs requires git pack-objects to check for ref names
>> matching the ref_rev_parse_rules array in refs.c. This means that every
>> object is triggering at least six "file exists?" queries.
>>
>> When there are a lot of refs, this can add up significantly! My PerfView
>> trace for a simple push measured 3 seconds spent checking these paths.
> Some of this might be useful in the commit message. :)
>
>> The fix for this is simple: set core.warnAmbiguousRefs to false for this
>> specific call of git pack-objects coming from git send-pack. We don't want
>> to default it to false for all calls to git pack-objects, as it is valid to
>> pass ref names instead of object ids. This helps regain these seconds during
>> a push.
> I don't think you actually care about the ambiguity check between refs
> here; you just care about avoiding the ref check when we've seen (and
> are mostly expecting) a 40-hex sha1. We have a more specific flag for
> that: warn_on_object_refname_ambiguity.
>
> And I think it would be OK to enable that all the time for pack-objects,
> which is plumbing that does typically expect object names. See prior art
> in 25fba78d36 (cat-file: disable object/refname ambiguity check for
> batch mode, 2013-07-12) and 4c30d50402 (rev-list: disable object/refname
> ambiguity check with --stdin, 2014-03-12).
Thanks for these pointers. Helps to know there is precedent for shutting 
down the
behavior without relying on "-c" flags.

> Whenever I see a change like this to the pack-objects invocation for
> send-pack, it makes me wonder if upload-pack would want the same thing.
>
> It's a moot point if we just set the flag directly in inside
> pack-objects, though.
I'll send a v2 that does just that.

Thanks,
-Stolee
