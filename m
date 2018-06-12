Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B3A1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 22:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934737AbeFLWXY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 18:23:24 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:41048 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934563AbeFLWXX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 18:23:23 -0400
Received: by mail-oi0-f68.google.com with SMTP id a141-v6so524153oii.8
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=632IVyv+C8yUyGVS/+lDb+xlGO3Pe0tNgUfopH71qXA=;
        b=MYgWea6wsQ5DzmyHYnA7pfYeD59iqD2BEeyqSUw5O5/lW3h2GDbppMyN4zRo15QRcM
         FgUxDfJNC9xcV18YCUHFJxCmOB+MY/1ySOcr+HJ5kdsaW6Nmo2O4yBDVB3RJwKrCtAdP
         2w8+oROXdw6aBu7T2NfOaxi3YJGN5zRu3TFSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=632IVyv+C8yUyGVS/+lDb+xlGO3Pe0tNgUfopH71qXA=;
        b=gzTD557n2AzC56Dg4yFZI7+ezWHDqdPd/DpcPVorSWQ28vrYHxlOS01uZ0YERtBR6/
         tFA4Akm426nqd7tFSHHiDL+ytDFGLwRxreQqWOw4nTHa3kFQ38eIEg1/FU8fsJxQ0uA8
         Td21Gpr6oZx5ismk8m1DV7QAD55jEsPadKLLjgNKuZT/cQOsm5ezd3WXN3d+q0RnzEtR
         pVFBzq8wtEjtSNpirYopdeVfnzpIttgGKCWKZDWdX/4/enDRU6vQRJsFCMaZ4Yw9Prpd
         9PAkWG3lZi19DPA/1lkoXlpW5xMZ1FwtA9CSEScW5gtmTt83nlSVIewZuFg2/3f2P/kr
         nwfw==
X-Gm-Message-State: APt69E0KYGO8Tcb5oA6yLfN5L8+Li5sTKJe1/FoBA2lY/yYwpN5hnLFG
        tzUXPyYb2Koc0zmd/Z+sLLGCfZ6sQkY0WNh5436taQ==
X-Google-Smtp-Source: ADUXVKIwDngVqZ9vy7FtayuKx4rkCjPzAJbe/RI/Wk7S1irSvg2q/RXm22CJQLR55SSfvHAGl0DYKFcmRzx/pvlxRwQ=
X-Received: by 2002:aca:ec09:: with SMTP id k9-v6mr3201297oih.81.1528842202868;
 Tue, 12 Jun 2018 15:23:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 15:23:22
 -0700 (PDT)
In-Reply-To: <CAPig+cQg5XE7peXDC-q0mkB9y6boK_iiM_55O6Po2PVmyZNLww@mail.gmail.com>
References: <20180608203248.16311-1-luke@diamand.org> <xmqqo9gg9bi3.fsf@gitster-ct.c.googlers.com>
 <CAE5ih7_ZDzg9h8BEGDWyg_jBG1rj=_eW1Kg7JO7oKiF6Q2+37w@mail.gmail.com>
 <xmqq7en38z8o.fsf@gitster-ct.c.googlers.com> <CAE5ih79NoTpbkU50tts2GgLJ7Wy9WyBUgJncm3KXPLxuy0P0hQ@mail.gmail.com>
 <CAPig+cQg5XE7peXDC-q0mkB9y6boK_iiM_55O6Po2PVmyZNLww@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 12 Jun 2018 23:23:22 +0100
Message-ID: <CAE5ih7-3_jUFNpodvv4szZ75hbgZwvrR1DsmnZqWBus=__37sA@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git-p4: some small fixes updated
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Git Users <git@vger.kernel.org>,
        Eric Scouten <eric@scouten.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 June 2018 at 22:53, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 12, 2018 at 5:49 PM, Luke Diamand <luke@diamand.org> wrote:
>> Thanks. While on the subject of git-p4, I thought I should mention
>> that I've been looking at getting git-p4 to work with Python3.
>>
>> I've got some low risk easy (mostly automated) changes which get it to
>> the point where it compiles. After that I have to figure out how to
>> fix the byte-vs-string unicode problem that Python3 brings. [...]
>
> See how reposurgeon handles the problem[1]. It defines polystr() and
> polybytes() functions which coerce strings and byte sequences as
> needed. It's not pretty, but it works.
>
> [1]: https://gitlab.com/esr/reposurgeon/blob/master/reposurgeon#L100

Thanks, that's got some useful tips!
