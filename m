Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0500D1F404
	for <e@80x24.org>; Sun,  4 Feb 2018 04:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750821AbeBDEoU (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 23:44:20 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34923 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeBDEoT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 23:44:19 -0500
Received: by mail-qk0-f182.google.com with SMTP id 69so15699545qkz.2
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 20:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ssPqt9xcDY9ZqKrMQ3JQBiArbMfUNKubyXz9hurlXCk=;
        b=G8WLLBQpr68Tyctlh0QyZS+ZaJiYS+1KoLJVaztydWdU4PTgl/eAzFVRUTxyqQMsIa
         oxqcsfAu9bavqxjLx95PFrzCipC3ludQEJdqvqmgxIphjc3Rd9MwME3+eehxZhH86dbs
         +kf15bFX0OaTQdtwX+YmeusJs5s0oDBObxfqgHzoZbyvLH6x5Hjr/qbqjaGhDlYhz11j
         hjlevMZtMA1EpKcYJUsn5FFD4wdE/p2QaBCLXbN2XlR7h+6XSoMUrOMckl0Yy8QG9umW
         WsZW2IkhB6ihkVDza/OMlN8KHGtZdaMj0oI745wuQhBrqObKVCYlFnjbpweKsVfMNuYr
         CGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ssPqt9xcDY9ZqKrMQ3JQBiArbMfUNKubyXz9hurlXCk=;
        b=mFllLtfTUD7cNumbENIuv5gSaeJATkeN1Yrs67a6jLWIoZT66Bql0TGtlxTlDCepYP
         uYqrADB6f/nWNuFC0l0POzdo3LbBPW5EuIXZJXFbdPjl9ISLGJK1vZqEy0VYLguWGcY5
         Zr8OuTSH4NuHo5vDJOZ3eQLHHWuXoObRNqZFuHoLJfVkWpO9EVAxgp/ImjRZxUVNrIUi
         biZNItM80aKgXfVo09DrtHPX1fPbYvbBjTNmfuNNn7PYpKwqc6DvqqiaptE4AZkLKcX4
         2/CHPS/kgmI3FupOuduwT6PSQdmm9TVg1jLMUOP6Pn5NZz/feywqa0wlZj4sRsRjKrRm
         4nhQ==
X-Gm-Message-State: APf1xPBgekqbDuLAXV/iL4qH7hV0kBaOGwT/PDHwIl16YmOMzZeIFaVc
        quJQ5wEm8t56CyXSUCjh0waSFq2akAC8GR0dWxI=
X-Google-Smtp-Source: AH8x224s4lpfkkxnLuH6DWZj/UAjXiEllocvebcIqcp0J5IH6MM3FiNwBkGLiv5deP3Velt2uf8drGTg1jLN9iqyNLw=
X-Received: by 10.55.27.77 with SMTP id b74mr5907366qkb.212.1517719458289;
 Sat, 03 Feb 2018 20:44:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sat, 3 Feb 2018 20:44:17 -0800 (PST)
In-Reply-To: <CAPig+cQu20ZH3hj=2MSNqS3K-+qtZjtHAUQA0TL1LOG685yQtg@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-20-newren@gmail.com>
 <CAGZ79kb2+tpr0K0x2VVfFR-u3W2htvbxokxfKBpG60mNjXGPEw@mail.gmail.com>
 <CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com>
 <CABPp-BGwAu7_+BJR+43G2SysmBMnZYEBtHnwjMZBRn5XDPubWg@mail.gmail.com> <CAPig+cQu20ZH3hj=2MSNqS3K-+qtZjtHAUQA0TL1LOG685yQtg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Feb 2018 23:44:17 -0500
X-Google-Sender-Auth: 24FxKY_yESp7E_68J419w-bgoFc
Message-ID: <CAPig+cTnvsvzVTEAJ2HNw_0oefETNp_C1bxUYS4XiMMDN7O1Gg@mail.gmail.com>
Subject: Re: [PATCH v7 19/31] merge-recursive: add get_directory_renames()
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 3, 2018 at 11:42 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> [2]: https://en.wikipedia.org/wiki/Diaeresis_(diacritic)

Correction:
[2]: https://en.wikipedia.org/wiki/Precomposed_character
