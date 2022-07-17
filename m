Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298A4C43334
	for <git@archiver.kernel.org>; Sun, 17 Jul 2022 14:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiGQOnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jul 2022 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQOnH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jul 2022 10:43:07 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C8DF66
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 07:43:05 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id l2so7151884qvt.2
        for <git@vger.kernel.org>; Sun, 17 Jul 2022 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RWdvsNwfFQ1tG195FTT0HULbxf0KIXXJMn5dwmbirbk=;
        b=OlGqYudsQ6R79BmcRLhqkzqyLDfgmTh90953v1rp4LRPnKEeMUwBnKY5X/EBa7mseX
         k+h/nrP9gEzcySglG2xKCXo6B7AxiN8T5I0SFhcgU6LX+xNvBrhjD6VwMniwsrLVT1mh
         eXjiDolF6QtzoeYV65Wk5rPgbx4xuU5TmGYa/+D5+n5YwSBGm3zToItCltsvyAsFoPb3
         l9R3FIap4+1QbTJp35ZzdohFi9jO8stNkfXPunJtKIsHuIo+0d4ab+a88zBEDSYiOKWE
         QRFISIzEd9PSnNJaECOUtK1582yKgDj4mhuX7zrfSQypSXzyFvnurw5R3va06B9QyHEq
         RtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RWdvsNwfFQ1tG195FTT0HULbxf0KIXXJMn5dwmbirbk=;
        b=8Hm870eWvW/hfQeR//ul9MDQ+yksaDvgCdkWeTs43YRHOLxv6sWTBDWxAs40qMkj3n
         2iK+/tbCb/Yx5uGtOX9F4CsMKklj3OaophCNbu0SJBDQq9A4pOMCoCTneHdMCK+2TcQh
         K+auzdRdLQr5bfrb8rHwTpdbuf9JlAUv11kuvwL1EYjW2leqwS78TKpWsTVd4Ogk/OUw
         kZcIw9PdfksaUOD4QwnmM2SRYzsj8DZnrWOfHhTMI1x8y8RNwRqAuKwBW9s4ITFKJ5pz
         NroiOZvyYOpbONGUcYL6UQvlezIcq+kJYmFExWTmTTpZIYtvfnmPEteaUiWlyyRysciJ
         9/3Q==
X-Gm-Message-State: AJIora+6mAanq1tfqbdrUaAPn83E59y2W7KDG8ZI8pyHU2TcGfZUC0SF
        eUxNj7NqbnsmLgBQ7kw/UAbk
X-Google-Smtp-Source: AGRyM1tPgjJxK3GaTy9oa+JxCrq5ud+VIbLRfiewTZ/8s+lmvId6EDpCsutyojHyWBg10QzIszy5iw==
X-Received: by 2002:ad4:5942:0:b0:473:80ce:7c4d with SMTP id eo2-20020ad45942000000b0047380ce7c4dmr18386821qvb.100.1658068984724;
        Sun, 17 Jul 2022 07:43:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:841f:e099:cbef:4067? ([2600:1700:e72:80a0:841f:e099:cbef:4067])
        by smtp.gmail.com with ESMTPSA id k13-20020a05620a414d00b006a981a2c483sm9352387qko.39.2022.07.17.07.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 07:43:04 -0700 (PDT)
Message-ID: <62456232-26af-6883-1f89-53f16863d2d5@github.com>
Date:   Sun, 17 Jul 2022 10:43:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: Can I use CRoaring library in Git?
Content-Language: en-US
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/22 9:50 AM, Abhradeep Chakraborty wrote:
> Hello,
> 
> I need the CRoaring[1] library to use roaring bitmaps. But it has
> Apache license v2 which is not compatible with GPLv2[2].
> 
> Is there a way to use the CRoaring library in Git? Taylor told me that
> contrib/persistent-https tree is also licensed under Apache License
> version 2.
> 
> [1] https://github.com/RoaringBitmap/CRoaring
> [2] https://www.apache.org/licenses/GPL-compatibility.html

I know that working around a license would be the the optimal way to get a
battle-tested implementation. Its API should be close enough to the EWAH
bitmap implementation that we can transition between the formats easily.
Continue pursuing that for now.

However, we always have the option of implementing a version from scratch
based on the description in the paper [3]. The benefit there is that we
would only need to implement what we need from the format and logic, and
we could even get some benefits from exposing some of the internals to the
rest of Git's codebase.

[3] https://arxiv.org/pdf/1603.06549.pdf

I mention this because I made an independent C# implementation of
Roaring+Run for the Azure Repos back-end. The way that the bitmaps are
split into "chunks" of 65k positions was helpful with how the object order
was set up: older objects were in early chunks and so deltas only needed
the later chunks. When using a chunk, we could lazy-load and unload each
chunk as we went through the object order.

So, if we really want to try this, an independent implementation might be
the way to start, at least as a prototype while pursuing the licensing
angle.

Thanks,
-Stolee 
