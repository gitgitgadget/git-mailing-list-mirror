Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC39E1F464
	for <e@80x24.org>; Fri, 27 Sep 2019 18:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfI0Syc (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 14:54:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34196 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfI0Syb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 14:54:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so2696478lfm.1
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zb+LapAsVTIbmkqb4yLPK6tdJl8FE+nQJ34SW3NmR/o=;
        b=gOcux/rWS+EBtXUWZhdzCTcC7SqSiYKXGIfUadn31vq1I4hY9ACz5kEQvcUfKRoSDM
         3eLLuK7w868m+X7jw4UPSUH58pEC4SEgQj9EPW+ZPeYgxCMwWeP2MFOpKFznUVMxCnqj
         i0Xn2Srt3lltA2daFbCBBEcYQL97uO3+5KUZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zb+LapAsVTIbmkqb4yLPK6tdJl8FE+nQJ34SW3NmR/o=;
        b=Rksm0iS63nlvVsTefrVN6l7X9JEjysvY2aSNXI/J4RH8rfJgEoyJPgHLuW1w90K9Z7
         M7v/XDjbe79VeHE2kuF4UdUTB34hR4KwOH9ArPizTO5YfzY5zMUPd0ePZSP2s7CiW1pI
         ilO8GdJtTMLSem8tnOG+r+C0W8drLHRtvvAgDhm/x81VACGy8BJalJrkLHWCtem+RswU
         efX2eymhYKhnwuD1kBqyRhf1PPzhcD4nUGoeV/ELMQM1BEsDmAqFj6oOGhmaVP0/2htf
         KfjUAPn8rDyHiOPwVSFHXu6Lfx0+l/HGTyfivxSOQM98+mMv1Ar9VLgu5oZ0SHCwDDMh
         kuTA==
X-Gm-Message-State: APjAAAU/2YPNfI883dJ3ubyIWAttXc6q8j7tfKx7MPlJkYQ5fUZGfoCh
        q1T/bXfoX1lS/w/J4WGaWeFMU2k3oeA=
X-Google-Smtp-Source: APXvYqykIOyIBWa2fUHhfWig9xAj57m5+19b4JbHk2kNhvizMFXg+3FMnT3gzbbJ2Nnafn8s5NX0pA==
X-Received: by 2002:ac2:5196:: with SMTP id u22mr3895559lfi.130.1569610469379;
        Fri, 27 Sep 2019 11:54:29 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id v1sm625615lfe.34.2019.09.27.11.54.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2019 11:54:28 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id q64so3459223ljb.12
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 11:54:28 -0700 (PDT)
X-Received: by 2002:a2e:3015:: with SMTP id w21mr3981150ljw.165.1569610466807;
 Fri, 27 Sep 2019 11:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190907045848.GA24515@sigill.intra.peff.net> <20190907050132.GA23904@sigill.intra.peff.net>
In-Reply-To: <20190907050132.GA23904@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Sep 2019 11:54:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk5c=zKVb_EbB5FWyNGD6d3GW8ayB3=2Boo83uq7JBiA@mail.gmail.com>
Message-ID: <CAHk-=wjk5c=zKVb_EbB5FWyNGD6d3GW8ayB3=2Boo83uq7JBiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit-graph: don't show progress percentages while
 expanding reachable commits
To:     Jeff King <peff@peff.net>
Cc:     Git List Mailing <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was going to make a bug-report about this funny behavior, but
decided to search the list first.

Yeah, I smiled at

    Expanding reachable commits in commit graph: 139276% (870481/625), done=
.

when I did the "git gc --prune=3Dnow" on the kernel, and apparently
actually looked at the noise for the first time in a while.

So I don't mind the bug, but I think this should be fixed. Because
almost 140 _thousand_ percent just isn't right.

So Ack on this patch. Looks like it is already in 'pu', but hasn't
made it into next or master yet.

                    Linus

On Fri, Sep 6, 2019 at 10:04 PM Jeff King <peff@peff.net> wrote:
>
> From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
> Commit 49bbc57a57 (commit-graph write: emit a percentage for all
> progress, 2019-01-19) was a bit overeager when it added progress
> percentages/ [...]
