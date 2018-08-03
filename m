Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481891F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeHCT5T (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 15:57:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40470 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeHCT5T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 15:57:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so6163309wrs.7
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UKWxBVz+cTbaBqXk3GI7btXiqrS5SY4hvfXlVvqHfII=;
        b=NxTdTves1PjoiLAD/i/7aLesvbm5ot9B3Ohe3z1tQQltDAOxTZMZWpM0VZKOR6pIwl
         ECzz9PXBDsf/1PujJbPvmviw/ZzuFQH95iBtlxovGvQnXb3hJpopfA2Noh0+KXdDsUqb
         c9bS1pIV0Y0du+zbxJJXVZxMPbEe6cxPR+6Iag/HR68+5wK9kNWVlNlSsSKSQJ+CEOwQ
         LqVXsCwfN1TY+i2hmYboailVbBHzL+RQGPgNkX0+I+jUvHnjA3eRyqqEBzHZnnLH9dR1
         FdA01Wia0PGQ87oVHmmfnWZpxzegTHYWZ7V77XtjlaIjjRevVwkBAOJLwsjwse5ZBni5
         EGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UKWxBVz+cTbaBqXk3GI7btXiqrS5SY4hvfXlVvqHfII=;
        b=pyODsAd4rS9f5BiiDutWtaFF1F3ZGzMT3NioVO7dEaLZ1VCchDZNPBNBGMPEUBoZ2N
         2AgSWy1yynv7nx2/Rv57rz0kh7efaujiG2Rx7SB10NyHLh8Mr9L6qABQvR5fHZHsiDon
         h3Q85f2M9NcDc/ewMScc/+DYFWo98LFZibgKAUYXu+oy1x6bKiPHEBptIML64j+UBMzm
         sHxO/r37fCvJdGTDIsPs9I+a6ResOtfvpuLTEy/e6PEa2Th2SiLhB8/5GoaUqoiKqbPX
         aqgzBwY5fj6/ErkdtG5eiVEb0zO2YOwPD4DGWwZL0I3K+jPSaC1Km8gLk0i7n/7vILa1
         7cXg==
X-Gm-Message-State: AOUpUlF5l+UeZgnL50iPjmUi90bLfsJ8Pd6p6nQq8swNYyNVQ7W6aEEz
        XevoF+8IG9QtsruoGQrFkd8=
X-Google-Smtp-Source: AAOMgpfoxJ+3mQpTcVFnozgcgmHOCK0oHJ5/XBmyHgEpodOZySC1AoqUZnncvbdQzybU2wOH4oCchA==
X-Received: by 2002:adf:e34d:: with SMTP id n13-v6mr3456307wrj.158.1533319197056;
        Fri, 03 Aug 2018 10:59:57 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id v5-v6sm6866156wrp.87.2018.08.03.10.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 10:59:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Git Mailing List <git@vger.kernel.org>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v5 0/4] add -p: select individual hunk lines
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180726155854.20832-1-phillip.wood@talktalk.net>
        <874lgjv8h0.fsf@evledraar.gmail.com>
        <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <d622a95b-7302-43d4-4ec9-b2cf3388c653@talktalk.net>
Date:   Fri, 03 Aug 2018 19:59:55 +0200
Message-ID: <874lgbtjok.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 03 2018, Phillip Wood wrote:

[snip (all made sense)]

> It seems clear for your comment and Junio's that I need to improve the
> documentation, I'm not sure if that will be enough though or do we need
> to change the behavior? [I'm beginning to see why all the other programs
> I tried while writing this (tig, gitg, gitk and mercurial's version of
> add -i) don't make any attempt to stage modified lines correctly, though
> I think git should have some way of doing it.]

I think this is ready to move forward conceptually, i.e. in these two
review rounds I've been focusing on the UI this exposes, and whether
this is even a viable thing to have conceptually.

I'm convinced that it is, even though there's osme confusing edge cases
(as noted in my mail) I don't see how those could be entire avoided, a
feature like this will inherently have such edge cases.

I've avoided going deep into how the actual code itself works / is
implemented in these review rounds, figuring that given the topic it was
better to move past RFC for that type of review once we had docs.

Thanks for working on this.
