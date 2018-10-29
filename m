Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8A301F453
	for <e@80x24.org>; Mon, 29 Oct 2018 22:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeJ3H0z (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 03:26:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36616 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeJ3H0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 03:26:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id x2-v6so8791825eds.3
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ut5/E+E4OloirnNbfRHsfDlQJnsVO0USoRx5WC8NIEs=;
        b=YXNkiO5DjPVJMKfgAGbLqxMrdCa9RvDYztGCp636Urabp6JhPDNqXli09JEc0FV1OM
         1JAcdXURnKfQJR/JRHXdxCUjKte92zzpyEb2k2bzRwQhvqhexjAVT2DmsaekVjTXYb0q
         92q2MKmWMtTNvAjtp61FyvpkFU5a5WnvIicWqMbah2EO2oCH97UUyhLqoSQCusD/A+2N
         TS80MQOZKWBOysYL3zVmhJF3p9VPqO+DhPpwW0oZln4qL4V9cQ/M233LsH4y5OWR3nvs
         Aik/ecITTOKOLARnoMSKdvdqhbfab6NJoAp69zqOnHyb2GK3+xq5bXHBiZRBKB5oHvk/
         qeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ut5/E+E4OloirnNbfRHsfDlQJnsVO0USoRx5WC8NIEs=;
        b=YxWwqKfouCsoFKMtu4TcAu0yoCQ9IvTaMhYGskGGeOzeWm+YWZ4TNrRH+IONbMUJYK
         rF780VRrpTN6sShWzPecvKm31v6yyQX1KR1oJP65gpgovEOn7bXDEWz1RQPVxO/w1hFS
         OZditD3WH+ky5eFWFQiOLQIJ5E468gNF8SkZjuDfpHjsQzYVnlBfS/hNhz8OQJobAovB
         AKA864CAPMK2Dmm1EQX7OUtg1aofHtlftkuD6fFzZEwEWFDxFAfaje1URk/JByDSH/mX
         T5PWOxNbuobguSfk0F3St+s0b3/h76Y63CWPr/1CpAnVUWNsUSBG+HGjEMkDUwAxTNiF
         rVSg==
X-Gm-Message-State: AGRZ1gJseQc+F1VM8qZq/sGfEfoObc9illRGIMgG6ZO/LqNZVavKvvtL
        rOU+2LqmTSmNFOwET5nr4jd6g3BGvjNZWEMrg3IK7w==
X-Google-Smtp-Source: AJdET5f0rAL+To0a5H2SVgyG1sBzzzsix7pstOK659TnvohQt3FPGP0hqbvvCofTUjLyIT97ohDMBxGdHMeOHU+iRgI=
X-Received: by 2002:a50:bc12:: with SMTP id j18-v6mr15024203edh.154.1540852570224;
 Mon, 29 Oct 2018 15:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com> <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com> <20181027093300.GA23974@sigill.intra.peff.net>
 <xmqqbm7da88t.fsf@gitster-ct.c.googlers.com> <20181029213453.GA8325@amazon.com>
 <20181029222742.GB24557@sigill.intra.peff.net>
In-Reply-To: <20181029222742.GB24557@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 29 Oct 2018 15:35:58 -0700
Message-ID: <CAGZ79kY=G5E-eyqH3j24KzeUqpgE8Pw-hJQcD5=OqTCMwscabA@mail.gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
To:     Jeff King <peff@peff.net>
Cc:     gerardu@amazon.com, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 3:27 PM Jeff King <peff@peff.net> wrote:

> So yeah, that's the other thing I'm thinking about regarding having a
> maximum loose cache size.

tangent:
This preloading/caching could be used for a more precise approach
to decide when to gc instead of using some statistical sampling
of objects/17, eventually.
