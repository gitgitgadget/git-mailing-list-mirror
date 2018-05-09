Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39611F424
	for <e@80x24.org>; Wed,  9 May 2018 17:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935507AbeEIRHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:07:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45579 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935495AbeEIRHh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:07:37 -0400
Received: by mail-pl0-f68.google.com with SMTP id bi12-v6so4660385plb.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UtDLjP/9Ym7Sx3dS7Yfr/i3cbEC3xYqKAkgoF1QvBTE=;
        b=W5xxDtKTMBg1VKD5bTu4bi5/rakjgz2Tsm8waKLYZ/MxHRXkAz1tgkrtxdIFB30pC7
         CZPamxIvAk92N8saTlsabywv3GrIeBmxZoSvz98QQVOsey7aJOjiledSHET7A4TPg+v0
         YYADDLhO6/gE/50QMSV5W/E7d9FLGEN9Qxz2JbAR2F7UTwIg0lmC/2TPx06ICTBGmb1p
         133lzIMMNpmKBsDf03Hnn2FGr1u9lBnQ85o62qHg7zXS3la4WlFj7Yohs0NuyNQHpmQy
         M1vSOermLr3mRPO3fcEoQo0Deq/u161kkXy3ADKvycAl917XHHf47FF8nACJT5hmfpGJ
         Ff7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UtDLjP/9Ym7Sx3dS7Yfr/i3cbEC3xYqKAkgoF1QvBTE=;
        b=sLGoOviLv06JuWDrHfvHCNoev0djtwuXnSCBSbQmmuoh00wILJL7p7n7YCResfwm78
         YXxhIcRkM4gc2r/pFX0gl1Gekp81q98ycVcgcmQ48UVNyI9o6kDr+SRmdDEgc1k6Qtus
         WJrwDeFeBWOUUmTBCjlpS6CDhdzEBtud6J/YiOdeAojfwGA3iYT9LKZpystpBzv+owk+
         mPyvf7Zv/P34vslhX1RyiL+2Ng3A8otdtRLyCxG/Qz6WBJlNqno4tjhDCZm3pbdxDtSO
         2i44XOotk8/6m0O5TZkOd8X5+LuHlKnUlT6iWzlaj6pzF5zcwZJ0fHjw84NyAQzIGumL
         xrpw==
X-Gm-Message-State: ALQs6tDkT5cP/Rx6s2X/ATJ1pMPa9kh9CwYbRz9EWNuBvxt0P6q/apqP
        6pbHKK4zfXGXgsw8s8xn9/iN+QUJh2n5AKGc2ac=
X-Google-Smtp-Source: AB8JxZr8S3eRUfv++I9wkw4AAdcdRbJfQ/kx3kyxr08X0HgpUfDREiHBZGvKzReXFh6Fi0s0QD4KzJ3JHdArqW9lDc8=
X-Received: by 2002:a17:902:b94a:: with SMTP id h10-v6mr47418634pls.321.1525885657250;
 Wed, 09 May 2018 10:07:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Wed, 9 May 2018 10:07:36 -0700 (PDT)
In-Reply-To: <CACsJy8BDaHUs+DMOM7h6Lgbn8qB8yE4-O4iG=t85nG6sQ77zOw@mail.gmail.com>
References: <20180506141031.30204-5-martin.agren@gmail.com>
 <CACsJy8DyRhQ0DKy8UyK+r7Kmw=0hHD=W6aXXKutk4e-wtGTdNg@mail.gmail.com>
 <CACsJy8Btuc2J4aCTymkvLYyMV5zJrdMUdtV5NDnPqXOjsTVw4w@mail.gmail.com>
 <CAN0heSpA5H7Gwwx0TEY9=iFJrgKb0SPXqKOwHK=4NxPYoGjZ7A@mail.gmail.com>
 <CACsJy8DDyrUinwXx1b66DCHB+2DLt1KBmFt_83R1+HWjbzGH2A@mail.gmail.com>
 <20180508181839.GC7210@sigill.intra.peff.net> <CACsJy8BDaHUs+DMOM7h6Lgbn8qB8yE4-O4iG=t85nG6sQ77zOw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 9 May 2018 19:07:36 +0200
Message-ID: <CAN0heSr7mdaMRxsy-Aev3RpBf-9Xvg6Gw_=UyRqV0FPCVx0KNQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] lock_file: make function-local locks non-static
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 May 2018 at 18:19, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 8, 2018 at 8:18 PM, Jeff King <peff@peff.net> wrote:

>> It should be totally safe. If you look at "struct lock_file", it is now
>> simply a pointer to a tempfile allocated on the heap (in fact, I thought
>> about getting rid of lock_file entirely, but the diff is noisy and it
>> actually has some value as an abstraction over a pure tempfile).
>
> Ah.. I did miss that "everything on heap" thing. Sorry for the noise
> Martin and thanks for clarification Jeff :)

Hey, no problem. In fact, the "noise" as you call it had some signal in
it: the commit messages should obviously say more about this.

Martin
