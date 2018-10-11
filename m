Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDF5A1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 02:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeJKJnN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 05:43:13 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35141 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJnN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 05:43:13 -0400
Received: by mail-wm1-f44.google.com with SMTP id e187-v6so7690070wmf.0
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 19:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dCRtyPlM7JTfstToNdcQpfrAGeTYSfNu/v0jT8LVKVs=;
        b=Ib9IXFkj9B1T/lW55+9j1kBtFwSAxHvL2rmsS7XgS5QXcti/j3Czvxaf/umWw0Z1Ed
         sm/JFk2mgnOetzymN8PrdrQMAwInFpAyF1vrpxtaNr2pEwapMDRd4IlAmlAE1/p/QdKA
         c9bFXgKLXptYTXeuXmDnq3HT3Hx97PD3D5mtsp7ceY+PfT7xo/5sZ2wByZBqN1USP0IK
         FbClTVNr4ELb9Ltg1hqG0HGjZeDtULC/Xiar9v4bO0blLvPAK6OoGkkbLq2rSkYoz5Ly
         6CKAckXkrx1zF+udpPq8p2xjMdrtB857BAe2k1DCGwgI1Z3MAQ/hVWwY/NQZEVSgHRl6
         bS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dCRtyPlM7JTfstToNdcQpfrAGeTYSfNu/v0jT8LVKVs=;
        b=sEf3cdQTpCzhttHrqsKUEp/jljdCkVOpOHOWeUxnRjwusa8eddMisC4cDjgRmobjKV
         wtEU1tMzXuj21Sejf5pClAH4DlvXc2+U+bW6PJiXVo1uih2CoKQ/vuyqNwLXdonTDs2U
         0SBSAmrmJLmsm0pwqXZWKBnfm87bafwCOv640GqkqUEkaGIIQWcvJl17vfBm6O1snMbU
         upqKn8d3JRUHPtmsdXu6CHLY1I7AWHi80ZXzN7DcA/h7s4kPW5PtZDsL18fOMS4x3JIi
         ciTFjk25UjpcMDpStxnfmajbpGP4c2UHULhN38YcpNJe0kuRX4BlZtrKRUbY6FgSDzWk
         RmyA==
X-Gm-Message-State: ABuFfogyNSlhc8ohs+k1U4YO740rduoHZn3+5bmI17dt6lh41lNfocS7
        Egby9NAM8diVTZ5lvzZwWaQ=
X-Google-Smtp-Source: ACcGV60V3XucKHxEdfvJ0ZMGn63JLxaraDuBBW4WLKGt4AOpk1L711WhxTEymCtCUi+LBO27+aruAA==
X-Received: by 2002:a1c:234c:: with SMTP id j73-v6mr13632wmj.68.1539224290883;
        Wed, 10 Oct 2018 19:18:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e196-v6sm13241812wmf.43.2018.10.10.19.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 19:18:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: builtin stash/rebase, was Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810101203571.2034@tvgsbejvaqbjf.bet>
Date:   Thu, 11 Oct 2018 11:18:09 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810101203571.2034@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 10 Oct 2018 14:57:35 +0200
        (DST)")
Message-ID: <xmqqtvltgra6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> https://github.com/git-for-windows/git/commit/6bc7024aecdb1aeb2760c519f7b26e6e5ef21051
>     fixup! builtin rebase: support `-C` and `--whitespace=<type>`

For c7ee2134d4 (rebase-in-c-4-opts); a single liner that is
obviously correct.

> https://github.com/git-for-windows/git/commit/1e6a1c510ffeae5bb0a4bda7f0528a8213728837
>     fixup! builtin rebase: support `--gpg-sign` option

For 28a02c5a79 (rebase-in-c-4-opts); the change looks correct (see a
separate message).

> https://github.com/git-for-windows/git/commit/ddb6e5ca19d5cdd318bc4bcbb7f7f3fb0892c8cc
>     fixup! rebase -i: implement the main part of interactive rebase as a builtin

You said Alban already has this in the update, which I took
yesterday, so I'll ignore this one.

> https://github.com/git-for-windows/git/commit/2af24038a95a3879aa0c29d91a43180b9465247e
>     fixup! stash: convert apply to builtin

I think we are expecting another round of update, so I'll ignore
this one for now, too.

> Speaking about the two `rebase` ones: they are simple fixup! commits,
> could I trouble you to fetch and cherry-pick them into `pu`, or would you
> prefer if I sent another iteration of `rebase-in-c-4-opts`?

Rebuilding 4 will involve rebuilding all the later ones anyway, so
I'll just try doing it myself and report back if I saw issues.
Thanks.

