Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F02320323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbdCVVJG (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:09:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50354 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754045AbdCVVJE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:09:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB5BF7FB33;
        Wed, 22 Mar 2017 17:09:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MKkjWCHxcg/0
        hSumMfF6JCsnWSw=; b=Xq5C4xdfjaDXxPXc6i+QjzxAj/0bLqR5YWmgiMhxaQ+j
        V3g3qFIbTBmLcfgMM8T9d6BuT2lVWQjjSYh73PryPT1ueI0xfVohn15XqcTo9dAT
        qXLRA6DusX6ivlEQVtiUvgqcy7Yrujw/mfz0scKq3g+Sp5BJSeW0R1/FKwRnt8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=quhDgH
        KHnrWBgEy0WQ/murB4SBQa2DVYH6bESJWV0AoDam5tXy5ktIgtP+YhBQ1Gl45tgD
        yGnjwXJQV01zxHjry12KLbdbnE47SraBbIp9moIce5+4MYGgCr+jE6PUugXk+snJ
        sGxX0wXmDUmVui2rn/hivr0SQYN6IzhBTouWg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2CB47FB32;
        Wed, 22 Mar 2017 17:09:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 14C977FB31;
        Wed, 22 Mar 2017 17:09:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 10/16] tag: change misleading --list <pattern> documentation
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-11-avarab@gmail.com>
        <xmqqo9wupixz.fsf@gitster.mtv.corp.google.com>
        <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
Date:   Wed, 22 Mar 2017 14:09:00 -0700
In-Reply-To: <CACBZZX70pb=h3nPKDY-rcM3rjh9SNYUzUhxA3Hu0-Jph8ODxdg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Mar
 2017 20:32:46
        +0100")
Message-ID: <xmqq1stpj9xv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C643C77A-0F43-11E7-BAB9-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Please drop "interleaved", as we are not encouraging GNUism.  We
>> just tolerate it but do not guarantee to keep them working.
>
> This brings up the same point you made in
> <xmqqmvci2zoc.fsf@gitster.mtv.corp.google.com>, I replied to in
> <CACBZZX5LN8nhs85K18XVg4Y9_qb9zKGBoFnnQHSsRZVOP=3DOkDw@mail.gmail.com>,
> and that you didn't get back to me about.
>
> Rather than split the discussion or me copy/pasting large parts of
> that E-Mail could you please reply to me over in that thread?

There is nothing to reply.  We know some people favor GNUism, but we
do not actively encourage it, period.

