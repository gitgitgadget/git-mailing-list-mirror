Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 434811F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbeHOAVs (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 20:21:48 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43857 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbeHOAVs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 20:21:48 -0400
Received: by mail-yw1-f68.google.com with SMTP id l189-v6so17347764ywb.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6H+OOoW4a3tKHt07zo+zOoZCMHoFwKjSzUMsboLV5JQ=;
        b=s/BhT+rBBT/M1GXTm1L35snSliVzK91IRWbkzV1eaf3w2/r1tks1NtwgsCq3mtsfQz
         mzNKnEofPq2O8/YD7e2a1GDa+jDrz9z+n1trCzbRBziimAdLVcWfhnkNZkpqi3Bi1AEG
         DTy55qayr/uUYkVzLKxouFnDE0B0GIiZwMxE2stEnzAfM+WBuvxwzHBg/NCda7UQQkLq
         cxX3LRomcelPH6UkODqGCLaLeUB4mZLQwOaRgiiNIGlvtBAiTkqx1iWVRqkelaZGz95N
         e3cQvzrI9M9aQLzrix6qXUsiv43/1HkcvINDEEl8LJCWXloCtrkBIACaSIUtOvNYo6Bj
         vSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6H+OOoW4a3tKHt07zo+zOoZCMHoFwKjSzUMsboLV5JQ=;
        b=joBuIqUI9BK76sX9WiWS/QiwGEnC1WsUM8Y8ACw/0WdvaFMs2j0qQPG0UQ26UKjZjX
         9jqM1ztNa5LGBzOMV9AWJkcfxvRaOlj0gBllUyCp+RdndPvxYKyEBsNhODKgY0zLkeNm
         Sb0pIaG5x4HApiUYyrzzA0OiKs6xhAab42EAHqecPNRPzIP3NGzv/yubBA6Zi9dnIawG
         FkQLRnyYmlzbP1EmxzZfvGeLH/6ZjgC6RF4EZgFUaeSQewnxOtf9OYWLs4iOUachuYwe
         ScMEEwy9UU1e9CI66qp1a1fCQXbtI6c4u9HhUhhjbnnNsrKadPPKyReJwZTVfGoVXHpz
         lWug==
X-Gm-Message-State: AOUpUlFWpvhVgzV+ortXVuClVBr9S9w+6G/CIleBISLPeqAx0UokMdFZ
        pWjFAQpDCwARCTN2OgWl2xKAKyim+tooENGaPOYfPw==
X-Google-Smtp-Source: AA+uWPzH2HP1t3q8QTIRCHVIx60Id/EBtHad2ASh28cSvoGUUD5CdNGwdF3uFVLma75WNJy6c9tCkiB0nl9VPsr5ryM=
X-Received: by 2002:a81:37c5:: with SMTP id e188-v6mr13368755ywa.340.1534282361363;
 Tue, 14 Aug 2018 14:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180814185906.2680-1-avarab@gmail.com> <CAGZ79kaK8Wt0TGvo-PyDZRLWr9PU0BRo4=DiYUXvv8c8nZ+M8A@mail.gmail.com>
 <87d0ukhd5g.fsf@evledraar.gmail.com> <CAGZ79kZuH8DKkoNb3AgHFxwYccOGHeVWOE7ov5QvavtomSxyAQ@mail.gmail.com>
 <87bma4hcnl.fsf@evledraar.gmail.com>
In-Reply-To: <87bma4hcnl.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 14:32:30 -0700
Message-ID: <CAGZ79kZq745X2PjRpGJGWdnd+HJtPuwCnJUcePXtRoLkaTWrsg@mail.gmail.com>
Subject: Re: [PATCH] submodule: add more exhaustive up-path testing
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 2:16 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Aug 14 2018, Stefan Beller wrote:
>
> > On Tue, Aug 14, 2018 at 2:05 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >
> >> > So ideally we'd also error out as soon as the host name is touched?
> >>
> >> Do we have some utility function that'll take whatever we have in
> >> remote.<name>.url and spew out the username / host / path? We must,
> >> since the clone protocol needs it, but I haven't found it.
> >
> > Nope. Welcome to the wonderful world of submodules.
> > As submodules are in the transition state towards "in C",
> > we could do some refactorings that would allow for easy access to
> > these properties, but the transition is done via faithful conversion fr=
om
> > shell to C, which did not have these functions either, but could just
> > do some string hackery. And that is how we ended up with this
> > function in the first place.
>
> The remote/clone machinery is in C and so is the resolve-relative-url
> helper. What's the missing bridge here?
>
> Maybe we don't have that function yet, but we can presumably expose it,
> and this seems unrelated to some other bits of submodules being in
> shellscript.
>
> No?

Gah, I misread your original question. Sorry about that.
