Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D9E1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeH3ARV (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:17:21 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:42943 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbeH3ART (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:17:19 -0400
Received: by mail-pl1-f182.google.com with SMTP id g23-v6so2774150plq.9
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 13:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomaszubiri-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=GtgDAjk8dUXMAakoU1nXwmPkS1L1uWoRb6Vg57omRHc=;
        b=M7MmHb/QW/oBgZrFZvR5lhDKbX/9BemxZ/o290+I9YwqaQ/ViqlwzQuWT3vqzkGk/U
         KjxHWP6nE1tIey05C0OP7nPRkRJY0tKwfjJx62Ob4eg/IL5bNq9jTsJUHLAa6CB/lihz
         USLdtr3JhK2qId/xLXhx9uTrBLKw+Nfs86gFwZxRUg9AQ6wiqipRZiNDYhYpgRoFL29v
         1mGEs7MOZOXzdojKczyZH6/1H8eGBr+9ML9uQzRAdgkhOlue4CAlMNh6eoWWSJ1xWGpa
         GT40JBtnRN+h/gmkp8a4OsswjXi6rMtSpItEVZZyB+IYOwpbOQGL57F0bJkJOdbwFX09
         swtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=GtgDAjk8dUXMAakoU1nXwmPkS1L1uWoRb6Vg57omRHc=;
        b=RtmE3cBoUnBuDyJeDGM04aihyMVK+7d3eMQUDX0UkPCmoUh9Fwj/i+IO/x46JAwdv/
         1y6fwNzoCvsDAjOF9JYwCsbwpI0jnTcb0PX6QxxZZsttmaxEhH0kln7DgKQIJXottimA
         Vn4oPMwIhmp1d3DfhpVG5wmvxhp3GI/MsocDZT0h4S5BxThmJoUze0XEDfmtpkx68qi1
         W0jPgi7rsus+CwpPPS0fRQ45CCXsyoU8oj7UZuHDLh0M+h0ggkKBvnhPIsOPeHISVXHg
         j6Sd7hUZnBSrMOyMKg3NeUtcaQsGBA8raxhYkb1iE9qgc4tA338SgLT8a5EVGr2Vscuk
         ukLw==
X-Gm-Message-State: APzg51Bc7N0RRAuLbdCwx3BsRu4cNXeZc7QB1+ynavhBaZGoTmrb3GnD
        gcg5a5mYA36TqJLXzrGMpiWCRbWoonQXX8dYYi/K+CAcbq4=
X-Google-Smtp-Source: ANB0VdYunWAg1NqXQpxWwmon/fNiuHVUNPuU7gELc52cJQaLQSt/pHlxRlYA2a3SegLqUKCy5sOJnEe9+ykYutQwego=
X-Received: by 2002:a17:902:758b:: with SMTP id j11-v6mr7312295pll.29.1535573929427;
 Wed, 29 Aug 2018 13:18:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:da03:0:0:0:0 with HTTP; Wed, 29 Aug 2018 13:18:49
 -0700 (PDT)
In-Reply-To: <CAE3VKErGMSgB9gJAEnAuEDE51Yem6WUsg6fmOQELY1HCrALk_Q@mail.gmail.com>
References: <CAE3VKEp3PJLCy3tL=K51nNzGry-HySb57QHemZzMtg3RkBmzUw@mail.gmail.com>
 <CAGZ79kakEYc954nQDThAZ0fSwbNp2-GGwthnevoQ4DxEUu4gZA@mail.gmail.com> <CAE3VKErGMSgB9gJAEnAuEDE51Yem6WUsg6fmOQELY1HCrALk_Q@mail.gmail.com>
From:   Tomas Zubiri <me@tomaszubiri.com>
Date:   Wed, 29 Aug 2018 17:18:49 -0300
Message-ID: <CAE3VKErVQ9-PcQ-83xUqBDvLxNUDmWvhOAm4SMhqpQyAZCWQEg@mail.gmail.com>
Subject: Fwd: Git Unrelated Histories
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for taking the time to help me Stefan


On Aug 29, 2018 15:15, "Stefan Beller" <sbeller@google.com> wrote:
>
> On Wed, Aug 29, 2018 at 9:49 AM Tomas Zubiri <me@tomaszubiri.com> wrote:
> >
> > Hello all,
> >
> > I have recently joined a team there seems to be a couple of  issue
> > with the git repositories:
> >
> >
> > 1- A branch created from development cannot be merged into the
> > production branch.
> >
> >
> >
> > (production)
> >
> > git merge development_feature_branch
> >
> >
> >
> > fatal: refusing to merge unrelated histories
> >
>
> See the git merge man page for the
>   --allow-unrelated-histories switch.

I have tried that switch, however when merging a small feature branch,
the merge tries to merge ALL of the differences between both branches,
and they have diverged quite a long while ago.
I am not getting the expected behaviour of just merging the changes
from the feature branch.

git-merge-base shows a common ancestor from 2 months ago,  btw.


>
> >
> >
> >
> > 2- If there is a file that only has a 1 line difference in production,
> > a git diff will return that the whole file is different:
> >
> > git diff production:folder development:folder
> >
> >
> > =E2=80=9C
> > diff --git a/folder/file.py b/folder/file.py
> >
> > index 9bfd6612..20cce520 100644
> >
> > --- a/folder/file py
> >
> > +++ b/folder/file.py
> >
> > @@ -1,245 +1,245 @@
> >
> > =E2=80=9C
> >
> > I=E2=80=99m not 100% sure what happened here. But it seems that changes=
 and
> > added files are copied and pasted into the production branch and
> > uploaded indepenedently as separate files, contributing to a huge
> > difference between branches.
>
> It sounds to me as if there would be line ending issues or some sort
> of whitespace issues (tab vs spaces).
>
> >
> > How can I confirm this hypothesis, and what steps can I take to solve i=
t?
>
> git diff --ignore-all-space
> or --ignore-space-at-eol

This worked. Thank you!

>
> Look at gitattributes to set your flavor for files so you don't have
> to pass these flags all the time
>
> Stefan
