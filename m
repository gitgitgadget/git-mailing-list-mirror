Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593E91F462
	for <e@80x24.org>; Mon, 27 May 2019 20:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfE0Ugk (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 16:36:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41628 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfE0Ugj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 16:36:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id m4so28281789edd.8
        for <git@vger.kernel.org>; Mon, 27 May 2019 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Ff0Vr4DkpOqCL8w9GrKYrvHdIxEt9dYrzMoNAR2sM3Q=;
        b=rUZa1Wr9ztsxsiAZAKDfa0BuXIH2hEwT1UUAb+DB62TXVgG7tF3y3ERINgj78jiXqp
         ysW/wj7gYoGtHJPVVHPWSMRIjwMx7g9Bp6qzhyUxeeQuhlOCtMXVbqtZJNXq7t6g6tmJ
         rs1oHu3RAPVmEc0Ib/0cFNT3xqvFLAFnQRzS9SmwC+trUJpCmHO0OUXHZF6fGRPM+be1
         DA1Puo1XoOTxlDBoeS+8CT1UHkZWkzOVIm0b66/dqrL766zPO+OkeGDdcLQuYC+9NyUk
         NoYOa5iCF+dwZbcccaQCjyupqXOZps0aJ5/eRfame3w+oHhb2F+QNnhF28T0RcAtKmfM
         2nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Ff0Vr4DkpOqCL8w9GrKYrvHdIxEt9dYrzMoNAR2sM3Q=;
        b=dKg4b2zktzR4TU+SUgJScd6oB8JmbHLYosUnAIZ7/d8kKGGlI76d2eMah8Dwg1xYU2
         gUWdiDKnglVGFpVN5+R/icHHQ2u5X188WdIDOMtbmoEdj7kHk7kJ+CEXo77ZPc89g0X9
         eGurAucpDsDNpwkRmyfb8ZCx5/sqXSERA1Kf8wGq4SRecojV5EwmoVSB0wNj+CBZ9BSk
         L280TYUDteRV16oBq6vK+vW0qJg1/YXwGohJKxGUgQSjDIUKfUwCdF9XDl7+rj8IOfLo
         LxfOJKkREQaEE0bNxzYaytDaI39RO5LXX7pPyt1V0nXY0sI5z/k5CRzUtHzfKcXwD8JP
         3jBw==
X-Gm-Message-State: APjAAAVX81/QB1kX8e5nWw02U154ruCIro1weAcQf2yFPC8lY7wCG0a2
        HJQHpSEbhQ/+1IUGqb1wnOg=
X-Google-Smtp-Source: APXvYqz9ed94x+vSwooMbpEV7C6utj06Z97VvgOeZQYhWPcke5BBrf81EBBYH3GOqUZXT5V3XSCBXQ==
X-Received: by 2002:a50:b7bc:: with SMTP id h57mr108944014ede.77.1558989398019;
        Mon, 27 May 2019 13:36:38 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id s16sm1891123eju.25.2019.05.27.13.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 13:36:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Chris Mayo <aklhfex@gmail.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] send-email: remove documented requirement for Net::SMTP::SSL
References: <20190526172242.13000-1-aklhfex@gmail.com> <20190527193517.GA22013@dcvr>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190527193517.GA22013@dcvr>
Date:   Mon, 27 May 2019 22:36:36 +0200
Message-ID: <87imtvmy7f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 27 2019, Eric Wong wrote:

> Chris Mayo <aklhfex@gmail.com> wrote:
>> git-send-email uses the TLS support in the Net::SMTP core module from
>> recent versions of Perl. Documenting the minimum version is complex
>> because of separate numbering for Perl (5.21.5~169), Net:SMTP (2.34)
>> and libnet (3.01). Version numbers from commit:
>> bfbfc9a953 ("send-email: Net::SMTP::starttls was introduced in v2.34",
>> 2017-05-31)
>
> No disagreement for removing the doc requirement for Net::SMTP::SSL.
>
> But core modules can be split out by OS packagers.  For
> Fedora/RH-based systems, the trend tends to be increasing
> granularity and having more optional packages.
>
> So I think documenting Net::SMTP (and Net::Domain) as
> requirements would still be good, perhaps with a note stating
> they're typically installed with Perl.
>
> Fwiw, I recently ran into some issues where core modules such as
> Devel::Peek, Encode, and autodie were separate packages on CentOS 7.

I've done enough git-send-email patching in anger for a year at least
with what's sitting in "next" so I'm not working on this, but just my
0.02:

I wonder if we shouldn't just be much more aggressive about version
requirements for something like git-send-email.

Do we really have git users who want a new git *and* have an old perl
*and* aren't just getting it from an OS package where the module is
dual-life, so the distributor can just package up the newer version if
we were to require it?

I.e. couldn't we just remove the fallback code added in 0ead000c3a
("send-email: Net::SMTP::SSL is obsolete, use only when necessary",
2017-03-24) and do away with this version detection (which b.t.w. should
just do a $obj->can("starttls") check instead).

For shipping a newer Net::SMTP we aren't talking about upgrading
/usr/bin/perl, just that module, and anyone who's packaging git
(e.g. Debian) who cares about minimal dependencies is likely splitting
out git-send-email.perl anyway.

We could then just add some flag similar to NO_PERL_CPAN_FALLBACKS so
we'd error out by default unless these modules were there when git was
built, packagers could then still set some "no I can't be bothered with
send-email at all" or "no I can't be bothered with its SSL support", in
the latter case git-send-email would work except for the SSL parts.

That would take care of the communication about module dependencies via
manpage problem since we'd error by default. When I package things I
much prefer that error mode to "parts of package silently don't work
because we check at runtime and I didn't religiously scour the
docs/release notes".

I wouldn't say the same thing about git-add--interactive.perl due to
more common its use is.
