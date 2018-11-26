Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D49B1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 16:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeK0DDb (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 22:03:31 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:41748 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0DDb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 22:03:31 -0500
Received: by mail-io1-f51.google.com with SMTP id s22so14347237ioc.8
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UWotTclZ3f7wsYZ06UMgTYNx6x0zxkd+VUMsucfRN6Y=;
        b=BHKAY3fSo0PKpctsDh883zOPH7wf18dmkYuh8qn/RZMymbpLVmLxY+S16vH/pXPMVi
         rN0BO4NkFzW0nPN0n/sW4CwT6nS2vO+pIDMVb4w4B8YSrKwWWlOM+RnouhwPM8ZDwSbs
         +gV0FuJ/fYlVMmT553zglR/zXNfRHTWm74nHROf9YsJnnj+WUTx342P2DCQhp9xlC4vv
         PbzmbwX4nEQ/n6EWamjoxfZDbKuErnm0KHazciKc1m/Vytd2QCx7cyoLdMCUPfdSpEBP
         GyYIjbWTxGjlqLuTfmUiGQR67IUUPhU7oqPWlRbuImP5pW3zICrPThqTgePwWTbU4eV0
         Lj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UWotTclZ3f7wsYZ06UMgTYNx6x0zxkd+VUMsucfRN6Y=;
        b=tyPOw88rqbuQ8+vYfetfPv4o33HvWASZOH7A4hGzBdhBcH80Q14k8jtCxUaSlVjUeC
         AWP2b35S5Bg6rk5qx90YSxY7ZNkkkDE622/nA+ZPqPbTZ3d7uMEaXfN4Lib299F+CiVr
         HilgHoMoRW+XJ1g0meF9j+ALF1AJb5SnVpzwr1BnHGIdjILp67kiqhk0cpKz4gXqFjwr
         xZ8FBf9hh+QfcOq2sVOXzSNvB4IdKg95CbRv20v7a236Rwq5KqDV1G6QmQ4zE6ZbXtPx
         7R7kkOw2Ste1ormo0/acZn/hGl4yDdX+AbAOTiIM8QKDeFCVGKcwOVXLG00K/fHx7mGT
         el8w==
X-Gm-Message-State: AA+aEWYuoJhsTACoW5xHsQX9tcocGld2af+rHwbXPx03Y7cgvC9d4RPk
        AD6Zca/HjyY25vwYJSoeHc6R7ufwfZ+uR2SsISs=
X-Google-Smtp-Source: AFSGD/Ua9djD0RIzPHbQ1cliNlG5do8HUw08uJw0fuiPNoi0pDiQaqyuv1+JmJTY7mu0+RfwsKXzYmSYtMAA3fUv/cQ=
X-Received: by 2002:a5d:9455:: with SMTP id x21mr3918000ior.282.1543248537790;
 Mon, 26 Nov 2018 08:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20181110133525.17538-1-pclouds@gmail.com> <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
 <8736rx1ah9.fsf@evledraar.gmail.com> <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
 <20181120174554.GA29910@duynguyen.home> <87o9abzv46.fsf@evledraar.gmail.com>
In-Reply-To: <87o9abzv46.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Nov 2018 17:08:30 +0100
Message-ID: <CACsJy8AU9HUPohHat7aGxFHuz9LAphKUTnMG=UoiZE-Foetddg@mail.gmail.com>
Subject: Re: [RFC] Introduce two new commands, switch-branch and restore-paths
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 5:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > So, what do you think?
>
> That "git checkout" does too many things is something that keeps coming
> up in online discussions about Git's UI. Two things:
>
> a) It would really help to have some comparison of cases where these
>    split commands are much clearer or less ambiguous than
>    git-checkout. I can think of some (e.g. branch with the same name as
>    a file) but having some overall picture of what the new UI looks like
>    with solved / not solved cases would be nice. Also a comparison with
>    other SCMs people find less confusing (svn, hg, bzr, ...)

Less ambiguous is indeed one of the reasons I wanted to do this.

> b) I think we really need to have some end-game where we'd actually
>    switch away from "checkout" (which we could still auto-route to new
>    commands in perpetuity, but print a warning or error). Otherwise
>    we'll just end up with https://xkcd.com/927/ and more UI confusion
>    for all.

I'm not going to remove "git checkout". Not until the majority of
users are really in favor of the new ones. So my end-game plan is to
just promote the two new commands in man pages, tutorial, advice...
Perhaps at some point "git checkout" is also removed from "git help".
But that's about it. If you want to stick with "git checkout", it's
there (and not nagging you to move to new ones).
--=20
Duy
