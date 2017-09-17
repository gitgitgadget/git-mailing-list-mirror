Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDB02090B
	for <e@80x24.org>; Sun, 17 Sep 2017 20:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdIQUo5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 16:44:57 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36360 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdIQUoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 16:44:55 -0400
Received: by mail-io0-f195.google.com with SMTP id n69so7315830ioi.3
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 13:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WzSLkMs3fqTZN1BJ9XYq4sg43zHLKQlZQG9V5vAfuTE=;
        b=QtPvRUzmDBcyi45jiJ4unkG8xbadUg2OU/7BYVJIf6SOr8B7T9k+2globyMDt1EiIY
         uCzsyopZCRBodTFX8/zEIhZ5LdI8PMnNkVWzfwFEivxvTqYC1J5UB+2U0b5nmKascxhU
         l9HJ98lyMuOx0n0cxV+UQSkSyyc6Jv1S6O46CKHrvHoS1M5dswbIxuGMAqPHGUjR23Uh
         7oG/zkY+CP8JmfrHC66k84A2jEeSHDfeWsEAnwH5VkXTLy5fFTMNrmCz/LRx1wKSM+DQ
         FxwiqFGVQKAxAZndzA1Ks/FQzFdKUdDWfUxb6sUtAoNFl7gKzAkCVTClRx/7E4RzBxln
         9KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WzSLkMs3fqTZN1BJ9XYq4sg43zHLKQlZQG9V5vAfuTE=;
        b=kG4k0zqA8YaMDMZzj00TRVK37QFa984+CqqSaiql7FFPPsEvetbUPJWDSCaIG/KXwp
         +3l0OnfiIeGW1tgqGLHIQMi0fxUpQHyQZ3Oahwt0/4oPeNLhpT59DQLnobV9OUT4XMOM
         hNt+j7vjt7W2rlihimCv0Bu6FGPfsFSpAsbZu1ayhi3VjDeyBsiT1jGsfa//og/l/2De
         l/NQ2gEoqcAeHRPb5kI7fk/6T0O6SqLmtNTnzsAL7gLYV3k0eJc4R+cIFUDUx+Ym1Lr1
         fafVDx8EjmjGWZMa3XQB9EmTsx/DKvgkaLkTj94OvUeIT6VGlDQ5DxUXqIMx5CAqW/05
         T3/g==
X-Gm-Message-State: AHPjjUhasWqPEkPqza/J3T/JFRXy/HmS2SbhrsjXmRXD7Xg2I9X14f7Q
        zsvJFOmYNTAgGLQM3l4Phv4mvFtOimvdGN0kUyc=
X-Google-Smtp-Source: AOwi7QCDk6El098xTDxjy/cUf3OUIjrjtzn9VJdNylya2xHywcGbazwucHqk895KUT9/0+jaEihUIdYrc5txqDF4uSw=
X-Received: by 10.107.153.145 with SMTP id b139mr17267699ioe.231.1505681094455;
 Sun, 17 Sep 2017 13:44:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Sun, 17 Sep 2017 13:44:53 -0700 (PDT)
In-Reply-To: <CAP8UFD2f3jXkRHb_S_dK7TDfhBwXQ+O63cBn0J7iQQA-5ysVMQ@mail.gmail.com>
References: <1505679467-20720-1-git-send-email-bugosip@gmail.com> <CAP8UFD2f3jXkRHb_S_dK7TDfhBwXQ+O63cBn0J7iQQA-5ysVMQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 17 Sep 2017 22:44:53 +0200
Message-ID: <CAP8UFD2d7y9COGj=bRLk_d+F_M=c7nv802AjBf=R9NnJQB7ohA@mail.gmail.com>
Subject: Re: [PATCH] pack: make packed_git_mru global a value instead of a pointer
To:     phionah bugosi <bugosip@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 17, 2017 at 10:42 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Sep 17, 2017 at 10:17 PM, phionah bugosi <bugosip@gmail.com> wrote:
>> Signed-off-by: phionah bugosi <bugosip@gmail.com>
>> ---
>>  builtin/pack-objects.c |  5 +++--
>>  cache.h                |  7 -------
>>  list.h                 |  6 ++++++
>>  packfile.c             | 12 ++++++------
>>  4 files changed, 15 insertions(+), 15 deletions(-)
>>
>> This patch makes packed_git_mru global a value instead of a pointer and
>> makes use of list.h
>
> Please explain _why_ you are doing that (why is the resulting code better).

Also the explanations should be in the commit message, that is above
your "Signed-off-by: ..." line.
