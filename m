Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3F51F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEIOV1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:21:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37114 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIOV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:21:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id o7so2685070qtp.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NgY8Ogw1KlT4NPK7lUprjVCHkcEzy+OdhkLLaC2Voxo=;
        b=fb8f6dL27P4ZJnmYBzS8aVrtpU0XuAlejrHpdo58piWIB7mxbZetW3T1qHBPEF2thz
         R1KC1w0TbDekL18QVj+q28ubXPlN4gGoa5yqqye7XeL1HxCwTNimp30gl/V8Aj2oENf0
         0WK8ubhVT9EA6um/VxyhIhWgxUK13BV1Hnmwwi1xhEYKFTc747SBltj1tjvbRDlMYAnZ
         p6jmElYtsOCpJh264ixTfgdqkni5QwU/PWIAXkN25D7dnl4Ie2Yr0lB9MUJTCMOLc0wP
         sUGDfdhxzvW50sgB484xwIETp23wIUQ5+7KrXN+BTxYRbl+phFqI8knuwdwPFPPXtZxL
         2MVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NgY8Ogw1KlT4NPK7lUprjVCHkcEzy+OdhkLLaC2Voxo=;
        b=ZYkGHjCmtCn7K5OiiRnbTSgVyEUwzcCLxxbVbOZU4vKhJCAAS8R/JEMfRjbyvy9L6S
         xzzlDBaMDTGA/rqgcW2MkPrT6mV9vgMDjMsJCDi2cwdIa3Tby/7ejgQPM3D0frvj4g89
         zVhvxaXG7wlOXZt7coY8EbQ3GH7HI0PrHgBCr9qAF/JrjmjEw2JOyMNwU2q4wkxLBDen
         EwqDeuFT+eYztW7hPhBGIefA7G0aIt+2zpZ2sg37M6OT9q4fmsE08evPZxoLnddAg9n6
         1R1DkVxvEFZEadkuuJfpeQWOvj/VeaxomQagysCN8qCF4cZAwAfkHFtsXge1cfyEHWZd
         h5xw==
X-Gm-Message-State: APjAAAUq5W1mTniLbGqCBWXZtdDgUXYabbShj54yQqCUwg7f1xCPcK7u
        gJb8U+beHSjA9yh/HE5+JS0=
X-Google-Smtp-Source: APXvYqzSGMfa7dxL83/HMZByN6ILUq7KTRouEoDbufNO9BqrSOL5HGp4NbSMT/CBpP7JUaQcv65WPg==
X-Received: by 2002:a0c:8187:: with SMTP id 7mr3847135qvd.247.1557411686042;
        Thu, 09 May 2019 07:21:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d14c:17a3:d28e:9336? ([2001:4898:8010:2:ba80:17a3:d28e:9336])
        by smtp.gmail.com with ESMTPSA id a15sm996617qkk.87.2019.05.09.07.21.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:21:24 -0700 (PDT)
Subject: Re: [PATCH 17/17] fetch: add fetch.writeCommitGraph config setting
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.git.gitgitgadget@gmail.com>
 <3c52385e5696887c40cab4a6b9b7923d60a0567c.1557330827.git.gitgitgadget@gmail.com>
 <87imukgier.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b1de6af2-c015-098e-a656-e1b68056e037@gmail.com>
Date:   Thu, 9 May 2019 10:21:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87imukgier.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2019 4:07 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> So rather than have this patch I'd like to as noted in 00/17 get the
> refactoring bits of the commit-graph in first.

Refactor-only series coming soon.

> Then some version of my WIP patch in
> https://public-inbox.org/git/87lfzprkfc.fsf@evledraar.gmail.com/ where
> we'd note the number of objects we had when we did the last commit-graph
> in the graph itself.
> 
> Then "gc --auto" would look at that, then approximate_object_count(),
> and have some percentage threshhold for doing a "do some of the gc"
> task, which would just be a small change to need_to_gc() to make it
> return/populate a "what needs to be done" rather than "yes/no".
> 
> That would give you what you want here, but also be a more general
> solution. E.g. we'd write the graph on "clone" once "gc --auto" was
> called there, as well as on "fetch".

I think this "gc --auto" idea is solid, but I also think there is value
in writing a commit-graph after _every_ fetch, not just one big enough
to trigger this new gc behavior. Perhaps your new metadata in the
commit-graph file could store multiple values for "number of objects since
X was cleaned up" where X is in { packs, reflog, commit-graph, etc. } and 
GC could consider each maintenance task independently. _That_ would make
this patch unnecessary.

Thanks,
-Stolee

