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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD6D1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 06:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405601AbfHIGwZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 02:52:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42334 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfHIGwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 02:52:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so128820729otn.9
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dSv8U8tbU8t9nINWibH6sFXg7Gdb6X78QXtLim9+axI=;
        b=CioKa90QorZhJYFZG+pHb87YZ88wuE1zkGQu0DadBZloR6GhGd3VuzgkvC03qwiLjR
         tNhbALxDb67xGGl0upqnTNjnFxiS+oSe3SDl51LqzsYKQtHYxmT8OCKrrVMjTvKZFVCy
         ADpCcrg7SPehSesdel/b7Skv1ylZBmJcHiJx8Ga/q8Eb3+IVZIVvMW8VKKkIHaGvmyoL
         h9CgvQqjiar4h2W9liiUAFWOnT7hvOtqB/J3+ub2EVDiX0eadjAxI/0nADp/k0/ILoFO
         toJaHPr4+UxHgP1KH8ZvRDaR0/AJblTgswm4b5AFam1im0vLxKwwH3l4Lk8T5aEjUWQ5
         jJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dSv8U8tbU8t9nINWibH6sFXg7Gdb6X78QXtLim9+axI=;
        b=dS5FsDksSkNGACPfqGOshhJqE/HQmQtR8rkdDmK3K48X4Oow90dNxU/McySUmdNfBl
         JDZo5ByzGBdXXbz9QXS06EPBbgL5UpsuS1YBI2HwuWO283t3RExS8L5GQapaC0echLYo
         FCs1TERQtPw5l9hnVS5RFh2ACJ0fbrOQFJg5NKdADOG3UpcYXNBHb83/0pbABo4KrB5q
         Ixm3/aGJWh2MYCoyUE+Td5LSJ1vBTo0oDfRdzmGUybxrIeTqms3sJ1RBRsuHXmz3szLM
         iG9bU3xbNc/WvBtQGG3643k0L+V4wzk1pI/xVlYU5oi/qezGL0/MjIj+qkuIPHTyWfnw
         JtgA==
X-Gm-Message-State: APjAAAXy7fEljtaIx6akWBfl0ZBVGfXKkAxSqfKTH2/NgOsAC4sefMVg
        FhKfhNHBLQ35cQjJEkCI3EydYNohipj/O0v5h9E=
X-Google-Smtp-Source: APXvYqy1fe/fmygTT5dNyaMnDSmlkXR2yROgBLRDV1QZBR1ws18dSumHKNEiiZL7YRy/57kf6LFMKu4+eOOXk2xPOC4=
X-Received: by 2002:a6b:c38b:: with SMTP id t133mr19273421iof.162.1565333543966;
 Thu, 08 Aug 2019 23:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190806085014.47776-1-carenas@gmail.com> <20190806163658.66932-1-carenas@gmail.com>
 <nycvar.QRO.7.76.6.1908082219160.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908082219160.46@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 8 Aug 2019 23:52:12 -0700
Message-ID: <CAPUEspibDcNfGk4=6Mvi2BHATGSxRPPph3F=3pLm_bLMBkBTNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] grep: no leaks or crashes (windows testing needed)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, l.s.r@web.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 8, 2019 at 1:21 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 6 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > Eitherway, since I am unable to replicate the original bug or take
> > performance numbers in a representative environment without Windows
> > this is only published as an RFC, eventhough it has been tested and
> > considered mostly complete.
>
> Well, this is disappointing.

Apologies

> I worked several weeks on getting Azure Pipelines support in shape, so
> that you can now open PRs against:

Thanks, I owe you a drink

  https://dev.azure.com/git/git/_build/results?buildId=3D862

Carlo

PS. I might had broken something here as I can't see the test results
that failed
https://dev.azure.com/git/git/_build/results?buildId=3D857&view=3Dms.vss-te=
st-web.build-test-results-tab
