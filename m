Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD61D1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 16:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHPQmg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 12:42:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62828 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfHPQmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 12:42:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF73A167112;
        Fri, 16 Aug 2019 12:42:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cpf86cJy70z3FIX0vcCcGleaQzk=; b=e1sbLZ
        toUm3oJE5wZXi5f0a9OOr9FfqATqJwEvAhoe4a5tsve9NH161i+EVuEVkYMnJHLa
        dqabLb8AZldBKMfYzu6JyzSoCzdBDbYcB+bDjiA+jJrPhwqDh8Gbd/wieiqEQSq/
        MbISqC951IgJ+sJdZcgUFrMZo/ekLhgt94UsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mUBJd+9xz8/Tlx7c3cuyx31xM000/CrD
        XSiIGMhHW2KQxU619l/c95sodH1a9tCKCOLC8nXIVMSXJUASDc3vkYS1mf7PEjZy
        m2GIe9quUZFyE8h8zof5mM4hSx90e7obdUDcdXZjQSHsPjBcU5HHkD9nL5EKhT4Q
        cMJXIa0mDOc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A42D4167111;
        Fri, 16 Aug 2019 12:42:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D131316710E;
        Fri, 16 Aug 2019 12:42:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Carlo Arenas <carenas@gmail.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Aug 2019, #04; Wed, 14)
References: <xmqq36i35tfv.fsf@gitster-ct.c.googlers.com>
        <CAHd-oW4kMr+Q1GhNQ7B7RW2hafqokvUoxg9qkXXyt98L53=Ahw@mail.gmail.com>
        <CAPUEspjWbHC2md3kFu8O88275pYSzpFmu9kjHEn4_0_hjxZ8MA@mail.gmail.com>
        <xmqqef1m4baf.fsf@gitster-ct.c.googlers.com>
        <CAHd-oW4qo=aTrA90RmWsLeW44WKUiL2x9rzdToFRMq=ebKYksQ@mail.gmail.com>
Date:   Fri, 16 Aug 2019 09:42:31 -0700
In-Reply-To: <CAHd-oW4qo=aTrA90RmWsLeW44WKUiL2x9rzdToFRMq=ebKYksQ@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Thu, 15 Aug 2019 21:30:03
        -0300")
Message-ID: <xmqqlfvt12q0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D82E9910-C044-11E9-8C61-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

>> Thanks.  Or we could just go the lazier route.  A new stable release
>> would happen within a day or two, and then in a week or so after that,
>> the tip of 'next' gets rewound and rebuilt on top of it.  We can
>> discard the older copy and replace with the newer one when it happens.
>
> OK. I'm working on a v2 of mt/threaded-grep-in-object-store which
> might depend on this patch. I can then send the newer version of this
> patch as part of the series. Is that OK?

That would be good---just tell me what stale one I (may) still have
in my tree that I need to discard when it happens.  Thanks.
