Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BD120248
	for <e@80x24.org>; Sun, 10 Mar 2019 06:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbfCJGFs (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 01:05:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35622 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfCJGFs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 01:05:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so1297642edp.2
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 22:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdVTlTssOm4A5twJf2kJm0gKg670up9/P5GXqIqLpes=;
        b=F1Ri1YGzFjicLaVgw4qqV/kmdYzoPEPd45c+UcStJZYpVMFDA45lnUgiNZGasGwP4y
         PtRMeLYIV9mkOw2hcXf6j6ihdsNSOTNHey1EU37cJp8FoFTnSzhC1uZkcACt6O7VRMIa
         14qjquJtnmtuwk3wYRvH5iWUNVpAPpH0gSQ3nj87c02x0kY4IU5EcmyyOVEb7/qiRGOv
         puaxa7hzHcXysXwHj8degAzmEwzaONpltXX9mgA/jXSW38kMcRiKrHliWnRbKu4N8QtJ
         /qq0EChR4N09zGK/TZ0fDeAp7wDz5pzWOmg1QZEsMFcnZCEbZaM9XGdTNa1hVgPPVUac
         kvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdVTlTssOm4A5twJf2kJm0gKg670up9/P5GXqIqLpes=;
        b=nm6Esivnq4gkVbcxZqQMKxy3EW3xD8l9cfbRza8OuehvS8ZpCcDGQDHU7y+2OgVcrB
         EwQgAHusNrHUhfAuIzjJ25+I/id21snB/PkpqSnahUCqS/mjqQqG+QLtBfex/SUffMIv
         GrhmUWaP7jkt0hFVTjNRW3kIgAU+sgPBaZeyctwDoUzHPFKk/GMOmJqJ0W6YgPB+65Jd
         hP2p5L56bfcz9a9qyhFa3qeayvb8J5hLfDRf2zE9E+eLXC5EO9jPaWXlPu/u6dmyDpkJ
         Ugv6ZYlwiIdgLuz94tIcwDRQRlVFeTmPaUrt2Ph9omlrDE2zpm/rMhRfp9p5tPLBWI+h
         fPww==
X-Gm-Message-State: APjAAAVgx/xc2Peszj7Q7kHJL6oDjVtStcg8BVvuBoIrcJ/39r1uCGn3
        8+vjsstYyUFS9ouT0aWxDjg+yZewdsVb7ykQ5P4=
X-Google-Smtp-Source: APXvYqw/TCc3ZpKoBxT+ch1iETtmYgpwryoHlVzNmUUcXIbCd02DpnAinQk6e8VLX0jMmSJ64rsDQ3xcIUuGROc8TcE=
X-Received: by 2002:aa7:c554:: with SMTP id s20mr3385592edr.131.1552197946603;
 Sat, 09 Mar 2019 22:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20190309154555.33407-1-ttjtftx@gmail.com>
In-Reply-To: <20190309154555.33407-1-ttjtftx@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 10 Mar 2019 07:05:34 +0100
Message-ID: <CAP8UFD26Zxt1FvwAajV48eBbhPv_q5oSLTekWxApcNpg=xRn3Q@mail.gmail.com>
Subject: Re: [GSoC][PATCH] tests: avoid using pipes
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 9, 2019 at 4:50 PM Jonathan Chang <ttjtftx@gmail.com> wrote:
>
> This is my attempt for this year's GSoC microproject.

Thanks for being interested in this year's GSoC and doing a microproject.

> I copied the commit message of the commit[1] mentioned in the microproject
> page[2]. Is this OK?
>
> Here is a summary of what I did:
>         - simple substitution as in c6f44e1da5[1].

If you take a look at c6f44e1da5 ("t9813: avoid using pipes",
2017-01-04) you can see the following:

    - it changes only one test file: t9813-git-p4-preserve-users.sh
    - its title starts with "t9813: "

It would have been nice if you did the same in your patch (that is
only change one test file and start the patch title with the test file
number).

On the microproject page, we say:

"Students: Please attempt only ONE microproject. We want quality, not quantity!"

And to other students working on a microproject, we also ask them to
focus on only one test file when they make those kinds of changes.

Best,
Christian.
