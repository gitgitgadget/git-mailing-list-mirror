Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731F0E9271C
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjJERtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjJERtB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:49:01 -0400
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B7CF7
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696528133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58Mo8Q4rXQCCQfLkWqBU/O8ewcVDXemg2+op3ibW6pI=;
        b=qXW1W/zZeK1arcrZGfwgIYqhKIUHu5YCJLwQZX8JS4LZv4LL9eynaLsnZl6hgQ2by3uOJJ
        S2V8vWzdT8417a3+3JBh3kTC/FiJQN5OXt0gyVZ7QytM8G4oWVrdpQV7qBmH4NkTtpWqv7
        Pj3BakXAO4+sA+KyQcAB95jhkruU0VQBsg9joThIbCulNhmT1v0BeNn0B2eWFBByALSJCD
        cw0zhWQ3RFSfzUuXesjannENaZzACoIuGNwppZi5XyvxjrFowrCOEL5AYuFYwuvLUBzb2a
        CamM/24QyQO4ZD99OfdK2tPz/K3PE+BfBCA5WIR47CN2p6aPe3Zmw0ESiiV8hw==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id c9391fad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Oct 2023 19:48:53 +0200 (CEST)
From:   =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH] doc/cat-file: clarify description regarding various
 command forms
In-Reply-To: <20231005171827.GC975921@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Oct 2023 13:18:27 -0400")
References: <20231003082513.3003520-1-stepnem@smrk.net>
        <20231003200659.GC1562@coredump.intra.peff.net>
        <20231005132018+0200.47596-stepnem@smrk.net>
        <20231005171827.GC975921@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date:   Thu, 05 Oct 2023 19:48:52 +0200
Message-ID: <20231005194852+0200.262756-stepnem@smrk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 5 Oct 2023 13:18:27 -0400
Jeff King wrote:

> On Thu, Oct 05, 2023 at 01:20:18PM +0200, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bme=
c wrote:
>
>> So how about we just butcher the DESCRIPTION completely;
>> [...]
>> DESCRIPTION
>>     This command can operate in two modes, depending on whether an
>>     option from the --batch family is specified.
>>=20
>>     In non-batch mode, the command provides information on an object
>>     named on the command line.
>>=20
>>     In batch mode, arguments are read from standard input.
>>=20
>> [That's all for a summary, read the following sections for details.]
>
> Yeah, I think that is a big improvement over the status quo. I might
> also be worth starting with a single-sentence overview of what is common
> to both modes. Something like:
>
>   Output the contents or details of one or more objects. [...]

I thought about that when proposing the rewrite, but feel that it would
again just duplicate what's said elsewhere, in this case even before,
not after, in the very first line of the man page:

    git-cat-file - Provide content or type and size information for
    repository objects

>   This command can operate in two modes, depending on whether an
>   option from the --batch family is specified.
>
>   In non-batch mode, the command provides information on a single object
>   given on the command line.
    ^^^^^
Any particular reason you prefer "given" to "named"?  However absurd a
notion of giving an actual object on the command line might seem, to me
"named" is better in that it leaves no room for such misinterpretation.
And the <object> description in OPTIONS talks about "ways to spell
object names", building on the same concept.

--=20
=C5=A0t=C4=9Bp=C3=A1n
