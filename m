Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C467720C13
	for <e@80x24.org>; Mon,  4 Dec 2017 13:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbdLDNph (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 08:45:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52132 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752540AbdLDNpg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 08:45:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8545FCB93E;
        Mon,  4 Dec 2017 08:45:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lBUdgZiSkTCCCr+6408pJmf8rKs=; b=Ic3SZv
        nxV93+5A4SUEip3eZVDcM9JiLABpYGo1BI80Jhdw9oez0PwPgm9EmwT65fHwaRl1
        dJmNaU7W1VZzQgRdbHscnphS1JBYzw/whQRccWrxMDAM8wAELPUnZvso/2BvENAh
        IEisykI9ApXxM9oMBaGrp0iPTvQb333Grgg/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kqd5m6x+AF/8pyaHm4KjynnfZZXgg91m
        fuy6whHTIlYXNlkdq4udScTWfj7yW7v3uf0d2cW26l5m34dSftRmzFu8hAPLVfCm
        TL/LjTUl/OEw7cdFScdxuhHFXx7wYwdRLDAu9Uhh3xsPj50ADmpk85wx2NlbDcLj
        FbWbiYdr67g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BEBCCB93D;
        Mon,  4 Dec 2017 08:45:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBB29CB93C;
        Mon,  4 Dec 2017 08:45:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nathan PAYRE <second.payre@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ryan Anderson <ryan@michonline.com>, e@80x24.org,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Subject: Re: [PATCH] send-email: extract email-parsing code into a subroutine
References: <20171202170220.10073-1-second.payre@gmail.com>
        <874lp7v5du.fsf@evledraar.booking.com>
        <CAGb4CBUY0QVOHqAFDi6kSVmK48PzKKTuXR2F_Nr+6cHHUhxBzQ@mail.gmail.com>
Date:   Mon, 04 Dec 2017 05:45:33 -0800
In-Reply-To: <CAGb4CBUY0QVOHqAFDi6kSVmK48PzKKTuXR2F_Nr+6cHHUhxBzQ@mail.gmail.com>
        (Nathan PAYRE's message of "Mon, 4 Dec 2017 00:41:04 +0100")
Message-ID: <xmqqlgiiobcy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67D475EC-D8F9-11E7-BDD2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nathan PAYRE <second.payre@gmail.com> writes:

> I've tested your code, and after few changes it's works perfectly!
> The code looks better now.
> Thanks a lot for your review.

Thanks, both of you.  

Could you send in the final version later so that I can pick it up?
I agree with Matthieu's suggestion on what address to use on your
From: (authorship identity) and S-o-b:; as you are showing your work
done as a uni student, the authorship and sign-off should be done as
such.
