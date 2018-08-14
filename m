Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136521F404
	for <e@80x24.org>; Tue, 14 Aug 2018 18:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeHNVkk (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:40:40 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36693 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbeHNVkj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:40:39 -0400
Received: by mail-io0-f173.google.com with SMTP id m4-v6so18244172iop.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gyl4ePX0mfJXP5euzrKmU9u1HkJHGus1TMr0hVi3v7M=;
        b=vDpjpqdzY0Y8nex/b8V5ZbYO5oqAKGMw0OrABVIDU+dWIeNe9ApvZmQyeSJZyTVh8v
         DYibGLhtHgb16lc8Pc7TY0xCrQ3FyEl0pJchXFOsNYsScgOjkXjNVqV7IC29cFcz/BjF
         jpBY0UlO/DbVkeciViC0YCoG7NEJdZ9FwAu+p7GCHK1Sjy4weCbYiL4TmvV5LV7BsHJm
         VxHV1ZSJucaX8ArcOaKtvmX5icZeHoxdKvN8/FqHIzx4F0j8X1JxSsfTGT4jpxzYJ6zr
         n82+j0zCcittCgbs9gKSBt65ENwqC2TfbFz5E1Fr6PXY3JIB/dTIBLccEjO9QBFizn6D
         lxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gyl4ePX0mfJXP5euzrKmU9u1HkJHGus1TMr0hVi3v7M=;
        b=FyV6WZjn3mZRp8H8l0pbSo9IJRy5EpGfZVgIl8x0EQ1v2T64mXDuSK+dmeNeQBn8jp
         ghfl9anA+Y0Mw5SXw5D4R3bCMMa8ECy2wSNcGtMIZdvovbJkWQ7+tU4GZKH3hPoLNCsd
         xbL4XXtwALUDTVJEwdELCRy6npI/BhYPJSojfghFgGqB2MG2/+qrP/VSj3j1ASNzBwEg
         mnVJ4/EMF+8YZYz7eIN3Y/JbzERTU/ow5Sdj7TsMNj95zIXukfVjw+nqx6GaNOpPAlj/
         746dhIMMyIY7QDBO+/lB26JCQs4jUmYsMtC92zzQ7p+t+7MjAH3rlLvLUuEfbupJ3i63
         uKjA==
X-Gm-Message-State: AOUpUlGqWi0ngaHJbAAJLBZqxWW2wdrFiZHUtMzbC/5TZvis4SNxlL/F
        yn8kKBqmtNJYuB+ypmBnAN12gaKWmR3RUd59Q58=
X-Google-Smtp-Source: AA+uWPymwYtv0jdVxJA913kaj7b8fl6o6zXI1uS3H4ohCijDOs8TzsOxPcPUXyqayjua6JIzz4Fd4SHzaVu0AW3ANUA=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr17867650ioe.282.1534272727419;
 Tue, 14 Aug 2018 11:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com> <20180813192526.GC10013@sigill.intra.peff.net>
 <xmqqk1ot3n4h.fsf@gitster-ct.c.googlers.com> <90d1bbf7-91a3-74ac-de65-1eb8405dc1f7@jeffhostetler.com>
 <CACsJy8DQmOCD2a5QFUiyPuoPZLq-QEejLhWACKpsJLvK5ERAMg@mail.gmail.com> <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
In-Reply-To: <CAGZ79kZwVpCBMkBKuYpwZFgAN50wZub_fyzWrAsE=ksuc-aCgQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Aug 2018 20:51:41 +0200
Message-ID: <CACsJy8CTNeR8Bchj37yNL+mWp1Y5rhD6QV2Gf06CPLHVXd8TDQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <peartben@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 8:44 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Tue, Aug 14, 2018 at 11:32 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Tue, Aug 14, 2018 at 8:19 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> > > I'm looking at adding code to my SLOG (better name suggestions welcome)
> > > patch series to eventually replace the existing git_trace facility.
> >
> > Complement maybe. Replace, please no. I'd rather not stare at json messages.
>
> From the sidelines: We'd only need one logging infrastructure in place, as the
> formatting would be done as a later step? For local operations we'd certainly
> find better formatting than json, and we figured that we might end up desiring
> ProtocolBuffers[1] instead of JSon, so if it would be easy to change
> the output of
> the structured logging easily that would be great.

These trace messages are made for human consumption. Granted
occasionally we need some processing but I find one liners mostly
suffice. Now we turn these into something made for machines, turning
people to second citizens. I've read these messages reformatted for
human, it's usually too verbose even if it's reformatted.

> But AFAICT these series are all about putting the sampling points into the
> code base, so formatting would be orthogonal to it?

It's not just sampling points. There's things like index id being
shown in the message for example. I prefer to keep free style format
to help me read. There's also things like indentation I do here to
help me read. Granted you could do all that with scripts and stuff,
but will we pass around in mail  dumps of json messages to be decoded
locally?

> Stefan
>
> [1] https://developers.google.com/protocol-buffers/



-- 
Duy
