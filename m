Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EEC1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 23:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBGXsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 18:48:40 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:45534 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGXsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 18:48:37 -0500
Received: by mail-vk1-f169.google.com with SMTP id n126so414059vke.12
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 15:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1slQTpEyXwsClEueQRCNexL5ESlFUBxU8p8LdH+9Us=;
        b=JPJrJq2mpPUc8DxtUnuCo+kAP25K2M7tjB96g0pK0DoYYX0pQ/nS5UHXdklzpu3EMX
         x1OYQ7g/w02cDQ6UBjjPNkgqwX/cIUsbUsFrMc/plZrHceQ+Q2yrJ5Z9N0SBD7QTyPh8
         m9KB++DZEwwJXlG8uyI1bhp37b6MEy2mYYwu99t8Dex9Faxrk2htDCfMN6C9/Lw04Osq
         OK/jpVaKS0AsGO6auUrLOWZiyD1ybQzQ0X70u4L9jSiMSz1jZf2TwNJCQKGf2F1AjaQo
         N7F0NlghMxI3C3/WOXJRIvqdM8gW0Mti+MYpr43GqiygsIEXYVvxGFGql9x8UJqySyAK
         Pv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1slQTpEyXwsClEueQRCNexL5ESlFUBxU8p8LdH+9Us=;
        b=geWKsNWPYaXwJdXlkhiyRMGvPpTX8340wnMXVsRQn7KS7xDg83Pw6178sSmYjCukXP
         yd/YBMCZKddKcWTVO5Fy8ypgimcbRL45d9jWwiY5wYO25xu2Yq5U0u7Y34OEYLRnNJkM
         CRIhVkVj+/pht+fGuDGEbTdsP6vI1rPfBqx8OnecJFVfEDxhrmjMcTl5Lt0+8tQaZfAC
         xUBtok0/42iDiSvGPZcDppVeoLyO9feHuYLjmwpBFvZ2ksua393dh7ohrdHd9QozHAyX
         8Irf82YQiSu4LjP6YcnKQDuSCv1X6eD9X+RzSK8cQn1V6sQTlCD2aAIf/lj5YbcR9kid
         rXNg==
X-Gm-Message-State: AHQUAuYIJ/QcAyp69hKhZqA1Tc614RpiStn0bBb9MTQ8lBygCvCpPirS
        ew8YL/Hi+WojyjONOZqzSIBbtQ9F2LneuRzV0oTr8ib3i74=
X-Google-Smtp-Source: AHgI3Ib+FVEBQdOu2uBu9Mn4EIXwpZhdeYFjQkSkFNGf3JWnQTYxZsFryfgLzQULTIbMtnzAJWckMwJfQT+sap4LxME=
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr7530961vkh.92.1549583316714;
 Thu, 07 Feb 2019 15:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20190126221811.20241-1-newren@gmail.com> <20190204200754.16413-1-newren@gmail.com>
 <xmqqlg2vtfmo.fsf@gitster-ct.c.googlers.com> <CABPp-BGyL5BAejK-P-EdscFdH3C6uR7e6CbgNe-9doy-mkw-vg@mail.gmail.com>
 <xmqqa7jarmvo.fsf@gitster-ct.c.googlers.com> <CABPp-BG4WftXZgbzN48zSo1Z5BcWYjdbz+8hGSGBNJbSsYUzAA@mail.gmail.com>
 <xmqqimxvny6s.fsf@gitster-ct.c.googlers.com> <CABPp-BHyLFNcdh+=hf=R5xhUoNAQHPophxgc5e2HRqgeTU4e8Q@mail.gmail.com>
 <xmqqlg2rmazz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg2rmazz.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Feb 2019 15:48:24 -0800
Message-ID: <CABPp-BEA9zUpv0-ZH4kjMg+KaQF=jT4D9sozvLC0gv8viN2MYw@mail.gmail.com>
Subject: Re: [PATCH v4] log,diff-tree: add --combined-all-names option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 3:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Now, the question: In addition to the two "from" headers, how many
> > "to" headers do we emit?  In particular, do we emit both a "copied to
> > F" and a "renamed to F" header, or just a combined "renamed/copied to
> > F" header?
>
> There is only a single path that can be on the "to", as there is
> only one final result, but _how_ the contents got to that path would
> be different, so to be technically truly correct, you would end up
> showing N "to" lines for a N-way merge, each of which gives the same
> path in the postimage, but some may say renamed, another may say
> copioed and some others may need to say in-place edited.
>
> That would increase the number of necessary lines from N (from) + 1
> (to) to N*2 (N for each of from and to), which makes it even less
> economical.
>
> And showing a single "renamed/copied" feels more like a cop-out to
> avoid being techincally incorrect, than giving a useful piece of
> information to the users.
>
> I am inclined to say that we should do _without_ any "to" line.  And

Works for me.

> if we can do without any "to", perhaps we do not need "from", either.

I would be okay with that, but looking through a few of them, I think
the "from" lines do help a little, just because lengthy filenames are
not uncommon and it's easy to miss the fact that there is a rename,
often in some directory somewhere in the middle.  A couple examples:


diff --combined packages/search/ete/src/test/resources/test-suite.yml
index 4ae66932ef9,1cc55276946..1cc55276946
rename from packages/search/src/geb/resources/test-suite.yml
--- a/packages/search/ete/src/test/resources/test-suite.yml
--- a/packages/search/src/geb/resources/test-suite.yml
+++ b/packages/search/ete/src/test/resources/test-suite.yml
@@@ -1,15 -1,5 +1,5 @@@


diff --combined packages/search/ete/var/conf/app/public/searchApp.yml
index 38cc5482e5b,487178ac0a9..487178ac0a9
rename from packages/search/ete/var/conf/app/public/searchApp
rename from packages/search/var/conf/app/public/searchApp.yml
--- a/packages/search/ete/var/conf/app/public/searchApp
--- a/packages/search/var/conf/app/public/searchApp.yml
+++ b/packages/search/ete/var/conf/app/public/searchApp.yml


If there's no renames or copies, then I don't add anything to the
combined diff.  With renames or copies, people can get the "to" name
from looking at the "+++ b/" line.

But not a real big deal, I could just omit this if you prefer.
