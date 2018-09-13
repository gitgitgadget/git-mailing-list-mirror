Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EFC81F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeIMX4q (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:56:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43290 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbeIMX4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:56:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id z27-v6so5438607edb.10
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=y4j9EEUUQDJAIQ/k/MGm7UHzh+tnbRALHiacUN2ceKA=;
        b=sz5GejwAEavm103tr5SZ7YVnUB9rQs2n5UH8O5JXi8vAR1CjVDafKKo0SrmuXuQQjI
         EpY6xPrHU2zOMlQyYCY3RH5uEWpATSXuZfsrUMv1ph+5ar459SUiuTR923IV52OP2hBV
         Qocz9mKCajKaO827MBEUXbwMVbHGwXXBdBbZeNCVtfVHn9KQmPpFLEuUVa9mYaviQ15i
         5HNNqAZSON+rSIkoFdXJLv1wTwYkb1S/voPgbmdxw2zry/1iq3KYGBeai4lMJX9aEAd3
         TxNoykva+SQhksNJqXOlgzdwFy+HCJT6uoz1e24CAbIu/8j1DkpWTTlQ+YgD1Q3gF+g1
         KE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=y4j9EEUUQDJAIQ/k/MGm7UHzh+tnbRALHiacUN2ceKA=;
        b=lh01RcZv+Glr5UNHcC2ni3RBBKhXL8yxMeXW33AxaFihk2htWJ6o2PwgRsPp3DjS8Q
         wSA1Gr9jHvD/nDhfFhsUuqbN7b/4gfbkV3UEfWqnM6lI4/+F2lDvDFNc8YykmDv9v2fI
         fRAt2FbLFz1vo4G67cF4l17m4rW4cZW0KPgbvr6rVEe7F/8WauECzBQ6LMlxqFbgPx5P
         s560YopADf2qPeBTKF84CwaVDeWMd3juIgegAhxcl8cqKnQLb8Wt8jPWE7mYNgj0+1kq
         qto586H7xN3oqal8tLmJt+xwN2SJnAFtawB+H2JNCzFW33WeGF3p+j0NFhFRImrCKNDO
         2b1Q==
X-Gm-Message-State: APzg51Cnsf6+3OeRKa5AXouLMS7GqJRy39oR/IPIv1VQCQkPSL40CgXT
        ba+JTYft/v4jsdrqTLlNSpH/u8dZJkM=
X-Google-Smtp-Source: ANB0VdZUMaAMNHehINz2cd30v2JibyhOUkIVAHIpQtkPPDdzoUC1PgpD8eTK5Z4kKrx9QEqhNgSwAw==
X-Received: by 2002:a50:f297:: with SMTP id f23-v6mr13534830edm.40.1536864360714;
        Thu, 13 Sep 2018 11:46:00 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id a33-v6sm2235361eda.2.2018.09.13.11.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 11:45:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Brandon Williams <bmwill@google.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH 2/3] archive: implement protocol v2 archive command
References: <20180912053519.31085-1-steadmon@google.com> <20180912053519.31085-3-steadmon@google.com> <CAGZ79kZOTsUH=zQX3rLXvuSOx1vp8C98maSn47ssfca8c-BrBQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGZ79kZOTsUH=zQX3rLXvuSOx1vp8C98maSn47ssfca8c-BrBQ@mail.gmail.com>
Date:   Thu, 13 Sep 2018 20:45:58 +0200
Message-ID: <87k1npkzh5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 12 2018, Stefan Beller wrote:

> On Tue, Sep 11, 2018 at 10:36 PM Josh Steadmon <steadmon@google.com> wrote:
>> +                */
>> +               status = packet_reader_read(&reader);
>> +       }
>> +       if (status != PACKET_READ_DELIM)
>> +               die(_("upload-archive: expected delim packet"));
>
> This is upload-archive, which is a low level plumbing command
> (see the main man page of git for an explanation of that category),
> so we do not translate the error/die() calls. Besides, this is executed
> on the server, which might have a different locale than the requesting
> client?
>
> Would asking for a setlocale() on the server side be an unreasonable
> feature request for the capabilities (in a follow up patch, and then not
> just for archive but also fetch/push, etc.)?

This would be very nice to have, but as you suggest in some follow-up
change.

I think though that instead of doing setlocale() it would be better to
pass some flag saying we're operating in a machine-readable mode, and
then we'd (as part of the protocol defintion) say we're going to emit
GIT_ERR_UPLOAD_ARCHIVE_EXPECTED_DELIM_PACKET or whatever.

Advantages of doing that over a server-side setlocale():

 1) Purely for translation purposes, users can update to a newer client
    to get new translations, even though they're talking to an old
    server.

 2) Again, only for translation purposes, servers may not have the
    appropriate locales generated and/or linked to libgettext.

 3) Ditto, some clients that aren't git.git may want/need to emit
    different translation messages to their consumers than what we have,
    think some GUI client / Emacs magit etc. whose UI is different from
    ours.

 4) Aside from translation purposes, getting a machine-readable
    "push/pull" etc. mode would be very handy. E.g. now you need to
    parse stderr to see why exactly your push failed (hook denied, or
    non-fast-forward, or non-fast-forward where there was a lock race
    condition? ...).

I also wonder if something like #4 wouldn't compliment something like
the proposed structured logging[1]. I.e. even though we'd like to run
git.git, and present exactly the message to the user we do now, we might
want to run in such a machine-readable mode under the hood when talking
to the server so we can log exactly how the push went / how it failed
for the purposes of aggregation.

1. https://public-inbox.org/git/20180713165621.52017-2-git@jeffhostetler.com/
