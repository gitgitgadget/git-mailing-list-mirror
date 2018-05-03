Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 783A6200B9
	for <e@80x24.org>; Thu,  3 May 2018 19:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeECTR4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 15:17:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37431 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbeECTRz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 15:17:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id w123-v6so8123185oia.4
        for <git@vger.kernel.org>; Thu, 03 May 2018 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A9rYk9I4VZw1nLbRDlHXdDJdoPjpKu+BIPk2rwbUpSI=;
        b=Y2x6kiq1Y0JR9wZBVqaAKsx4qP8VSKbDGv/qglLzGi75M6xfNCKobaMR2diUouowbn
         bG3Pd3ELuSkoM0XR0htjq9CfGELKrvKsYXLGk/Yh4Q8D7ooDJYRXyjlO1DdwPVaIOhuc
         HIQEP6wUYHCv+O2Na68QCarM67THAEL+xC0cUUHRGgH6uIVch98sP/RkJWTZBOvQqR+7
         GYlal8c4dXiY4v6ST/k68Ts6c6cyQNwiHodyyhENN/GvaE8dTAk52w4lYV4r9NLpAAuL
         UB1BZs+QYv2WcwL0Be8R0u3HdEbqbKoLHp9bu2T39QeYMSFDSCURowwYp8VFAf8Cu0Yx
         0oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A9rYk9I4VZw1nLbRDlHXdDJdoPjpKu+BIPk2rwbUpSI=;
        b=aM8y7X9E2qkkzw8v+ZcN8ZW5eN6n9jOW3mKQjgGUWl14qh5yBKPUnxOaCJaTVwvqBm
         iOB9jlBvG66MHsQu4pJqASRcnSmV+70+ICf+f5697+w2+zmCbEtYdBZ66BBuAtPCLjHv
         ByL/LOLi5k92j9qHPWMfghhoJ+olTGxTkLzcswsZ/V5VDkHP8ClqmhLzSImg8S2rdcWG
         CCaxM7/wodBbbOGrDA6lTCwsBjHGhAj2ejlLh/vSjRjJiU7EYk+I0k/DwQ9lmkLzBE+b
         Nxk+EgpxxENh9/vCbWeHQ7V93zEQPcZiR/XOs7vsL3ipQ1pElu77vbNGOPOclFHxvjmO
         iKlQ==
X-Gm-Message-State: ALQs6tAKluQGbLyfOAXrJui90VRtZPSjW8Tn0USuK5LHx217VRO1MPUW
        j8BisDuD77oe4azgXD9UESYYwNlNjaSw2IQsRiI=
X-Google-Smtp-Source: AB8JxZpUrx0ewWs/WqRkftWxpXzG3UP8yAjZuHNIq6nz5Wgb1QDgGKYwcJZEo5umvnDN4QjKmMk+mRxNvy6Tnuqcb10=
X-Received: by 2002:aca:2e09:: with SMTP id u9-v6mr15772349oiu.228.1525375074729;
 Thu, 03 May 2018 12:17:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 12:17:23 -0700 (PDT)
In-Reply-To: <CAGZ79kbyPya0igC9v5JwNTsi0TSp-sj6v5SB4MOt625+yVB-Gg@mail.gmail.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180430153122.243976-1-jamill@microsoft.com>
 <CACsJy8C3yZ6bSZGw1d5DjwcPgHMDE7iGGUOn9SvyLmshzs9DvQ@mail.gmail.com> <CAGZ79kbyPya0igC9v5JwNTsi0TSp-sj6v5SB4MOt625+yVB-Gg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 May 2018 21:17:23 +0200
Message-ID: <CACsJy8DF40o3gesuNbHACK+NiE=iZuXxLacyEQjECYewDy_icw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Allocate cache entries from memory pool
To:     Stefan Beller <sbeller@google.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, May 3, 2018 at 9:35 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Apr 30, 2018 at 5:31 PM, Jameson Miller <jamill@microsoft.com> wrote:
>>> This patch series improves the performance of loading indexes by
>>> reducing the number of malloc() calls. Loading the index from disk is
>>> partly dominated by the time in malloc(), which is called for each
>>> index entry. This patch series reduces the number of times malloc() is
>>> called as part of loading the index, and instead allocates a block of
>>> memory upfront that is large enough to hold all of the cache entries,
>>> and chunks this memory itself. This change builds on [1].
>>
>> I have only looked at the mem-pool related patches to see if
>> mem-pool.c is good enough to replace alloc.c. To me, it's a "yes"
>> after we optimize mem_pool_alloc() a bit (not that performance really
>> matters in alloc.c case, but that may be because it's already
>> blazingly fast that we never noticed about it).
>
> alloc.c was not just about speed, but mostly about dense packing?
> 855419f764a (Add specialized object allocator, 2006-06-19)

I know. I vaguely remembered Linus made that change but did not really
look it up :) That reference should be included when/if you switch
from alloc.c to mem-pool.c.

> To me it is also a clear yes when it comes to combining these
> two memory pools.

I also did not notice that jm/mem-pool already landed in master. Have
you tried measure (both memory usage and allocation speed) of it and
alloc.c? Just take some big repo as an example and do count-objects -v
to see how many blobs/trees/commits it has, then allocate the same
amount with both alloc.c and mem-pool.c and measure both speed/mem.
I'm pretty sure you're right that mem-pool.c is a clear yes. I was
just being more conservative because we do (slightly) change
allocator's behavior when we make the switch. But it's also very
likely that any performance difference will be insignificant.

I'm asking this because if mem-pool.c is a clear winner, you can start
to update you series to use it now and kill alloc.c in the process.

PS. Is Jeff back yet? I'm sure Junio is listening and all but I'm
afraid he's too busy being a maintainer so Jeff's opinion in this area
is really valuable. He has all the fun and weird use cases to play
with at github.
-- 
Duy
