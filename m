Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F280D1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 21:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbeG0XOs (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:14:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33797 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389728AbeG0XOr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:14:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so6390277wrt.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 14:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=73XPyAks4WYfo3POpZOBfqSi+6/V5NouI2i6EsA8WqM=;
        b=XbjPHBXIzZXVux3SgkN3tKrOw54HDysfSi4qRVh0TC737JJ3wy7L+2fioOWDbL3kY3
         tk4/nrbbgdBP+zf6BuZojlS2O+PrU0RTk4skZsTGAtFD+rFX9tHYCV8Inlbx8P2zTPDM
         ucf6C9I6DpoXJyqlB9MW+yMQjBI9blie1u9GZSbDGtpZcSuQUwtX7pDrijLlG8pg/gxW
         WA+ox+zwRRK5zI7XMIDy26fBYItQ+b71P+Ag25vBB/vpSn17ar365s9c18/LNgiYBHpg
         klsJ3Xt1CvLx+CcKC5upUnNDGmSTjbdbOLRGRmbqoQJJ1lXs4hbJ4JeGNI9rxSTBeOVA
         UR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=73XPyAks4WYfo3POpZOBfqSi+6/V5NouI2i6EsA8WqM=;
        b=oEyS+ubywbv3lCx033Q+f/vQxQA2v/tp3DS1APaPsIajLqXYoCW5K3lu+5ZFFEUCgI
         GDSKmI1S/tgUPL9cIfThtYTPSiu7KCESLfFj1hIwX6Br/2QbMX8jvx8o6y3MxK0oDNFE
         qKyBK1gPdZmLP1xROzQEoxZme7wH40eLTuiJ6STMW26IWY975i50T6bXHCoPbyT0W2sp
         zJJYWJpNjHNvdFSdDHOLIsElz2mgiEZcXoqMQ2a5VR5Z2MUZEipOpOfs644N1vUO6iRE
         bauiFh1v5PeedMMxQVCrXPwfi1ejzYOLdJsOF11TlC9BZXsx73ZMJPEMDgY5TzORnXvE
         kLtw==
X-Gm-Message-State: AOUpUlEWL6FWlO/fq067Y6HBBoctf+5xcuUcbwim5aNcNXeMsEwSsZMa
        H6unevg2p7am2S6jvAk4Y/v3kvHq
X-Google-Smtp-Source: AAOMgpdUSjU1oiDb7kSdDXAqzdwrFtQ1/IUHVjHbP9UmQQzKtJA/4vUz2L5InbBGYpbPfAIc5CNo/w==
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr6905321wrq.8.1532728257446;
        Fri, 27 Jul 2018 14:50:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o125-v6sm5589914wmo.0.2018.07.27.14.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 14:50:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] tests: make use of the test_must_be_empty function
References: <20180605154501.13502-1-szeder.dev@gmail.com>
        <20180727174811.27360-1-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 14:50:56 -0700
In-Reply-To: <20180727174811.27360-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 27 Jul 2018 17:48:11 +0000")
Message-ID: <xmqq7elgl54v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change various tests that use an idiom of the form:
>
>     >expect &&
>     test_cmp expect actual
>
> To instead use:
>
>     test_must_be_empty actual

I trust that you eyeballed the result to make sure steps after these
converted parts do *not* depend on (or expect) the presence of an
empty 'expect' file (e.g. ".gitignore" has 'expect' listed, or the
expected output from "status" has expected in the untracked section)?

I'd imagine that kind of sanity checking the result would have taken
10x more time than the actual conversion itself.  

Very much appreciated.

> This patch is on top of "next" since one of the things being fixed up
> is a test in my in-flight ab/checkout-default-remote series. It also
> applies cleanly to "pu", and the only conflicts with "master" are due
> to that series of mine.

A patch that truly depends on all of 'next' won't have a chance to
graduate, but it seems you only need one topic out of it.

If I were you in such a situation I would have prepared two patches,
i.e. one to apply on 'master', and the remainder to apply on tip of
ab/checkout-default-remote, and made sure that applying the former
on 'master' and merging the updated ab/checkout-default-remote would
match the tree you would get by merging ab/checkout-default-remote
to 'master' and applying _this_ patch.

Let's see if I can tease them apart myself first.

Thanks.
