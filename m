Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8EDD20248
	for <e@80x24.org>; Tue,  5 Mar 2019 23:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfCEXDj (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 18:03:39 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:41298 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfCEXDj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 18:03:39 -0500
Received: by mail-io1-f42.google.com with SMTP id 9so8532432iog.8
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 15:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ls0E880fmJ9Ly4MckDfLsiyawmkQ/Ii0A//jJaq1DH0=;
        b=OohrXSGeLoG9gz4Inv6Dozd5HKEAbUiN+zUsavlpAC83WZfj1fhnHrIXTa8en6DORm
         9388aayh6q9NKQaL3zBLN71mU+L7pjTnsEeR8foukror1yn7BZSHYBdDVu/dne5aO5QF
         7FzRokXU6mQtDyJ99HpR4fwWy5jjgcqyzFvXCFC0v7SKgJ9k40S53zZhwWr7SVBX6r92
         WjMdMp8laIGo92KQ1mjhNoo+Tmu2Mzk7qa5Zw1DqWuidm4mmsF3wKffICNBjFAx/RVit
         1hfJDm0684ySOYoY1qvyRf1eKV0Dg+qAdRvJUgjYjzZHbH8per/bJWPsuuMuk8SBtOkY
         x35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ls0E880fmJ9Ly4MckDfLsiyawmkQ/Ii0A//jJaq1DH0=;
        b=SZgP/TlPE6k//N1ibTUcECggAoz0EW7irOlWzmLKZJ0WHdfiqs8IxsaiwKxSxw9kLh
         Xv+jvnXmnYywl99baIa1IkVO7sWrdgW0tlyQ3yVjWlqH6j+MHoNF9uBv1MILik/bzzrA
         ZzCdcMUtFIRA52RirNB96VOHmvqF6/U/wx3o4R9XqgrgdQ+ebv4Os1RFr2Ko/S+7CEuh
         j8tswdct+BdahX8EJiNTjzb/F5wpHhwT/84xtITQCTuHj/WghLv4kNi3bLKTUKHXtJaS
         p6Waf4jTbFdbm27s9wlN5ucdnTXZaK97kdzpevS5+cmlz+QCWSJkCzYNp27dr0N6mrRH
         CpSA==
X-Gm-Message-State: APjAAAVz1j4c1yq5PI9GsvJEF7tboDY5ewdkIDaxdma1HnaL2MFsyzW1
        qiAnDUND/qmyBz7I6dIHAtfcv4FKe4uooy8MK/fOfA==
X-Google-Smtp-Source: APXvYqyzo5T+8jXObpBuOX03N4nLmxDqss5PkIW15dr4h/0olMzPUjhrtirddA+5MPMoVv9oCmpz0xQC3I4PlhtXVd8=
X-Received: by 2002:a6b:7941:: with SMTP id j1mr1551447iop.262.1551827018135;
 Tue, 05 Mar 2019 15:03:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com> <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
In-Reply-To: <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 5 Mar 2019 20:03:26 -0300
Message-ID: <CAHd-oW6rVptPnHn-aoeMTkp0p-TmoQ7fniftpQm9rw+tjukZ_w@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, I must apologize for not replying during these last
days. I'm traveling and I rarely get a connection here. But I'll be
back March 11th.

On Sun, Mar 3, 2019 at 4:18 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Sat, Mar 2, 2019 at 4:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > I'm a bit wary of a too large proposal here, as we've historically
> > overestimated what kind of project is achievable over a summer (I've
> > been there myself, as my GSoC project was also more than I was able to
> > do in a summer :)).  I'd rather have a project whose goal is rather
> > small and can be expanded later, than having something that could
> > potentially take more than 3 months, where the student (or their
> > mentors) have to finish it after GSoC.
>

I totally understand the concern.

> Yeah, I agree with your suggestion about a project that declares
> removing the global variables as the main goal, and adding parallelism
> as a potential bonus.
>

Talking about a delimited scope for GSoC and a potential bonus after,
a potential idea comes to my mind: I'm still trying to define the
subject for my undergraduate thesis (which must be in HPC and/or
parallelism on CPU/GPU). And the idea of bringing more parallelism to
git seems to be too big for a GSoC project. So, perhaps, if we manage
to identify wether parallelism would indeed bring a good performance
gain to git, I could propose that to my advisor professor as my
undergraduate thesis and I could work on that during this whole year.
It is still an idea to be matured, but do you think it would be
feasible?
