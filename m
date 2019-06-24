Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423221F461
	for <e@80x24.org>; Mon, 24 Jun 2019 09:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfFXJgE (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 05:36:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33502 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXJgE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 05:36:04 -0400
Received: by mail-io1-f67.google.com with SMTP id u13so179000iop.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=blD6sn5yC11ZUQgsdDD51MheitiBbJVjfdkmmE05zRA=;
        b=EwGVB6pwhz2KXSj9kt8VQ0IkfDdIDzUTd6THlaiJehQKzxtgdciTMeqwFim70nsddM
         1nLw8bNn8OGCMPBIypcjtUqj7QlnJODvaWA3hJEHSsuy5gGLVSmcrq/UxiauBq4JHFKn
         SCcTxRevRIvCtjQuOodi/xwfKRUepjggGBOkMto0dvLINt2whEVidSwdDs3pKWXS0eGw
         GcG0GIdJKfHV3UUrWO8J5yNUoSQT4bZH7oK6Kt6EuL340hzvRru15CwrDJr9JRI92Jxr
         /924sV6O/q4YqS1tKrQcWK5gxpPm9zlaF2hkdvTFNZyM76x99SvTAdfcMcWWqWKtydpB
         Tgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=blD6sn5yC11ZUQgsdDD51MheitiBbJVjfdkmmE05zRA=;
        b=WxxhX9vCGnbshmsQRS77RtpKzV1vAYmw9aO/apDII7OE1ZqPb7CNeb8UJfovIRw+3k
         tZWll556tDBuOjp3czdlHX1WDDplTS5iK3j1+5FgcPv+GlDMGShOTAaQ2aqre3cG/mlP
         EwgPWuGgBCSh4CppzmMgvCRRnPu9M9ZsLDoN4x/oce5QlwY030/6rHIgKVLQWNqpynth
         FdiAo8pWLwAcezr4Xel91ubwXpHG2Tun3RYfwdZ5z8x9ejC5Jk8aKb1YhJP/699TT0Yx
         I67zCahIaW8NJi+SXoQR3fT+Wj0UWzxBqFEuE+Od9A04zLz2fC6z/gKa+MOY4ykG+Vbt
         HEKw==
X-Gm-Message-State: APjAAAXQmrs9Uwm87JhEwENbj5i2UH4/APKRn1ds7dukcTyiN7EtMXt8
        Qyw+PodyDSd8ls/62DrKtHLY5UO0ixDMUycKgbYfUw==
X-Google-Smtp-Source: APXvYqy2ETyeLB2+fLoe7UYDkCw2Fo4dRlC5KKWCi+1oaWb2LwqvSbStzCsqs730LQ839BS7Ho2InN3GmQqoYkyC/uU=
X-Received: by 2002:a6b:7312:: with SMTP id e18mr11805009ioh.156.1561368963078;
 Mon, 24 Jun 2019 02:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619191709.GF28145@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet> <CACsJy8A=Vhwgv8cvs8s2f_aJ5W335s8CdqRQCDSFrdJu2j9fjw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1906241129490.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906241129490.44@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Jun 2019 16:35:36 +0700
Message-ID: <CACsJy8BtqiUx92=U8kTe_0LFv2PFkUq3BaBqhpLfx5tgBHENuw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 4:32 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> On Fri, 21 Jun 2019, Duy Nguyen wrote:
>
> > On Fri, Jun 21, 2019 at 8:16 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >
> > > > I think your warning in the manpage that this is for debugging is fine,
> > > > as it does not put us on the hook for maintaining the feature nor its
> > > > format forever. We might want to call it "--debug=json" or something,
> > > > though, in case we do want real stable json support later (though of
> > > > course we would be free to steal the option then, since we're making no
> > > > promises).
> > >
> > > Traditionally, we have not catered well to 3rd-party applications in Git,
> > > and this JSON format would provide a way out of that problem.
> > >
> > > So I would like *not* to lock the door on letting this feature stabilize
> > > organically.
> > >
> > > I'd be much more in favor of `--json[=<version>]`, with an initial version
> > > of 0 to indicate that it really is unstable for now.
> >
> > Considering the amount of code to output these, supporting multiple
> > formats would be a nightmare. I may be ok with versioning the output
> > so the tool know what format they need to deal with, but I'd rather
> > support just one version.
>
> Once the format stabilized, I don't think it would be a huge burden to
> support multiple formats, if we ever had to update.
>
> It would, however, be a huge burden on third-party applications. In
> effect, we could be lazy, but we would put a lot more burden on others
> than we saved ourselves, so that would be a bit... selfish.

JSON is the land of high level languages. They can adapt to new format
quite easily, compared to restructuring C to support multiple
different formats. Yes I'm quite OK with being selfish in this case.
-- 
Duy
