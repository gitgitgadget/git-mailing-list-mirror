Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83882C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 18:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbjHKSvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 14:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjHKSvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 14:51:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470AD30DC
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:51:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so3522142e87.3
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691779858; x=1692384658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4tSX7wsU+LNgha3Rf3/gG7l5x2Phdo7J52onEH2nn0c=;
        b=qQXxsUiNwWfZeitbN3uD670Cm05H1IIUijkUpHFCtdgHs65Z6f/Bo6F1cFNy2PPKfG
         X80+++iyA55H0zTiXBBt9kJ/CVGqjjh+/Wy08JYgrulIshKS0kqbMQ0R9YOVCDjGlK07
         jaNh1OWY7d07MoTUw1puqo0lHGEbv5jPtC/eAH7MxnvBRTtpJKDsOyrtOyPWoyuBEFIs
         wt1vJy9nYU6jrsYMFhP6NJWOkoyfBkWPmQRYr4tp8aFovJ48hz/B1HOXhKYv6vplRz8k
         FownUkz5d9CkayoRtyUtOkJ0EIeCXLLA//043UBNUV9HSiwDVstnmBA83b5iArNJWHhG
         5Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691779858; x=1692384658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4tSX7wsU+LNgha3Rf3/gG7l5x2Phdo7J52onEH2nn0c=;
        b=jsEU9UuBEvptic8+++7if5RFtxwhNPft873gaQeFg/yKjCDD4itaL3f3YRLBcYCmx8
         xClHep5khe9CxATXZmu+5yG5wV1Cvpht9r/Ux9XJMAInwphSH9NLW0SVSD7cLdl/GuFh
         +O3dhmd2hbjOYXLUd5OghPEXEJSuiPx0wszMdVqEnEIuPdkFqohm5d7VQE2OfJtUm0Qo
         z38e8Bq5NMLJCpdsc8FnqaRtBNfdmk4TVdrurWjY7dRYyYl4xX0iOG9bR5I8kMeVF03u
         VANZUJf3yKS9R02UTRaQ01mqF8zw0xliDTWzbhcfFA8+yQCF9qdGBxYuAKm2QVMc8f22
         FK1w==
X-Gm-Message-State: AOJu0Yzl+jeU7ExKYmgyMGfCNNnI8SepHB5bRBU3iDj0JpQUO9S1RKMa
        dFP2AUGE5U8Iy5m5+2JY0CFw4tMFlxutFVpaZi+bHd58okY=
X-Google-Smtp-Source: AGHT+IFb48mDRW0j8y1jWJHRLgMTHybX8j0WdLg2PEy/XCIgsma6tdLEQCPhQv2t0I1a37UfuUxcGrTLPuEp01GK6c8=
X-Received: by 2002:a05:6512:3b0e:b0:4f8:711b:18b0 with SMTP id
 f14-20020a0565123b0e00b004f8711b18b0mr2716268lfv.3.1691779858101; Fri, 11 Aug
 2023 11:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230715103758.3862-1-andy.koppe@gmail.com> <20230715160730.4046-1-andy.koppe@gmail.com>
 <xmqqmszudtih.fsf@gitster.g> <xmqq7cqydo5v.fsf@gitster.g>
In-Reply-To: <xmqq7cqydo5v.fsf@gitster.g>
From:   Andy Koppe <andy.koppe@gmail.com>
Date:   Fri, 11 Aug 2023 19:50:45 +0100
Message-ID: <CAHWeT-ZSirWAQcw8fDNp=Qxik5wg8PMPmBEj_n1Hg5q3ZbvVmw@mail.gmail.com>
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        "phillip.wood123@gmail.com" <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Overall, the patch seems to be done very well when viewed as a
> whole.  Thanks for working on it.
>
> It is just I cannot be as confident as I would like to be in my
> review when the single patch does several different things at once.
> If it were split in steps, each step focusing on doing a single
> thing well and describing well what it does and why, reviewers can
> be more confident that they did not miss something important in the
> patch(es).

Thanks to Junio, Glen, Phil and the Review Club for the helpful
reviews, especially the guidance on commit granularity.

Sorry for not getting back to this sooner, but the v3 patch series
addressing the review comments is now here:
https://lore.kernel.org/git/20230715160730.4046-1-andy.koppe@gmail.com/T/#m46ad3ebbe3163821f649f7122edcabd619fc5837

Kind regards,
Andy
