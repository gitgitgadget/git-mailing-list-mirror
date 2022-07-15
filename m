Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA46C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 22:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiGOWs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiGOWs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 18:48:27 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BED194
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:48:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id k7so1762156qkj.2
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1/lSEQSepF/PSZ7nvtEuWxfuJumdex4BTYgNj68oz5c=;
        b=QB8QKfgBtyHBvKq404ebiClJeXKrTxR1L+AUB2bYIrhKhctJLJfJcSmBNSjScTE6Tt
         uGo7YD3msdAWwWHhIvFM+gE2TT3JjXIDP6R8yS8/EB/NbN2v3Yb9d5GMLc+ZPF/19K4S
         CvoYjCQ+pHIB6Sd7NwMzj5etZQCVHwjxW3f5CuQaN1XqfXZOqZXSFKv201TCdc8ob4+B
         TTsUG6yjEHLjFGl3UDan6BrWOs1FIaMvbhJOdpQErOV7g1H15aq8F2ibj8L76fbzzmRw
         BB062v0jpAfWavApV8AJsu7xS4NrHFlrC0P3d8jjFWQ6F4Sg3CHyFYKGucN0nuH4ROyw
         YWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/lSEQSepF/PSZ7nvtEuWxfuJumdex4BTYgNj68oz5c=;
        b=bKK6VDLjfzubeKLO/e7eIAdSeYv1Etxk0oYFnpYMfsd/2O5fIv7L87rk0OUSpW9GWZ
         nzCJ/AD4hVgEM+YRN1SOA0RehukKVCHgVu0hks3VAuSHgLmOdpCNDqTTSsgfTafuOXEc
         wBgxzfVNpiYhHwVVjPo+G/zD2iCxAgmdqwJGlz61sZX67eQml1MidDVo/IJbGOxnbTrl
         WQ0Myf5J34tBT9+KG8Ag4GIruRSQjIJG81GhdKg772NdKKl/v4FzTeKaEc9dX9fNJuJP
         59uXBFN3mmmPbfHjSRtQ/nG9U8WCQe54z3ezvyE1J4AJzYO7bbSqdl38TnHOdFBLHqy9
         xLSg==
X-Gm-Message-State: AJIora94LT4i4QmW83xsogN2gaydXX4P/Ea5AQmD3MAogWFGypZvEOGO
        hKXGoQRmAcrX8reQsteQXWhaLQ==
X-Google-Smtp-Source: AGRyM1umCfrK/yw/e5cmbLDHlBisz8fWVAnpNVQDU8/kvebkcH36NxpEpv0l5bCjiYN0oWDQhvebDA==
X-Received: by 2002:a05:620a:17a5:b0:6b1:46fb:172a with SMTP id ay37-20020a05620a17a500b006b146fb172amr10610381qkb.687.1657925305885;
        Fri, 15 Jul 2022 15:48:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bm8-20020a05620a198800b006a67d257499sm5191821qkb.56.2022.07.15.15.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 15:48:25 -0700 (PDT)
Date:   Fri, 15 Jul 2022 18:48:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git Merge 2022, September 14-15, 2022, Chicago
Message-ID: <YtHuuE42bogVLOGn@nand.local>
References: <YqjEAEPYEJMUx8Wu@nand.local>
 <CAJoAoZnXyyZZxexyEeNjTrOBq0FkJ+EVhYT8YeqHYLHnJ1xASA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZnXyyZZxexyEeNjTrOBq0FkJ+EVhYT8YeqHYLHnJ1xASA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 03:27:17PM -0700, Emily Shaffer wrote:
> Any chance we could open up a topics and voting sheet/doc early? Once
> in a while I've been saying to myself, "oh, we should discuss that at
> the contributor summit" and within a couple hours forgetting what
> topic it was :) (I would say the thing I want to add to the doc ...
> but I've already forgotten. I think it may have had to do with
> libification, but I'm not sure?)

Sure, that's a great idea. I created a Google Spreadsheet to keep track
of topics, session leads, and do some voting.

Anybody interested in contributing thoughts down should feel free to
email me off-list, and I can send them a link to the spreadsheet.

Thanks,
Taylor
