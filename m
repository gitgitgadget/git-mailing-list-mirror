Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1E21F404
	for <e@80x24.org>; Mon, 22 Jan 2018 22:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeAVWKc (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 17:10:32 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:44912 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeAVWKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 17:10:31 -0500
Received: by mail-vk0-f49.google.com with SMTP id q62so5928301vkb.11
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 14:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1tfotWinBER6R70I33alZAKkF7d3cqGdrKjcffgu+xM=;
        b=I+nMZony6afAmXR7opOk5BivgH9cIUr93kMBUAy1OE0ik0rQkcLEZkr1mR1oy0pwHw
         U4P2rXPPSmJz0nx0k7MIFmqY7i7A0GOmTOz2mTDaaV2U9zJSbgmMVgS+Bnr4tjLhpJp7
         dgxnUt9ix05narZvnkGw0gIoiml9Bq/fPVp2eDXpVxjBWr7hDZJPwklR7qiXu/m3rTxg
         DxKtdVTMtpU+SESWUCd4dK4BKH4Vl+nxnlFf8JDJZ8S4Z+vLnB2uwKWUt9hgGbvZVzlG
         5RMO76d4xyF4BpPsi43/nJQDdkLeHwWLyhV1SHV31YBzwqTkE9qiF5ObQVbMg79/LWv+
         at4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1tfotWinBER6R70I33alZAKkF7d3cqGdrKjcffgu+xM=;
        b=a4yCQCJRpFbHCiM30REIfQe/HGP7z8Bgt78lcNdeWFJdqhf8ZHjmzRHNXRgVxPCPo6
         fQXz1+FgeFtiLJuMAghFZaowgsF8dYPphv8Nj1rgqqLoIO6ojcwVnHvvGUPdyoI8rXTQ
         EtA6FKcCcKhieH0aPByRlGwkq8sFkDLqsIGu1ieBVspjIyRM7nPOCdcgMsPpHf3Ix9RB
         reuNZTv00nc/7ogjRmnkv1ZzlNWaaR9LxjPUxGgyAyckWrYEuDA4CybAT0tIa5qNHbSd
         c1VhutNUpqmq/IdtIUsJ2n6/Unz8P1dzOIrZTVcOj8+UQ4Bdci8KblYImGczHLZ6vjeH
         pdcg==
X-Gm-Message-State: AKwxytcVqP+evhCZK9+7IOUpnzIrdiQmS3ef68H5FvfkzyLjtHBmIrmi
        nA2WhgvMZneEg3ng6GCdvgcm1+d9KcsfPoxKIqg=
X-Google-Smtp-Source: AH8x226KlVFYuxPjw27C2b1fMN62RnYzMoa/6rE4CACszq6bZHKWEGanXgQOrwDHrYPUR/S4yAemJDCkF5BBKgCZYRQ=
X-Received: by 10.31.45.1 with SMTP id t1mr281763vkt.12.1516659030857; Mon, 22
 Jan 2018 14:10:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Mon, 22 Jan 2018 14:10:30 -0800 (PST)
In-Reply-To: <CAPig+cQnVfFcN_kH-pQmjJWa_3SeEb4_vdL7-nDCO-tV-U7Pvg@mail.gmail.com>
References: <CACsJy8BBXQ9KErfiuf2ty_4szE2fiHLDiKvMig1LbSefzf-o7w@mail.gmail.com>
 <20180122182717.21539-1-szeder.dev@gmail.com> <CAPig+cQnVfFcN_kH-pQmjJWa_3SeEb4_vdL7-nDCO-tV-U7Pvg@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 22 Jan 2018 23:10:30 +0100
Message-ID: <CAM0VKj=EK7ZQkxvhvzyDgKJXxzd19Mtj1vCRULqthVmPj4W2Tg@mail.gmail.com>
Subject: Re: [PATCH 3/3] read-cache: don't write index twice if we can't write
 shared index
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 8:46 PM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Mon, Jan 22, 2018 at 1:27 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:

>>   - The logs of OSX build jobs have CRCRLF line endings.  However, the
>>     'base64' util of OSX doesn't wrap its output at 76 columns, i.e.
>>     prints one single albeit very long line.  This means that while
>
> Perhaps you could pipe the 'base64' output through 'fold' or 'fmt'?

No need to, according to its manpage[1], OSX's base64 has an option to
wrap lines after given number of characters.  Of course it uses a
different letter for the option than the coreutils base64... :)

(While long lines are ugly, in this particular case it comes handy: when
using vim to extract the base64-encoded section from the log to a
separate file, it's less keystrokes to yank a single line than to search
for the end of the encoded section.)


[1] - https://developer.apple.com/legacy/library/documentation/Darwin/Refer=
ence/ManPages/man1/base64.1.html
