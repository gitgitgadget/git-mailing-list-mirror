Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6803208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbdHOTfg (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:35:36 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38881 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbdHOTff (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:35:35 -0400
Received: by mail-wr0-f193.google.com with SMTP id g32so1190329wrd.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 12:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rb3zfZ4/VWkHu93otKmp+8uM6OYnVainqA7O8JFvKyM=;
        b=MHEYhG+a33Qlz2PeuDB+H7TdhQFPi4LazXlzd3R9UOyyT+72K6VQCmGQmIARCiK8uA
         Ko33479yuL0zxq6dYRKvNBXf2vJeLjOJj/DBVLy4T0q7jVZF7Z5lUrlaeeI0L6Ok3HW5
         UMtGMd2SIXboB7rqZMMh3TG3Qce7sMdZ4O9tMmA+xtjR9mgIyuB8DNm1Pdyk8HxPs4MC
         SaKk3hf7aL7wfiwUeOH2NJaGyAyPxUseZX7P3fU4vKjS0SsJBUVPwhDYphGtMti/2yRQ
         cPjHiRTzqkLWisgJ6j/VeK3ch+DDkIRLGxUvICTJP1IzZflqTqMP/oCB5VqReR8nNcWa
         kLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rb3zfZ4/VWkHu93otKmp+8uM6OYnVainqA7O8JFvKyM=;
        b=a3zHeJ2ZQsr6WAwZbHdpPhVJKfLaPz3FJ19NbnvtyTiKTSc/dIoZvDBS6BgP2pOSJ4
         yoqrrSBE48JbooRUGtZAsaBRYpfPFaywwkMdO7iGEs3kyjbqZoZDqP5Qllh5N8Dlvtrf
         a+LELCNBqk8EZRcQMYNSLpDD+RgZNR98f4tbSG1N/SCbhBawL/y0olEsMQBMJAYEUPPv
         1BdcR78YdyRFn2xeO1hTds96bwyRn0WFhNflQd7eXduYAw9VnFtbRCRaJs8LrAbNcQT1
         LsMOizTHvFToq+YP1WPubmNCAjgwRibfxhP+0i4epHXCeZ+VcdsH4RJKEO0SlRi3FW34
         Q+5g==
X-Gm-Message-State: AHYfb5gqg8v2L/xB45fw10MXajtMoMx7JzmKbl+hUvaLxWKXf0To/anY
        +qUSyjNd2mAv2w==
X-Received: by 10.223.165.12 with SMTP id i12mr19055075wrb.5.1502825734304;
        Tue, 15 Aug 2017 12:35:34 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB6853.dip0.t-ipconnect.de. [93.219.104.83])
        by smtp.gmail.com with ESMTPSA id q16sm8673137wrg.44.2017.08.15.12.35.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 12:35:32 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] sub-process: print the cmd when a capability is unsupported
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAP8UFD2KBEVwZE8obaDxf+0AyU4zH0+5bWJzzHazFywgWT9QjQ@mail.gmail.com>
Date:   Tue, 15 Aug 2017 21:35:31 +0200
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC865401-2FE6-45ED-BBA5-524C3E29477E@gmail.com>
References: <20170815173611.2267-1-chriscool@tuxfamily.org> <836F754B-C78C-4D19-8365-875D96B3F115@gmail.com> <CAP8UFD2KBEVwZE8obaDxf+0AyU4zH0+5bWJzzHazFywgWT9QjQ@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Aug 2017, at 21:29, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> On Tue, Aug 15, 2017 at 9:00 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 15 Aug 2017, at 19:36, Christian Couder =
<christian.couder@gmail.com> wrote:
>>>=20
>>> In handshake_capabilities() we use warning() when a capability
>>> is not supported, so the exit code of the function is 0 and no
>>> further error is shown. This is a problem because the warning
>>> message doesn't tell us which subprocess cmd failed.
>>>=20
>>> On the contrary if we cannot write a packet from this function,
>>> we use error() and then subprocess_start() outputs:
>>>=20
>>>   initialization for subprocess '<cmd>' failed
>>>=20
>>> so we can know which subprocess cmd failed.
>>>=20
>>> Let's improve the warning() message, so that we can know which
>>> subprocess cmd failed.
>>>=20
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>> ---
>>> sub-process.c | 13 ++++++++-----
>>> 1 file changed, 8 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/sub-process.c b/sub-process.c
>>> index 6edb97c1c6..6b133f8dce 100644
>>> --- a/sub-process.c
>>> +++ b/sub-process.c
>>> @@ -158,7 +158,8 @@ static int handshake_version(struct =
child_process *process,
>>>=20
>>> static int handshake_capabilities(struct child_process *process,
>>>                                struct subprocess_capability =
*capabilities,
>>> -                               unsigned int =
*supported_capabilities)
>>> +                               unsigned int =
*supported_capabilities,
>>> +                               const char *cmd)
>>> {
>>>      int i;
>>>      char *line;
>>> @@ -184,8 +185,8 @@ static int handshake_capabilities(struct =
child_process *process,
>>>                      if (supported_capabilities)
>>>                              *supported_capabilities |=3D =
capabilities[i].flag;
>>>              } else {
>>> -                     warning("external filter requested unsupported =
filter capability '%s'",
>>> -                             p);
>>> +                     warning("subprocess '%s' requested unsupported =
capability '%s'",
>>> +                             cmd, p);
>>=20
>> Wouldn't it be possible to use "process->argv[0]"?
>> Shouldn't that be the same as "cmd"?
>=20
> Well in sub-process.h there is:
>=20
> /* Members should not be accessed directly. */
> struct subprocess_entry {
>    struct hashmap_entry ent; /* must be the first member! */
>    const char *cmd;
>    struct child_process process;
> };
>=20
> so if cmd is always the same as process->argv[0], maybe there is no
> need for the cmd member in the first place?

The struct is a hash map entry. `cmd` is the key for a `process`.
Therefore, I think this is still necessary.

Does this make sense?

- Lars

