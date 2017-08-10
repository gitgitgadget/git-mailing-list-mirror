Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C617208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbdHJSfv (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:35:51 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:37463 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbdHJSfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:35:50 -0400
Received: by mail-lf0-f46.google.com with SMTP id m86so7164997lfi.4
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZAtWDGOJ4lGR290cDsCKusAKIOHDqLZc8q1DaOc0Ftk=;
        b=SBa2nlzUceZtEdGDg/VWk1xed/ZUBpbGbamqdgX/UYCt0ivVylQpnBeuWY0ovic5eG
         xSf+BiWM1G/ES88GR/gUGGWzdvY873MP1JqtJo45wAVsEu5cWq5xDxqrWSqIumoMayeU
         QWNAFXc17L3tORZLDK6Zv9Pb9GUY1/Idjx2bg4TzVS1NRYezp6PRDQvZWV5Y2qUnDOzB
         g84lH1cP9rfrSEt9OohXc6NVqtS7bfzU1eRiIMnshOt+pDTybFs4UDYPTfQUo8VJR4z9
         WtPzsoR7IETYpeTkjspZfOmAUsNKjorwfz5Y358Nonb1n/xrZZXbmCJdFu/X7QRQc9AR
         TRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZAtWDGOJ4lGR290cDsCKusAKIOHDqLZc8q1DaOc0Ftk=;
        b=dHsiv9q/OCQESfK0mTTKs7kOaE0Pqu7fIEO+pjKb7tb8M2NVJceZMjo5T//uHFtKVv
         jNTaVtMm3H7FRVMyzsw6ZNh1yI7DL+Gg1p3ezkCbYZ+HNgpYmZw5CEOh4jbEDCloTpa3
         h2cMBFVjfpo851uQdWrOjcmU20xL8Ma09xRdDIURAEaO29pJRKjOH845baxLlNDq0QBl
         cvlm6Hn2hKE4AA0LR0I6tBwDxWDXbjeu3yI2bd7PV1ISQOUnNS32Dev2sUF4GECF97q8
         yrKsaDbDCyqgZ1kMgi1lDDPfu7sZ8crnxxN3bRs92x1RdhdlQmxo/vzivt34wLIPMVgJ
         /Nkg==
X-Gm-Message-State: AHYfb5gt2fDlcopEYaJvaFF4WnhQZ5oNOv4pgxhrmQ5g1sQEalsUOquA
        wG+/cupz9F1Y4ciit7e0WOJuP3Rh0wSD
X-Received: by 10.46.5.80 with SMTP id 77mr4364016ljf.91.1502390149333; Thu,
 10 Aug 2017 11:35:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 11:35:48 -0700 (PDT)
In-Reply-To: <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
 <20170810080246.njjd5zkphytzmlda@sigill.intra.peff.net> <20170810180326.4kkmawywvdbuzwnp@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 11:35:48 -0700
Message-ID: <CAGZ79kaNrqvqr3OVcwhxFEMoS2sK8wvfVE_pmxXTWYVB-OBDXQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] make interpret-trailers useful for parsing
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:03 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Aug 10, 2017 at 04:02:46AM -0400, Jeff King wrote:
>
>> On Wed, Aug 09, 2017 at 08:21:47AM -0400, Jeff King wrote:
>>
>> > This series teaches interpret-trailers to parse and output just the
>> > trailers. So now you can do:
>> >
>> >   $ git log --format=3D%B -1 8d44797cc91231cd44955279040dc4a1ee0a797f =
|
>> >     git interpret-trailers --parse
>> >   Signed-off-by: Hartmut Henkel <henkel@vh-s.de>
>> >   Helped-by: Stefan Beller <sbeller@google.com>
>> >   Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> >   Acked-by: Matthias R=C3=BCster <matthias.ruester@gmail.com>
>>
>> And here's a v2 that addresses all of the comments except one: Stefan
>> suggested that --only-existing wasn't a great name. I agree, but I like
>> everything else less.
>
> Here's a v3 that takes care of that (renaming it to --only-input).
>
> It's otherwise the same as v2, but since the name-change ripples through
> the remaining patches, I wanted to get v3 in front of people sooner
> rather than later.
>

Looks good,

Thanks,
Stefan
