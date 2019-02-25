Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327F220248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfBYU7Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:59:25 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:37494 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfBYU7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:59:25 -0500
Received: by mail-ed1-f47.google.com with SMTP id m12so8803633edv.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HOTFqpVvILtTMN9URy7XWtIaFnnXT5bk/gqyrPpt5qs=;
        b=fNrnQIVzSdmIbueJ69yNr2ZsK7Qy0VLdsapTKH1RljnEp9Y3V7aGLYPuTIWBmnhykf
         0ANidqwqoE7bE+QqZBRfrDBVdbipgA/rb6HFfIHaQ+AbvWk6NsCFAZJ/aDI2D7wQeZM8
         +A9urP2rc8tawPkP3TeV4kqBIh48IvvtYtV62nd3VurCPcUkb4DLM+p7fOaRhTqaPUCJ
         oWXfqbuy94+IYq1mXQuom0xWgKqvQ5jiqCs01MVawLtE0tI9q8zsXW7dmbZSEaNFEtz8
         hYcMHSPuTfgI288/HNU4puDu/jsXcbkIFlzylPfmgAUJ7O6e84gVhZQDpLyi9/HO9lj0
         LeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HOTFqpVvILtTMN9URy7XWtIaFnnXT5bk/gqyrPpt5qs=;
        b=kHEiYCl6fnJiLuJcB/1czJeVKad4rkWgZzPUVOYbhiyDY7tUgZz25E3dc6h/Wg5AkP
         JHHRqRVRIWV+AZ0W9K3YcE9luOKDjdGLDSlqMweCeXcNy1B5UNqQaTUw6mqW0iQVMssM
         tgIPZRVhmjIMw4N6OvJE4EjUgya3Ngj645ZhXndgNL68WsWx3rSiq2OQ/4LvzTaZrzZc
         1RRPsa3WFgCg0AFK1wY7Sr6TwJ+bDmHn0JXrIIhpHjtj1rAwtXCsW+pug2pVy0Oh5LRJ
         nx8d2jID2rjjzw1WGf7QfSIGZPwbSy2BaZt8DE706zTDQ7XYHoOcE+v3AY7SRhWwX8mv
         OHhA==
X-Gm-Message-State: AHQUAuZeijzPm8Aqk8OvEq+zpT9LIopig2euCOG5CYmcpyZdTPJ7uUCg
        XVERxEf8T/tyGHegxdaGLR8=
X-Google-Smtp-Source: AHgI3IY86wAWBVaUNddfai9hSSjOys8WeLTb6UrC/0Strd1B1UV0H8xYQ8nG0Tjr7nkL4G+pAsO7iQ==
X-Received: by 2002:a50:9235:: with SMTP id i50mr1469476eda.20.1551128362941;
        Mon, 25 Feb 2019 12:59:22 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id g11sm2977569edf.44.2019.02.25.12.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 12:59:22 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Compile error due to po/fr.po on old gettext in v2.21.0
References: <874l8rwrh2.fsf@evledraar.gmail.com> <2933589.YIuU4JMJIj@cayenne>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <2933589.YIuU4JMJIj@cayenne>
Date:   Mon, 25 Feb 2019 21:59:21 +0100
Message-ID: <8736obwpna.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 25 2019, Jean-No=C3=ABl AVILA wrote:

> On Monday, 25 February 2019 21:19:53 CET =C3=86var Arnfj=C3=B6r=C3=B0 Bja=
rmason wrote:
>> On a NetBSD test box I have with msgfmt 0.14.4 v2.21.0 fails to compile.
>>
>> I didn't spot this in rc2 because b3225a4183 ("l10n: fr.po v2.21.0 rnd
>> 2", 2019-02-13) along with the rest of i18n updates gets pulled in after
>> all the RCs.
>>
>> I.e. this is because of the comments being parsed (fuzzy comments).
>>
>> The 0.14.4 gettext release was back in 2005, so presumably this is due
>> to some GPLv3 allergy of NetBSD's. The OS version itself is 7.1,
>> released a couple of years ago.
>>
>
> I kept the commented entries as a translation memory, even when they are
> fuzzy.
>
> Would unfuzzying these entries resolve the issue?

Yeah it seems so. I think specifically it's complaining that even for
comments there needs to be a msgid/msgstr pair, whereas in those fuzzy
comments there's 2/1 instead of 1/1.
