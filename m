Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4041F453
	for <e@80x24.org>; Fri,  5 Oct 2018 06:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJENHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 09:07:13 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:35453 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJENHN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 09:07:13 -0400
Received: by mail-wm1-f43.google.com with SMTP id e187-v6so725349wmf.0
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 23:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rx0nSjK6Do9yst4b3d2c27yeJuJVL1ukgIR7cMYjam4=;
        b=ga86P7YirvyvbxenShTDhDgfKpfqBiUo83kE/V5Z+NAa1Xqx47DAGmKtqdkr2aFHUn
         QR9iAnViKSpN2/nh4nQnKnnMT5eJwHD7DWbhTCZued7mz1kCh9sw+LQ33cdWRyNJQoKR
         jwDqWinHMhk0mUgiK04zeyHKhFoMPi2jEKDkEjJb8IgSYPYHCe2pREVujObE1+5syLzq
         T1aeaI/mqhJFP7Ou8MgEis/OEG2+TM1HOBRKkA3CeXLV4PJhTS9AY8gz2HLiWLlx4lUS
         J+Rlcfb8cpZgacJ79MevbBMzbP+GsI2iXYiTCKwNxXaA/r+zpr4pBVDo29d1T6/hRY+o
         ehAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rx0nSjK6Do9yst4b3d2c27yeJuJVL1ukgIR7cMYjam4=;
        b=WAO/GgOg5W3Z2fop4zh8L4EPKffK+HgD7Wm0sm8gRUQWctYzKbenyHIh3xw2wxWUTc
         GRwgRHsNzgiTdhF3NU/E/zMS0a7ImScbxHzWr63IHufmtd+yJHEKT7g6HPB/vAP1o9Xg
         Y1tGFrHoYdU9+bVhphk/R5tkvxkk4XxjVJ0U22HIGet8xKjS/+Covh8aE3jNhh3j+v4R
         uy3IXSJI5fzsX0yUvhVPXMbFyR1tvbqzZ7rNNx+U05APu9IFbM9bJ4HSZYkLjqTSwawf
         z/IBz6UuYRB3aPy9goUxxgqACNYGsSTCwAMCk+0deCeMPzbNzC5uoLQ0rlkUlTRWWyuW
         Gvuw==
X-Gm-Message-State: ABuFfoiy0pED8AdNthDtM32ZbepvN6Hnwvk/H73gxplhfg9zzVmLIDJ0
        vUU3NZSKtwHmcIXKMv7emd4=
X-Google-Smtp-Source: ACcGV630QnX10cindCce9x+YzMpCNxbc/HYL1o2FACiQs3AKvRsYzQaphPz11uTiGE7jE1XEOFgtIA==
X-Received: by 2002:a1c:2984:: with SMTP id p126-v6mr7117744wmp.5.1538719800051;
        Thu, 04 Oct 2018 23:10:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x186-v6sm1236473wmx.24.2018.10.04.23.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 23:09:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
        <20181003133650.GN23446@localhost>
        <87r2h7gmd7.fsf@evledraar.gmail.com>
        <20181003141732.GO23446@localhost>
        <87o9cbglez.fsf@evledraar.gmail.com>
        <20181003145308.GP23446@localhost>
        <87murvgir6.fsf@evledraar.gmail.com>
        <20181003165926.GR23446@localhost>
Date:   Thu, 04 Oct 2018 23:09:58 -0700
In-Reply-To: <20181003165926.GR23446@localhost> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Wed, 3 Oct 2018 18:59:26 +0200")
Message-ID: <xmqqpnwo3ow9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>>     git-gc - Cleanup unnecessary files and optimize the local repository
>> 
>> Creating these indexes like the commit-graph falls under "optimize the
>> local repository",
>
> But it doesn't fall under "cleanup unnecessary files", which the
> commit-graph file is, since, strictly speaking, it's purely
> optimization.

I won't be actively engaged in this discussion soon, but I must say
that "git gc" doing "garbage collection" is merely an implementation
detail of optimizing the repository for further use.  And from that
point of view, what needs to be updated is the synopsis of the
git-gc doc.  It states "X and Y" above, but it actually is "Y by
doing X and other things".

I understand your "by definition there is no garbage immediately
after clone" position, and also I would understand if you find it
(perhaps philosophically) disturbing that "git clone" may give users
a suboptimal repository that immediately needs optimizing [*1*].

But that bridge was crossed long time ago ever since pack transfer
was invented.  The data source sends only the pack data stream, and
the receiving end is responsible for spending cycles to build .idx
file.  Theoretically, .pack should be all that is needed---you
should be able to locate any necessary object by parsing the .pack
file every time you open it, and .idx is mere optimization.  You can
think of the .midx and graph files the same way.

I'd consider it a growing pain that these two recent inventions were
and are still built as a totally optional and separate features,
requiring completely separate full enumeration of objects in the
repository that needs to happen anyway when we build .idx out of the
received .pack.

I would not be surprised by a future in which the initial index-pack
that is responsible for receiving the incoming pack stream and
storing that in .pack file(s) while creating corresponding .idx
file(s) becomes also responsible for building .midx and graph files
in the same pass, or at least smaller number of passes.  Once we
gain experience and confidence with these new auxiliary files, that
ought to happen naturally.  And at that point, we won't be having
this discussion---we'd all happily run index-pack to receive the
pack data, because that is pretty much the fundamental requirement
to make use of the data.

[Footnote]

*1* Even without considering these recent invention of auxiliary
    files, cloning from a sloppily packed server whose primary focus
    is to avoid spending cycles by not computing better deltas will
    give the cloner a suboptimal repository.  If we truly want to
    have an optimized repository ready to be used after cloning, we
    should run an equivalent of "repack -a -d -f" immediately after
    "git clone".

