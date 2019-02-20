Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8671F453
	for <e@80x24.org>; Wed, 20 Feb 2019 09:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfBTJT0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 04:19:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43104 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTJT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 04:19:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id d17so10665854wre.10
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 01:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lA197HcedhidMGb2IpGVPACfHu3TMmXjTK8dtnivRpg=;
        b=QyiegJW3+E8JOOxlH1LwMuXOSIAWIhudpSxCgfVgDCNuUYynCtIGtmxhaSwdVekLdY
         FmYc4t3t44fBAKQUFSpzE/TLyErIu0qW6pcNXqD9Ogl9seQpfIMCTrr+r1j82Mdfbiqf
         C86jFsdHegCGqXCdmK0arPbenwCQ93QXKhbfrllEi29XoM4xa9yQRhmvrj2ZFuX0k1Os
         KTxnQYO8JE6682bBXxqN64A/IFFAtBLQz80T6hia0O2SAoT023mfB/+v2Clkz7h1Mi0I
         nSop/9imnf+YYwnECSQsswJkKgusV5+h2FzvE2c2iM07FIwkzZVuBnQd+d8b1xmI8iko
         4hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lA197HcedhidMGb2IpGVPACfHu3TMmXjTK8dtnivRpg=;
        b=hlwqlrWyX3UCzDaioxPJunCBkNdKHkHqb7Z6BYjG7tyN6poxRLF9hj59jeS+Xtkj5h
         rfOThOhznyOjA0T9GNTOoGQz5Kmb/K+TfR3COLJJfKLj5099QKDeOKXIll4nEvUIqCiw
         J3PG/uM7eZS70L/HgMywBde9oo7GgAlDc0Ur7FoAN6D9IqoteowK55V9Vj2qsIp6oiZu
         1hKEg/8snqcPsOwIxHXu9AEMmDhVOgc1Bgk5582knmLv6nzCgqrto+6nqXeYOntHoPrU
         Wr28IXXTKBhnGjk88ffcaxpBzRC+thMbR6aiZsCY+g/bR9GwVnYggltbyx4DdyrLvoG4
         eOPA==
X-Gm-Message-State: AHQUAub12ru3ybh0P9xy2tU1d6NSajzq3rzguKzeZSIT2ANsj1bnZqmK
        Q59yXhXpRbOe7CLYXmXEYUD/GNDGSts=
X-Google-Smtp-Source: AHgI3IZ586bnPnWdOp4xTZ8GtvYWRUmiHr0430nNdNpxknXBj2SMR6LnnANiTK0n04i/8SO7KgtguQ==
X-Received: by 2002:adf:fc49:: with SMTP id e9mr25346979wrs.2.1550654364128;
        Wed, 20 Feb 2019 01:19:24 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c9sm13596662wrs.84.2019.02.20.01.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 01:19:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "Git Mailing List" <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        "Clemens Buchacher" <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        "Kevin Ballard" <kevin@sb.org>
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com> <87wolzo7a1.fsf@evledraar.gmail.com> <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com> <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 20 Feb 2019 10:19:21 +0100
Message-ID: <87h8cy6cme.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 19 2019, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sun, Feb 17, 2019 at 2:36 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>>
>>>
>>> On Sat, Feb 16 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>>
>>> [Re-CC some people involved the last time around]
>>>
>>> > A new attribute "precious" is added to indicate that certain files
>>> > have valuable content and should not be easily discarded even if they
>>> > are ignored or untracked.
>>> >
>>> > So far there are one part of Git that are made aware of precious
>>> > files: "git clean" will leave precious files alone.
>>>
>>> Thanks for bringing this up again. There were also some patches recently
>>> to save away clobbered files, do you/anyone else have any end goal in
>>> mind here that combines this & that, or some other thing I may not have
>>> kept up with?
>>
>> I assume you mean the clobbering untracked files by merge/checkout.
>> Those files will be backed up [1] if backup-log is implemented. Even
>> files deleted by "git clean" could be saved but that might go a little
>> too far.
>
> I agree with =C3=86var that it is a very good idea to ask what the
> endgame should look like.  I would have expected that, with an
> introduction of new "ignored but unexpendable" class of file
> (i.e. "precious" here), operations such as merge and checkout will
> be updated to keep them in situations where we would remove "ignored
> and expendable" files (i.e. "ignored").  And it is perfectly OK if
> the very first introduction of the "precious" support begins only
> with a single operation, such as "clean", as long as the end-goal is
> clear.

FWIW I'm in full agreement with that.

> I personally do not believe in "backup log"; if we can screw up and
> can fail to stop an operation that must avoid losing info, then we
> can screw up the same way and fail to design and implement "backup"
> to save info before an operation loses it.

Yes, there could be some unforseen interaction between git commands
where we should have such a backup log, but did not think to implement
it. I'd hope such cases would be reported, and we could fix them.

But those sorts of cases aren't why we started discussing this, rather
we *know* what the data shredding command interaction is, but there
wasn't a consensus for just not shredding data by default by making
users use "checkout -f" or "merge -f" to proceed. I.e. taking some
variant of my "trashable" patch[1].

> If we do a good job in
> supporting "precious" in various operations, we can rely less on
> "backup log" and still be safe ;-)

Is noted in previous discussions[2] I think that's entirely
implausible. I think at best the "precious" facility will be used to
mark e.g *.o files as "don't check in, but don't clean (Makefile handles
it)".

Most git users are at the level of only knowing very basic
add/commit/pull/push command interaction. I feel strongly that we need
to make our tools safe to use by default, and not require some
relatively advanced "precious"/attribute facility to be carefully
configured in advance so we don't throw away uncommitted work on the
likes of merge/checkout.

1. https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/
2. https://public-inbox.org/git/871s7r4wuv.fsf@evledraar.gmail.com/
