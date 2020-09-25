Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DA8C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0122086A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 18:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgIYSMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 14:12:13 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:32961 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYSMN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 14:12:13 -0400
Received: by mail-ej1-f68.google.com with SMTP id j11so4905429ejk.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 11:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAY0JWya5/uIMwa2JSF1dX8IxoRv/fwjHTx1Q7GmKBs=;
        b=i4CpXTVPMJqAGOZfN3305RxU7f/YgjEoxJJ5dpWxky/k9aQOX84oFRduAVm0FMRgpw
         vAi4le00JQyklWjz7puqVHFJ+8VpJsVCxzTJ07r4fUwGqdE/c+6gPeueAuJKqX2aBVDx
         AEqryzHpWcj3313iOtmeW2IdJ0gb5wTJ5LomaAaE9AHMVIafzVfGiz2Svmpcqq6y0cpC
         jlXTG7c92EwMgHLPbstjCer6U4AS8gnLuAhIriUnyF/QnSaHgi+/ZHoogR7AZjo7laCO
         kmh2gr7nm3mG/s57IBiURsHcAXb//7fviwD1T1Nnxx0ydklZxS8CmEaJtNC4MqK3QxLE
         mjPQ==
X-Gm-Message-State: AOAM532Q7laCo519RvTrzeO1Q9acX5GmZhBhyu+7s0dRp9vYV1CUWE0G
        SkfyXDCGdz8F4DVQ2AYJbH6joD2pllyESY/KfmU=
X-Google-Smtp-Source: ABdhPJyT29bxbZWm1MwmywdkHoLqExFHmTLAj8t1PxNVW2lYGeTVGSKAmy0pUw/Aft/3n2Gf6wpagN9RwP5n59vLzwY=
X-Received: by 2002:a17:906:250a:: with SMTP id i10mr3914066ejb.202.1601057531396;
 Fri, 25 Sep 2020 11:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <20200925170256.11490-5-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-5-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 14:12:00 -0400
Message-ID: <CAPig+cSb2nB0cK-3Xh=5mhTa6Knh0in-wFE-DQ7MiKGWv=qR=g@mail.gmail.com>
Subject: Re: [PATCH 04/11] t7001: change the style for cd according to subshell
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> t7001: change the style for cd according to subshell
>
> In some tests there is not a proper spaces after opening paranthesis
> and before cd. So, Lets change the style for cd according to subshell.

Nits:
s/space/newline/
s/paranthesis/parenthesis/
s/So, Lets change/Change/

However, a more significant observation is that this change is
actually specific to the formatting of subshells, and has nothing to
do with placement of `cd`, so calling out `cd` in the commit message
is misleading. I'd probably drop mention of `cd` altogether and write
the commit message something like this:

    t7001: modernize subshell formatting

    Some test use an old style for formatting subshells:

        (command &&
            ...

    Update them to the modern style:

        (
            command &&
            ...

The actual patch is fine.

> Signed-off-by: shubham verma <shubhunic@gmail.com>
