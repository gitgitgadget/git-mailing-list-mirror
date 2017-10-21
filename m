Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E271FF72
	for <e@80x24.org>; Sat, 21 Oct 2017 12:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbdJUMTD (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Oct 2017 08:19:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51052 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932070AbdJUMTC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Oct 2017 08:19:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D07ABA4B7;
        Sat, 21 Oct 2017 08:19:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qc+pcOlNnicP
        M31SEaP4HML73VE=; b=FZajtJB8jWstmKdbG/meN9dZDUAnTY6Rd8K4EMNNSZ6U
        ri247WJqSDD62V4getJAu9WyQSdsXMptlpuhnvepbV1j9It4/ZPrxzrJlogV5XLq
        OA8qlp4xMle24qg0d0WA4xzaG0Ua2DA+XF//ehmvQZwXVFyYOCyqYEFrDxEM498=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Um4nwu
        BS2xjMCktQopR5QF4nQkgPLrEXwx3Hy8dpdSJnh0BC5Cb6CyRf5WJ3PEuGVZOMeB
        FngpISGWFplGt2dsZWDW9RcNkT+OJd5dbadNsdUWMC3qRRyTxQf775XJyQD+8+9h
        RkqW7sFTnTNxVPd77iOEEHOr0D2QqG7pdEEK0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41382BA4B6;
        Sat, 21 Oct 2017 08:19:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66B71BA4B5;
        Sat, 21 Oct 2017 08:19:00 -0400 (EDT)
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
Date:   Sat, 21 Oct 2017 21:18:59 +0900
In-Reply-To: <437f4e47-fcb1-ff8c-3c5a-fa9a5cecedfe@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 21 Oct 2017 12:14:35 +0200")
Message-ID: <xmqqh8usg0cs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04F4298E-B65A-11E7-A9B2-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> FWIW, I use "-?" for that everywhere.  I have yet to find a command or
> environment where it does something dangerous.

Yeah, it would have made the world a better place if we made that
choice back in 2008.  If we start a transition to make it so right
now, we might be able to make the world a better place by 2022,
perhaps.  I am not sure if the pain during the transition is worth
it, though.
