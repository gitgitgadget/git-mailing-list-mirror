Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5391F803
	for <e@80x24.org>; Mon,  7 Jan 2019 21:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfAGVMf (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 16:12:35 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:42722 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfAGVMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 16:12:35 -0500
Received: by mail-ot1-f45.google.com with SMTP id v23so1622659otk.9
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 13:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dqxtech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+XvZgUJ02SxcQ/kFau4U/D+QLFQtLs1y2qGlSJjpHo=;
        b=l4G3CurBkHKCLFTVNjtTI+qN1egfdDPgDP2It4bDMmgkWMVhXxAXxna500pycY6t41
         0P7kkkAmv/RVJTNW7GvlTKZ56affqQhP5O+KKXqjpXCkfZVr5w1NALQZ8eeEn3zCoWDe
         Kr8xJHBX97XX2KqJdN8jb5obQVF5wXyceABm+BecaJTUticKP21znn2SWcDXbTNvQVO9
         2og7NDCvIOCO1XeGr0JhdaBrsgKVUjzZK1gj2072gqahFpQauqcUi3+deiJB5rZzpMdN
         TOsQ9eGO38tdWJqhtxnj4RVZxj9ZwU81LmWpRfAtR/45aAX06hY7mfBEBgGUghB3f0DV
         +woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+XvZgUJ02SxcQ/kFau4U/D+QLFQtLs1y2qGlSJjpHo=;
        b=Lno7XL80cVdpetGYuTtyquAto2+KJQdALB+OqjK4aJ5/k/d1QzKSCM8Dr3q1sCT31p
         JsRuWeCJXNNtepuS5mko5INl0RH+V5c9HbFq+UVXvflsnNUlKNWcbifNdJTh/47pWh7G
         FnsNi2kNjZyC4R0crX/Fg1l774/9xFax3v6BzfYLizmfDYR5Z+c80cZd/+70Vti9UttQ
         9wMafzc0At+F4l5hC5phZ3vc2OhQFV+wMuTOwgLTjJKM+N9EI1p9O2nxBCUEDtmxt/K0
         mJ08fWsUGqFsrf7uElzzp+fZW9Xs+Tq2AH6SM/sPeub8rf3s276sNflMROLpR4ZrRcOS
         wETQ==
X-Gm-Message-State: AJcUuke14dvuMbikURkW7x3TFS+VhhcF0R0Btb0aytLln9G8Yo4VNMyE
        QvUaxINr7mm5GoKQ9lVN58iYa51utlrtcQ==
X-Google-Smtp-Source: ALg8bN4tXmIgOdxqcfd0MHpqXcc/+Q6NylvBdiaadkWegnE0yjudbbOmMO0gt4euv5QMSXez0pqDYA==
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr41200980otq.119.1546895554024;
        Mon, 07 Jan 2019 13:12:34 -0800 (PST)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.googlemail.com with ESMTPSA id b18sm30268200otl.33.2019.01.07.13.12.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 13:12:33 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id j21so1554671oii.8
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 13:12:32 -0800 (PST)
X-Received: by 2002:aca:c46:: with SMTP id i6mr40547068oiy.208.1546895552266;
 Mon, 07 Jan 2019 13:12:32 -0800 (PST)
MIME-Version: 1.0
References: <CAH0Uv3Eu7bGSVaJKu6kDjp0BPRe0yROucDfJ8QHV3X_ZjNJT7g@mail.gmail.com>
 <xmqq36q4berk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36q4berk.fsf@gitster-ct.c.googlers.com>
From:   Andreas Hennings <andreas@dqxtech.net>
Date:   Mon, 7 Jan 2019 22:12:21 +0100
X-Gmail-Original-Message-ID: <CAH0Uv3FRq0JiXWx9Ow1EhKrYB4OTM-9Fpox7FvZ3tC6J6toEsw@mail.gmail.com>
Message-ID: <CAH0Uv3FRq0JiXWx9Ow1EhKrYB4OTM-9Fpox7FvZ3tC6J6toEsw@mail.gmail.com>
Subject: Re: Feature request: --preserve-merges to add "exec git merge ..."
 instead of "pick ..."
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It sounds good!
I was using git version 2.7.4 all the time. I should have checked
before posting here :)
Now trying 2.20.1

From "git help rebase":

           By default, or when no-rebase-cousins was specified,
commits which do not have <upstream> as direct ancestor will keep
their
           original branch point, i.e. commits that would be excluded
by gitlink:git-log[1]'s --ancestry-path option will keep their
           original ancestry by default. If the rebase-cousins mode is
turned on, such commits are instead rebased onto <upstream> (or
           <onto>, if specified).

I am not sure if this criterion (which ancestors it has) will always
produce the behavior I am looking for.
I will have to experiment a bit.

Thanks for now, I will post again with new thoughts once I have done
some experiments.

On Mon, 7 Jan 2019 at 17:42, Junio C Hamano <gitster@pobox.com> wrote:
>
> Andreas Hennings <andreas@dqxtech.net> writes:
>
> > This means we need a rebase operation where:
> > - The commits of the acceptance branch itself are being replaced.
> > - The commits of the feature branches remain as they are.
> >
> > A "git rebase --preserve-merges" almost does this, but not really.
>
> This wished-for feature sounds to me more like the "first-parent"
> mode that has been discussed a few times in the past but never
> materialized.
>
> The preserve-merges mode is getting abandoned by the original author
> as unsalvageable.  Have you tried the rebase-merges mode?  That may
> let you choose replaying only the merge commits on the acceptance
> branch without touching the tips of the feature branches getting
> merged.
