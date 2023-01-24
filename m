Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7CFC54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 16:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjAXQiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjAXQiu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 11:38:50 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE0C3C35
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 08:38:43 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 203so19546732yby.10
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RDu/PMHg0ENTkAgmfRUZ/b5FYyt3keBZn0YuwzmMetQ=;
        b=gpRiLeS3HYBWlDcos/nrE2w0t9Hca5XeRaER8EopPtNgLEX0ZDl9omKTnjgb8l/HhE
         CeiqtlEZUwXtXylBZEjyYsm3PftTg/mo7OrN4pyma0jIDV1MX6knjliw0cEYwiFwESb4
         D3vNMDS8Ck6GFPwnvjetNCxsUnfCKTTJJGBrqezJR3yYc+vIQkDs3GDqBwJdOgJ6u1Qp
         lL56o4EXqI5cVVLpJQOLV1pD/XJ7jDY+gL6NdPDutMgQADNWXYkbDit0htRF/6EwApaG
         3D7BFSvaSqYOy+2NGHHMN71101rRnu0juad1xgdJktKaUDA5y20C89x8GEOS9RHFjfpG
         5cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDu/PMHg0ENTkAgmfRUZ/b5FYyt3keBZn0YuwzmMetQ=;
        b=wNVQ4SrEYy8hJvRC86guzSLqtx1H18G12QQ8DjrlCmMOuRNojzHFXnmhTSWds15p6l
         SCaC3VFdCVcItOqhE1l8MKCBP5T3eXpBtdV7rtzX9xaarl//aqh8qyZt6NbGb64zFcyF
         nkQu1e2UtzrQ4Mhxa8RLvU53q5Tr35NXhlTAIc49wZewHeBwdkuuTLHJ9fp0zDzDvdrH
         w6ZPpt7CSfiqHFw4c7AK3tavt3JpEKwqUXzR0yb5Toj+srvrtPd2vlQQYLXWcld2e9tb
         x5wtHx4fQRDCSIEOeYksiccELARk76IzJ41owTDnK6KsFUPnps3NzYMiCfYNfMgTxD/F
         4F7g==
X-Gm-Message-State: AO0yUKVbml2CmbIDGk1m9l5lOj54vGKUD6sfGeu/hNNjZpsGlUq2o7rx
        sfGSlLoKxpugc9II0y0eFYyOELiSzxhKEnd/a2Q=
X-Google-Smtp-Source: AK7set/Z0RlhTxiJIRyctoeab0qPat7xIhpL8mFWuc5r5MqGv5k/4KORjPv4WVOS20JQfqnpGQZcGZs5Hq5fwnKru6I=
X-Received: by 2002:a25:e0cd:0:b0:80b:7727:8363 with SMTP id
 x196-20020a25e0cd000000b0080b77278363mr167232ybg.366.1674578322913; Tue, 24
 Jan 2023 08:38:42 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com>
In-Reply-To: <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 24 Jan 2023 17:38:31 +0100
Message-ID: <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
Subject: Re: GSoC 2023
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jan 23, 2023 at 6:41 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> On 17/01/23 15:04, Christian Couder wrote:
> >
> > GSoC Org Applications open next week on Monday, January 23rd at 1800
> > UTC and close on Tuesday, February 7th at 1800 UTC.
> >
> > I am interested in mentoring and being an org admin for Git again this
> > year, so I plan to apply for Git soon.
>
> I would be glad to help as an Org admin this year. I don't suppose I
> have the capacity to mentor / co-mentor this year, though. I could very
> well help as much as I can passively where needed.

You are welcome to be an Org Admin, thanks!

Actually you were already an Org Admin last year and it looks like
they didn't remove people from the roles they had last year, so you
are still an Org Admin.

> One thing to note about the Org application. As per Google's claim we
> should be able to complete this year's application quickly since the new
> webapp allows us to reuse last year's application details.

Yeah, I just did it and reusing last year's application details was
quite quick. One needs to read, agree on and accept 3 long documents,
and they still ask a few questions about last year's GSoC though.

They also want an URL with an idea list, so I quickly copied and
edited last year's idea list into this one:

https://git.github.io/SoC-2023-Ideas/

I removed the "Reachability bitmap improvements" idea but left the 2 others:

  - More Sparse Index Integrations (I removed `git mv` in the list of
commands that need to be improved though)
  - Unify ref-filter formats with other pretty formats

On both of them I removed all possible mentors except me though. They
are welcome to tell me that they should be added back.

> We certainly are in need of ideas and mentors for this year. Do chime in
> with your thoughts. :-)

Yeah, sure.
