Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6497C1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeB0VzG (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:55:06 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40932 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbeB0VzF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:55:05 -0500
Received: by mail-wr0-f193.google.com with SMTP id o76so320938wrb.7
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ijQI5Oj+AL7EXFQKupy1PluiRsy/bu8Q6V/aVF2AFfo=;
        b=a7zEFtmHzSjlzGJGick6JJyOcPlB/7VW0UB139OWU9R1ZLon5Y16N3sMcDXO6yojdl
         8w4BFM2YlzhzMgTikRq/D7n0TG4dobZJPePj9XYn8Ya8UyrVTxSFCC+AG6JzPzTk24yL
         HYJ4yNUIjG4tlUmtI6PPs9hZM4TYdFL2FoLbdlNmMHIGit35o/12WJuat/FXQ8KEbclo
         Eo1TCwgVBkXqb3KmXwrCjjJTRZeG/EwuDxFZAVcy0JsBpov+GlSL64GMBkX63qpxojkx
         YgglSKKB155+9u0PBvLBAsGetB5+IUO6q6gPFNUxDNlZWVcmUSE4G5wOQ5qB/HvFeP3J
         iZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ijQI5Oj+AL7EXFQKupy1PluiRsy/bu8Q6V/aVF2AFfo=;
        b=t8Wkt7fW6ahrCQIV0Z0iCGDkApDLe3GVLv/J/9v7CGLy3h4UnW4K2XxLIEcAUoDAxE
         TQOuqQGItzL8hPiFja4fa/OUDvHQ5glwM+HO7uzIq+tsLrwsaAqetcBQSlOaJy7hnVY/
         YNk89CXMFZDnrVdTFzoS2UHIUafhO3e1vWRojx5APAZVQdkYQLCFD5f1YYR0JftJ5Y4P
         OAL01S5seH27PdiVKuUpIjxghovpO5D7DQan6b/ckXcrYRTnYISyfzg6IBiETc0BF9bw
         WrgxfNzDiXpZlbH7dEStmPGGL3sq40AkRTCL/cNxfKCCTCVktOCm1hXrVpRFdMfWxN9W
         8KPg==
X-Gm-Message-State: APf1xPBvNnlAj8ky/oG8dbOxl9GicFEDIH654CCaKULuOBkpWA3ivrjs
        ukmLs/UyxIYLDAoS53fSbe4=
X-Google-Smtp-Source: AH8x226tKUy0Q2enTdtZ5t70Ph5UyhkzGt2W6mIsgGsDhuu1vKB4KqAYE5D2g838C61BJoRSQsKLvw==
X-Received: by 10.223.199.69 with SMTP id b5mr15322379wrh.212.1519768503603;
        Tue, 27 Feb 2018 13:55:03 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m15sm146051wrb.58.2018.02.27.13.55.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 13:55:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <DC552BF4-3E87-41E0-BF92-4BA9633D374E@gmail.com>
        <20180216165815.GA4681@tor.lan>
        <19EDC192-0D83-4762-AC6A-81F7D693475A@gmail.com>
        <xmqqbmgfvf2y.fsf@gitster-ct.c.googlers.com>
        <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
        <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
        <20180226014445.GB8677@sigill.intra.peff.net>
        <20180226173533.GA7877@tor.lan>
        <20180226204635.GB12598@sigill.intra.peff.net>
        <20180227210517.GA17555@tor.lan>
        <20180227212537.GA6899@sigill.intra.peff.net>
Date:   Tue, 27 Feb 2018 13:55:02 -0800
In-Reply-To: <20180227212537.GA6899@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 27 Feb 2018 16:25:38 -0500")
Message-ID: <xmqqd10qp07d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of the three solutions, I think the relative merits are something like
> this:
> ...
>   3. w-t-e (Lars's patch)

I thought Lars's w-t-e was about keeping the in-repo contents in
UTF-8 and externalize in whatever encoding (e.g. UTF-16), so it
won't help the issue hosting folks want to deal with, i.e. showing
in-repo data that is stored in a strange binary-looking encoding in
a more reasonable encodign while diffing, no?

Usually we only work in-repo encoding when producing a diff and show
the result in in-repo encoding, but I can imagine a new attribute,
when set, we first convert in-repo to the specified encoding before
passing the result to xdiff machinery.  Then convert it back to
in-repo encoding before showing the diff (or just show the result in
that encoding xdiff machinery processed---I do not know which one
should be the default).


