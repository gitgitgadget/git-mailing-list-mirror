Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1A720323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752450AbdCVW00 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:26:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51241 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752414AbdCVW0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:26:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CF318078B;
        Wed, 22 Mar 2017 18:26:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iebpEUtLW8fm
        fRsrovnRn3Spbzs=; b=T5//KbN3GrdTft+fu6yuYjmbNy63FKNcW9z59l9D3Anx
        m6y8c32SobIGSG4EZw5Z+C+l2qa4PhM5zjVfMlM1c9mzpTtz5S7lSlOEARM6wZYg
        8eIyeKQg/K2P7t66Ef3dN4ghtTy2q6cqOlw4r/Ohn60pg6sz7aTVrakWFie5rnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=c+HL9i
        npLgk2f9GXSHQHz2Kc97hsozweJf7gsYv5HA2rlKQbud+TRuXtP0KL5+0+Z8WDUJ
        getzDYOylygAS3g0z6fHMBcYEe8MKibnUavR4ug/0mDN9dDoHXQdtMBuHTLf++Pu
        R/bMC1turvWt6I34R3P6qzHSgNgk0S5tJ2H74=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 133378078A;
        Wed, 22 Mar 2017 18:26:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6617680788;
        Wed, 22 Mar 2017 18:26:22 -0400 (EDT)
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
        <xmqq1stpj9xv.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4rofOquS4q0NDCb8cHOF=E7iPzFMxj3bre6CTB7=b_MA@mail.gmail.com>
Date:   Wed, 22 Mar 2017 15:26:21 -0700
In-Reply-To: <CACBZZX4rofOquS4q0NDCb8cHOF=E7iPzFMxj3bre6CTB7=b_MA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Mar
 2017 23:08:28
        +0100")
Message-ID: <xmqqtw6lgd82.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 941DF030-0F4E-11E7-90CF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> of things you think we should be putting in the test suite. I.e.
> should the tests be:
>
> a) Only be a collection of invocations of git we'd be comfortable
> showing to someone as "this works, and this is how you should do it",
> or things that explicitly fail marked with test_must_fail.
>
> b) or a) && also various surprising combinations of things we don't
> necessarily want to encourage or even support in the future, but which
> are in there so if we change them, we at least know our change changed
> something that worked before.

I am strongly inclined to (a).  If we cannot decide when we designed
the feature, and we anticipate that we may want to change it later,
then documenting the choice in a test or two may be a way to remind
the choice we happened to have made, but in general I do not think
we want to promise (to ourselves) more than what we are willing to
commit to.
