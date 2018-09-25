Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1475D1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 20:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeIZDHH (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 23:07:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50304 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeIZDHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 23:07:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id s12-v6so39883wmc.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UnX8botRMywNXrTAZlcsbNK6e1UF6Slg81PjOVGvKWU=;
        b=sAQeFPeeODuciBJ0qyWjQ0O3PfxQHqqBd7m5xpR6itymIi9wUHGY9XwSKFJBsPf3VF
         qsoI3aWgtIFa1uYS3TISPyWeHgGtNRJEYJkE/4NsfSZ0mewtv88xh4M1AmPJJkLu3v7p
         V5rb+OyMRwo0B9SlO9ASrGqpk6EsQTq1T82VJVEdedk+Ja6B56WlGMywqhsaZrDEJ8sw
         UoTZMxRBVHg+w6F92TLTXS4eSb+i+f8pBTofxxPq1ShDTwLenyhokYFy/v7sPWxlV2hH
         eUa414X3p4koytAPz9WneNcc5L2elPDTLbPWV9Sgw0E1AHIiP1l99LmFUzATACVNeJUi
         6j8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UnX8botRMywNXrTAZlcsbNK6e1UF6Slg81PjOVGvKWU=;
        b=CkTCHhXtK5VD5MndMwy5tF7KuW2CEgZ9M54b5hJtgi0WZKhVCOkllLrAUS7NUiXqUP
         PExX17Zqj+JjxHzuJwdEncXHd4sH2cAu5VCLdMXk7gJo0TskEzAFKQ6uOaZQcXi9ZI++
         dto4Hs6bk2yHDTKCv2LunS3S8XKjZMMfgg6hTtJOuEEAxzSOt67rV1xD6AHzQA32vcnK
         dTK6PVgnuy/FRjh8LkJylf3PitGQ8qer0g3/tg4wYRTkp5ziwXzThiIWTX4QvxHqCS41
         ylbAok/O41sdP5eJMoXXM8BMYKG3iyKDKxmlevwNGcUZfBfOTLJy6VBm9MpZ/PwtFSlp
         yyIw==
X-Gm-Message-State: ABuFfojn3Pb1hekSPFMCDHLmO39zAB47igMB7mBNj8e4mWXtjeQ+zbuY
        NG3yg0XmiYumnyNoEzYlrfQYkBoa
X-Google-Smtp-Source: ACcGV61GGUc83wSe7dp08RivGjOonU694A1Stg/9qUlIQootenmG5ClKtdHoAY/lmBkCuTaqBCvpEw==
X-Received: by 2002:a1c:88cd:: with SMTP id k196-v6mr2026369wmd.17.1537909059553;
        Tue, 25 Sep 2018 13:57:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 184-v6sm5986277wmv.6.2018.09.25.13.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:57:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a repository
References: <20180922124215.0c8172d1@pc09.procura.nl>
        <20180922141145.10558-1-szeder.dev@gmail.com>
        <20180924181722.GA25341@sigill.intra.peff.net>
        <20180924212034.GF27036@localhost>
Date:   Tue, 25 Sep 2018 13:57:38 -0700
In-Reply-To: <20180924212034.GF27036@localhost> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Mon, 24 Sep 2018 23:20:34 +0200")
Message-ID: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> However, if we go for a more informative error message, then wouldn't
> it be better to add this condition in populate_value() before it even
> calls get_object()?  Then we could also add the problematic format
> specifier to the error message (I think, but didn't actually check),
> just in case someone specified multiple sort keys.

Even though I suspect that verify_ref_format() is the logically the
right place to do this (after all, it is about seeing if the format
makes sense, and a format that requires an object access used
outside a repository should trigger an verification error), doing
that in populate_value() probably strikes the best balance, I would
think.

