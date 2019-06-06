Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3AB51F462
	for <e@80x24.org>; Thu,  6 Jun 2019 19:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfFFTAM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 15:00:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40430 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFFTAL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 15:00:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so3528250wre.7
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 12:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgHnjJsSLCdczgUDHdy4nkxGN2jyqRVvD7XT4+fwzSo=;
        b=gsDtvF9qP1D5/yvLk9HwWRGdP0YxruzfKtq1ELuGUNQrUFVxa79+MDFwcImkoywRfB
         BgKq/wTv7+goz75UZ45dJ9772j2N4xWLVL5ZJmglmHX31v32RQYWIl3/oLcSP8FZh2I1
         YPX4hgejOPHP8M8c7w4e10BaEyb4axPXlthvvsjCc2mPPe/1qXpHWAjZ6GFIWR2uO5En
         k/P0FfBkbscybbjaQWk8ytjgPBG+RdjeTbTLLDx1lq7y9Iy7SMWeaVWofAYArmTclKAA
         lBcc7bbZcoFBtDx7iX6t/ROacXuC4uNpia9kmG3s8sVbJrEiU/XPKzprgthzfYfEbrGw
         wifw==
X-Gm-Message-State: APjAAAWemd60Gnman8qrqw0zh6iPDBzCzOJCv4gJecmqbThhvxBsFbG0
        ulrtoZma7D9kD7n8kxv85hMmcENGKXdpQ/KgEm8=
X-Google-Smtp-Source: APXvYqyaer54HaFuTlX+1H3r3cxk23rD3PnkQi/hXSCuDAHAKFVVg5W0dVnDp6TBcAF1va2i7KpCr9KAbDb3mJ9R7So=
X-Received: by 2002:adf:8b83:: with SMTP id o3mr28978565wra.278.1559847610707;
 Thu, 06 Jun 2019 12:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8kynjwT8wbHYV0DpDaMX=AnfmXeOci3uYUnnfsvbq4iRg@mail.gmail.com>
 <CAH8yC8knkXtBii9KhS2iUo908zTx_NyPUgXZhqdwmwEF7Gz8Jg@mail.gmail.com>
 <CAPig+cS98DeSaF6pNqKCn6bAy=jjiTuc3AZpPB2cXm6hQ6vcqQ@mail.gmail.com> <20190606173516.GA25089@sigill.intra.peff.net>
In-Reply-To: <20190606173516.GA25089@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Jun 2019 15:00:00 -0400
Message-ID: <CAPig+cQi6V=B7GtdN3+-1nPnLXiVjz-O+=WJt5f94o7wHy1VHg@mail.gmail.com>
Subject: Re: Git self test failure on Solaris 11.3
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeffrey Walton <noloader@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 6, 2019 at 1:35 PM Jeff King <peff@peff.net> wrote:
> On Thu, Jun 06, 2019 at 01:18:01PM -0400, Eric Sunshine wrote:
> > > > not ok 12 - check normal git operations: twelve packs
> >
> > Jeff Walton reported this to me privately. I'm not familiar with this
> > code and don't have time presently to investigate it, so I'm
> > forwarding it to the list in the hope that someone who knows the code
> > intimately (Stolee) or someone who has touched this code (Peff) might
> > have some idea about it. The failure is intermittent, so perhaps the
> > output of some command is not stable sort-wise(?).
>
> I can't seem to get it to fail for me, even under high load. Do you know
> which of those commands is failing (i.e., what does "-v -x" say)?

I don't know.

> I can't reproduce the intermittent failure either on 2.21.0, or with
> v2.22.0-rc3.

I can't reproduce it either on Jeff's Solaris box. Perhaps Jeff can
add "-v -x" to his automated build/test script in order to help
diagnose the problem if it occurs again.

Thanks for looking into it.
