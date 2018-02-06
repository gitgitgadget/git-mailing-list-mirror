Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843821F576
	for <e@80x24.org>; Tue,  6 Feb 2018 11:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeBFLx4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 06:53:56 -0500
Received: from mail-oi0-f42.google.com ([209.85.218.42]:41487 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBFLxy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 06:53:54 -0500
Received: by mail-oi0-f42.google.com with SMTP id m83so1114975oik.8
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SxTiUwbWGIvSBeZ2YFbspN0gYRAdg4P7ge5k/Jmwk94=;
        b=CVMdniNUvvdkFM0XYWHO+O789b0oZgCkzpX4Qiv2xUNhlRVD2+yq2Dg9Xr0jAAdL4f
         OL9s9/cVdlrBO0TyNFVSM6G25TSDAoRarfLXt6eu9w5taX1LNF7qXmOEgqKXP28eXxQF
         ULrMqpKwEqByk/zl7hQBPktkk3tnYx5s3z0/tCQM9AlDNGivI/MhQay3Hdk0/PO6T6F1
         QksXvPaumZwcxam3wQY4psewvy3C831TbEBsGYB0IAlHeoQvneKlssc5mUwM+sYxhURq
         u9I9tTzAN9xtMHd4pRhtLzEUyTgRDNnHO2ICYu5X+sf/Ytk6rkLUCoFJxNdQ2UHYBttV
         5Y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SxTiUwbWGIvSBeZ2YFbspN0gYRAdg4P7ge5k/Jmwk94=;
        b=MKX1CprvIwDGThO1ntfq6QAzKKg3Igu6ShziucrdZmubau/9XeyzL+xVU4cGs0kaXu
         f5ardasTK3qk+TzVUW6HVqw2B1e5hBXmHRGAHeD2da0J8PFC+5Zk9U0KUbgGHgXVxzXW
         AFV6YYj140b6wBXWCGaoeGS3KMh0SUJm7jnRTwGfXL96ERvVfV+02iCXHZDDTaWWjocu
         0pO3Ja/Ze9xBVgi8kUoikzWMKcCe9jyNR80ifliHRbL3aA80BQfUnpHNjEAQ4dyKJLnJ
         kIpJVndZVajNdaXDmCT0SSKItcfK7SuxNxYukKXDv/U+jvcX/SDkXqytw6+C8T6Xu6pn
         0+pA==
X-Gm-Message-State: APf1xPAX+F1AsGAeOcUMDL8C3F5RNx74BdnurekSHc/mQcA9TGQoT/eg
        hh6KorrRDDPF7MEqFy9YgHYsieglVh0mZHVl2TY=
X-Google-Smtp-Source: AH8x225axPVM8OFK4tL0hpDkcQBMzD0UmDJ4rJY0AQtbu7WqKwPUyultlJFRwApJVEcSFOu0ovQcZSY92L5dj+9en54=
X-Received: by 10.202.49.73 with SMTP id x70mr1240521oix.351.1517918034140;
 Tue, 06 Feb 2018 03:53:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 6 Feb 2018 03:53:23 -0800 (PST)
In-Reply-To: <20180205202332.GE2130@hank>
References: <20180121120208.12760-1-t.gummerer@gmail.com> <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-4-t.gummerer@gmail.com> <20180205021833.GB17847@duynguyen.dek-tpc.internal>
 <20180205202332.GE2130@hank>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Feb 2018 18:53:23 +0700
Message-ID: <CACsJy8BEKYqW+Ne_WY2RBaSbb9OKcjREtrawStj=eJsVsia_Jw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 6, 2018 at 3:23 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 02/05, Duy Nguyen wrote:
>> On Sun, Feb 04, 2018 at 10:13:05PM +0000, Thomas Gummerer wrote:
>> > -   if (opts->new_branch)
>> > +   if (opts->checkout_existing_branch)
>> > +           fprintf(stderr, _(", checking out existing branch '%s'"),
>> > +                   refname);
>> > +   else if (opts->new_branch)
>> >             fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);
>>
>> I wonder if "creating branch" and "checkout out branch" are enough.
>
> I thought printing the branch name might be a good idea just to show
> more clearly what the dwim did.

No no printing branch name is definitely a good idea, especially when
I think of one thing and type another. I shortened my example phrases
too much. It should have been "creating branch %s" and "checkout out
branch %s"
-- 
Duy
