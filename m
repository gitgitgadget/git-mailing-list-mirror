Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3541F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeGRUOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 16:14:06 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34405 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRUOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 16:14:06 -0400
Received: by mail-yb0-f196.google.com with SMTP id e9-v6so2318560ybq.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duuH141ZAEKiwbOhYXGYzl+BzCzhdXEdQ2zjgfQed8Y=;
        b=hbPvr0yqw8RP6ext+KNkg/WLgoyInmEHxHHLdEIFHt1t9+piY33rP2FHis7f+1agKP
         g2cRkYd6B5wkAD1w98Z/sKvmaGyT8YJyp9jIFxa8zFFp7WP8tarESZBr7/otPX942UMD
         zGTXjvvEbKgjbSnI7l8Z+TxegzYFs1opPCKhpPRo5L40og9vn5OD2qzeLnpMLYPZOH9K
         sht2Q40AYmpKy9WP5GYUAS/nRfKXWhjDsLKr06Remm54W2xROVdm8ioinmr87XsLi7Rn
         3+RRCnuy1pjmyhZo7K+4xuedFhz6c6RVK+y5HyxBqXcOIxKiOaBjTgheKuU21urwBpws
         Q7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duuH141ZAEKiwbOhYXGYzl+BzCzhdXEdQ2zjgfQed8Y=;
        b=Cl7+7O2uQjsllGCADHaBnQyh/NGSjjfHcU9TFFGUujDYSyID+pUlHUW/5bEUVsR1QG
         dhg+k0UWH5mNHNQo0VGK+ovyX6vX6q1B1VQ6Dm8wGWqB/0drhSnHY2qqLb010CvgZNSK
         q8ZWH7XRxifeFgX8YPKhG8FGaT2af4UVfZG6YJ9T34sMIEeJ9pzV61ASkuGgc80sgwOl
         0dojwCtblXVMUSkuFD5BwZLUPJy9S6o2u79zIgJtZSGhUeOOqsjJeERkEooGJONcraDL
         sBcEWIZfkKb3dBnozq1bWXGt+cL2feVfCNjlr5lt2J1JoGUR7UvX6tLILGErBnWXYSNp
         1sQg==
X-Gm-Message-State: AOUpUlGJ9K9oXNvzF93CYg+4onLjNyb8SBc8sLKm1BhNNTCF0VO59xZZ
        tbsWvBOrJteZyrT0TRhgFgFm97U8hgZkQvXh7ExgWhm9N0M=
X-Google-Smtp-Source: AAOMgpeMNp2+1qE/keecJpvBsmX0Oi3oWT9Qb/vIk6keGSyfev1/JAhCLK/RmCcnTZitISEt9k3uJeaH47tbQq6YVkU=
X-Received: by 2002:a25:dc47:: with SMTP id y68-v6mr3733130ybe.515.1531942485006;
 Wed, 18 Jul 2018 12:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180717002654.120375-1-sbeller@google.com> <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com> <CAPig+cRx5-2TYOm_8oayFfbKGpmTJf=M0cNR3L5UJGGC6vHPDQ@mail.gmail.com>
In-Reply-To: <CAPig+cRx5-2TYOm_8oayFfbKGpmTJf=M0cNR3L5UJGGC6vHPDQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Jul 2018 12:34:34 -0700
Message-ID: <CAGZ79kYCDR=m0C1Vmh5U2tsj5bTTpGUo1mKe0BMDKmO5riBLLw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,
On Tue, Jul 17, 2018 at 11:59 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Jul 17, 2018 at 2:53 PM Stefan Beller <sbeller@google.com> wrote:
> > > A tangent.
> > >
> > > Because this "-- " is a conventional signature separator, MUAs like
> > > Emacs message-mode seems to omit everything below it from the quote
> > > while responding, making it cumbersome to comment on the tbdiff.
> > >
> > > Something to think about if somebody is contemplating on adding more
> > > to format-patch's cover letter.
> >
> > +cc Eric who needs to think about this tangent, then.
> > https://public-inbox.org/git/20180530080325.37520-1-sunshine@sunshineco.com/
>
> The "git-format-patch --range-diff" option implemented by that patch
> series (and its upcoming re-roll) place the range-diff before the "--
> " signature line, so this isn't a problem.
>
> I think Junio's tangent was targeted more at humans blindly plopping
> the copy/pasted range-diff at the end of the cover letter without
> taking the "-- " signature line into account. (Indeed, Gmail hides
> everything below the "-- " line by default, as well.)

Awesome thanks! (I missed that hint given by Junio)

Now that I grow more accustomed to range-diffs, I wonder
if we want to have them even *before* the short stat in the
cover letter. (I usually scroll over the short stat just to take it
as a FYI on what to expect, whereas the range-diff can already
be reviewed, hence seems more useful that the stats)

Thanks,
Stefan
