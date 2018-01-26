Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B081F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeAZSRQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:17:16 -0500
Received: from mail-yb0-f175.google.com ([209.85.213.175]:45918 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeAZSRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:17:15 -0500
Received: by mail-yb0-f175.google.com with SMTP id k127so499555ybc.12
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 10:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oSidcUGGx+DI4tuChNeu64aq2n0/bttS09FgAgafsMA=;
        b=lqb1oTfPPvF1yHIVFTWdAW5k5dPQBhkvKTye2S461qf8vu4IZSmf5Al79G7WveWQnx
         GXhHQbQWKrkutJYDhRfUVoEe6M8uItyoqzukwI29r5igIBm8WNF2q+LKoQ/XHy7gg6CZ
         BdsE0HdKeWa+kZhRBph78Vc+L8OtTb6o/jGQQl5EVjsUFj6z+3T42K0YNgX58YQiCrab
         uskRNXLTMaG2AtjmQyjaNhLF7KawVGmEkWIk7pgA87YCiD8vXn3p9foQABICrj1XVIFF
         69wkPYln0n4sz6Jme0do6Ys0hflqgwnsvxwYK/XwUCCzKSe3GXKbpVJpUtn/Rn/nyf7X
         s8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oSidcUGGx+DI4tuChNeu64aq2n0/bttS09FgAgafsMA=;
        b=dLJMkTLNkIdwF57pvCrjOW4AKQbkJIvQfKE37Jl41A5dOH17Gk1asWhRuwiFQEV9pg
         zXixy6sb5nxK2ZIsLgvZ1SEZCIeWfSzKk1xA8mzr//peG7w4soYoC47qc8Un8gxF5ZjO
         uj2kis5hNupq3YtbKzOJ4u3riTFSlYMgUA3SHuBATDnQDCHBP0DOQjh2Jj0+I8/AYZBa
         FysJP6rG81/zIbApXz+k7DMgKKjYQTi2JMhVWj6EOrcXcY40JY0JkorKHytpC0AHsTPg
         L0W3ZZTPw2ao/P8/k1FRC1Mfc6UV3DJNlKzv47cl7UdTvlMLxDz9tug+UFcepb5H23M0
         rXeQ==
X-Gm-Message-State: AKwxyte9sc5BepzQDt9kT5FDskTksjbGFFS3ibU+RjgBPBw1bD5fMfMe
        7n+AwhFGvlY3wPGe5Mo1OnvIDbSW9TH+GAW0ZXsRVw==
X-Google-Smtp-Source: AH8x22685DIZGZgVmdu86I5yL9Ijy9neyomEsU346vQTj5YIHO6DE+KWJXt7Z2FG/je1AyIr7oBQhCZxStLX3B7iRXI=
X-Received: by 10.37.163.198 with SMTP id e64mr11914199ybi.438.1516990634178;
 Fri, 26 Jan 2018 10:17:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 26 Jan 2018 10:17:13 -0800 (PST)
In-Reply-To: <6b72406f-90cd-194e-1f5f-02a43b7b60a5@gmail.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-2-dstolee@microsoft.com>
 <CAGZ79kbVoJpP3d_jgJ9Ekn=9NBMaKVNoapjygz7BxABxP2dCBg@mail.gmail.com> <6b72406f-90cd-194e-1f5f-02a43b7b60a5@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 26 Jan 2018 10:17:13 -0800
Message-ID: <CAGZ79kZUYW-NJYUfPco_SUDdO29Wo_cKW1-gxsFGvR0-3vV0NQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] graph: add packed graph design document
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> +- A graph file is stored in a file named 'graph-<oid>.graph' in the pack
>>> +  directory.
>>
>> (guessing)
>> where every commit up to <oid> is included in the file.
>
>
> Sorry, the <oid> is the hash of the graph contents (up to its trailing bytes
> that contain <oid> in binary).

>> So maybe I do not understand the <oid> after all, yet.
>
>
> Perhaps I should instead use <hash> instead of <oid>, since it is not an
> actual Git object but instead the hash of the graph contents. The
> 'graph_head' file simply stores the <oid> as plain-text hex characters.

Yes, please use hash. Oid (object id) means to me the identification of
a Git object, whereas here we only use the hash to
(1) check if that file is valid (consistent, no bit flips in that;
    --verify would do this)
(2) to have a different file name for each file such that we can have
    multiple graph files at once, e.g. build the next file in the background
    while using the old file to keep working.
(3) any other use case?

For (2) we could use `mkstemp` as well, but the property of (1) is nice
to have.

When using <hash> you probably mean sha1. When writing the hash
transition document, we discussed about uses of sha1 apart from
object naming, such as the use here or in the new pack file format
and we thought it would be ok to keep sha1 for the purpose of (1),
but as we may want to lose the sha1 code in the far future, it may be
easier to migrate that hash to the new hash function, too. So
it is easy to confuse that hash with OIDs because it is the same hash
function throughout time.

Thanks,
Stefan
