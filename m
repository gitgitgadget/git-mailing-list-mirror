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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DF931F462
	for <e@80x24.org>; Fri, 26 Jul 2019 04:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfGZE6z (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 00:58:55 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35413 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfGZE6z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 00:58:55 -0400
Received: by mail-vs1-f67.google.com with SMTP id u124so35290902vsu.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 21:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXTVXItrkRb2Zefgzpy5/8/1Bu527GtZg/M92TWkAkY=;
        b=Ampf8GOWUKu16y8X6pohs1ieY2v7l928iv01uqRkxSY/29iolRlmXai9bPKQg3632l
         tCFl7JaIve0CF1hq6jx6Zy+HupeyY8D4as+O9Jkra6+XFd4QtGGtPlbMhl97lb9/Qmfx
         r8+dvEIb0Xj5Q/f6C3y6dWrl60DuGk8noSWptKhFZAvu23/gRejzGSKbmNZRqVBa8UtZ
         0kgspY82W1pIM4Gjtb4zcAxkGf0CGRixcm37+YHWEhe4o0oX9FWoOuY3y9b3H4+VD/WZ
         nepHZeTyvrc06QztjUkQ3k9iRfv5iDnwJHops+gjKtlu9/qXJGbu+/KxwD30tLA30b1Z
         jDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXTVXItrkRb2Zefgzpy5/8/1Bu527GtZg/M92TWkAkY=;
        b=aaG307VBDP8+LV7SbmDEsV3MygsEZEI0s/oux2uVcDtBKPApmYQFST3CHNVJNtyQ3+
         JuN9gHTmu51GAgUySyFvUczNmDAo8KYgbaM/e3aP7r9B0HpuTqhyd2vf+ZchAvo+xuJ7
         +J+TkOK+FTpUwYQm9Rjys0EJTp36mC6wmw3IIzjAIol5cWoVK6jwyaG21b+Mlj2gyO3a
         610ZK0VEQ2ISM5ZWYIbG4Uuo3PaLQWVKQJn76KOLHSR0ov/BHnkx7QEk4NPaE3kz37dX
         GngBmss5c59jXznEDp5hqomlQxXD+VF87SL989QcXMY/GCAsbef/al+jJiTh5+Zc9/xF
         lqUg==
X-Gm-Message-State: APjAAAVNO63bOG8Jg9goEDZJAMWHX5es+tQyjgc6eh0/JpJYaFmARosq
        cWoqgrx2SJjnTHfudxLrKtfRX/dQb9XxfcyudvA=
X-Google-Smtp-Source: APXvYqxpfVUThORUgkne/8tLbq9XquQfh/nZH8F2XrmMvTfR/VKGocTrC+ApFL+pvYpvnSkUcTYukb3ZDzDNcYQyT5E=
X-Received: by 2002:a67:c419:: with SMTP id c25mr58697162vsk.136.1564117134398;
 Thu, 25 Jul 2019 21:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190725174611.14802-7-newren@gmail.com>
 <nycvar.QRO.7.76.6.1907252153530.21907@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907252153530.21907@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 25 Jul 2019 21:58:43 -0700
Message-ID: <CABPp-BHs47CQ8S72-Wq5SHr-BsBOA5tUcbTeYQupchz6Xi8T4w@mail.gmail.com>
Subject: Re: [PATCH 06/19] Change call signature of write_tree_from_memory()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jul 25, 2019 at 12:55 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Thu, 25 Jul 2019, Elijah Newren wrote:
>
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index 7f56cb0ed1..1a3c6ab7f3 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > [...]
> > @@ -434,11 +434,10 @@ struct tree *write_tree_from_memory(struct merge_options *opt)
> >
> >       if (!cache_tree_fully_valid(istate->cache_tree) &&
> >           cache_tree_update(istate, 0) < 0) {
> > -             err(opt, _("error building trees"));
> > -             return NULL;
> > +             BUG("error building trees");
>
> Hmm. Is it possible that something else than a bug in Git causes this to
> fail?
>
> I wonder, for example, whether a full disk can cause
> `cache_tree_update()` to return a negative value.

Yeah, you're right.  Based on the conversation with Junio, I think I
can modify the write_index_as_tree() function slightly to do what we
need, then call it instead of write_tree_from_memory().  Since
write_index_as_tree() doesn't try to output any error messages but
just returns various error codes, I can then have the caller handle
the output.  So I'll do that instead of this patch and the previous
one.
