Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7291F597
	for <e@80x24.org>; Fri,  3 Aug 2018 16:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeHCSjj (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:39:39 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:43562 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbeHCSjj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:39:39 -0400
Received: by mail-io0-f193.google.com with SMTP id y10-v6so5474582ioa.10
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 09:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fxtJLb9AI467VPjxb/n+NQipm/CPNiVWHY0i9YKkDyM=;
        b=MJnjEWR46mbwcGvFQvL9ERrlRO2Tj56JQxuEkdguEHEoCjHtGfDsUs5Jq1SKmpnThC
         J6dCJH5ZpHprucy7ocwANMFk11XLbB7zek+O5GnJ6VgMgGoigW2EIQXT6bmlaCM9FxdM
         Jj50NKbtrtMtcKnELU0kiZtZwt6EMVzbNrcWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fxtJLb9AI467VPjxb/n+NQipm/CPNiVWHY0i9YKkDyM=;
        b=gmRw2lS/Y1rD13frgbCaqeJA5j8G5SKzfvs+mIb6FFe9BsqOgoBmCBjMR1xVXTxjfz
         MsQ3PP/YcUFopijZWVUIa2UgnxaP9RJ3yt8GJ8x7gDUlozl3tQ36/OYShqDdwA48VyCV
         IVMEQH3VUjvRk3KRYY+4kK5PV28By81AzucQexFbyIQNqb5pJHG16GjwGKNP7qLpOD+W
         Sro1rhuL+Pk9kDeu6M32v4dZDRF2hN74fDKECmy/eOsi6Ql6sEXFZLg/0REqagn/RR3c
         KEi5Xr+/ko/4gTrO5uuf4xcscuDZShub1RXR6g7TqzXq5NPfZxSoS/RjssBPkhghhb0A
         uyEA==
X-Gm-Message-State: AOUpUlFh/SuzkJfurcb2MTCgWpeb4obgankLcUbJVqTvuZFaDKG476CB
        ijDzwOxiFUesB4W2zekYdrYxrcFMpRujsmt3h4c=
X-Google-Smtp-Source: AA+uWPwNgZl6v3vJF9NVuXDVBqL+4N25S3Em/iulG+zbCPzlGXIJ2tC8xYrv4N1TsrYvqdV3KHg04lgsNXkiWpfONyQ=
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr7044202ioh.259.1533314555264;
 Fri, 03 Aug 2018 09:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqin53t30d.fsf@gitster-ct.c.googlers.com> <20180726134111.17623-1-avarab@gmail.com>
 <20180803072014.GA256410@aiede.svl.corp.google.com>
In-Reply-To: <20180803072014.GA256410@aiede.svl.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 09:42:24 -0700
Message-ID: <CA+55aFyLQ4vRPcWOiAsR8Qihgin+kJLaGQ8_mes_B3eQ-BQNag@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc hash-function-transition: pick SHA-256 as NewHash
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 12:20 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>
> Here I'd want to put a pile of acks, e.g.:
>
>  Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> ..

Sure, feel free to add my Ack for this.

                       Linus
