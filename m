Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719A01F404
	for <e@80x24.org>; Mon,  5 Feb 2018 18:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeBES5s (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 13:57:48 -0500
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35653 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753561AbeBES5k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 13:57:40 -0500
Received: by mail-yw0-f171.google.com with SMTP id u21so19131465ywc.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BfUO1+uZ9hosfXeIW34V6NB8Ccf3Hr1L3V7vSc96TM4=;
        b=cs8zC7jtTMObGAWFSZsCchAuxPxHtLAUhDZqHbUiXv6/lnczYcDzWy8KscR7OQrVuE
         TLA7FpP238EWr6GaS2hcpx/Y+ohtZU5j+rwRKfZtAh4UU6ermnpsARMy8ggbruAoQYEx
         U1XpUPvmYTOx6zLwsVrimG7P1ONYvx6sVLLrPJSCe0anDY+GO3ZfmGoFyG/jMbIS2De5
         OYdvCAEtNoltrxO8osERhHmTLwD3rm5PiAgQVVsAPNVigten3Cr/8wiPneUbzttpoEXY
         8GMBkrxnNIdxqWyVzYxFiCi1to481eKu9XeehFcZyznoGKc89xTwTkqqzAf9IVz9cCSh
         ZqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BfUO1+uZ9hosfXeIW34V6NB8Ccf3Hr1L3V7vSc96TM4=;
        b=Z4NTTWQworg9BDnM87GET9wTSzbmjBLNfyu+eNQj9xkQMgsshPrj1BjT4ZiiLLmNlZ
         yLfjGKNI/Oh6Z6AnA7VD8yHFNFZspOxLk2bzKt5l3x0HvXV1zDeO60vT3LqzLUzDiCx2
         qHgBG6lf0jqv5zg0MoNZWRKBL/fdogPjrbvDuHxPeHGnP1MKA/gLhnykkX45HVjfDvDL
         rAFi6msNFkz5DjdKku5h5coATfEetMjIhQklZL/XtOw1w+gmx9vFWmBJ9lTB+j4kxqFt
         /Z21kWb8hWeR6z8wRr/3NFKi+jLxEOGEsUv27qFcATILnbCiOSHN6T6HvfBIVT9M9iwf
         cllw==
X-Gm-Message-State: AKwxytdZBy386tAeiua0tIcvTY6+EWfUspgTb+lPfgEPrv96m7AmbIs5
        RerNBSkc5PTsIWouULfFHcC9vS+0bJwUxUp0m5tCiA==
X-Google-Smtp-Source: AH8x2252MjdQnCEboTL640IkXivgXJyZHYJ39O08ana9uPmyCOTRFiNq6HV9WmqdA39ThdcS0X6ObF/TsZqLzNly0ro=
X-Received: by 10.129.119.131 with SMTP id s125mr31055255ywc.166.1517857059453;
 Mon, 05 Feb 2018 10:57:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 10:57:39 -0800 (PST)
In-Reply-To: <CABPp-BFDgDDa_fPSFJQUSzR1k5-ix0SWrviUPFu+SCoyWfG5cQ@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-13-newren@gmail.com>
 <CAGZ79kZ4uHbOsqTj49SaKqUMdyTWCGjcHNNM9-8HYXyqZWqxWg@mail.gmail.com> <CABPp-BFDgDDa_fPSFJQUSzR1k5-ix0SWrviUPFu+SCoyWfG5cQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 10:57:39 -0800
Message-ID: <CAGZ79kbhieX+ZkG-Tv_NNJMUw0=syDthnW1Q=o4jhotaTiC0Ow@mail.gmail.com>
Subject: Re: [PATCH v7 12/31] merge-recursive: move the get_renames() function
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Move this function so it can re-use some others (without either
> moving all of them or adding an annoying split between function
> declarations and definitions).  Cheat slightly by adding a blank line
> for readability, and in order to silence checkpatch.pl.
>
> Does that sound better?

Yeah, that sounds perfect (no red flags on reading)

Thanks!
