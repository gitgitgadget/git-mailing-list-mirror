Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB7F1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 15:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbeK1CGu (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 21:06:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45443 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeK1CGu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 21:06:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id v6so23040462wrr.12
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 07:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ExybT5rtMVBh/MZFZ+M2IZBV9GMGCR9/AMw3EnBM53w=;
        b=SqDKRD/+qUP2EnE1qOnf2RpPHeBS0q6/v9rCNnXAYwBupo9N8ZRTKzEIvj8HVSruik
         USKAWwbokGSQX69lRw/0SbzZaM2+LNKbWM68rL2suicEz8GvifSMgCPLCvLcRT4bLVis
         cD7RcZsOCxR7tl2qjaU7CP5o93K6bZDkqjR0QdiggQLuF+J0et6MvipsY4sqXypfy5js
         Dz91MMYLpXxvRnXXJaQvJESRRd/L32XioOqH+XCN1xOmRwH5QmY4K+GYlqhRkHoTl8rD
         aoO0H0GKioy53C+uSAN/VBp/RCYpDeaQkBzMCarAAuyd2+0n9tEj/lT1aSf4mRBvuZlP
         nA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ExybT5rtMVBh/MZFZ+M2IZBV9GMGCR9/AMw3EnBM53w=;
        b=eBsbuoSoTa8YMUqEuIEHLALTE3AJ0EyR8w+F+gkAsUrQLFOSRN2TLQAXTvn5IdLqNQ
         rqLheWmGi/yYt2mgC6NIUGEI7FdrKsaluPr4lt2C/GVg3nGRTNYS4Ud+a32gCEihr4XV
         Gb75DHtVoRx5DhM6jz/C3T0bdroIKqLJKTREWLv3leblyiOorUaqsAijAhE0WSkNARNH
         r27afhSeXWzVcUi4XhwIV7tT/YLB0y9cwQc3NcYQM3DXN+EWsmAri4ytColMWNF0zSyC
         xnY9v2FIZYCC3dxFjWAz5yqwxmlS7hi0bm/htJ16XV1hoaw5d5vuTYnRHHoFtK2S1EsP
         BQVA==
X-Gm-Message-State: AA+aEWYnz2lxbkS8WQcebq7TfTgGjHPJ5+i/0sBhb8byKZHW5ciZUGbT
        z55x2hRdut6OjthwFnelOhNQInbu
X-Google-Smtp-Source: AFSGD/VmvpWKL0Lqx0UoVrgaosQXJwCFGH2RRFWfrH5wo2xYUwhyO41ABJKJGWcrR761ZMBNZ4L4yg==
X-Received: by 2002:adf:fe8f:: with SMTP id l15mr26713873wrr.313.1543331316383;
        Tue, 27 Nov 2018 07:08:36 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id j20sm3506685wme.20.2018.11.27.07.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 07:08:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Per Lundberg <per.lundberg@hibox.tv>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Clemens Buchacher <drizzd@gmx.net>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com>
        <875zxa6xzp.fsf@evledraar.gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <20181112232209.GK890086@genre.crustytoothpaste.net>
        <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv>
        <xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqzhtwuhpc.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 27 Nov 2018 16:08:34 +0100
Message-ID: <87mupuzhfx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 26 2018, Junio C Hamano wrote:

> Per Lundberg <per.lundberg@hibox.tv> writes:
>
>> How about something like this:
>> ...
>> Would this be a reasonable compromise for everybody?
>
> I do not think you'd need to introduce such a deliberately breaking
> change at all.  Just introduce a new "precious" class, perhaps mark
> them with the atttribute mechanism, and that would be the endgame.
> Early adopters would start marking ignored but not expendable paths
> with the "precious" attribute and they won't be clobbered.  As the
> mechanism becomes widely known and mature, more and more people use
> it.  And even after that happens, early adopters do not have to change
> any attribute setting, and late adopters would have plenty of examples
> to imitate.  Those who do not need any "precious" class do not have
> to do anything and you won't break any existing automation that way.

The patch I submitted in <87zhuf3gs0.fsf@evledraar.gmail.com>[1] changed
the behavior for read-tree & checkout & merge etc.

It was an RFC more in the spirit of showing what in our current tests
had to change to spur some discussion.

But I'm very sympathetic to this line of argument. I.e. in my patch I'm
changing the semantics of read-tree, which is plumbing.

What do you think about some patch like that which retains the plumbing
behavior for things like read-tree, doesn't introduce "precious" or
"trashable", and just makes you specify "[checkout|merge|...] --force"
in cases where we'd have clobbering?

This would give scripts which relied on our stable plumbing consistent
behavior, while helping users who're using our main porcelain not to
lose data. I could then add a --force option to the likes of read-tree
(on by default), so you could get porcelain-like behavior with
--no-force.

1. https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/
