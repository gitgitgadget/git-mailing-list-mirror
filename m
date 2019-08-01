Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544D01F731
	for <e@80x24.org>; Thu,  1 Aug 2019 03:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfHADIX (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 23:08:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41345 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbfHADIX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 23:08:23 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so136946426ioj.8
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEJ0YhWVu7CG9utxjo+mrrdpO4kNS8cnYtpijr8onTs=;
        b=O9IMxd0blLSSxvP78wfpnY7yLOn8nB+1aefXEa7cHCkz3RxuEgOlLVaVhGwXbG1Cc4
         eHZqCC9LOhdtp6yEbpc7QZLwcd3HxO3pRvQ5ZZTQsbXg8mUvLklU1UnPOtey9tAek5W+
         uLLe9n+nhBwiIjfbk4fM1wkQXWkqSFCPDLzDAVSEHyPY8uxQxMeuMKclhQA5nad5txTJ
         nK8o1f1t2WaDoyCyfLsGRPBAWCPfXd/HOIlW7qeyBxQbi77NKfDLZelGx1gTGj4jjJpH
         32Nlsh7Bsxa89mhhuQtxUwKx71M5AN4oQNj0IKAqidxxYu66f9IJ2z3KptWeoGyKTuRw
         pTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEJ0YhWVu7CG9utxjo+mrrdpO4kNS8cnYtpijr8onTs=;
        b=gaXlI4+clr2AWu0m7wYUyHrOEWLYb1xtaEHH53l9fqZktXNsbY9N/LIwF3Rehr7WDF
         rsRhbIm4pIP75m3lEuARmsrOog0tcQQ3DSIjm/kW2Hg73a7z0fcKOu2KGo4NPk0lKl9l
         eSiI/POLmwH9QSemuISPCCZ+6Kx9HSNODFL1G+Wd5dZLN17429NGgJ2sr4JC9KAYlhw6
         /GtbSGQl73RFN92hexb/Dz6iuwOIOcZDB3MT8FNm+lNsoLAvF8gR2HHHG/NcZTZm3yWo
         ASLFIWwbzBH/TVh5X2KpAZir061NZ+EbWWFEvDWSLzoL6Z495JXmX2FWyo94EkimAdsN
         o5BA==
X-Gm-Message-State: APjAAAUTG8DYNZLUZle22b/dS8OusZoUnrUmyud8yfzdBQSv9S3WAgGp
        ORPc2vljZszNN03HE+RfBBhxHT3YVYoIY5O7QGLPvQ==
X-Google-Smtp-Source: APXvYqwKKKRcdpdNApv96NA52k0pK6a43s99EMp3q4896saJahG4y2Ubnle7mr0M+PzTyj3iGJFWEUSU5gH5RtUj7dM=
X-Received: by 2002:a5d:9613:: with SMTP id w19mr79553065iol.140.1564628901165;
 Wed, 31 Jul 2019 20:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
 <ba3d8a953a2cc5b4ff03fefa434ffd7bd6a78f15.1564505605.git.matheus.bernardino@usp.br>
 <xmqqtvb3s2zi.fsf@gitster-ct.c.googlers.com> <CAP8UFD0bH7ZNWFt3MfkAQf2tkF6CAgFj5FsZyc9zechg7MkCUw@mail.gmail.com>
 <xmqqwofyqjrz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwofyqjrz.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 1 Aug 2019 00:08:09 -0300
Message-ID: <CAHd-oW78PpLspY94F9JDfw3C6v3oRbt0tZY1Jth4R_WbYUSQCg@mail.gmail.com>
Subject: Re: [GSoC][PATCH] grep: fix worktree case in submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Daniel Zaoui <jackdanielz@eyomi.org>,
        Antonio Ospite <ao2@ao2.it>,
        Stefan Beller <stefanbeller@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 12:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > On Tue, Jul 30, 2019 at 10:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>
> >> Matheus Tavares <matheus.bernardino@usp.br> writes:
> >
> >> > @@ -598,7 +599,8 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >> >                       free(data);
> >> >               } else if (recurse_submodules && S_ISGITLINK(entry.mode)) {
> >> >                       hit |= grep_submodule(opt, pathspec, &entry.oid,
> >> > -                                           base->buf, base->buf + tn_len);
> >> > +                                           base->buf, base->buf + tn_len,
> >> > +                                           1); /* ignored */
> >>
> >> The trailing comment is misleading.  In the context of reviewing
> >> this patch, we can probably tell it applies only to that "1", but
> >> if you read only the postimage, the "ignored" comment looks as if
> >> the call itself is somehow ignored by somebody unspecified.  It is
> >> not clear at all that it is only about the final parameter.
> >>
> >> If you must...
> >>
> >>                 hit |= grep_submodule(opt, pathspec, &entry.oid,
> >>                                       base->buf, base->buf + tn_len,
> >>                                       1 /* ignored */);
> >
> > Yeah, I suggested adding an "/* ignored */" comment, but I was indeed
> > thinking about something like this.
> >
> >> ... is a reasonable way to write it.
>
> Thanks.  In this case, I am not sure if the comment here really
> helps.  If anything, shouldn't there be a comment near the top of
> grep_submodule() that says 'cached bit is meaningful only when you
> feed an empty oid, aka "not grepping inside a tree object"'?

Right, it makes sense. I'll add that.
