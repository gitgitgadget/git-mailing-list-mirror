Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D6941F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 19:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeKQFar (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 00:30:47 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37295 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQFaq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 00:30:46 -0500
Received: by mail-io1-f65.google.com with SMTP id a3so11188849ioc.4
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 11:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEGDvuhAGJeTRwq94fjs969yKUJq9a00IUKzSwmGKO4=;
        b=mP3kTAujaXX3FKmt0K2DvEFZVHaJqjAB2cVRbl/gOE+nXwA6FxQQ0JXxq8g7e21UFk
         ESboUvb9r0c2X8OsrX8QctIchOhpYQjawrckxDldtXmlQEhiWV1FEOVDlpmxChk6NhhS
         yBq5lf+YrXNzyowo87RScJwZmE4FVRCgUxq806adZjiCcmYFDZl44TFEzKRyEQufZgz/
         EaLmBX+U2o0ZYN/mWsqaA+uIaUf+gkMTFvJZsztNacW2HhtgytgBkXZz8F2aaeZBqk8u
         fdn4qIt2mdRW+vAX53nJSWnfEdwyRBpg2K2AqxXzUmjj4OJEJYLGpqWc+1E310AY8X5J
         0VHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEGDvuhAGJeTRwq94fjs969yKUJq9a00IUKzSwmGKO4=;
        b=nOVu2U4xZKKRLLtJQXUHCxcLNAP1W20zzAFKTn5NhjJ/Nc5tBQOOaEzOCJ5d3fSycv
         dRBZ8VE0KmCbTTnEkYM0BgbURN3scZSzv8Jpf1q1L3T3fzryimJZGvke6IACg199TGXP
         nf1IUHYUSaqUIYXxXTMtGhAhi1mHr4R38l6pccGjQDOCvaEKyzr+EeJ07Li7PmkFhCnM
         jrClnLaM/JuqaEp0GMa3kmEkwHf+qpgcZWOSHO4oDmCthIwKOVbQM1buh3T7sID62NRp
         rod6NYjDSxKuXdtQUfzJ7xwXJdZllQOfiaKDSehBcgiaUNtlXPTz02wymiLImAkxxgPf
         C3xQ==
X-Gm-Message-State: AA+aEWbVtGO7dGzUTsobq1s0yzl61uQtGguWksva438bSuPU9Rcz+XHs
        8p9Nt8AE/d2CiYNRxyEf3Of37gVvB8Boi0bvWL0=
X-Google-Smtp-Source: AJdET5c3M1j1QWwbz+febO7uQfbYWMqSvn5GtES5Bh4tyqIBEiUQ5rYHCOz8DmOFPTApF7M3sJu0pkxqOlbnczhV6u4=
X-Received: by 2002:a6b:242:: with SMTP id 63mr9795251ioc.118.1542395827681;
 Fri, 16 Nov 2018 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20181116173105.21784-1-chriscool@tuxfamily.org>
 <CACsJy8Cdk8YQWJM1HAFYWB6qJpepNQoj86yrTqF9Rg3oN0TeUA@mail.gmail.com> <CAP8UFD2Y4dC4GfjgPDtR3gyrG_3hOvn-bRHMDNVSutaCF49i8g@mail.gmail.com>
In-Reply-To: <CAP8UFD2Y4dC4GfjgPDtR3gyrG_3hOvn-bRHMDNVSutaCF49i8g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 16 Nov 2018 20:16:41 +0100
Message-ID: <CACsJy8ACgDq_EkV5-d9jPiy4LEMuzK8EDdgsdSANsQu=U9TZgQ@mail.gmail.com>
Subject: Re: [PATCH v2] read-cache: write all indexes with the same permissions
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 8:10 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Nov 16, 2018 at 7:03 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Fri, Nov 16, 2018 at 6:31 PM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > > diff --git a/read-cache.c b/read-cache.c
> > > index 8c924506dd..ea80600bff 100644
> > > --- a/read-cache.c
> > > +++ b/read-cache.c
> > > @@ -3165,7 +3165,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
> > >                 struct tempfile *temp;
> > >                 int saved_errno;
> > >
> > > -               temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
> > > +               /* Same permissions as the main .git/index file */
> >
> > If the permission is already correct from the beginning (of this temp
> > file), should df801f3f9f be reverted since we don't need to adjust
> > permission anymore?
>
> df801f3f9f (read-cache: use shared perms when writing shared index,
> 2017-06-25) was fixing the bug that permissions of the shared index
> file did not take into account the shared permissions (which are about
> core.sharedRepository; "shared" has a different meaning in "shared
> index file" and in "shared permissions").
>
> This fix only changes permissions before the shared permissions are
> taken into account (so before adjust_shared_perm() is called).
>
> > Or does $GIT_DIR/index go through the same adjust_shared_perm() anyway
> > in the end, which means df801f3f9f must stay?
>
> Yeah, $GIT_DIR/index goes through adjust_shared_perm() too because
> create_tempfile() calls adjust_shared_perm(). So indeed df801f3f9f
> must stay.

Ah thanks. By the time I got to this part

> Let's instead make the two consistent by using mks_tempfile_sm() and
> passing 0666 in its `mode` argument.

went look at that function and back, I forgot about the paragraph above it.
-- 
Duy
