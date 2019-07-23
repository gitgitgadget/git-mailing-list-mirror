Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9151F461
	for <e@80x24.org>; Tue, 23 Jul 2019 21:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391874AbfGWVBX (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 17:01:23 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33105 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389103AbfGWVBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 17:01:23 -0400
Received: by mail-vk1-f196.google.com with SMTP id y130so9014581vkc.0
        for <git@vger.kernel.org>; Tue, 23 Jul 2019 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hnc7u97WMdFBmnKkRvj7BkyI5iJKxohF++KC+hkzEyE=;
        b=Qcz4gLslFyx/AgjxniNBxfjt6epc0HP4OJqVT+Q99YnujDhr5yGGu6Q6cGgh+ILg6h
         ZETiyvAxZNkWfA2kKR8r1A5pcfYqmr/OGxGKUC2vRCMVI7T3p2BT22b344ttCHuwEWP0
         dSi1ssDbJVvFgx+HDYc7E8fPZ7TZPj6x3lawNqZw2+O4JVnuV70MInuQ191yRw7Qb+5K
         nXRo0z9CpxbkhYGNu/I74KN1lcTqXC2Gr96riWhN+/oKUBPr+FboqV85MozwG0ZxPpER
         QX78DijOW2vBVBC4HTs5j2W9f9R4+YMXPjcc8gK7ZEdOPAnTSriWwc17hpRXSBiGq+gG
         z+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hnc7u97WMdFBmnKkRvj7BkyI5iJKxohF++KC+hkzEyE=;
        b=FRerkixABM0ZdLNdv9jWhwm79/d86gGL2c63z6eaI74gcffuUsHdhc/KwvOx+xwyjh
         t17UbGoqb3eHCPhIoKU5ZdOD8y/jx4EgDZv/mPZcY5iwUq5eAQWNtyAqome9mSJCEKfI
         xKeVf7xQ0DNZpv1EOyKZMjBvA0bvAvPRvMBFzg5VE8TmBmvpbvirYR7gYGpQr1xwRi8L
         bsBhEwIOU00rJxoeVpCgaQmDBlehGid/M3HqFAkVta9CuCRkfiTkHyE3xyONNaFkAyIj
         upTKbJui3Kh2dNi6vF1V6nGIX6HL34XeFwqROVe9vaIdsvXfx7WEAfEDoaSHcMVpNphb
         qWmg==
X-Gm-Message-State: APjAAAXttdiarwcLMIBnL9yS4ZPqbl9UG2z9hspgjRplPKvkfaG2XODr
        wf0lO2lDjhY1pNjZF7czLQgWYMBqM2WjebWL7Nk=
X-Google-Smtp-Source: APXvYqw5XWIG+uFMJK9FO2ff/9+HEMtiq1g8biadcpnho/PTVSWNAnu/u/OACDJhxx2GaPx5Ait7kVDDFvXlRjbv+bo=
X-Received: by 2002:a1f:8513:: with SMTP id h19mr30089802vkd.92.1563915682087;
 Tue, 23 Jul 2019 14:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <6e61e65e-53c2-eb49-2197-03fe9796ef1f@gmail.com> <20190723195820.16856-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190723195820.16856-1-rohit.ashiwal265@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Jul 2019 14:01:10 -0700
Message-ID: <CABPp-BE1=FB3LXAZP+i0Mj2OZQ7kTx2s3S+fZR9Y7EAg8KhqRg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 1/1] rebase -i: add --ignore-whitespace flag
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Phillip <phillip.wood123@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio <gitster@pobox.com>, Martin <martin.agren@gmail.com>,
        Thomas <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 23, 2019 at 1:01 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
> On Mon, 22 Jul 2019 11:00:40 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
> > [...]
> >
> > > @@ -489,6 +501,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
> > >             { OPTION_STRING, 'S', "gpg-sign", &opts.gpg_sign_opt, N_("key-id"),
> > >                     N_("GPG-sign commits"),
> > >                     PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> > > +           OPT_BOOL(0, "ignore-whitespace", &opts.ignore_whitespace,
> > > +                    N_("ignore changes in whitespace")),
> >
> > As with the other patch is this actually going to be used by
> > rebase--preserve-merges.sh?
>
> I added this just for the completness. Is there any discussion on
> dropping rebase--interactive as command and may be lib'fying it while
> deprecating rebase--preserve-merges?

preserve-merges is already deprecated, see
https://public-inbox.org/git/pull.158.git.gitgitgadget@gmail.com/ and
the output of:
   git grep deprecated -- '*rebase*'

It's also instructive to take a look at
https://public-inbox.org/git/xmqqk1rrm8ic.fsf@gitster-ct.c.googlers.com/,
which talks about how git-rebase--preserve-merges.sh came to be; from
reading that, it looks like the whole point of making
rebase--preserve-merges.sh a separate script was to avoid the effort
needed to libify it.  As such, you probably just want to avoid
breaking it or even changing it at all until it can be deleted.
Anything that only the preserve-rebases backend uses (such as direct
invocations of rebase--interactive, according to what Phillip said
elsewhere in this thread), are probably better left alone as much as
possible, with us instead documenting that preserve-merges lacks any
new capabilities you are otherwise adding to rebase.

Not sure if that answers all your questions, though.
