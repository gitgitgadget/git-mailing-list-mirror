Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9046202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 00:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdJXAxC (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 20:53:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60860 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751200AbdJXAxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 20:53:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E4CF9468E;
        Mon, 23 Oct 2017 20:53:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oRymDBIUeouY
        H1jVvQPxqvikdC0=; b=ubaAj/Kiha3w9O3ILIZgPceAL9LyljEXBNBLD2qOHJLz
        ZKH1FA1wy9mfYuvb/HcASSOL6js/k0Go09MkAKaRWmKh8HcCJViV7Jy1QCvfGJVB
        4HjHiHK53IMQmaWstXy7Di3e8Z83/P/hUyUKeiEWgyeLpmyptA2dHGfsEbmqh1U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hwHszZ
        mVIpDfGUY9ElPwLyl65aHV/hBfGvqkQMXj0eK7aUFleROsAGHwTLKB+CR6zmNl/g
        ur6oXd2/lsYv5T7aMiZOL7f1Ay11fHEqly2tc6ClYIcBx22ySPOq1PsBUw3tHdrR
        dse6UrVdJ3Fq1WWBGR/Ga38TgdvNfkHfSuhpk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26FEC9468D;
        Mon, 23 Oct 2017 20:53:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BF3C9468A;
        Mon, 23 Oct 2017 20:52:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
        <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
        <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
        <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
        <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
        <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
        <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
        <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
        <20171020030524.4xlwrdag7e4gzg7s@sigill.intra.peff.net>
        <xmqq7evqidp3.fsf@gitster.mtv.corp.google.com>
        <437f4e47-fcb1-ff8c-3c5a-fa9a5cecedfe@web.de>
        <xmqqh8usg0cs.fsf@gitster.mtv.corp.google.com>
        <7c53071a-5154-1246-d2f1-1064e3f923d4@web.de>
Date:   Tue, 24 Oct 2017 09:52:58 +0900
In-Reply-To: <7c53071a-5154-1246-d2f1-1064e3f923d4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 23 Oct 2017 17:05:23 +0200")
Message-ID: <xmqqbmkxbc45.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE684228-B855-11E7-92DB-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 21.10.2017 um 14:18 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>=20
>>> FWIW, I use "-?" for that everywhere.  I have yet to find a command o=
r
>>> environment where it does something dangerous.
>>=20
>> Yeah, it would have made the world a better place if we made that
>> choice back in 2008.  If we start a transition to make it so right
>> now, we might be able to make the world a better place by 2022,
>> perhaps.  I am not sure if the pain during the transition is worth
>> it, though.
>
> "-?" works fine with builtins already -- they complain that the option
> is unknown and then show the short help text.

Ah, I misunderstood what you meant, then.  I thought you were
advocating to move the built-in short-help support to know about and
explicitly react to "-?", and somehow forgot that it "works" more or
less already.

The fact that "-?" already works for most things is good, but the
transition pain still remains, as what's costly is to transition
people's expectation (i.e. "'-?' and not '-h' is the way to get
short help from any subcommand"), not the implementation to fill the
gaps for those that do not yet support '-?', I am afraid.

