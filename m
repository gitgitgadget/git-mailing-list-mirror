Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E5C1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 08:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIQOG5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 10:06:57 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:40025 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeIQOG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 10:06:57 -0400
Received: by mail-io1-f45.google.com with SMTP id l14-v6so10766495iob.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 01:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c5Q5PdBCorOFUuBadPWrOw9+X4dXyMRxNhRaMoe/1Uk=;
        b=lB7+9Mzexf6tg9LmhyXfLiGnf3c4c3wY6/z3nin1FFvKeFtYmtWyfM7czL7D5ndzPo
         VeRXESWjuaqKDJWW22WfeyCPfbvd3ICjvgJHVvTc2U+N5Ms2jyv0FaRh9ZuSJJqFiwJX
         YcYu6aXAMtx0c7IULN2iVZ3g+ru3EF/gIpJnhao3jSVT1nvOVcg0MIspZO21q5Mna2Jq
         2+pdRCIdb+T9rt7eHQj71Imq27IwU/kUq733jRnVl2AujqUGRCpz+BGOl4ChnKYySVhr
         59o+JkQOU68heajY0Y4lVnJbc3sXRHzPI8uyR/HmgFofqg7rcXo357Y7kW62cMkfsAfx
         Vq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c5Q5PdBCorOFUuBadPWrOw9+X4dXyMRxNhRaMoe/1Uk=;
        b=lcpbP/yMvOOG7ZkQaccSlUEJHmg5HeGNyAOKU91G2JQGlAw6h/kgD13XPVmYmRW7bZ
         me6tUcYPUAmGxmOdqpXRhUQi1ISvM9+TjY09GA4E90bd55nrcQg882lYp6zA02F2xZJD
         flDuhJ39oNZu+8yB0LUMkK2oN3ckeNaABqwHLfK2LLknaZGp1/GvyK/vBSk7EZdQkNE9
         q4QzjlsS7S/tdeXgsO4vLzRNkrmNot0jd9YnvGrkAsY+QnxOSjp3lDJXL2FOCx0VMG8O
         HmKEHddD7mBl4G6x/tBDVDLTuTxMQ2I187eD5PSZPcV1smC0GCzLV2rISYuveR+VfVhm
         RwFg==
X-Gm-Message-State: APzg51Dbht3nzv4bUco2yxnCsxB4VYT1sv3FK+Sa5GBcyV8FUntIUyaz
        CR3W4EjKridy7MJhziKO74H8aZm3qHjnjHhFF+jpDvpa
X-Google-Smtp-Source: ANB0VdYvWc+/eBUxvij0UFyMS/D7Ax+bCZe7f5KFvoyTNAUUtjjpY3lNgXERhE87w25B9KyJ9SLyWwrqHcZFeT4GB0U=
X-Received: by 2002:a6b:1a11:: with SMTP id a17-v6mr19156428ioa.223.1537173632432;
 Mon, 17 Sep 2018 01:40:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 01:40:31
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 17 Sep 2018 10:40:31 +0200
Message-ID: <CAP8UFD0arGNnC-zVUcdC9a8pR8jHjShDZhysMXGOLZWLS5+NrA@mail.gmail.com>
Subject: Draft of Git Rev News edition 43
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Michael_Mur=C3=A9?= <batolettre@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Tacitus Aedifex <aedifex@sdf.org>,
        Kyle Meyer <kyle@kyleam.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Matthias Beyer <mail@beyermatthias.de>,
        Julian Ganz <neither@nut.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-43.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/308

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday September 19th.

Thanks,
Christian.
