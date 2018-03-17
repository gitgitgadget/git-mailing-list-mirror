Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FDC41F404
	for <e@80x24.org>; Sat, 17 Mar 2018 23:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeCQXuN (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 19:50:13 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:45119 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753370AbeCQXuM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 19:50:12 -0400
Received: by mail-wr0-f175.google.com with SMTP id h2so15011273wre.12
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0YmyXzsprikrLGbHAjRKVqg1vwFI/s9xC6Tn/pEvGTs=;
        b=PnKXlNII0Fy/8LO6P4HCatPj4LTR+xc63Sz6As6cy3kV1Cf4dNiln/9fOcZ3UFzAcx
         QdDjc8fiO2dW2G8xE8SVUo8q9pJR066aofThb1I9dQLYpkGbx3DcLpcMRz/SBMbSjACx
         xhIuS/pMwwVh7ZpJDlX1xiEZhCmrivxwiJdwt5JpQK/FF7+ODYbx0zU5+uR7/mN7PsZk
         eLuMJYkjxipbGId6odi0nkS7SBmmZ5AJuMLQaKairose2Ni7/osXEq2nsBSO1X2lJkqy
         qDXB/OuvCaW1V2UStwncxxKLDvQlzg02cvfSe3mzuUK/HGBUINgOfnAShmYswDHFXFMf
         yTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0YmyXzsprikrLGbHAjRKVqg1vwFI/s9xC6Tn/pEvGTs=;
        b=B2n85aXJjKrMDgLoe9jyVAsEgp/aNKani6uAwhq8uxcV1PrgWK0pclIOzCKExAOgh2
         OKnFD/9e5aE2qiWH0CTy/nFck1LRNIElaFFWsbUMTMQciJpvD+/OrryChjPRBJwXkk4K
         2aIFGbV0jhQjjp8yzRnusfkumHgWjTZYerJOPYlbvmcEJeJCDxIgtGKWeO2CkAgAhSwN
         p+eZZXG203oEhcGoMw7E1MY/YnyJFP8i99lQL/euCCS3IG0Eu99F6pL+EPb+P2a7ZWdv
         gz/Ue+sNJw4/jwRxLX6eky0aYQNvUfa853LIRiBR5ZYjDG7oswIdQ1rZ/eriDYSl59ZS
         Lr/Q==
X-Gm-Message-State: AElRT7El7KPGkphNCtJIkun7i/6MkAuy4MPWKl1rkocEqaW/gDwBh7ME
        O9bNedvQoRIz8PXQz2lDxLU=
X-Google-Smtp-Source: AG47ELvphvMZiwsscjfbsKYoO4RgPqvaTeCkWAG8IRc25B1z3bVrW29ToaZg22KawBQYnuCe1o5cVA==
X-Received: by 10.223.224.200 with SMTP id e8mr5318756wri.149.1521330610428;
        Sat, 17 Mar 2018 16:50:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 188sm16107937wmx.14.2018.03.17.16.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 16:50:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] travis-ci: enable more warnings on travis linux-gcc job
References: <20180303014605.10603-1-pclouds@gmail.com>
        <20180316193355.20161-1-pclouds@gmail.com>
        <20180316212208.GC12333@sigill.intra.peff.net>
        <CACsJy8A3_itjs0MRar+Aog=0yZDuAK2-x4MU=Rvqh2C6Le-7Aw@mail.gmail.com>
        <D8137CD9-9E11-4FBC-B89B-907C007FC6E9@gmail.com>
        <20180317145923.GA24689@duynguyen.home>
        <20180317160832.GB15772@sigill.intra.peff.net>
Date:   Sat, 17 Mar 2018 16:50:09 -0700
In-Reply-To: <20180317160832.GB15772@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 17 Mar 2018 12:08:32 -0400")
Message-ID: <xmqqsh8yxnwu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Unfortunately I think that's hard to do in pure make. But we're already
> relying on $(shell) here, so we could just move the logic there.
>
> Something like the patch below, perhaps. It should do the right thing on
> clang and gcc, and I added in an extra clang-only warning I've found
> useful. Otherwise the list of flags comes from your patch.

I see this discussion is going in the right direction, and like the
approach taken by this "how about this" patch.

Thanks.
