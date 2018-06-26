Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A6591F516
	for <e@80x24.org>; Tue, 26 Jun 2018 15:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeFZPeG (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 11:34:06 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44506 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeFZPeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 11:34:06 -0400
Received: by mail-ua0-f196.google.com with SMTP id v15-v6so4323534ual.11
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LsaLVnbhQhpogGQLwBbcfhNqVf4KrwY9u1yOsaYa+d4=;
        b=vNcIF+yh2DViId2aOqzulfZo61yRvKWNnHazXi+RqgMxjjOJvTyQ9lp010sE51FDQt
         LJMJTc4ZL+oiVKKbESmhs79d9aZ6/1xaW8Kwb17izY4Y6Za9LoTDocpuCCitk1z2iz2c
         t/9Rh8Sio1uqXjfiRmc3l8xCdDSimvuSITqiC7CW9N6z+LY9fYRcjqjc0iQCOEkBSw+f
         fK+i/tM0wXca3yBs0ILDtO6SmDerWGqnIYaxh6tMloOKTjUtWu4Nx4WSl3fgZQpPEhMJ
         zEEpnQWmiI+WDJ/ahoxkOo+DMyr42X9+fTMQ/+vTGnN361oB6cyrMt2L4jcEiAIqDdgj
         33yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LsaLVnbhQhpogGQLwBbcfhNqVf4KrwY9u1yOsaYa+d4=;
        b=Zvx0mulkT1xiAZk26XpL/KrTI7hBSgT0Tb0WVWm1rqlr9xG8DlQEbQIlA0B5ufktV/
         F7lrz2FCLNZ4CmE+KVASzgg3NaI3AS2Ry/RVH1oIiWCBR9mA5xpCkldbppTl4rLu2Ylm
         towd0R54HVwtGxa4iGDx6eEXY0l2WqhAz0ZGm4EmI4sVVz7yZsFjI+94nCKE43a5wOpP
         8Tg4bdeF89V7mN5rS/dXQB7ZrLmcsEix/9vFMxDAEyrN/+WYhKfoSxfvs+e/XbcyfdMT
         AZR9yacr/Y6pOReMaw7sCUAg1XlpMtm6UDF6cJJ1c3OatCHvmj9U0nXEOXFwrFfErCjp
         pKEQ==
X-Gm-Message-State: APt69E10Wl7G85YNaU61mf5wwSmPEs9iwb3STeE5FNvsJh0sn9AtTcgw
        NZQ8YJoc8TjSQBrCJ9hZ1SJdlKNRZD1Ht7aUJwU=
X-Google-Smtp-Source: AAOMgpfx4woO/YH7zcjuigyOIBiqXiuYLkUa9wqV3kQlQ9tnKP+XX+oSro9EQ0+vOIwQOp/uq1/jvw2o4iSVngpkYoc=
X-Received: by 2002:ab0:57c9:: with SMTP id u9-v6mr1364195uac.94.1530027245032;
 Tue, 26 Jun 2018 08:34:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 08:34:04
 -0700 (PDT)
In-Reply-To: <CAPig+cRBN5-80HOvajG8WXqZUHmOX5SCrO93T9G4ePzgbGftZA@mail.gmail.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <CABPp-BEz=mLHsg1NizJUKxOKM=dKFSAVec=x0mcs=4cJ73k_+Q@mail.gmail.com> <CAPig+cRBN5-80HOvajG8WXqZUHmOX5SCrO93T9G4ePzgbGftZA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jun 2018 08:34:04 -0700
Message-ID: <CABPp-BHr52=Yg4Ugxmfw0=5XhOus2sNEMZ+wxzfef0sTFfU_Og@mail.gmail.com>
Subject: Re: [PATCH 00/29] t: detect and fix broken &&-chains in subshells
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, Jun 26, 2018, 2:31 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Jun 26, 2018 at 5:20 AM Elijah Newren <newren@gmail.com> wrote:
> > On Tue, Jun 26, 2018 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > Aside from identifying a rather significant number of &&-chain breaks,
> > > repairing those broken chains uncovered genuine bugs in several tests
> > > which were hidden by missing &&-chain links. Those bugs are also fixed
> > > by this series. I would appreciate if the following people would
> > > double-check my fixes:
> > >
> > > Stefan Bellar - 8/29 "t7400" and (especially) 13/29 "lib-submodule-update"
> > > Jonathan Tan - 10/29 "t9001"
> > > Elijah Newren - 6/29 "t6036"
> >
> > Commented on the patch in question; 6/29 looks good.
> >
> > I also looked over the rest of the series.  Apart from the ones you
> > specifically called out as needing review by others besides me, and
> > the final patch which makes me feel like a sed neophyte, all but one
> > patch looked good to me.  I just have a small question for that
> > remaining patch, which I posted there.
>
> I guess you refer to your question[1] about whether test_must_fail()
> is the correct choice over test_expect_code(). I just responded[2]
> with a hopefully satisfactory answer.

Yes, it does.  Thanks!
