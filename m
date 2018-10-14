Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5711F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 12:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeJNUOc (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 16:14:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38710 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeJNUOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Oct 2018 16:14:32 -0400
Received: by mail-it1-f195.google.com with SMTP id i76-v6so23940565ita.3
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 05:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0a/qNpej46fvxXODj6/OrAIx9QCWdEMzb3Xa4R62L5k=;
        b=EXJUNcudqyKk7/5pyEHQq4G0tS/0KTc/xXoBRKTr2lbNi4dDPpIhsKuL0M+4ENzRRW
         DLgPjwCh9UN1VHq1paXBm1uiyASn+L3mIvAjz/tJlzewL0vGbGx5OJECM6BagGZdiYQX
         kw20MfouNNDjiX0hrfosNGIaMnLVIkAok1qy7XYbe9jWaj2l8FKN5OQlEFLBxdA/b/rE
         4IbjRFDMOj+dpWsi/AcwkVWOs8o354xySlBL8atkRqKJOFzBZO1t438vANU3WVNDI1lQ
         J4Wu9buUTCeUuvH263Id5AhkQK4zbjrl9gPf1HpLFrrhx4fbMBkLknt5nNdLmJRXR9kk
         HwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0a/qNpej46fvxXODj6/OrAIx9QCWdEMzb3Xa4R62L5k=;
        b=P3+8lGP4gFLbnX7MkbPFP9IO/57U/siGzS21fviEpU/IIPX6CCpcZOdPZx9wky2c+T
         2pCkfSGSfVRA4Or79Row81v/2F/7fnEdKI/JllRzaRQm9Nkqu860U1FNH1Hi1OoknEzC
         g2TnFHkjmZ57qT0LBVVriJjGepqP8G5guJPTyBL6a6yLyZfGLBSyTUf3LwdnTzNZMht5
         pQPLIYaRqeXAt1iBGYtQJxNhlsJ4mNdPSladARk35+5wjboLv4+ovRi84mplxEvju+5T
         1Z6pCcKSpJrwiNTflKPt3dTF+EQ22QMmNp5B9D+D/wGTPRkQ3+URJzyW8TsuUpZit1HC
         zZFw==
X-Gm-Message-State: ABuFfogk8dPC4nmGRwV7yvATwUxOhXTIQ9enWT2JUiDWZCvDCikACLLI
        INgLegA9toKid1QQwHTiBNJCt+gMnmEj9FPvykEubg==
X-Google-Smtp-Source: ACcGV63X1V80NUhLQqyb3oA6+13xDZ4OQI9utSlwE7Mbcrlw1cMCKjD8ePO1KyL7QkEQ6HWg1OKUcesSw/6JQpFtLGE=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr9950982itg.70.1539520419205;
 Sun, 14 Oct 2018 05:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180915161759.8272-1-pclouds@gmail.com> <20180921155739.14407-1-pclouds@gmail.com>
 <20180921155739.14407-18-pclouds@gmail.com> <20181010145116.GA11772@sigill.intra.peff.net>
In-Reply-To: <20181010145116.GA11772@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 14 Oct 2018 14:33:13 +0200
Message-ID: <CACsJy8AF4ZqL67NyuAbjW=M=0-Bhuh6j+DY8ACbRGauWL81T=A@mail.gmail.com>
Subject: Re: [PATCH v5 17/23] userdiff.c: remove implicit dependency on the_index
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 4:51 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Sep 21, 2018 at 05:57:33PM +0200, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
> > diff --git a/diff.c b/diff.c
> > index 140d0e86df..5256b9eabc 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -2093,23 +2093,25 @@ static void diff_words_flush(struct emit_callba=
ck *ecbdata)
> >       }
> >  }
> >
> > -static void diff_filespec_load_driver(struct diff_filespec *one)
> > +static void diff_filespec_load_driver(struct diff_filespec *one,
> > +                                   struct index_state *istate)
>
> I hadn't looked at this topic until today, when I tried merging next
> with some of my other local bits and ran into conflicts. I found the
> idea of passing index_state here, rather than the whole "struct
> repository", a bit curious.
>
> I get why you're doing it: your topic here only cares about removing
> index dependencies, so you did the minimal thing to move that forward.
>
> But if you think about what this function is doing, it is quite clearly
> dependent on the whole repository, since the userdiff config we're
> looking up may come from repo config.
>
> So I think in the long run this probably should take a repository
> argument, and use r->index instead of a separate istate argument. That
> said, I'm not totally opposed to taking this incremental step and
> letting somebody later sort out the config portions. I wonder if it
> would be worth calling that out in the commit message to help that later
> person. But I guess it is a bit late if this is already in next.

Maybe. When I made this series, I tried to reduce the access scope as
much as possible. If it turns out it needs more, we can always turn
"struct index_state *" into "struct repository *" later,
--=20
Duy
