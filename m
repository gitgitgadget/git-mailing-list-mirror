Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C741F453
	for <e@80x24.org>; Wed, 26 Sep 2018 15:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeIZVcx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 17:32:53 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35440 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZVcx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 17:32:53 -0400
Received: by mail-it1-f194.google.com with SMTP id 139-v6so3378059itf.0
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 08:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PSuG5evoYuPiSMF3A6DiDcxzj/jben8pwDq8mwIJ73c=;
        b=OjM9VeH8ZBUKx5wQBpOXBBzNLEkKtDKlD+CtxvmJP3isRtqKNPyhvlsIaUsyloj8ih
         TXMF4/fK34MGnSIIT9a/lXScu+deVTBlVEHmoZYcNoNvz+9PO+7NKMVYmH4SN04bJzV1
         RUYRuLkB6Ggk8oSsuq4+elCQ242rxUZCjd9ykp4PkRETceYJlS9WmOGFqtsyB0i0hO2u
         oRVfN1CzD1TQRpBX+Ob7r5SKwHY5Icbp4EjOOwHSiesTeakofhuXowWLQ05opEVInKbm
         mc6dvdIhdW8Bcb479yYyOj1lXlxv3jC39jmE3+YLIo5R0kT5DgSpe+Qr1e8g85I15Z4y
         BEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PSuG5evoYuPiSMF3A6DiDcxzj/jben8pwDq8mwIJ73c=;
        b=tfjC2xhbcZmk0bRGX59fczXH2T9ZO3OcBittFoc5IapZr+8FiCThmE9mED+mTuDOK7
         6VoB+G3WEbx3gh6rRIRY3ewD6potWAyUjeLrSRoM1u0DzH9NmeQSpV92fZ/w7rG9rMzC
         JV9lskYWpSrXaHVDjaMY5R96JVDAaIsSVAWIrXNi2zHFzx3zMXs3nLLF0FzmQgWN6JlS
         qGTcveV4f/XVxXvA36izoe+juGPAswrNrhaOhBTj4O6/z+0AS5AttFchB2ap79XIEeHl
         TKGAbydPRIXCjAOK+XkyBNcK7lX+nZt5XAuBST2JuNNP09uGOQygcNRMAJwhMjwe7Abz
         pLWw==
X-Gm-Message-State: ABuFfoj6NOM9GoKwxh0AhSD15ZkGMcs6tQVP4sFoDeJkDqO2tnGnEX34
        ew0hyeghZgzaUmlfIumnfv6z1kC7j0PrAHC8qgU=
X-Google-Smtp-Source: ACcGV63+OJdoJMa+pk734V4zS2QUhF02gCw6VbnMlbpoB889gHVmTazklxh7hJJ3nB0MxX1LrQhtXNiB0RsSd2GZFeY=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr5491070ita.5.1537975166858;
 Wed, 26 Sep 2018 08:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk> <20180926143708.GD25697@syl>
In-Reply-To: <20180926143708.GD25697@syl>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Sep 2018 17:19:00 +0200
Message-ID: <CACsJy8AQbJPVNtcVEsLH-iiXw2TPABr3LsgZ779h3KMvR98yZQ@mail.gmail.com>
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 4:42 PM Taylor Blau <me@ttaylorr.com> wrote:
> > +
> > +             /*
> > +              * We use split_cmdline() to get the first word of the
> > +              * alias, to ensure that we use the same rules as when
> > +              * the alias is actually used. split_cmdline()
> > +              * modifies alias in-place.
> > +              */
> > +             count = split_cmdline(alias, &argv);
> > +             if (count < 0)
> > +                     die("Bad alias.%s string: %s", cmd,
> > +                         split_cmdline_strerror(count));
>
> Please wrap this in _() so that translators can translate it.

Yes! And another nit. die(), error(), warning()... usually start the
message with a lowercase letter because we already start the sentence
with a prefix, like

fatal: bad alias.blah blah
-- 
Duy
