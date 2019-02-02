Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B386C1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 10:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfBBKE4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 05:04:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32888 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfBBKE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 05:04:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so7942699ljd.0
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 02:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7wJptlyZbIqWf9CKiVzABKqYc1Eoi57dy7/xSWFmvo=;
        b=sH26H1zqWQibVuPtZAj8BqxWbkgtNNn1nBPdi5Hd3ijPzSkP6LgNI5j0H4CyFLBVnc
         cLLezC0+nBFsTFpBQPAzCZOIHSdEWSoYfv4p3TfcnGngtKq1AgsnFczGp42G88jtsM/G
         T8aEunE0N7rVYIapZ6/QV0OQ6m/u8gK7++CpqRlVFaD8+HGqyqvGvYrWDM/5Vc19errx
         ffAEN1+ykR7P1fKaHQsGQ8fFvG76KGghEaGhwX8Iu524RVFY2UtLJ5REGLJd70qQChez
         8zmy+Jb6HQnyQHVd8hwkWKFdG64/21aUj9uea/ETZdqxlFN0lbX7F2S3I7Kleh6wOQtz
         ADmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7wJptlyZbIqWf9CKiVzABKqYc1Eoi57dy7/xSWFmvo=;
        b=uod0JaprKgI/OU4GOJ0oTqj7xvKLWERWE2lbY+l0Ox9AeToV/o191KStfATPscedVx
         OhRGoMB3nCt8SBfa4KR2t667AXt39wMQYXY3C1k4y/FrOXlxWiupC4zLIqqlEjNkot9G
         8jsoPGWS+qzJQhfhTQb1McaZX/4yi1vFxbaDPhS1DUvdYXs9Ljxh4MGRP8DeiPRayBgf
         7d56V+JkqP4n3p+wvGVUcdFGHIZel8yQwYBOBt99XbP8wEqfg1uwo3EfXQZBjzxLq/0p
         gMd2XthB2gnwFURPAu1OORjHUkhU2V24BtgPZr8MY1OcdmIH5SibAz/O9xmMpqoVC3ws
         4W5A==
X-Gm-Message-State: AHQUAubf6rILC1swNQTfnPc2mi7rvDG9hOzbdT4HRW1juk6ZYQLKVVin
        NzVLu9tbDtv3cqPJX38DIctlxvmdeXzSJ6oiWEo=
X-Google-Smtp-Source: AHgI3Ibeql0IUxJVKLaouFAtfW4MYkPXsas/RjNdrAV1KbuHwW+5Twji32LK6u5IXc1xT0oNMxDB5Gay+6IIJ4i9wVo=
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr1463352ljk.80.1549101893780;
 Sat, 02 Feb 2019 02:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20190201135512.68220-1-koraktor@gmail.com> <CAPig+cQgEVJ6OGn9BRUJoALxE7aDCHK308sq7V0EQVRRn6Vn8g@mail.gmail.com>
In-Reply-To: <CAPig+cQgEVJ6OGn9BRUJoALxE7aDCHK308sq7V0EQVRRn6Vn8g@mail.gmail.com>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Sat, 2 Feb 2019 11:04:17 +0100
Message-ID: <CA+xP2Sa2zLeLg-6pFn9UEufurd=EOOf8UFx3Qh7o0dwzJgN-ag@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] describe: setup working tree for --dirty
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fr., 1. Feb. 2019 um 21:12 Uhr schrieb Eric Sunshine
<sunshine@sunshineco.com>:
>
> On Fri, Feb 1, 2019 at 8:55 AM Sebastian Staudt <koraktor@gmail.com> wrot=
e:
> > We don't use NEED_WORK_TREE when running the git-describe builtin,
> > since you should be able to describe a commit even in a bare repository=
.
> > However, the --dirty flag does need a working tree. Since we don't call
> > setup_work_tree(), it uses whatever directory we happen to be in. That'=
s
> > unlikely to match our index, meaning we'd say "dirty" even when the rea=
l
> > working tree is clean.
> > [...]
> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> > diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> > @@ -145,14 +145,38 @@ check_describe A-* HEAD
> > +test_expect_success 'describe --dirty with --work-tree' '
> > +       [...]
> > +'
> >
> > +test_expect_success 'describe --dirty with --work-tree' '
> > +       [...]
> > +'
>
> Can you give these two new tests different titles to make it easier to
> narrow down a problem to one or the other if one of them does fail?
> Perhaps the second test could be titled:
>
>     test_expect_success 'describe --dirty with dirty --work-tree' '
>
> or something.

Thanks, didn=E2=80=98t notice this.
I=E2=80=98d use a suffix (dirty) for my test titles. But this won=E2=80=98t=
 work for tests
using check_describe(). Any objections?
