Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AD21F453
	for <e@80x24.org>; Mon, 15 Oct 2018 04:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeJOMG0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 08:06:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52178 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeJOMG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 08:06:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id 143-v6so17298501wmf.1
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 21:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7ZlEdnDIdC1SHIRZOH5R3iZz/+cPQi5LbPEKAbEEt8I=;
        b=MqggreyeBhMTdkFL7zW/wo5yXw4VLq7xTFH+we92LCdK0Uch40QWTw5Z8qyjeVUMEE
         rvwZLClE7RgC7nGmcGBYXYZ+fIPaWiOzfSRY8UBUPzhw1nMO9s73RpVRAevaFuEY9UZX
         0bvp/irXNYurIhZuKt/t4h1Ye5pL4gjjjPs5AUQm6wzmydmfbWlfeVx5l+HQrH7eHJ/E
         WdfWVW5352zq5XAROh2Uh1udLigT8cvpIrPftHMN1gSQd+svW8k8avBCAzd96Q27/ijQ
         CkE2Ir8r8KOlmjjS6xBxbLkLPJhZilkeP5wZiZG6NAnyHMiXUR1MdkXVU35WKtgASdOo
         tddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7ZlEdnDIdC1SHIRZOH5R3iZz/+cPQi5LbPEKAbEEt8I=;
        b=gxaMbsyDp3+u9pParH21+ic1b+a0mdWWwRHjFlCtNEnbYvPspNBBGxFilqOmGfaQf/
         mkEBqwgi1VdcckCA6Y6RF66LiZsrCVU+S9/KKKRRXpN6H187W0zeDH2sH5No4gUDUzYG
         kZbjhLusxxB8eL1LVeRnAtxclVFNcZ9S3sqQ2NRncCsJvodSYDbOvbVjFG2Mhy05BUz6
         ajqMfOEpwQuiFmh4vhbhXiN58wRBRhyAsR8vOO4Bz6pmSeN3bcjv154UCTV+lt8xlPw5
         SRKIiSXmawUaKC5CbjaHZa2zw4OCiYi54bqyZJcbv4UQkiDl7RX0epoUVUnGvnruNsRC
         xG0A==
X-Gm-Message-State: ABuFfogMvQotsTyHMk5x0kM3B9weZ/AHtE1mTwaZ3Hql4peDLiE/XZ+N
        Y6/bMF3f7LhvGg+rne6+VHs=
X-Google-Smtp-Source: ACcGV62zQWk1Lae/4VhAN38Ogs5XL8sNUGQIDFSVA2kOkms7gPwp3XsKfsKUrRtfRid2K6OJr+XoIw==
X-Received: by 2002:a1c:6504:: with SMTP id z4-v6mr11227262wmb.130.1539577378328;
        Sun, 14 Oct 2018 21:22:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 130-v6sm8320043wmn.7.2018.10.14.21.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 21:22:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
        <20181012204229.11890-1-tboegi@web.de>
        <20181012222234.GF19800@szeder.dev> <20181013050057.GA6805@tor.lan>
        <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
        <20181014025207.GA1527@sigill.intra.peff.net>
        <1e3233f4-ea40-6fff-0951-6b4885f88445@ramsayjones.plus.com>
        <20181015000147.GB13510@sigill.intra.peff.net>
        <d3d291ea-00d2-f0dd-5a43-cbea5476d64d@ramsayjones.plus.com>
Date:   Mon, 15 Oct 2018 13:22:56 +0900
In-Reply-To: <d3d291ea-00d2-f0dd-5a43-cbea5476d64d@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 15 Oct 2018 01:41:19 +0100")
Message-ID: <xmqqin236dpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> 
>> For the record, I am not opposed to including the comment _and_ using
>> xsize_t() to do the cast, giving us an assertion that the comment is
>> correct.
>
> Heh, I haven't found any enthusiasm tonight. Let's see if there
> are any more comments/opinions.

OK, in the meantime, I've replaced the thread-starter partch I had
in 'pu' with your v3.

