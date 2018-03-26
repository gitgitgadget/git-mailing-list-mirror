Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6BBC1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 01:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbeCZBsk (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 21:48:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35780 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750977AbeCZBsi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 21:48:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id r82so12529916wme.0;
        Sun, 25 Mar 2018 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L3inJFhJhupYcyU64jqqg9S67h+3dFHH9kh/OX2OSxY=;
        b=IIABEsDtwaA9daQ+w7fZPzoz0D9CoIHUavQvWJqLcn+GWTHPbyJVT2Ct1F9cMaHsZp
         PqayxlpZt5EXhPomdjX2KDc3+35Z4700Y99TV3EyGJ2iD0zxhNTob1OS3vtccYa3GKdE
         9CWX15s90V1l6djo2Qu4BZo2njl4z1xy1CgEloQswoVTRr7kxA+5UcUPRrPolwT+xXNB
         X47EuHpZx9GeQVz9s6jVCQ7fcEAADci+D4CzfPILM5f757fcLalMzht0mITg+dkzyMwG
         wcTr5xbwNUfv3cdtU0CzZyuboPmzSPePJbUtXQcMof42ImhnaqyRon/rzHzTiizHe60+
         6TaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L3inJFhJhupYcyU64jqqg9S67h+3dFHH9kh/OX2OSxY=;
        b=N3uJHJpUpB5GLEnbkwRpT0On3Wlc+M3iUBF1zwaCUYNaE1m7gpauzGYzrAUyAXBlea
         hfeY2MAYobClnYFhpdmVDm+f4Hjh1LTQy21SOqq6TsW92/aHgEkfFVP8uSF7b7g9erMP
         ApL9oBQc03NgYmQdf6hWxPyop6toqSsQQGsEMstFp4384iwKQ18JNyt6C2HLAspPj4SI
         b9NTishLw56VJ/qAeRRePC5NNE09SgK64d+s2scJiOr15qOtm4qmwoT2vgNdOTF8xLiH
         oVtXoGRQemPGEb+8TBPPZVkwjNXCpV6Vy5HCDR1WQxZIxnSAAPwKGZ+nRmQv9llz23yY
         co1A==
X-Gm-Message-State: AElRT7FWPApH/16tkyK3cvVRnvTnNAwLTOphHcrQ99GmlKQ+oOcq3zes
        uFyhxsoNsVHwhPsml0hDG54=
X-Google-Smtp-Source: AIpwx4+cKEOa98v+d1y3jj5UUy/OWP60AyasWurkZ/Rqh62tIft/d77oVDKvqL4wSrvYQvWIo8aCLQ==
X-Received: by 10.28.94.131 with SMTP id s125mr1797991wmb.83.1522028916867;
        Sun, 25 Mar 2018 18:48:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l73sm14503209wma.10.2018.03.25.18.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 18:48:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
References: <20180325182803.30036-1-avarab@gmail.com>
        <20180325182803.30036-3-avarab@gmail.com>
        <20180325210132.GE74743@genre.crustytoothpaste.net>
Date:   Sun, 25 Mar 2018 18:48:35 -0700
In-Reply-To: <20180325210132.GE74743@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 25 Mar 2018 21:01:32 +0000")
Message-ID: <xmqqpo3rehe4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm not sure that this is going to have the effect you want it to have.
> Let me give an example to demonstrate why.
> ...
> In short, I don't think this is going to be especially helpful because
> it won't change the status quo for a lot of senders.  You'd have to
> insert some significant delay in order to get the effect you desire, and
> even then things could still be delivered out of order.

Thanks for explaining it clearly.

In the past on this list those who do not get the store-and-forward
nature of e-mail transport have brought this up a few times, but
this approach fundamentally do not work, at least for the purpose of
forcing ordering of messages at the receiving end.

