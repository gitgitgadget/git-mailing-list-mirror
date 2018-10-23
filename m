Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FB11F453
	for <e@80x24.org>; Tue, 23 Oct 2018 15:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeJWXZG (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 19:25:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38155 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWXZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 19:25:06 -0400
Received: by mail-io1-f67.google.com with SMTP id q18-v6so1069822iod.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lk/oGvzpvFQklGUobX2lV9A+DzK9j+aPItGA1RkftpY=;
        b=M3JoSy4czO7113vJ0AMs0nw4/T2D+MJW62HDrOLmEboaf+DRkVQCR/5SCHnnm/8+uX
         hWcVQgEl/fxnUvANpcWu+YRs8zqgiiQdn4Fw7381/cWKvjyJL0kzhJ3UpQ6FNqGcj9vb
         EUVU/jm5lwVdoDD93qCQtMdNWeGeZQdEChbUDEdOveO+2e8eFU4jt7j/62zeu9ZPydDX
         A0nNoaH/WQsIQYeOu28yP4ExYKOyXVt99fIXrJ8fIBWPfcd/lK5AUeaCZhmvB6GGuNpx
         1zvWt671hFCXhEYkOQsZeHXCtlBjig7y5r8dMK2J4lBkzuGs+4GTNsPo+VJ/yeBpRcrB
         li1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lk/oGvzpvFQklGUobX2lV9A+DzK9j+aPItGA1RkftpY=;
        b=tntWDHJC/+LDr5c0VzRLicPu2fBUmfZPGFDdaQztVySRV6T/qqRot7CuOfrwKhcyCr
         Ot7jBrqF2fAkDQRYB5X7RxWbvq8+M4JzrLeOpYwTXjCPKRMtFqSYUVPGg9Ady17sq1cK
         Gc1fhe4zKUZVgwyUkbRXSx8oUuzv9h417Qz+SzGpuvgvb0rQkdltiA1OFIZIlge1div2
         s+xECMndNxkj1Lw7txCkhXxbv+4SMTkO/8B1ilZLQaU2s+SxFTCAbYh25791uFuglalu
         6fJ0PQn+kOguZeHUz19WF9+zkQLG2TmMjzW4lLc8eAZiQWoPJQUuzejCD2yP8k/S/Y+7
         Ouiw==
X-Gm-Message-State: AGRZ1gKIsKaq9I4undXt6jcdP8m7m7tGESbtJ8b77VT08mDBqusUFAGG
        Rxnj1VA4Mr4CVnwJtSlAsdLSrLjel1xLJoJ0ddU=
X-Google-Smtp-Source: AJdET5fQLuNY5uHCtnSvEDIAHzOIyTvZ9zFY51sDru16pM6xQX/ocClLx+8IIcqEeJt91ALY7rLX/yGFKLwapq3+Kvo=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr10570530ioc.118.1540306878901;
 Tue, 23 Oct 2018 08:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181022153633.31757-1-pclouds@gmail.com> <878t2pd6yu.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1810231126470.4546@tvgsbejvaqbjf.bet> <8736sxc6gt.fsf@evledraar.gmail.com>
In-Reply-To: <8736sxc6gt.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 23 Oct 2018 17:00:52 +0200
Message-ID: <CACsJy8CX78EbANbv8a354djJaO6dKRpXshHhHJTspJvOSewgpA@mail.gmail.com>
Subject: Re: [PATCH] Poison gettext with the Ook language
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 12:17 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Oct 23 2018, Johannes Schindelin wrote:
>
> > Hi =C3=86var,
> >
> > On Mon, 22 Oct 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> So I think the only reason to keep it [GETTEXT_POISON] compile-time is
> >> performance, but I don't think that matters. It's not like we're
> >> printing gigabytes of _() formatted output. Everything where formattin=
g
> >> matters is plumbing which doesn't use this API. These messages are
> >> always for human consumption.
> >
> > Well, let's make sure that your impression is correct before going too
> > far. I, too, had the impression that gettext cannot possibly be expensi=
ve,
> > especifally in Git for Windows' settings, where we do not even ship
> > translations. Yet see the commit message of cc5e1bf99247 (gettext: avoi=
d
> > initialization if the locale dir is not present, 2018-04-21):
> >
> >       The runtime of a simple `git.exe version` call on Windows is
> >       currently dominated by the gettext setup, adding a whopping ~150m=
s
> >       to the ~210ms total.
> >
> > I would be in favor of your change to make this a runtime option, of
> > course, as long as it does not affect performance greatly (in particula=
r
> > on Windows, where we fight an uphill battle to make Git faster).
>
> How expensive gettext() may or may not be isn't relevant to the
> GETTEXT_POISON compile-time option.

If a user requests NO_GETTEXT, they should have zero (or near zero)
cost related to gettext. Which is true until now (the inline _()
version is expanded to pretty much no-op with the exception of NULL
string)

> The effect of what I'm suggesting here, and which my WIP patch in
> <875zxtd59e.fsf@evledraar.gmail.com> implements is that we'd do a
> one-time getenv() for each process that prints a _() message that we
> aren't doing now, and for each message call a function that would check
> a boolean "are we in poison mode" static global variable.

Just don't do the getenv() inside _() even if you just do it one time.
getenv() may invalidate whatever value from the previous call. I would
not want to find out my code broke because of an getenv() inside some
innocent _()... And we should still respect NO_GETTEXT, not doing any
extra work when it's defined.
--=20
Duy
