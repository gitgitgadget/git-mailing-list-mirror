Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC2D1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 01:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeJKJTc (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 05:19:32 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:40306 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJKJTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 05:19:31 -0400
Received: by mail-wr1-f46.google.com with SMTP id d2-v6so7766879wro.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a8/6IzEJ7FqjgyAZ3jWu7iszuI/HeLfkKPt1tKMVdU4=;
        b=XMqNk2XJzuyu2n4bsdJidBAvJzPdJEDNVaf7E333vswwDxCaPhnEiTbgFifk/MhQq3
         gyYboYPc6iYFhHDl0IGLmPiu7Az1oRGFcqRGa7PEc3QVk+j7z1khjK3mCdpUJ9rWHLzN
         zK409nbYSD5cuXlbE0eMxn59bqdoZqBr6QoWm1BkvDV8GJPO0wa+8y0uKIOyD1oBg4My
         konUFqxXWqAn9j+ZDXqUWFfKDD2ijaNxbSnaWak5HVm2JxSKDX01Ru//u5iNxAEzwFWe
         6UiM7En9BOFbjbaCRu99lhj+hcL9mme/W749DEJwNE7jRTZyl1aZODDvVz4FVIlxlS3C
         /E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a8/6IzEJ7FqjgyAZ3jWu7iszuI/HeLfkKPt1tKMVdU4=;
        b=J+KL97SsGFQSDQgNcwaaGYCkUGhaNVQ3ak4DRgNJHF2gPesFIyX+Ol3HfLPna5p1s/
         HhOUX22jJk2fKWjK8POhNSAnlbYCwcmIvI8YaKMyDl2ehHrtCHlLGrMneRTGRAz/f5P1
         1X3rm9d83U4IIP6tEJeIsfwPNC1FfyFZ/yjljyuSjzeec8Bb3h5ZS/F9fEsjkAFnETGK
         FRLe5RsPVfURLK+GjF7qHkuNZC8mLWUzLLrxXczaHTxiF3HkTFkoa05EZZag9Z3ZTYsz
         ZceqRm6CULuwJuoZvyV8f5FVWj+q0kE+cWp2FZdnspFXB5Z6/uBG9F/Tqhshl4gn23Tn
         XUOg==
X-Gm-Message-State: ABuFfohWBFu+NTYeKhg21sYsUoZlaa1Z+6ZqiA+xx3lksL6ZW5GjlZHD
        8RgSB8kVjrQiIOpBVHJRVYs=
X-Google-Smtp-Source: ACcGV61QVTtp8mY4bpKRn3MlYQeLYbJOsXi4bgF+I8Z0uGYb8kz4tldRIJXaOOhLUnkjO8+6hftHJA==
X-Received: by 2002:adf:8288:: with SMTP id 8-v6mr26553141wrc.252.1539222874869;
        Wed, 10 Oct 2018 18:54:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n11-v6sm19750699wrx.17.2018.10.10.18.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 18:54:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
Date:   Thu, 11 Oct 2018 10:54:33 +0900
In-Reply-To: <42930bb1-502b-b168-be12-92aee526a258@talktalk.net> (Phillip
        Wood's message of "Wed, 10 Oct 2018 14:58:39 +0100")
Message-ID: <xmqqh8hti6xy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> On 10/10/2018 06:43, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>>
>> * pw/diff-color-moved-ws-fix (2018-10-04) 5 commits
>>   - diff --color-moved: fix a memory leak
>>   - diff --color-moved-ws: fix another memory leak
>>   - diff --color-moved-ws: fix a memory leak
>>   - diff --color-moved-ws: fix out of bounds string access
>>   - diff --color-moved-ws: fix double free crash
>>
>>   Various fixes to "diff --color-moved-ws".
>>
>>   What's the status of this topic?
>
> I think it is ready for next - Stefan was happy with the last iteration.

Thanks.
