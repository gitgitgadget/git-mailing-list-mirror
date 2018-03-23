Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346811FAE2
	for <e@80x24.org>; Fri, 23 Mar 2018 21:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCWVGE (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:06:04 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:45828 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWVGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:06:03 -0400
Received: by mail-lf0-f43.google.com with SMTP id l4-v6so15868333lfg.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7mbfR96G4Dw1455I9psnzB7/Sl8unRffxK8Yi/Tomhw=;
        b=FLlJm3R8/7QKeqBsE+WMSDCrpBMFqSjb99nNV61C2grtLCXFKrWov4Tl+bip9qjwmv
         HM6LT47ZgU0Ed3Dx4UYucdsGaANeqdmNYqn6DhYkcPSQkr+hNOGt1l6YBuWSEo+0UhbD
         z0ioFS7KMdRfe349OYTlKnYi5ZiZfTBOBWAWdj7yWnH+frw+Aci/nk2SpW9wgLpiF96q
         2Q4Ep54/ulZJh7MhBumQgQi63ul4ZreUv426uK4JfG3FM00N7WUNyx4K6+eLYmS7G1xG
         us8yaoGkfN+yb2Aj7bkT3BUW9MSAGil19l/o00nCBkONcIcj0f+wubQLaw7yLo/TWT8M
         hIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7mbfR96G4Dw1455I9psnzB7/Sl8unRffxK8Yi/Tomhw=;
        b=jLItzOb25DpahEuzo1fCmrDIwuKaUOQQWlWqPNb2j0xxxdO3m6qxM06l1hhb5g/4wa
         8kOoPz/XiQHR3uQVoegLqXe/gPF2m5Vn9c/CrLwWq9QczC15ix+Fj2QqjuHh8pd9FWVR
         6w5x/pgQ4Pdyj3iUhlrHPkaA3Cqr0aWEar4m1TAg58qFEbD0mlbV3dla8PxBSvn6/ibx
         c2g2u7te8hRFHBR1JfXzPDJOSByxpy+Ed2cCi3d//nvPgFE1ABwhvyF2S6ZnlEnEKAQV
         QJs6GU4gn3qQQGgIr3CKOMit49tn4j00Z9i+A2d+ZNOcvHHCgoMFY1p0GTVx2GAVbUeN
         h0wA==
X-Gm-Message-State: AElRT7EfK0zl3DAv53fcCwYTOGkhtyX9Sx3EvUjB2OBoZ+lEBDJFOd/7
        wQdfkbOXD/d+QOA+WYmsyy6kTI0nawRlaI64yzae/A==
X-Google-Smtp-Source: AIpwx4+rcXNHj//k8PY3LEZNX6PrJbRGy47CrRPCBYWoQKyTR8eiUH3UmoR8OUDCxVW0fizgOAcmGBCyfTHn2Ofg8jQ=
X-Received: by 10.46.84.12 with SMTP id i12mr4436921ljb.9.1521839161463; Fri,
 23 Mar 2018 14:06:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 23 Mar 2018 14:05:40
 -0700 (PDT)
In-Reply-To: <xmqqfu4qikhp.fsf@gitster-ct.c.googlers.com>
References: <cover.1521779249.git.wink@saville.com> <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
 <nycvar.QRO.7.76.6.1803231811530.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAKk8isrxTmryumw5EFVcPxx9wUKA=pB3VxvH9VaHPLRraa=4=g@mail.gmail.com> <xmqqfu4qikhp.fsf@gitster-ct.c.googlers.com>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 23 Mar 2018 14:05:40 -0700
Message-ID: <CAKk8isqwm4Fibm1cFfSUm+g7JckOrfDwjvsTBgmktei5w+N0xQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4] rebase: Update invocation of rebase dot-sourced scripts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 1:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Wink Saville <wink@saville.com> writes:
>
>> Here is one possibility:
>>
>> git format-patch --cover-letter --rfc --thread -v 5
>> --to=git@vger.kernel.org --cc=sunshine@sunshineco.com
>> --cc=Johannes.Schindelin@gmx.de -o patches/v5 master..v5-2
>
> Sounds sensible.
>
>> If this was the first version then the above would seem to be a
>> reasonable choice.
>
> My personal preference (both as a reviewer and an occasional
> multi-patch series submitter) is to use a cover letter for a larger
> series (e.g. more than 3-5 patches), regardless of the iteration.
> In fact, a submitter tends to have _more_ things to say in the cover
> letter for v2 and subsequent iteration than the original iteration.
>
> The motivation behind the series may not change so greatly but will
> be refined as iterations go on, and you want help those who missed
> the earlier iteration understand what you are doing with the updated
> cover letter.  Also cover letter is the ideal place to outline where
> to find older iterations and their discussion and summarize what
> changed since these earlier attempts in this round.
>
>> But this is version 5 and maybe I don't need --cover-letter which, I
>> think means I
>> don't want to use --thread. If that's the case should I add --in-reply-to? But
>> that leads to the question. from which message should I get the Message-Id?
>
> The most typical practice I've seen around here is that v5's cover
> is made in-reply-to v4's cover.
>

Make sense
