Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_BLACK,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2825E1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 08:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeKBReL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 13:34:11 -0400
Received: from mail-it1-f170.google.com ([209.85.166.170]:36062 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeKBReL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 13:34:11 -0400
Received: by mail-it1-f170.google.com with SMTP id w7-v6so2184288itd.1
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/rS/WIp/6878dkDliLmHVSXH0NFF5bW0QZ+uDjrzm4Q=;
        b=pVD5Lhm2MI+QPyCy3LshqB3CPtZOKMQ58+KIeqpxTdtUtXjl/VyYJRNnmOqrUA4p2w
         JZI1Jt+T3pLqwtdJSU/Lj5ofYAbB01QhHJ9NrqM3susC/jWTXUAJYOxp/Ir6sTXvWHTz
         VkHk64Xrv1Qwa3AO8LRzd1Pb0vqGQT4udM5g1jaL6IRfN3us83olEz1TWGDeiJzsjIor
         4I4PS7VzQuuyaTcpJx1iZphuFE4QHqp+4kzZ5S+/Ir4EA9j+/J+MltQ0om6Q52U5aG/w
         hfHx2roGzLbHz07iC8o/xK/Z66U9qbNHIYLP49bPkQEmCQOf6k9PYsjFEnz4F5yXJ4iI
         E8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/rS/WIp/6878dkDliLmHVSXH0NFF5bW0QZ+uDjrzm4Q=;
        b=r1uJCs13VT8a4/NoiIwyiDyPA87jl2gZ/ASXJSEK5MtnTZ3MiY3s5iVaVdbq2I8TA7
         FQNAgjcOB9/DAAGOfLomlo9lT2U9NYgjIjWp2fLaCtne8kegbjp8i0LKz15bG2PZz57e
         oX/yjdJ8dz1ZVjPRAK8qN9SWMSXMZfpu5EmzgTit4NHFCwv1Mtr0cq6DlV3cF6UXme8P
         vwhUtCKnG7n7cPkBzXlmtF5HKW5dCrK0VCNu3pYjWcT58kNswOTyctVquK5rt4TyJ5Ij
         kdRePYrjcE1UAMqhqHLaz/obl88WwRGmlczE4XMSz4o4V72BJ4pXYwn6x8QOiQpIefF8
         CLzw==
X-Gm-Message-State: AGRZ1gIoC+5IVB6Oleg/lHHWbO4wvUjwDRTE1IgRGyq+dCMm6H7QuxtT
        +qqe0PC3RxToTEMVYnTzAQDDSdobQl7RUeN4Wgo=
X-Google-Smtp-Source: AJdET5fXh8nwV70/BCI30tL5OmCJeaHOFbygrXZD6rOjsd1PtxNEddx+4+N+hzkOBt5L84cJi1H5YAzpw/0D7LKzmqM=
X-Received: by 2002:a02:3b2c:: with SMTP id c44-v6mr9628971jaa.31.1541147268362;
 Fri, 02 Nov 2018 01:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <6d8ef01ad9eb08d90cb9848eeaeabe6784b7b3e3.camel@laposte.net>
 <87zhutjb3t.fsf@evledraar.gmail.com> <6f3d8c49e1d44ab20d4169e5254364cba707f1af.camel@laposte.net>
 <CAP8UFD1rTJNOZzFMryY9BNKHUZKE8FUEgw+4jFfnZ7G8KGNrkw@mail.gmail.com> <62bf61555a6c2789e959e4f085bfedf28b60f268.camel@laposte.net>
In-Reply-To: <62bf61555a6c2789e959e4f085bfedf28b60f268.camel@laposte.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 2 Nov 2018 09:27:36 +0100
Message-ID: <CAP8UFD0DHGShwo=DnwbSHz3nvRMF9P4GegEzC27uwHLXQ=A4Zw@mail.gmail.com>
Subject: Re: [RFE] Please add name and email to git credentials
To:     nicolas.mailhot@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 3:42 PM Nicolas Mailhot
<nicolas.mailhot@gmail.com> wrote:
>
> Le jeudi 01 novembre 2018 =C3=A0 15:13 +0100, Christian Couder a =C3=A9cr=
it :
> >
> > How can Git know when you commit where you will want to push the
> > commit afterwards?
>
> You have an url in the repo config. of course you can change it between
> the commit and the push, but that's not the general case.

If I did a `git init`, then I have no url in the repo config. Also if
I cloned from a repo that has a different URL than the sites I have
credentials for, then how should git use the URL in the repo config?

> Nowadays, most git projects have a preferred git hosting, and your
> name/email with the project match the credentials you use to push
> (otherwise things like gitlab/github issues trackers would not work at
> all).

I think you are talking about a special need that you have, but it's
not the same for everyone. For example I always use my real name
"Christian Couder", and when my email changes, I would like it to
change everywhere, so support for .mailmap files in GitHub and GitLab
for example would be much more important for me than what you suggest.

> > What if you want to push the same commit to 2 different places that
> > need different credentials?
>
> Then you do not use git credentials and have to configure all by hand.
> Which will usually be a major error-prone PITA, so you=E2=80=99ll end up =
pushing
> to the system that matches the ID you want to se in git logs, and then
> push from this system to others.

You could have no user.name and user.email configured in your global
config, and a script that configures those in the local config
depending on remote.origin.url. So when you commit in a repo, Git will
fail if user.name and user.email are not already configured in the
repo. It will tell you to configure those, then you just have to run
your script to get those configured locally, and you are good to go.

Another more flexible possibility is what =C3=86var suggest with
conditional includes in the config.
