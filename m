Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15DFD20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 18:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeLJS6c (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 13:58:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37496 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeLJS6b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 13:58:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id h15so10430864edb.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4QkWgG+b29CvOaW7i9ZW6EQ090/cTybO+ITCJXaLKA=;
        b=qSnAHS/k1ohv5GhKExJRntQtMFicdlRiai7AYzXZRQIQ9MSq5dzqYWBG9iAyInrF8x
         /ZOvIk50cMQ2eImjs9djdU3PaQYGvlXRnNooO5CHhKJBRPvHPHlQM4xeCrtYGDPLc0hW
         4RfskvMmQ/FGTT6+/B6nAZaLjKAI9gma993Fsh0lCPv1N38Yarz7zAwgWo94kT9UZjdz
         lmU26zl2rn8owxahDF4no/Ks3GLp1CgcKhN1/w2YSRCPVDMVcsAErj/YPyaRw+4N/iEt
         qvBb1XYZBKhoyJoun87DYYQRB2oj95xqBkQ754FVJmLPKRseR5vi8tF7zPDBf8MjEOeh
         7M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4QkWgG+b29CvOaW7i9ZW6EQ090/cTybO+ITCJXaLKA=;
        b=kgnE2T4aQUsXVfXTyVOVRJs9dU+0GMiBxwf4gKMFOZoCws1BYlJiR17wK8tv9nsbHf
         k8acbKGWxyhSejNubKhmV5gfGkzQjUvETi+fO1EOLkUm6zZO+EL+vBir7YCcQ8iMK60i
         tci1XnjvzGkXgtUu9kVBjB4a0YvQ3q3Ogrr31FdcHODzOlD2FdHie3ujdeADtf47vL+e
         5MW+VJ+XY5bCIkrz8e1rY7p2Jbw5lTv4IwRqVKiKngcT9qOAzeZerab4DBpjMTtlGL/R
         ux/O85BnSs40mLRmK2C1jh7ovzNkU6aFnmgS+SDmP1y+DDCBFq87b4l/+3S5/H3JHulO
         bzew==
X-Gm-Message-State: AA+aEWaVkDIV3cPVvjxBYq23nrvVrzb2uceZS4vuhIvqTrmXhuE2fgCD
        3JeQLlFF8VLfyQ6ILwFse5sg9Ey+GcvSvViEts1S+ldgURKtwg==
X-Google-Smtp-Source: AFSGD/XKNUywVsumLnW/0hF+adnpLN+DwKWP63KxKNquaroJ1k87BgxdMPaP9UcaBeepoNbwSismURrqmZxSi27Ht6w=
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr10329249ejq.19.1544468309788;
 Mon, 10 Dec 2018 10:58:29 -0800 (PST)
MIME-Version: 1.0
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com>
 <20181206212459.GN4633@hopa.kiewit.dartmouth.edu> <CAGZ79kYoGqWW4tv4-caA18SHKe+y2mnDT84AEWVksDtDObLq0g@mail.gmail.com>
 <20181207012256.GR4633@hopa.kiewit.dartmouth.edu> <CAGZ79kbeAd1C-ySnJye-QU5FFf2jygksUsWtEmbvPZ_dQy_3uA@mail.gmail.com>
 <20181208021531.GB4633@hopa.kiewit.dartmouth.edu> <20181208042139.GA4827@hopa.kiewit.dartmouth.edu>
In-Reply-To: <20181208042139.GA4827@hopa.kiewit.dartmouth.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 10:58:18 -0800
Message-ID: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
Subject: Re: [wishlist] git submodule update --reset-hard
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 8:21 PM Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
>
> On Fri, 07 Dec 2018, Yaroslav Halchenko wrote:
>
>
> > On Fri, 07 Dec 2018, Stefan Beller wrote:
> > > > the initial "git submodule update --reset-hard" is pretty much a
> > > > crude workaround for some of those cases, so I would just go earlier in
> > > > the history, and redo some things, whenever I could just drop or revert
> > > > some selected set of commits.
>
> > > That makes sense.
> > > Do you want to give the implementation a try for the --reset-hard switch?
>
> > ok, will do, thanks for the blessing ;-)
>
> The patch is attached (please advise if should be done
> differently) and also submitted as PR
> https://github.com/git/git/pull/563

Yes, usually we send patches inline
(Random example:
https://public-inbox.org/git/244bdf2a6fc300f2b535ac8edfc2fbdaf5260266.1544465177.git.gitgitgadget@gmail.com/T/#u
compared to https://public-inbox.org/git/20181208042139.GA4827@hopa.kiewit.dartmouth.edu/
(which I am replying to))

See Documentation/SubmittingPatches.

There are some tools that provide a GithubPR -> emailPatch workflow at
https://github.com/gitgitgadget/git
I think if you'd open your pull request there, then it would be automatically
mailed to the list correctly.

I left some comments on the PR.

>
> I guess it would need more tests.

Writing tests is hard, as we don't know what we expect to break. ;-)

> Took me some time to figure out
> why I was getting
>
>         fatal: bad value for update parameter
>
> after all my changes to the git-submodule.sh script after looking at an
> example commit 42b491786260eb17d97ea9fb1c4b70075bca9523 which introduced
> --merge to the update ;-)

Yeah I saw you also updated the submodule related C code, was that
fatal message related to that?

Thanks,
Stefan
