Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9BE215F4
	for <e@80x24.org>; Tue,  1 May 2018 12:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755355AbeEAMsh (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 08:48:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33339 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755121AbeEAMsg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 08:48:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id x12so14810094wmc.0
        for <git@vger.kernel.org>; Tue, 01 May 2018 05:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2vcBPrpixgxeicCeM9puivJyF9yo5hHcar3k/V5P+MU=;
        b=JBleDtyfG8RMt/V+JZsvcUeKNiOaZWbwttZd6uqfIM9nFsXiBMnprSD/EHtdotnlyk
         YxNoDIlNBs57vIhnFU9C/4SQ4pVoOhfx82JQrgnwbP51v7hphP91UXOc4LQl5H3y8VbQ
         9PPpvZAGPlOcBF36uVHLeChXC5YX+deDQ4QQYPsM5ej6BOOP6u6P7D7i/jkE9+DsNHwh
         bGkLUYgeIx0bBF2vbkf7B97m1YY0kD8+iVr/LidWgbblkvEOAqwyTjwCHzLtOy6bo9ms
         eRFdbMDiZMV/xsPwKA3J77QTBHIMO/hkjEXmCNCmeTT4iGNBInqdDFVuFXhTMW6HgR0R
         aAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2vcBPrpixgxeicCeM9puivJyF9yo5hHcar3k/V5P+MU=;
        b=rHZiA3TwtjWwEF4tt912YR/pIyTd2MglSMvDLoAfrnClexvKqXWGx4zWaEwre1FGBF
         mG5B4msaZKV85ZSBHAp7w2gwHgMt5g0okRt454k9Nl/kG63HhZkwzy9lY/yLZCWm82dk
         ouLy+8VwVtvKdr8VsrXl520cDhmBNfbJbbtIm64j7BF7/TmTGdSxZRLRpPfUM7Sgqm6V
         ow5NS3I/DFy7HBpKMDhVg+PZHW4W3rPBIplnmnhUW6vtq7dXrocMjx+a2xGqzeXNS4cs
         /E3vcyN07NjbOhjWxgFeSnXJfWZxY+gYkQg44SKSeBR3jylrPg9iKn5KmWB/d/jJeeMH
         0guA==
X-Gm-Message-State: ALQs6tCgfEYum2mn9Zkr9Nwnyiff79nIGek9hujoL5jkzp1qFLCUoo8l
        fhHj310MZnYl04dMk7oFcjc=
X-Google-Smtp-Source: AB8JxZovPpCJfIj9lDT+UTF97z53IxQ8DdGVR0Dce1Pi++jA24YxqQ6zwdfWepamPp5l5LaXfvo+5g==
X-Received: by 2002:a50:ce1b:: with SMTP id y27-v6mr7215742edi.300.1525178915425;
        Tue, 01 May 2018 05:48:35 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id a11-v6sm5353273edr.89.2018.05.01.05.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 05:48:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Avery Pennarun <apenwarr@gmail.com>, Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@Wilcox-Tech.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
References: <20180430095044.28492-1-avarab@gmail.com> <nycvar.QRO.7.76.6.1805011338490.79@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1805011338490.79@tvgsbejvaqbjf.bet>
Date:   Tue, 01 May 2018 14:48:33 +0200
Message-ID: <877eonzgm6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Johannes Schindelin wrote:

> Hi Ævar,
>
> On Mon, 30 Apr 2018, Ævar Arnfjörð Bjarmason wrote:
>
>> I think at this point git-subtree is widely used enough to move out of
>> contrib/, maybe others disagree, but patches are always better for
>> discussion that patch-less ML posts.
>
> Sure, it is used widely enough.
>
> However, it flies in the face of so many GSoC efforts to introduce yet
> another one of those poorly portable Unix shell scripts, as central part
> of Git's code base.
>
> The script itself does look quite straight-forward to port to a builtin,
> so why not give it a try?

That's a valid point. I think it makes sense to leave that aside for
now, maybe the consensus is that subtree is fine in every way except
we'd like to have a policy not to introduce new shellscript built-ins.

Let's first just assume it's in C already and look at it in terms of its
functionality, to figure out if it's worth even getting to that point.

> If you are completely opposed to porting it to C, I will be completely
> opposed to moving it out of contrib/.

This series shows that we should split the concern about whether
something lives in contrib/ from whether it's built/installed by
default.

No matter if we decide that subtree should be a blessed default command
it makes sense to move it out of contrib, purely because as can be seen
from this series it'll replace >100 lines of hacks with 1 line in our
main Makefile.

We can then just e.g. add a flag to guard for it,
e.g. CONTRIB_SUBTREE=YesPlease.

But that's just an internal implementation detail of how we manage code
sitting in git.git.
