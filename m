Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABBB1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbeIHNoI (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 09:44:08 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:36049 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeIHNoI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 09:44:08 -0400
Received: by mail-io1-f48.google.com with SMTP id q5-v6so3339804iop.3
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 01:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/lg+nSqAyZjnojIUxeyMrZcnoxtOlEa+6UcxnWT4HRg=;
        b=LZ0883AJujuE5hDIN/Xxlol86CKa5vJ8qdSIaYT5PL7zIdsLMR6BPuQj5RUy14b2pi
         dkMNRslT4rQM2ag6TvwDohGegx+5je9kDnKFN5DcME67DV4LCa2jV64aSn2XT1Jh5khG
         yzKJe9LHq11aG+jHMYdmpzBkhH7OiXV3LCajb32t91Bwlopn/7deecrUdLAd3BnOEyeQ
         nV1ujMD/9wJJ0QLqFlk6TJTnpJs8OhBA+s9E6RGoV80Qtk9Lq5iRyH2zs2N9qly4BYlk
         8IHF2SslUTiV2RZgz4MgFRVZQIhBsXxuU7vnboBNeM5Ew2EdGBsJiFzP3tcXPBz0Fw5A
         Lt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/lg+nSqAyZjnojIUxeyMrZcnoxtOlEa+6UcxnWT4HRg=;
        b=HtNyTfzSUKNGJ0VEXdqqJ2KGtuZ89OKKUFe2g6pwIunlTtXZSMZ0iaB9sOOBcPPv+H
         0++U2zpINdBJGFKUHsWObQkBVtMnAbFzkghLLCCLxhLwl+1Ncy7lRiaB0a7ervnqMNYH
         GuALgJAiBdyR1Pc7a7Zk2pLoUDLasiYJWzZGjZfimVsfxdxmdk7CKQNBLQAKz6Dr1ssb
         6GyrAzQOy5HaM71BfRjW2M7qzgQD2+iAkUtDRXUB7VkJ//F7iHi1bk3vlGBTiYq75zzu
         PapQv3LDO8j2tlzsYFjJ3zhsNLjgZimV9c8CDinJ3c646nKhhMoxMfQJBSHrOkbxHmQf
         Wb9g==
X-Gm-Message-State: APzg51BMJPx64Q4D00Az9580KpwIwwIOl4icZeI6kKQk2qBsZXKRTX+I
        FD5+hv//Ug/pUd+Cazoa0ymZgFN+NwQxpf37i24=
X-Google-Smtp-Source: ANB0VdZwydAr+lcelA8GTnVoYRsXUlY7dQ21J0z/roS3LJ7oy6HOCxTk+xfpYg45XqEd1bPhQi9Dh1RqL2y+rdX/zwQ=
X-Received: by 2002:a6b:500e:: with SMTP id e14-v6mr9302329iob.5.1536397147488;
 Sat, 08 Sep 2018 01:59:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Sat, 8 Sep 2018 01:59:06 -0700 (PDT)
In-Reply-To: <20180906193431.GB28588@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net> <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net> <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
 <CAP8UFD3DrhA9C0=k-ie_fnpKwmbezQ9ufp1RPHrZ7A-VUjhz0g@mail.gmail.com>
 <20180906011428.GA5024@sigill.intra.peff.net> <CAP8UFD3-djatPqoVGNGWNQkuJ84BboFMYrGSAEOQDygjJVcqeg@mail.gmail.com>
 <20180906193431.GB28588@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 8 Sep 2018 10:59:06 +0200
Message-ID: <CAP8UFD0w=MQkrJDy4VVZt1T7iFi2KUBtDzr3zssWHbiGcg-5Uw@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 9:34 PM, Jeff King <peff@peff.net> wrote:
>
> By the way, I've got funding from GitHub lined up, so we are good on
> that front.

Great, thanks!
