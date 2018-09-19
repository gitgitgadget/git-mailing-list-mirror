Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9651F453
	for <e@80x24.org>; Wed, 19 Sep 2018 03:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbeISJUg (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 05:20:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45355 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISJUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 05:20:36 -0400
Received: by mail-vs1-f66.google.com with SMTP id x198-v6so1340258vsx.12
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZXiBWRtuTc+r/in7YMnZfYbE79f8t5FDhAm9hP5H8g=;
        b=eDxCU7hAA2RYsZRY/4PVhFjH4eI8m0Siax1zN7iB6tWg86oEJEk3qTAb6Fbrojra2r
         rmi6wW5wX67esS2wVnErzzjbA7w+I+hNQGNOvEPBhOW5qSUQw+Je5Iv8u/O7E1RwOXAi
         JyThSTrD5Hf4Q4vKZFBW1IyXJvS/xE/HeBMoT/GAfI0hX11LIfLWb/wHrFz0JKJcr81G
         8lFIIFAxVvo42gMJKKRuTEd5s0DC2naKjTAv/nxi47WSaEcO5MhiunqHjba+jcAWF98N
         RTfYPPr06Rcso0ESGlSsjTjdzxL35cVzLAqdTnar0cSXePeK0EcHCRGj0m/hZUteRaeo
         gC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZXiBWRtuTc+r/in7YMnZfYbE79f8t5FDhAm9hP5H8g=;
        b=pLMsl52qw/1Rv+U4PsRfe5WJpxUaC98ONILeduyyGw1wgrHBv/asL1JDgMdahA+NJi
         0jhXh9vQusvqkY48IlmWNQOzug1zOQ5KHf2yldkd/zZPh9C8jbFGKMZzhzoltpZ09U+y
         cJ1P9PPWX5nfrcVZZByPpZ9RPt9kZ9qOWe2xZ+bjuv47P7baRUTejFod7XmfYeUEawWl
         v0Hghxryajaar0K+xTDNjWFceFQIgcYPW07XuDxurCTWaLb4WxJwhI4e199CW86U6CHn
         qw4+4Or4SPFySkWAjwYuYcOVTFSEmLpJ0lIgbQ0TeAKK7WZULXYhDqc4ECnBwlMVHRmO
         44fA==
X-Gm-Message-State: APzg51BIyLtIax9WiBBBkHDUHIZBdoydiBvYXnx9lzduFUHgT2znxAfG
        kiQkRMomj6mBq670KiuIENWZIQL1d8yCsuEVfps=
X-Google-Smtp-Source: ANB0VdYTGdKeLEd2E33shx5OHImy2Jy3OC/LnUJ0n0J+zCyd2vizQjnT34b1iX+CFu5coZbmGJuCArJYGOT3/e6GkhE=
X-Received: by 2002:a67:f60f:: with SMTP id k15-v6mr9420381vso.71.1537328682235;
 Tue, 18 Sep 2018 20:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <466296e7-6462-d5c1-2d57-2a636309054c@ramsayjones.plus.com>
In-Reply-To: <466296e7-6462-d5c1-2d57-2a636309054c@ramsayjones.plus.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Sep 2018 20:44:23 -0700
Message-ID: <CABPp-BFZMKCxjuZvNQRgyj2MAqV2FjoTZ=z7p6aX6EWad4i70w@mail.gmail.com>
Subject: Re: Subject: [PATCH 0/9] hdr-check
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Tue, Sep 18, 2018 at 5:09 PM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote;
> This series follows on from a quick "just before bedtime" exercise
> recently[1]. The new 'hdr-check' target essentially automates what
> Elijah did by hand.

Cool, thanks for doing this.  I believe I only tried to directly check
the toplevel header files (any fixes I made to headers in
subdirectories were just due to their indirect inclusion), so it's not
surprising to see that you needed to fix up some headers in
subdirectories.  It is slightly surprising to me that we've already
gained 6 cases of toplevel header files that needed fixes; that
suggests this hdr-check is even more useful than I would have
suspected.

The Make-fu in patch 1 is beyond the make I know, but the other
patches are all pretty simple and look good to me.
