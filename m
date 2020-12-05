Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22ABC4361B
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 22:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F2B23101
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 22:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgLEWJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 17:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEWJD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 17:09:03 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09A3C0613CF
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 14:08:22 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id r24so12657783lfm.8
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvibMSRou4Etu1DiL6hEL20+yutJLQZW2mU5ihOQ4YY=;
        b=KQoswwdDkgAb0Swl4QZPTxfI8zDD22pMZ9e50UvaJBpm5wiU+priezu2z7XvxzzDyi
         0aU5fBHL0Mq5rKM/aNDterhkgE9Ipwycf1I6WQr7SXxydXQ6UD6IYqN3tzt6nADP5zuc
         1NTCFsM0HWrhH+R1dvkiKCopLyccpCe8aIWUN8aIHjbMjnWN4wKmHoQaRK6XZvTwSMi5
         gh43UDLQPiKjzeDKXl5TBxqHe1sNwovz8TKnbXR/ICZ5jENv5+cBjJeJff+SzFPUb7GA
         7kGgBv0tL2LH9Qg7ZiVzQh7iIUnz5fHr76tZ9KIMN2K747/Y/xShfx4PRWH+EztAFl98
         e59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvibMSRou4Etu1DiL6hEL20+yutJLQZW2mU5ihOQ4YY=;
        b=T4O2/EcX6IJaDYan8QiNlViXw4DCmwlWNCGoUHyk1DkQssVz5uthn3fif0Tww9AfRq
         60TWem5GX62R/0C+qDEMdMlYAakjTqCK//YvDW/JVaCf07PFezukp9pzB2wIVc8hYt49
         eonKxT01JoBQ1Yit11aBl0cAKmMIU8Mg4uwVJ7JyIBnWAEuMJRxENWXohPf/L9bygNGn
         AKTXMcFDa/6gUjgk6YTlPii1y3WRB8Y01fYmQl2Na59/k2qg03pcZ0q3m5yRXvHEkoc5
         AztFpuZTWzeWiQCuIVZX/qI7Fb4FCrq1kuV8PQGLRUUrer+NHpmCviPIiHGhIMwLa9lq
         zPZQ==
X-Gm-Message-State: AOAM5300O4UiqPrjDruab2VGE/X6WWAJXVvXvetCEQuxw4+HUOM2NOMT
        vikIjtsQ5IkP9d5CBlTqyjUJ+gMrsQC85g+ZCVvQIA==
X-Google-Smtp-Source: ABdhPJwOy8GIbP/1IFnxV8LfFrp1yj0Dfr+vpghlmSAz+AD+OZEvNhBC3z2QdY3rVpG1U5Ob4xGmtZZTqjFjhgF9yi4=
X-Received: by 2002:a19:c20f:: with SMTP id l15mr5355271lfc.187.1607206101165;
 Sat, 05 Dec 2020 14:08:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604521275.git.matheus.bernardino@usp.br>
 <aa1eb461f46d200f36b33c07ebc0a350829ab1f5.1604521275.git.matheus.bernardino@usp.br>
 <CAP8UFD30JOhFxxSU=bVY9YfSHAjVJAKabLEv4x28JotOdj8xRA@mail.gmail.com>
In-Reply-To: <CAP8UFD30JOhFxxSU=bVY9YfSHAjVJAKabLEv4x28JotOdj8xRA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 5 Dec 2020 19:08:09 -0300
Message-ID: <CAHd-oW6yvPH24kTedX1LzBvZw3zMi4=QN6iXh5myHkC-bqKcZA@mail.gmail.com>
Subject: Re: [PATCH v4 04/19] convert: add conv_attrs classification
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 5, 2020 at 9:07 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Nov 4, 2020 at 9:33 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Create `enum conv_attrs_classification` to express the different ways
> > that attributes are handled for a blob during checkout.
>
> Micronit: the subject of the patch might want to be a bit more
> explicit like "convert: add conv_attrs_classification enum". Otherwise
> it could make one wonder if it is missing an underscore between
> "conv_attrs" and "classification".

Makes sense, thanks!
