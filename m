Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4EFD20248
	for <e@80x24.org>; Wed, 20 Mar 2019 17:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCTR2P (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 13:28:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46743 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfCTR2O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 13:28:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so2257815pgg.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0hwzLRlNSQ2rbfhOmMLYPs4TTzMQdGYmRV0s2lEQCFI=;
        b=KLmam2otuSpt5FbZqiymIVzUlZUeIyPV3YhrarnK9izZq5wTn5Z4Zj63iS+6uZpIkz
         H5E/T3Zkrt5NgFzE0ZY7FocMDDf8JSZfy0WKeCN62zyENrt+O0GNr1+2eZhxLDZAS0u8
         6mz/2UbK73F/FiVvtzsMDfprWafH6Au9Muhshp8y3XukXfh1sgLzdN8j4AMAQnROg/mn
         T6LXEwW9fijuiQ4bDKtXFtwMsa+mEz29yddp4dL9Te9vB9w6jjTqF9SooHruhUiBw2lb
         o/vt8i7DQeWQISsIxmEc9LmzEL1GdkC+2obDWtHRaMBrTsgdEo2nGljZI4UZ9/2JoWaU
         hK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0hwzLRlNSQ2rbfhOmMLYPs4TTzMQdGYmRV0s2lEQCFI=;
        b=GOq6pvfV0dtXfBUkDEovJCi4A2VntZOXvkSgEyIeclcmSlBDdzDRpV3foYaO6CIBuM
         k6mC764NLa/T5tboziOgvRPKmuYBztPTNZOuKmFL72skGrwg6K3NrsZZ+Xn+GwXP+vbV
         k8XvZADYEhAmG7QvT9TSspJxS7h5wo/tniJtLfSSn89/LUUEf6/Ly88Lq2ubWnHS1G7m
         rt1xkyUhHlhDqYTKOzMLvu3e04/Zi3WaVWJtC+F4Vwal55iF6knfn6OkZUypn8fnA3ky
         86rQfkbK01IwxiQlAF9K0sm/lyt2Qtks9XdRNFGT6GShM10BU0eBCnYlhjbPYI4kImFy
         u/WA==
X-Gm-Message-State: APjAAAURCR3iNZMuwlh1Zhk8TVJu0gMd04AebwCr4vbaydrpBkaniknk
        lRsH8iVtOz0AXpftHg6wm5c=
X-Google-Smtp-Source: APXvYqwpx1pqc0WVYoGb9e3pozsuvu8rX1mPbk5w16qEEreex58n44LF8Yht3Ic+pTZwvoMmKqdG1g==
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr32991578plf.210.1553102893914;
        Wed, 20 Mar 2019 10:28:13 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id k17sm3289831pfk.166.2019.03.20.10.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 10:28:12 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:28:09 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
Message-ID: <20190320172809.GA17593@dev-l>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
 <CABPp-BEy9nN=aV8Y+ueYqv299umHoF2E=8D7heJARM4Qa7P5JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEy9nN=aV8Y+ueYqv299umHoF2E=8D7heJARM4Qa7P5JQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Sorry for the late reply, I've been mulling over it for the past couple
of days.

On Mon, Mar 18, 2019 at 10:59:56AM -0700, Elijah Newren wrote:
> Hi Denton,
> 
> Thanks for working on this.  Some thoughts...
> 
> On Sun, Mar 17, 2019 at 4:09 AM Denton Liu <liu.denton@gmail.com> wrote:
> >
> > The documentation used to consider
> >
> >         git diff <commit> <commit>
> >
> > and
> >
> >         git diff <commit>..<commit>
> >
> > to be equal counterparts. However, rev-list-ish commands also use the
> > <commit>..<commit> notation, but in a logically conflicting manner which
> > was confusing for some users (including me!).
> >
> > Deprecating the notation entirely is not really an option because it
> > would be an arduous process without much end-value. In addition, there
> > are some valid use-cases that we don't want to break.
> 
> Yes, there were multiple people who commented that they liked to
> copy-paste the "A..B" output from fetch/pull in combination with diff
> and log (even though one suggested that this gave the wrong output and
> what they really wanted was "diff A...B").
> 
> However, "removal of functionality" isn't the only form of
> deprecation/warning.  Updating the manpage is another one which you
> implemented, but I'd like to suggest yet another: Prefix the diff with
> a warning message, e.g.
> 
> "WARNING: You ran 'git diff A..B' (which means the same thing as 'git
> diff A B').  Many users confuse 'git diff A..B' and 'git diff A...B'.
> Please see 'git diff --help' for more details."
> 
> Having extra text (e.g. commit message or warning) at the beginning of
> the diff does not prevent tools like patch(1) or git-apply(1) from
> successfully applying it, it still makes sense to humans (and who as
> an added bonus happen to be really good at filtering out common
> messages if they do encounter them more than a few times), and gives
> us a chance in the future to figure out how to potentially extend the
> message to make it a deprecation warning and/or provide details about
> how to change the behavior of '..' to either be an error or behave
> like triple dots or just not warn.
> 
> 
> Elijah

I was originally planning on doing something like this (by warning to
stderr, but your idea actually gets to the user ;) ). The only thing I'm
worried about for a change like this is that it'll be very controversial
since, as we could see anecdotally, a lot of people have trained
themselves to use the .. form.

In terms of backwards compatibility, I think that there's the
possibility of breaking some scripts by doing this change but we could
mitigate this by detecting if we're outputting to a terminal and only
print the message in that case.

Thanks for the suggestion!

Denton
