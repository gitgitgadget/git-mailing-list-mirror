Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1235F201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 13:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755540AbdCKNHT (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 08:07:19 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35446 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdCKNHR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 08:07:17 -0500
Received: by mail-io0-f194.google.com with SMTP id f103so9367062ioi.2
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 05:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ow/KZSjdxOuE+spWc5LwB8uMsYr3xxT+tXW+eLYz4ck=;
        b=WpL+IGgP0dYDc7SrOGSIS+rS69zwyVjeJF3xtl70an1VEHhnA8EEkZ759gI8KkTxgM
         XoiUxaWs0e7mCnobZyuKoZW4IgMYAGAiBOyvfrhCnWtfz3Nw7GQP8aD7YShftTabi79f
         mpen3g3ofE79S3oXb3Atcci9lcZ4SC2/NndtBCo/cGJBcR6xvIgjeasjSb1zPt/nzvLU
         8pP0HFEfQZd/VaQ1LiMKOjuP4xN5w2pN7CauDzbNONiwfmAGZiENevBsdmIz8t8WjVRW
         HFgibD44YxQeKuh7qiU/mL6I033NVoPMwwsyHyEd43JG4OUbxWLmm0Xekbf1ieFA1ssx
         I8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ow/KZSjdxOuE+spWc5LwB8uMsYr3xxT+tXW+eLYz4ck=;
        b=iNms8H5PskDcN4RYryIAd+zLsZwWatQQ6cOZfT/0BriVt7dFB5PiyxsD2NFzHnLSIG
         XjtyoZIOyMGom3JsTw6GovLiaXqHgJkvBoDXrWfOLiyjicdm9X1PKl187ojPiKdfElEy
         osREnpr1/f66nBbOnmILzlAzIzY6erB5OXYHAR5ERYnaOzi9qq4ahn7T+o6pM4j54Gmv
         g/BE3LMtyhoIPLv9xkhL//xCEE7ObB1NvOKJA4elPw3XXLq7JAxozS/s2eAAPTl/ilKq
         1grVwv+tDnvuNsudV3duOUoY21/+4G+w30D99jwy/hIRc1+rHAPXg2wX3eKn9dn8afpU
         E/iw==
X-Gm-Message-State: AMke39lqqnAexxus63DExiL0hYlsYI6z0amd80clJ4dZDjmDJuCKeZyy6shXoT7dhsFhwUjPCKt3AIb79EmJhg==
X-Received: by 10.107.200.139 with SMTP id y133mr22482383iof.147.1489237636315;
 Sat, 11 Mar 2017 05:07:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 11 Mar 2017 05:06:55 -0800 (PST)
In-Reply-To: <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
References: <20170308202025.17900-1-avarab@gmail.com> <20170309100910.z4h7bwqzxw2xynyu@sigill.intra.peff.net>
 <CACBZZX53rMiB5-cA_7-SeU2Dt7d_Cr7_GgyC0rjQQPPf4qyCqw@mail.gmail.com>
 <20170309104657.7pwreyozxo2tdhk4@sigill.intra.peff.net> <CACBZZX5i+8bQLhLB4DnUAaUw1vA_KQjhtNBvm7drLepPAFFbAQ@mail.gmail.com>
 <20170309125132.tubwxtneffok4nrc@sigill.intra.peff.net> <20170309132728.c57ltzel746l366a@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 11 Mar 2017 14:06:55 +0100
Message-ID: <CACBZZX5rgomtp3E6JkZdyJPY_iw=j+Sg3-nYw-05jW0raRvK0w@mail.gmail.com>
Subject: Re: [PATCH 0/4] fix object flag pollution in "tag --contains"
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2017 at 2:27 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 09, 2017 at 07:51:32AM -0500, Jeff King wrote:
>
>> Looking at this, I'm pretty sure that using "--contains" with "--merged"
>> has similar problems, as they both use the UNINTERESTING bit. So even
>> without your patch, there is a lurking bug.

Sorry about the late reply. Been a while since I was active on the git
ML, and my broken list search was searching for cc:me, not to:me. So I
sent my v3 in <20170310203348.675-1-avarab@gmail.com> without reading
this.

> I wasn't able to come up with a simple case that actually demonstrates
> the bug. But I feel like it has to be triggerable with the right
> sequence of history.

The tag brute force script I hacked up
(https://gist.github.com/avar/45cf288ce7cdc43e7395c6cbf9a98d68) is now
at >1k iterations without finding anything. But of course it may be
broken / this may not be producible on git.git

> Even without that, though, I feel like moving away from this flag usage
> is a good cleanup. Here's a cleaned-up series. What do you think of
> building your patch on top?
>
> We can do it the other way around if you prefer.

Getting this in master first sounds good. I already have a working v4
on top of this, which is of course much faster for the --contains
combined with --no-contains case. Gotta run now, but will clean up
that patch & submit it to the list soon.

>   [1/4]: ref-filter: move ref_cbdata definition into ref-filter.c
>   [2/4]: ref-filter: use contains_result enum consistently
>   [3/4]: ref-filter: die on parse_commit errors
>   [4/4]: ref-filter: use separate cache for contains_tag_algo
>
>  ref-filter.c | 70 ++++++++++++++++++++++++++++++++++++++----------------------
>  ref-filter.h |  5 -----
>  2 files changed, 44 insertions(+), 31 deletions(-)
>
> -Peff
