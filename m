Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96592211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 18:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbeK3FhS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 00:37:18 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50661 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbeK3FhS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 00:37:18 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so5201953iti.0
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 10:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxSHrZGsRQWLtjGJIe8RuChE8L9SvzojK3cy5TPE96c=;
        b=OBlzEyocwj1eoiRpdxSOBs+Eya2zMMqfYVaN7Mp7ISkbvT4MgiptHeBn8cf56c61yY
         f0Rzok4HtOA5yGpwDe648FmdmwnolZYyxnUCSkz2lRGA9GEUfTNy1GDuBOWwpQM8GCrt
         cCVDL5KEyZgQ08+lWInLu5BqrZ3I31enAa8PjG2q0QsMr1dePyWrXJRMQrpvVYp6l5Or
         x3EY0KVrhJaeUpM9+0xXlxZK9M69KsO0EKJ8CuzWhwcFrSBYZ6REGsMuztAtxOq5D9mR
         ABBw6/ukv/GVV/c1bQvyInUE5ARqBzIGWZ8lFEynWP7uRzP374KhTXBBP4eY7eTanBlX
         ok+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxSHrZGsRQWLtjGJIe8RuChE8L9SvzojK3cy5TPE96c=;
        b=XQYRpsyeh8lTKXtUZB/RZTrhIXvnQp5yBv107OtK8e/+48pkatsdB58aqxx1r7UJlN
         DobcDOP7vnKQuRoiN0OBPKOczZYSQd7hOPni0ku7u8Baj8pjelWBx3GjmEegu6z/wBoZ
         /M8PteStLV6XONtldrkOWF0P9fnhcj+SEve8+nXtGTDJx2wFSQjH2yS8z1xDS07kK2so
         KCwjPris/+9FqoQws8IqkQ+voXs5yZrKiNwaxAMNebqVPD3a08X0yP3fUc67SEe6JvNN
         OS+CKkzuPqeTow3jzv4THOLIcmuguIHf5EVxmeHG9LTsp+Sgk/Hw7F6oU4sO6KHedLkF
         UKDg==
X-Gm-Message-State: AA+aEWYGHQ1jzmwjd+kkfzC8hIdqRFQFICMxgaDrv7f4jNu8Q3Od55/S
        Zm13eeg+l/G3z6EbjYXOByHb1rZ1/BsD6Xzcams=
X-Google-Smtp-Source: AFSGD/VcQc3I7PKYI6WM2XdLFyTbuOYw/co8quFDoM+X9aeOzB4hdxZnuudZ2Txzt/89SaIVLQm0K3CcZKxamq9G3rk=
X-Received: by 2002:a24:f589:: with SMTP id k131mr2214839ith.10.1543516260349;
 Thu, 29 Nov 2018 10:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
 <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com>
 <CACsJy8An2n5yah1UTCJZoC5ucSpCoM0vrXtEXnjg-di7jQZwLA@mail.gmail.com> <CAGZ79kY2Fu_3b8MnO-yV_JhevZRgx7=6ndX-N_R2HdJGByciHA@mail.gmail.com>
In-Reply-To: <CAGZ79kY2Fu_3b8MnO-yV_JhevZRgx7=6ndX-N_R2HdJGByciHA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Nov 2018 19:30:34 +0100
Message-ID: <CACsJy8C8pf=VQk54svj0ahQ3Uhhf_-FeGxUfBQofAcnDUzQzMQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     Stefan Beller <sbeller@google.com>
Cc:     Stefan Xenos <sxenos@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 7:14 PM Stefan Beller <sbeller@google.com> wrote:
>
> > > Idea:
> > > If git checkout-files modifies the submodules file, it could also
> > > auto-update the submodules. (For example, with something like "git
> > > submodule update --init --recursive --progress").
> >
> > This one is tricky because we should deal with submodule autoupdate
> > consistently across all porcelain commands (or at least common ones),
> > not just checkout-files. I'd prefer to delay this until later. Once we
> > figure out what to do with other commands, then we can still change
> > defaults for checkout-files.
>
> checkout/reset are respecting the submodule.recurse setting for this
> already, and as your patches only change the UX frontend
>
>     git -c submodule.recurse checkout-files <pathsspec>
>
> would also touch submodules. Given that deep down in
> the submodules it's all about files again, we could think
> checkout-files is still a good name.
>
> I think Stefan X. is asking for making submodule.recurse
> to default to true, which is indeed unrelated to this.

Yes and I'm concerned that checkout-files now recurses into submodules
this by default but grep for example does not. That just adds more
confusion.
-- 
Duy
