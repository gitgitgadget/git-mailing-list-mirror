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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8361F461
	for <e@80x24.org>; Fri, 21 Jun 2019 13:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfFUNuU (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 09:50:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40843 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfFUNuR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 09:50:17 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so821613ioc.7
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1kmVapKpQMnljAeOz665f7ouoJcxPnAr+IZjQSDZ2Y=;
        b=ZokEgNDfO0rPNw8v1QTwQhXYkqWD6brGkwPeIVhstjH6vYVuvlyjaO9tJ8DdEb32TG
         c9Zv8226vQwrFtlQAkOjuwLlPMlsuSob/lOAr1IWVK6jsIHdCVWovh1iGGJtZvZ0LxuS
         biyPzkxV34/p6L5h+MfLq7fWpOO22YwTk2tSiJyeMoPsRT4KT+fedszHdWC9BL1PKpKO
         fl57UQ4MXdjM/a0VmyniHLSd3WAr1Anf1GaJ1oTys1GkQsDSAP0XnE0wfdoltMQIFoLs
         jW+FQPqGYO9eRUJQsNKZwXkHz42k1j5PoJtauYBvnIxhaQlYjlvVsJM5GcdBPrE14Yb+
         L7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1kmVapKpQMnljAeOz665f7ouoJcxPnAr+IZjQSDZ2Y=;
        b=ViH5jO3ZdamxYgHQwBzHq5nMYHFUrJOqk1Wy/mYs+D7xNHraeWGlJH/Vk09K/Xs1i+
         dp4VJLtWa4ZDQ+i3iwSfpr3+fU+yamQmGxGF7Qtqhk0Z5j5NwrzMcdU6ZKEkzI0S/Frz
         MiXlKhG/OQtNAW/AcA50QC7rTX/6lP0f0H8Pk38TAeQ2uT5+cdq0FPKLU4be9EnN9bBT
         oSMFiL0DY1KkdMMgC4D8UPWQfaWAjFYMoEGERzvDUhd8o/RRz+4gzX8/30XP2/V71Xhq
         zeSEGKcFXe7wMwG+Wggh/qIExpAaL3DXCMhqhaw6X1eGqLksMd27qLj/5tpT2xlvgaqO
         MkzA==
X-Gm-Message-State: APjAAAVuFpVJ60Wh3FTT08SKW1SuZbq7GWoblxWnenriTUGIw8XIsxz3
        xr4AmTQBIrrtiTTTbi+OM33lxJVpTZju+7zpHtc=
X-Google-Smtp-Source: APXvYqxSnLHXmyzpUoLCRf/G6AAu4Toy8bYJHDHY+dHEXZCoGG59fQ4rntttihH2euufKi9SJ2i4yLkFaJjIOjOt6cc=
X-Received: by 2002:a5d:8347:: with SMTP id q7mr40507192ior.277.1561125016502;
 Fri, 21 Jun 2019 06:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190619095858.30124-1-pclouds@gmail.com> <20190619191709.GF28145@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Jun 2019 20:49:50 +0700
Message-ID: <CACsJy8A=Vhwgv8cvs8s2f_aJ5W335s8CdqRQCDSFrdJu2j9fjw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 8:16 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> > I think your warning in the manpage that this is for debugging is fine,
> > as it does not put us on the hook for maintaining the feature nor its
> > format forever. We might want to call it "--debug=json" or something,
> > though, in case we do want real stable json support later (though of
> > course we would be free to steal the option then, since we're making no
> > promises).
>
> Traditionally, we have not catered well to 3rd-party applications in Git,
> and this JSON format would provide a way out of that problem.
>
> So I would like *not* to lock the door on letting this feature stabilize
> organically.
>
> I'd be much more in favor of `--json[=<version>]`, with an initial version
> of 0 to indicate that it really is unstable for now.

Considering the amount of code to output these, supporting multiple
formats would be a nightmare. I may be ok with versioning the output
so the tool know what format they need to deal with, but I'd rather
support just one version. For third parties wanting to dig deep, I
think libgit2 would be a much better fit.
-- 
Duy
