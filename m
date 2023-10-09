Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761B3E95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 08:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjJIIg7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjJIIg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 04:36:57 -0400
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2009F
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 01:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696840611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUv4gP6umIYCBj2w5FjfjF20you7TAZUEqyMAALmQHI=;
        b=O6EnAiJKwRMEZHR2g/LiDGLh3IxHD1K6P2qwByEg9Nct4BmNntIH5VpxjNOMoQS4EgMo0K
        LHpKPVhpqXMU3oKs+DhqlM2B3t3XOAlHOppzLbovH2uDOaRYqiVkcpQuY2JE1ftpsMdPda
        bAyprCWPvhQfgJIJjAdbF6/q3MQhyO3IgF5ijaG3TqVQTVUharfgkTrMInZIlUC5vnTOT/
        sSFR7Wh5bsa33OqUXAtFJ/T0NIVmije5XK6xsuavmx4BW1shMuhTw7x/K9wm42Pn24D+rY
        ssTy6KaiIF7TsFv22W0gaaDaCoqJqyESOSKrDkYa7MSyhrBFLBBfZHRh+BFpzQ==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 71ecb0bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Oct 2023 10:36:51 +0200 (CEST)
From:   =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: clarify description regarding various
 command forms
In-Reply-To: <20231005210125.GA981206@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Oct 2023 17:01:25 -0400")
References: <20231003082513.3003520-1-stepnem@smrk.net>
        <20231003200659.GC1562@coredump.intra.peff.net>
        <20231005132018+0200.47596-stepnem@smrk.net>
        <20231005171827.GC975921@coredump.intra.peff.net>
        <20231005194852+0200.262756-stepnem@smrk.net>
        <20231005210125.GA981206@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Mon, 09 Oct 2023 10:36:51 +0200
Message-ID: <20231009103651+0200.580831-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 5 Oct 2023 17:01:25 -0400
Jeff King wrote:

> On Thu, Oct 05, 2023 at 07:48:52PM +0200, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bme=
c wrote:
>
>> > Yeah, I think that is a big improvement over the status quo. I might
>> > also be worth starting with a single-sentence overview of what is comm=
on
>> > to both modes. Something like:
>> >
>> >   Output the contents or details of one or more objects. [...]
>>=20
>> I thought about that when proposing the rewrite, but feel that it would
>> again just duplicate what's said elsewhere, in this case even before,
>> not after, in the very first line of the man page:
>>=20
>>     git-cat-file - Provide content or type and size information for
>>     repository objects
>
> Ah, true, I was thinking that the DESCRIPTION section would be the first
> thing users would read, but I didn't notice the headline. I agree that
> what it says is probably sufficient (though arguably "type and size" is
> slightly inaccurate there; I said "details" in my proposed text but
> maybe that is too vague).

We could also leave the NAME vague(r) and put an additional sentence at
the beginning of DESCRIPTION:

NAME
    git-cat-file - Provide contents or details of repository objects

SYNOPSIS
    [...]

DESCRIPTION
    Output the contents or other properties such as size, type or delta
    information of one or more objects.

    The command can operate [...]

--=20
=C5=A0t=C4=9Bp=C3=A1n
