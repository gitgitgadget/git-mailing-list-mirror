Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA481F404
	for <e@80x24.org>; Sat, 23 Dec 2017 12:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbdLWMtz (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Dec 2017 07:49:55 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:45151 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbdLWMty (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Dec 2017 07:49:54 -0500
Received: by mail-wm0-f54.google.com with SMTP id 9so25967696wme.4
        for <git@vger.kernel.org>; Sat, 23 Dec 2017 04:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uu8ihit0IdldML1svrJQ2yiexX3e/GX1rag3a5hhUPI=;
        b=jXnnnic3yt8lU8Pql9xfsPVhBUhSBqHInzDULyijFIPh/9Jo8VO5Z5HMxGLfVruQXv
         IQjqu5g98B8tSTjar5OZ9egOEqZ+4gJBNKUDi3EBuz5K9HVGJNGQOywlGt4fylswcvMn
         JNdD/zYRfdpamB/qR7jMGq8CzeSNaCWyWaNLqPzsb+ceKlWGbmPjAwZ6EMuYJ3Ekw09t
         2rneij8uOF0xV8D0OwbvevyECl97W0RvbForblGqHmDvLmyrNtB89EMDU6ppY2JcbISi
         4BiDykZKfu04mqJ3vc1J5Xj+Nq61YXPPcP7EkgHMo8BQcO3QsjZAhVxfz66NnuI2Rbjt
         oQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uu8ihit0IdldML1svrJQ2yiexX3e/GX1rag3a5hhUPI=;
        b=W8mEIr8d/9paWQkyTszoQVGjzFj6EzIWBtn9kk7mVN6S8Z7u3Lu6UDK15jZbNh8Ph5
         5yV2uVWTW07kB1zCg/xv1gsEubmfhu4qmuhI/EepyHszGEw7yASVjCl+1m4sti4q84D8
         92pzs8iGgVmA3Mfp9wCtED9bgdGBbYYNBn5KsR1Nt/vz+zeFE80G6kxNZ3O6E+H9WF8j
         Xbud2+d2dXaIkYcqoDF9B2X17ti0CCeOR2Acr7mF9bHBqptbswupKFcm5KCdE/TlZ6x0
         xGe0a1OkkjAPzpnQckeixiX1Ptw74xUQtJUisWkffeRFZHhLWzl0GpY5bjGwBVNopNun
         81JQ==
X-Gm-Message-State: AKGB3mIF+vwJIQQfm2AIAXiQoYRbObE7yT0kzjqJYT3+zTuaLycVQfaJ
        KE3rm1HYd5/vYsdvFht30B4=
X-Google-Smtp-Source: ACJfBouG/8FfEZoUpDP6Zd9iRG+2Vrcoj644Bt8xEAzxcPhSt75Nak7wEZqhlbFlhnlnkf4kV2J2iA==
X-Received: by 10.80.134.18 with SMTP id o18mr19187534edo.306.1514033393057;
        Sat, 23 Dec 2017 04:49:53 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id w13sm20720603eda.63.2017.12.23.04.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Dec 2017 04:49:52 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Pat Notz <patnotz@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] commit: add support for --fixup <commit> -m"<extra message>"
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com> <20171222204152.4822-1-avarab@gmail.com> <xmqqzi6api5a.fsf@gitster.mtv.corp.google.com> <87h8sis9w5.fsf@evledraar.gmail.com> <xmqqfu82pgdg.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqfu82pgdg.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 23 Dec 2017 13:49:51 +0100
Message-ID: <87a7y9sj68.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 22 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> I don't agree that git as a tool should be so opinionated. You can edit
>> these --fixup messages right now with --edit, and I do. That it doesn't
>> work with -m"" as it should is a longstanding UI wart.
>
> I think you missed the point.

I did, yes. Sorry, I was being a bit touchy and argumentative there.

> I was expressing my opinion, not an opinion of Git as a tool, that I
> think one of these two "use case" scenario was a bad way not to be
> encouraged.
>
> That is totally different from allowing --fixup and -m working
> together.  That is a good thing that helps the other "good" use case.
