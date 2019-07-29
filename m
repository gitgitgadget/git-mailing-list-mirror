Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407051F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbfG2U1g (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:27:36 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:40943 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbfG2U1f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:27:35 -0400
Received: by mail-io1-f48.google.com with SMTP id h6so36452782iom.7
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XB0G5Hojz4jQFrwTa4jtuZRqqORGd0eHfp30+Ik8BnI=;
        b=tQu5Vs6fdnh+Vl1GpSs80HGaHrjmzZCkpHdVUPtVgzHqOHrcQRCB2sLVAIhizSGgUK
         /KC3737ZtczUBXOitZAsIV1gojEchI9L8uinZtWvnZ5nd7j1rfAU8yxNC8VmS3bfe5Me
         DtTR6an20M8gkeN0hRQdu3cun/MXUOE06HdCuEXvdTquBHNmMmn9gHdY0qQi7e1WdJF1
         7fZBZGfy/Muu+b/F/by4aKSaEPb4880HOiGZOZkNtbwErU+LXIm1aBhl6pBANOerS1I3
         K+gHVdEdMDhAM7VCRZQ25MfLO1QUz+WP10Gl91bh6F4/WJIlaIyaTF5PTI3yfu7SzYgq
         R3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XB0G5Hojz4jQFrwTa4jtuZRqqORGd0eHfp30+Ik8BnI=;
        b=WbouKLZkmYQRWq8juMNf5hGt7IjDjv/AjVwbdyV9ZchmoDwGrJMUECV0yC7omrmFAL
         8QHdwyJqS5Nd1OG09S0ug+n/ZqGuORdbJVy50HTjaqeFFAiwCe/1T9mAfKJRsPIdk3HY
         SeY6gxxIp3EJyCJR/tjLfpvl35fmD7K9s1SImjaBxcA31ft80pBgt8mmaYmGfKTS+RUp
         1+BoBGfq3/Ulhz0tZQJesbeT2LGGoAPZvE6tH8xC8RLarZe/9eByhKNksezl+GaCDRTQ
         vrsC/7b95vB5YQ+Bw2ItMpsV8+N2GVwsFfBoL5/nxLX4zLSzATBzKyUKro6sXv1xkG0T
         er7Q==
X-Gm-Message-State: APjAAAXjuDuzHILrDHFVB7YvccFWqN+Z9E0rkNqF/Iu8ccmnn26m9bUc
        kobtnr1Qs07p7vlQYPYQZ6Sbi5MAEy1SnVGXZsUuY08R6oU=
X-Google-Smtp-Source: APXvYqzAWhkHFUnyVVpWn6Q5mCd/phMLdSmC85ddsizw1hJ7l+/bEesQT9v6y/6Z60oCWZdfoM920sGDktLocry3rRk=
X-Received: by 2002:a02:4e05:: with SMTP id r5mr31941142jaa.27.1564432054646;
 Mon, 29 Jul 2019 13:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190708111459.135abe50@zen> <CAHd-oW5Q1PWDzWKpsmdv4ecUMrQTj4Vyh_SoVu6vaFeSFmxE5g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907101313450.46@tvgsbejvaqbjf.bet> <20190716211012.226b7059@zen>
In-Reply-To: <20190716211012.226b7059@zen>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 29 Jul 2019 17:27:23 -0300
Message-ID: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
Subject: Re: Weird behavior with git grep --recurse-submodules
To:     Daniel Zaoui <jackdanielz@eyomi.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 16, 2019 at 3:09 PM Daniel Zaoui <jackdanielz@eyomi.org> wrote:
>
> Hi Matheus,

Hi, Daniel

I'm sorry, your last message went to my spam folder for some reason :(

> Thank you for your response.
>
> I really hope the change Brandon made is not a project decision. At least, it does seem to me like a bug.
>
> How do you recommend me to solve this issue? Is there some place where I can check if some bug ticket has been created on this matter? I didn't find anything in the mailing list archives about this.

I think I manage to solve the bug with this[1] patch. I'm going to ask
my GSoC mentors to take a look and then I'll send it to the mailing
list :) Thanks for reporting it.

Best,
Matheus

[1]: https://github.com/matheustavares/git/commit/37aeeb3ab86b5dfebfaafeb98d34e379341a529d
