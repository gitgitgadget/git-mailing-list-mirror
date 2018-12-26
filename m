Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58A6211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 22:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeLZWOd (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 17:14:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54645 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeLZWOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 17:14:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so15406596wmh.4
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mVLfZGCUNoKzGIxZRZdHUiabY+9+dhaqRNcZWml50lQ=;
        b=jBGBlGafokCI25EuF5bsBiOqHurxd38+T7Gv89+KIQ1FeZoTJ5Na3dK9RmHcHQWzov
         vkFLIRPBgzstp57aV7lCd92QVnxIYLZTFMZ95rKKV7/2Vo8NIEca4UuLbz8LT12ZdFHw
         1aA6VQm8nctKmG0XB1Cs8kl24b0RjjOX6erc1yhRCNzsWGVx2Jcd9poX8rogVeVYpDMh
         AH9thMHMi2WeU53CYXMrrWgHeqnl6Uf4x1b6KA6IFbhdDyJM0zm8rN8IsWIARSTo4P7x
         HERz6WPzLyRUBwkAAbjHc3jDKLoFL9Bo6/CR0j8Mms9uklj2PKXnIGe5R3FwdWK+6uXu
         Av4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mVLfZGCUNoKzGIxZRZdHUiabY+9+dhaqRNcZWml50lQ=;
        b=QpzRjYtdUAT5MkUO24kVZQf5pBaJjnTy3LtIiTa2XffP70xqM6cArOEfwZzKViR/YN
         VCJdrpEw5K/Oe6n6McAYsuhOFSRzyOwb8cNExNMoX3CwiYQgQJffJhKOBfSUF6b0MuOL
         ewYp/XV3giunXFGLb4t5XVA8sAVyhcYoo/YFVjlZbbL43L2dZ3Gv9DfbGY4KiS0sD2N6
         vmm9vQx/X3p7vcyb5u4y4Qg5qe7zF4hf0Yw5i+gQXluqwGmKqfP2pNKN4g5UDyb9SAcD
         bcJMArmymPPBoEg0cXHd86une+rbqez9FGNksGEqXJOiwNBfxxlk1cxkziw71ssLkHDz
         PvPA==
X-Gm-Message-State: AJcUukc4Ni9EOga+lIX+y6raaZjyZTYst1HWqBdEE1wJCovG4eTvLT1f
        Rg6IAG1Zn+duDoEW+hhCeiE=
X-Google-Smtp-Source: ALg8bN4YuVSG63n1QFM6ToWSb3W7e8sNQ72yn2xSWXsa3lhNd0VjcpxKyKBWBQTAd7xh0zlakVWBtw==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr19942972wmh.92.1545862470559;
        Wed, 26 Dec 2018 14:14:30 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c129sm20445348wma.48.2018.12.26.14.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 14:14:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under GIT_TEST_PROTOCOL_VERSION=2
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
        <20181213155817.27666-9-avarab@gmail.com>
        <87pnu51kac.fsf@evledraar.gmail.com>
        <20181214101232.GC13465@sigill.intra.peff.net>
        <87o99o1iot.fsf@evledraar.gmail.com>
        <20181217195713.GA10673@sigill.intra.peff.net>
        <20181217231452.GA13835@google.com>
        <20181218123646.GA30471@sigill.intra.peff.net>
        <87d0pzf0as.fsf@evledraar.gmail.com>
Date:   Wed, 26 Dec 2018 14:14:26 -0800
In-Reply-To: <87d0pzf0as.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 18 Dec 2018 14:10:19 +0100")
Message-ID: <xmqqlg4cq6kd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> The genreal ways I see forward from that are:
>
>  A) Say that v2 has a security issue and that this is a feature that
>     works in some circumstances, but given Jeff's explanation here we
>     should at least improve our "SECURITY" docs to be less handwaivy.
>
>  B) Improve security docs, turn uploadpack.allowAnySHA1InWant=true on by
>     default, allow people to turn it off.
>
>  C) Like B) but deprecate
>     uploadpack.allow{Tip,Reachable,Any}SHA1InWant=false. This is my
>     patch upthread
>
>  D-Z) ???
>
>
> I'm not set on C), and yeah it's probably overzelous to just rip the
> thing out, but then what should we do?

Hmph.  The other overzealous thing you could do is to strenthen A
and "fix" the security issue in v2?  Which letter comes before A in
the alphabet? ;-)
