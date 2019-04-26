Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15BD1F453
	for <e@80x24.org>; Fri, 26 Apr 2019 23:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfDZXk2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 19:40:28 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41948 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfDZXk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 19:40:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so2252307pls.8
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RC3v1O6cga7hXenqdGZPV7KcZhw88BDYkeRGMwlXqs0=;
        b=KmCg9mdD1eNrtOVDIuGeJaH4j60SOnBqIJ2cld9nkHEAGi4BK/J+iwImCbiRB0MNEA
         nZl6/fWaZ0cbxmbquWhdw61anNxLlinaeSyZC44QmStIGRZNypblu4w4ykuFO2lPWAME
         igLG5q3kIpAyM3VCl/e4CPXmB5gAEmq8a+lFVkoDUGFAvsoU66A2wyFq8CqytCMHDDkj
         pR1ju1b7ul89Hnh8WpgaOOa62NIAZD0uhUG3hWwNu88tijd/WXmomAUrbxqtAZjLXgJy
         xW1/I9P9dnyK9vWHCA6oXng47reIE+52KoGx/v20YE/bSEoONIaN52n4/FG19n7x1iel
         YVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RC3v1O6cga7hXenqdGZPV7KcZhw88BDYkeRGMwlXqs0=;
        b=NQOFggYElEm0vGytFieq+mcrLNpskQqljNtxOdvQIpiK6wT8QmkXbTKn3PL/mtDZwI
         WvNmZ5j3aPVdNEJx/8hZpeUKR/+Xhg3WouIJcQ/F0eihrSTkGMSOvufrlntZzlA1rgkJ
         Vm2Blf+XB6BmJhuFsbDsgxqy6JybDAJpKsPXfdWavABQTUuMbRF15UFctvpbiMyNS7pG
         NMskglGJj4gO/w9atX7VeNJV7Cy/8E8ksXdLy8cUsF/XakKPA/et+HSwPvk86YekdGew
         cybZYEaVGuIp3Yde4q3LDK2HXauuXqrBwrqhT0bTiu5T2eZyY++GpZGWFNcm/9Bao1T1
         pAow==
X-Gm-Message-State: APjAAAUJmVbgHpImk711u0IV2VRlkp8BUmNR9R/N7y77eaVzI1+yQisK
        JBJbuw70HvCG5ugChz2sDB0=
X-Google-Smtp-Source: APXvYqx6jmFTvsDm9N9slIdYT9OzKc3/1Vs/gb6MqWX7G2H4Tjy+LUbNQLdX0lJfE71DsIZa2n2RbQ==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr4583300plq.97.1556322027244;
        Fri, 26 Apr 2019 16:40:27 -0700 (PDT)
Received: from dev-l ([149.28.199.249])
        by smtp.gmail.com with ESMTPSA id b7sm54910026pfj.67.2019.04.26.16.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 16:40:26 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:40:24 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] allow checkout and branch to create branches on a
 merge base
Message-ID: <20190426234024.GA28055@dev-l>
References: <cover.1556226502.git.liu.denton@gmail.com>
 <cover.1556305561.git.liu.denton@gmail.com>
 <xmqqlfzwtlft.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfzwtlft.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 27, 2019 at 08:07:34AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Thanks for your comments, Eric and Junio.
> >
> > Eric, I've combined the `test_when_finished` calls together so that the
> > statements within appear in a more "logical" order.
> >
> > Junio, I've taken your suggestion and moved the change into
> > `create_branch`. Initially, I didn't want to do this because I didn't
> > want to change the semantics of git-branch but introducing the merge
> > base syntax seems to be a positive change so let's do it.
> > ...
> > Denton Liu (3):
> >   t2018: cleanup in current test
> >   t2018: demonstrate checkout -b merge base bug
> >   branch: make create_branch accept a merge base rev
> 
> Because "checkout -b new" is supposed to be merely a short-hand for
> a "branch new" followed by "checkout new", the lack of "branch new
> A...B" is the same "bug" as the lack of "checkout -b new A...B".

I didn't consider it to be the same "bug" because git-checkout.txt
mentions the "..." syntax, whereas it isn't mentioned in git-branch.txt.
That being said, now that I look at git-checkout.txt again, when doing a
"regular" checkout, the parameter is called <branch> whereas when we're
doing a checkout -b, it's called <start_point>, which doesn't mention
"...".

> 
> The second patch that does not talk about the former but singles out
> only the latter is being inconsistent.
> 
> One person's lack of feature is a bug to another person, and indeed,
> when we did "checkout A...B" in 2009, we weren't interested in doing
> the same for "checkout -b new", and nobody thought about adding that
> until now, and/or considered the lack of feature as a bug.

I agree, based on the above, I now see that it's a lack of feature and
not a bug.

> 
> We do not "demonstrate" the lack of a new feature in a patch with
> expect-failure, followed by another patch that adds the feature that
> flips expect-failure to expect-success.  A patch that teaches
> "checkout -b" about A...B, that is adding a missing feature, should
> not have to do so.  As it is shades of gray between a change being a
> bugfix and adding a new feature, switching the style of testing
> based on the distinction between them does not make much sense.  Be
> consistent and stick to just one style.  And having the test and the
> code change (be it adding a missing feature or fixing a bug) in a
> single patch makes patch management a lot simpler by making it
> harder to lose only one half.
> 
> Having a preliminary clean-up as a separate step is a good idea, but
> for this topic, I think the latter two should be combined into a
> single patch that changes the code and adds tests at the same time.

I'm going send a reroll to update the documentation to mention "..." in
<start_point> and, while I'm at it, I'll do the squash.

Thanks for your comments,

Denton

> 
> Thanks.
