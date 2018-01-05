Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6E91F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeAEUiQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:38:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62562 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeAEUiP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:38:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66EC0CEA4B;
        Fri,  5 Jan 2018 15:38:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Oti2ABL5hqwtt3Ps+qNtAnjC4c=; b=j+Y7za
        gFy6HbG4Y/cbOB8oQBtBOVbnLgLKKjPjDN0J1pDZxJTKq8ObluY1c/JcdbpPXE2W
        M6mdqlq+Kctw/yVoGXdr8zehjp9HrbKrIb8khGua2g8abGWX4fehLEL9G/00EVpU
        0c0EQp96nGQjbbKS/6vW2QsXj7qHme5emi5bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gyaP5yESsPTpI7Be1CGsG/5ziXbRJjXs
        gUCKonJaUSR29cKbgdHCVfxwMxEkD0vDbFwpyP1QufJwyt1SsP8VIHEZThNRnglS
        Z+cFwW7E+e6BfeCFwEMB8EZrGrUOI04LV3xxlaR+/gvdp66sN9QtJ5jAUivZ+MkS
        a2jgt7Krxsk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DD02CEA4A;
        Fri,  5 Jan 2018 15:38:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6A02CEA49;
        Fri,  5 Jan 2018 15:38:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Isaac Shabtay <isaac@shabtay.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
        <20180103222821.GA32287@sigill.intra.peff.net>
        <CAK2k7nRdk5qBp6Xzud-GS7YeSpchrQoOdqRd-3uXVeWZ1xsnVg@mail.gmail.com>
        <alpine.DEB.2.21.1.1801050019250.32@MININT-6BKU6QN.europe.corp.microsoft.com>
        <CAK2k7nTRAqQKFGi0OfVgub3vWZAkdML5p786L7UyhVDFtsk7Xg@mail.gmail.com>
        <alpine.DEB.2.21.1.1801051130500.32@MININT-6BKU6QN.europe.corp.microsoft.com>
        <CAK2k7nSWoNX+Y5dhLqLVzhzE12f3MgZo0R8xrHYKFwxCL+9mEg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1801052118410.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
Date:   Fri, 05 Jan 2018 12:38:13 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1801052118410.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 5 Jan 2018 21:22:07 +0100
        (STD)")
Message-ID: <xmqqr2r4avnu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A8D3540-F258-11E7-B443-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Isaac,
>
> On Fri, 5 Jan 2018, Isaac Shabtay wrote:
>
>> Done: https://github.com/git-for-windows/git/pull/1421
>> 
>> I added credit to Jeff in the PR's description.
>
> Sadly, the PR's description won't make it into the commit history, and the
> authorship really should have been retained.
>
> I found Peff's topic branch in his fork and force-pushed, to demonstrate
> what I wanted to have. Currently the test suite is running (I test 64-bit
> builds of the three major platforms Windows, macOS and Linux), and once
> that is done and passed, I will merge the Pull Request.
>
>> Note that I tried compiling master, but failed due to a reason
>> unrelated to this patch:
>> 
>> builtin/checkout.c:24:10: fatal error: fscache.h: No such file or directory
>
> That was an oversight in a previously-merged Pull Request. I have fixed
> that locally and will soon push it out onto `master`.
>
> Ciao,
> Johannes

FWIW, I do not mind including this as part of -rc2 if not -rc1 for
the upcoming release.
