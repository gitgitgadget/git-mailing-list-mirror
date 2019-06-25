Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D41251F461
	for <e@80x24.org>; Tue, 25 Jun 2019 18:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfFYS1g (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 14:27:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34856 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFYS1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 14:27:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so3986008wml.0
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gHm8roYp/Eh4QtCBnzt3onO5Gx5nkN/sZ9e8FYHKse4=;
        b=tQMftMfc7eO9PxeUeElzokb8WC9TLM65M+vuBOP+tH7gnFA5++Vo/JxwjZ+fUnlZO7
         h++ZLqVeRHGQOmD+ea0MtHN8+3zHpDX4wWFki/T4ZqmStQnCE1m2OmwEbwX6OvNnnMyy
         +jPlBWaMqtI0BVR1KFtp7RPxKnEF2v4K8mOmdps2GwIarJt4b3ffXamG6PQU459nFFxE
         AwP5oqPjiAMflbw3TzYOPiIwfalQQiuGLBX0fXER6INU5EKQsZPxhhCuzqwEw5kYVQCT
         FIHSz/FMTk22hbxwQmTGWDCy2ggB/m2Y+3ZgxPgYWRXMZYKB+U0XZUAxAf9mVWfaN/Du
         UMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=gHm8roYp/Eh4QtCBnzt3onO5Gx5nkN/sZ9e8FYHKse4=;
        b=fDWFU5AOusUgTDUtjyeZPc8PphSTuY8ZLrW5RkOTUlEfDg+UYAV9c1Ne5cPifVbali
         9s0ocDhOPI4qvZclVwi1bdJ+bXR2v1r7lSXYm2xgTC1eI11aiT+MxT/JilYUqkE49X8H
         MukZWIJma//5/mSfXY6Nnm83rX7BMMlQ2be00OW6IC72j9tGkU+KrUUrlFoiZohlDjPv
         J2Ze3wzzlytSHKONKCFWnxP7/bu/1Ueh5Ll/9tEHGDt8sU20GRxHc+e3Mkv7jqPl3Xq9
         t8YK8rQM5vyyWvviaaqxLJYCCAlp3MeNYzVRQFiDKjA2Pro7LEcOyu8XkYkrysxUNnNJ
         JntA==
X-Gm-Message-State: APjAAAUDtZTqRI8NZsjzRZ9AzeiDp5Q3NeJRfVfb2Dq9YJ/4TuUyEhNd
        4jQqD5TkkRew8X7xKZXSmmUllQKNwU0=
X-Google-Smtp-Source: APXvYqxL++ysu/8Gnjro2UZa3XA3q1NhZAen56naqX5FHpGxL1SAcfLeAuhdkAr89rgxKfdh6w/qSw==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr21355256wmf.51.1561487253374;
        Tue, 25 Jun 2019 11:27:33 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abpv205.neoplus.adsl.tpnet.pl. [83.8.63.205])
        by smtp.gmail.com with ESMTPSA id l12sm31509175wrb.81.2019.06.25.11.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 11:27:32 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
        <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com>
        <86blztq8ap.fsf@gmail.com> <87tvdkg7ld.fsf@evledraar.gmail.com>
        <20190523222031.GC951@szeder.dev>
        <f05405d7-c78d-a0e4-75a1-d623f977400a@gmail.com>
        <20190524093459.GE951@szeder.dev> <87o93sfahj.fsf@evledraar.gmail.com>
Date:   Tue, 25 Jun 2019 20:27:32 +0200
In-Reply-To: <87o93sfahj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 24 May 2019 11:49:28 +0200")
Message-ID: <86ftnx4j1n.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
[...]

> To clarify (and I should have said) I meant it'll include only packed
> commits in the mode Karl Ostmo invoked it in, as Derrick points out.
>
> But yeah, you can of course give it arbitrary starting points, but
> needing to deal with those sorts of caveats makes it rather useless in
> practice for the sort of use-case Jakub mused about, but more
> importantly a full XML dump of the graph isn't going to get much of a
> benefit from the commit graph, it helps with algorithms that want to
> avoid those sorts of full walks.

Actually for an "XML dump" of a graph of revisions (assuming that you
can give nodes and edges in arbitrary order in this graph output format)
doing it using serialized commit-graph should be faster: you only need
to read one file, and convert it to other format (perhaps even in a
streaming manner).  No need to delta-unpack, decompress and parse commit
objects.

Though on the other hand you are right: if "git log --graph" uses
serialized commit graph, and it is used for XML / JSON dump, it should
also be fast.  If there is no serialized commit graph, you still can
generate XML dump.

Best,
--
Jakub Nar=C4=99bski
