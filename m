Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 698961F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbeB0WKY (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:10:24 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41724 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbeB0WKX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:10:23 -0500
Received: by mail-wr0-f193.google.com with SMTP id f14so350336wre.8
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 14:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cE4iNa0eFH4DrQmY++/MmmHQhL3yLU+qljzK6hqp314=;
        b=JWKqKEEA80UFCWoxOpXHePSpN30AtXlKouxczVRvwWG2HWQtEiv5V5GS/IXt4KDjmA
         JxbqD0Bb2aOMwZ1+2RWRgmJ9xFj4h7w2HekbWtduGUakW3TUYt4VAh/DX1zDmF/eRKTV
         QEk741bes8KI19GXxwdCx0rD4bWA30m1LMpdxEuSKrOmN5ICRTIEt1c3KaHX/fp178ta
         96owxtdhlLCxpaNUvBL9XOEIg724HDSxEtCADQJ5iskOkkJ+kcX9gQgu+8FWBUGM5VvM
         V6aax+huXJWx5BlzmKOml4JOHwvX1k4MywW5BOGO9N6J6YjGoWuD6r5DumaYB7qF16+H
         naFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cE4iNa0eFH4DrQmY++/MmmHQhL3yLU+qljzK6hqp314=;
        b=GRXZe+s+t083PVNKJXBO8V0XltefdsaVfmFo2wj2/h1GTNcA0PR6R0nuMlN7QeY7cF
         Vja2cTb5tYVZDVpEgZxby3kIJVIDS/0qhX9qVH0HYPRyEFBqXWEaiB+YkNCA2D7rTLSO
         NPhlngR/my/fZ41A1m3SKW/BHOoWrHkMiGzX4xZAItP4p1ApZNgJyKQuFqKN4Q8nGiiN
         xonOCrPRG1Q+2dBW1j5d2CBs/inYdqBInAaPv+Q9alVZ2rBUVUk8QqjVLC21wQdDjWtW
         Ihe6YlMly7D4koP1y4meIeaAxGJjFBLlk2vwK3iDTyKjmyQGjWun6F8f5f9zJJRqU00u
         2HfQ==
X-Gm-Message-State: APf1xPBmOfULOmPmytE5K9bvarus/Xo2mG2UuzxeT7Hpy1pn4EnVZaLv
        UNc20Mr/5wVZg9myAEDBh04=
X-Google-Smtp-Source: AH8x226DCp5KO1EBp5bLC6RjRmNjAdD98fOshYq4WIywjd4XlrCJbe8qxciFkbXRLQMIpFuh32AQVA==
X-Received: by 10.223.199.137 with SMTP id l9mr15013918wrg.6.1519769421706;
        Tue, 27 Feb 2018 14:10:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y28sm199074wrd.46.2018.02.27.14.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 14:10:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
        <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
        <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
        <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
        <20180226014445.GB8677@sigill.intra.peff.net>
        <20180226173533.GA7877@tor.lan>
        <20180226204635.GB12598@sigill.intra.peff.net>
        <20180227210517.GA17555@tor.lan>
        <20180227212537.GA6899@sigill.intra.peff.net>
        <xmqqd10qp07d.fsf@gitster-ct.c.googlers.com>
        <20180227215845.GA11187@sigill.intra.peff.net>
Date:   Tue, 27 Feb 2018 14:10:20 -0800
In-Reply-To: <20180227215845.GA11187@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 27 Feb 2018 16:58:46 -0500")
Message-ID: <xmqqzi3unkxf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Feb 27, 2018 at 01:55:02PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Of the three solutions, I think the relative merits are something like
>> > this:
>> > ...
>> >   3. w-t-e (Lars's patch)
>> 
>> I thought Lars's w-t-e was about keeping the in-repo contents in
>> UTF-8 and externalize in whatever encoding (e.g. UTF-16), so it
>> won't help the issue hosting folks want to deal with, i.e. showing
>> in-repo data that is stored in a strange binary-looking encoding in
>> a more reasonable encodign while diffing, no?
>
> I thought it solved that by the hosting folks never seeing the strange
> binary-looking data. They see only utf8, which diffs well.

Ah, OK, that is a "fix" in a wider context (in a narrower context,
"work around" is a more appropriate term ;-).

The reason why I have been nudging people toward considering in-repo
encoding attribute is because forcing projects that already have
their contents in a strange binary-looking encoding to switch is
costly.  But perhaps having them pay one-time conversion pain is a
better investment longer term.
