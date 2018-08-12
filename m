Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AB131F404
	for <e@80x24.org>; Sun, 12 Aug 2018 03:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeHLGaX (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 02:30:23 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:42575 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeHLGaX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 02:30:23 -0400
Received: by mail-io0-f179.google.com with SMTP id n18-v6so11294599ioa.9
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 20:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TPASlH3AvBg72+t7UGDefKZQZIsYJtLm9nKUg1a0vY8=;
        b=ogA2QnFP5MHgsPxqt7/S4mcS1/4fr6h8lBzTpJV/4v0poSwHx0FLpDHqwwSEtkA1L2
         +I5m5Xlar6DyfdGKBGU8NYlIkgMZbJUXfF64TB3dPWn0EzI4WTp8Ixr2VJwW1j2Ou5lX
         pOPirbQvyL4mNV8l4TD2OEt6qiyp5OHRMtcuOQvwFeVzxWrm8IfOK0RR5qJTmrtPpxF0
         SCKvNZVM3jLHa+AugQonP0UhwWN+kDgYq3OM72ZFXDaPE1+YH/9c4h68OwOz1CIh04eA
         cL9PQmxAUONtdU2AkjyLqBxBnQOkZ5U7YbhnVtaayKIm7qEM8kn6cJxkr6/dWL2fHbuQ
         jDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TPASlH3AvBg72+t7UGDefKZQZIsYJtLm9nKUg1a0vY8=;
        b=IiMBfrl+BpHu/RtUt2Efascpi5CWRwcE2S+LStPcTweDIsYFYhi3zEVuZKR/Z5m2Dz
         mTSjTuYH8gaM6wsvC6afW74VP2jJScAy4nyROzb0NxTKPEI2Htqn4yv4g1zVQTGxSeoL
         mjTOfxn/y0vG/c2Rreu7cXK0D1psf//nPZb/5QMjED5Toh7JZDYYk3bb6HF1DMr69AVb
         +oK5yPRs+NuCY/Ic9Sxw6IecbPHXIObgtnxmO/f7jfZBKgorQUsTJTTZY+UmWF88kiVz
         FxD7Ufqe5+l7HlQW477p4KbJWMGHi46C2cQIIXIulisryVacGS98N/OmqIZ74E6qrgm5
         dT+w==
X-Gm-Message-State: AOUpUlEJhAeOFG2eAgys0wJOJ5FvSybEUyIFWbV/AxLx4NiT6QLFp+pa
        eNqNT1Ngmc2Yv+JdOVQMHU92Vk3RPpKTjUg93T2m/A==
X-Google-Smtp-Source: AA+uWPzJbyQ5odmS25UTwt1rsmfmL92GZjex78QsoeudN1/dkRYxxnrw2mBpa6zFYBvR+Km28+IGc0UwnUgrBGKsYa4=
X-Received: by 2002:a5e:9301:: with SMTP id k1-v6mr3134256iom.53.1534046035043;
 Sat, 11 Aug 2018 20:53:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 20:53:54
 -0700 (PDT)
In-Reply-To: <20180812011612.GA10782@sigill.intra.peff.net>
References: <b5b25177-38de-14ba-5d83-c8909ce0addd@ramsayjones.plus.com> <20180812011612.GA10782@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 12 Aug 2018 05:53:54 +0200
Message-ID: <CAP8UFD0KtVWtyAp1sBoLLCE5L5u6qH0VQ6Ng12Bopv+28Nnk1A@mail.gmail.com>
Subject: Re: function get_delta_base() is a file-local symbol
To:     Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay and Peff,

On Sun, Aug 12, 2018 at 3:16 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 12, 2018 at 01:30:02AM +0100, Ramsay Jones wrote:
>
>> My static-check.pl script has pinged me about the get_delta_base()
>> symbol from packfile.[co]. The first patch from your 'cc/delta-islands'
>> branch exports this symbol, saying that it will soon be called from
>> outside packfile.c. As far as I can tell, no other patch in that series
>> adds any such call.

Yeah, I should have checked that but I didn't.

Thanks for noticing.

>> Do you have plans to extend that series with additional patches which
>> will add such calls?
>
> Hmm, I think this is just my error. I had to untangle the delta island
> code from a few other topics, and I think I mistakenly attributed the
> need for get_delta_base() to the wrong topic. It can just be left alone
> for this series.

Ok, I will will remove the first patch in the next reroll. Thanks.
