Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B98F71F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 16:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbdBAQxf (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 11:53:35 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32874 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbdBAQxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 11:53:34 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so32093970pfg.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 08:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ipvWn3oqZXzWnBZUCnSNwBYcu4Na52QZDsGTRQ3Sn8M=;
        b=UQFAbUo+tXSDZ2hnPZYkFuy77c6Mjeso3toWRy64T7m7cqp4AAJb2dO0hNc33IY6jZ
         AMMMmoL1lbjc8nBPm4AGDTrH8MUyiTbzI/AXb1FyrFNlXEh2ky9tOdNh5SQkstqjjXca
         QSL57sUwVO5JxdCYXP62aJA8mx0Cnf2dAy+52uOSVGxMmc1X/0GMet8LR9MJVzNMBXMK
         B+Y5XievjGHDJ1nIq86eDO31ivqLn11qJ4VEImC8HG/DyEnhWU8hSD+LAxrxyQf3KEL2
         HnI4GX/L/swcmjBWzPXUJ5M1LiqIt1swtNa4U0ef293ffw+u1vnp26YMiGqpH283F5Sl
         Wwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ipvWn3oqZXzWnBZUCnSNwBYcu4Na52QZDsGTRQ3Sn8M=;
        b=GPYcfg+8SuRQj0CpNgda768uRhPhb8a8NtsFIrHymdBqLB7qfkPah4kzG42YCEJcqk
         56AEymtSX+cKsXKhDKC4pr6jJRflvgB2+rj4jpqe0p/nEPLdACKCgfhpS1w2prYQ0s5x
         YGLByuUkAJx+f/ue/znSnYBhgK7IJdkF7SsWVOLo2dFwunOuz7DKKdw1DMN00UpO1qvG
         zF1tlkkiPherMSL/krsDIolbEIepLQfVQRLtlPcKwvvJoTwO8el+7z7fMz5XhhjTeoNv
         lCUv+tIWiILFFPAoz5OtOWiqhxnUJDsGjJRq0NP6YZlRhV/gC+0cIDnQCv8fliSBmLuV
         Nv6A==
X-Gm-Message-State: AIkVDXKHCymiMOhhh/TYaKk79XXugGfcnaChRDjDfhCS/O5AeKRS08TROf+IXrTyvt+JHA==
X-Received: by 10.98.95.70 with SMTP id t67mr4714841pfb.37.1485968013821;
        Wed, 01 Feb 2017 08:53:33 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id t6sm51545050pgt.8.2017.02.01.08.53.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 08:53:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Segev Finer <segev208@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] connect: Add the envvar GIT_SSH_VARIANT and ssh.variant config
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de>
        <cover.1485442231.git.johannes.schindelin@gmx.de>
        <3d451f2c357a3fd7f0b0e4b427548553d7d05306.1485442231.git.johannes.schindelin@gmx.de>
        <xmqqo9yt4o5i.fsf@gitster.mtv.corp.google.com>
        <xmqqpoj8z7su.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702011216130.3469@virtualbox>
Date:   Wed, 01 Feb 2017 08:53:32 -0800
In-Reply-To: <alpine.DEB.2.20.1702011216130.3469@virtualbox> (Johannes
        Schindelin's message of "Wed, 1 Feb 2017 13:01:25 +0100 (CET)")
Message-ID: <xmqqlgtpq2cz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 27 Jan 2017, Junio C Hamano wrote:
>
>> IOW, I think it is acceptable to always split GIT_SSH_COMMAND into
>> tokens before we realize that the user used the escape hatch and the
>> splitting was a wasted effort.  This is exactly because this thing
>> is an escape hatch that is expected to be rarely used.  Of course,
>> if the "wasted effort" can be eliminated without sacrificing the
>> simplicity of the code, that is fine as well.
>
> Simplicity is retained. Battle-readiness was sacrificed on the way: the
> new code is not tested well enough, and `next` will not help one bit.

Let me make it clear that there is no burning desire to sacrifice
battle-readiness in the above.  If we expect that auto-detection
would be minority, then it makes sense to get the configured value
first and then spend cycles to split and guess only when detection
is needed.  

In this case, because we expect that auto-detection will be used
most of the time, it is good enough to always split first, get the
configured value, and spend cycles to guess, or for that matter it
is perfectly fine to always split and guess first and then override
with the configured value.

If your attempt to optimize for a wrong case ended up causing new
unnecessary bugs, don't blame me.
