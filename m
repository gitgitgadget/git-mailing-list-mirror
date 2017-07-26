Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CED32047F
	for <e@80x24.org>; Wed, 26 Jul 2017 22:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdGZW3U (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 18:29:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61642 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751034AbdGZW3T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 18:29:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8794F92B4F;
        Wed, 26 Jul 2017 18:29:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QBj5e5sJT1OCWfm2j7jkHF+SFQc=; b=EKsEr7
        qB6Q+AKiwWN+5HErW3QIyWz16SYizywW5mnS8gT77YV6pi2IBl/mS7wmM0KyN4Nk
        B0D1i/0BOI/odErDlYxYlulbLceBxOkNfXQyn2/EU+CJRFOl3aSP5bbwmfdh0CRl
        9HQPUPkHKLSWqzX5OC2fSU7KE5cR9z3Z8fszk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dJD0QlQImBxCFN+LeGRtnH/y6RUYaLOp
        tNvX/qkHy+PbNCUik0DqHpGnGAgU9T+1GzYnL0FJs8AfISWF/8W9oOparvItGfd8
        Sb7QO433mQouxOwZyre07d/fwIIhtg4ZDk+IKL1bJRu6mks9jJl1SY/KSVZlc9c1
        1qrmU+WMqes=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FC3E92B4E;
        Wed, 26 Jul 2017 18:29:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C4FA992B4D;
        Wed, 26 Jul 2017 18:29:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Change in output as a result of patch
References: <20170724154119.2926-1-kaarticsivaraam91196@gmail.com>
        <1500923812.20078.8.camel@gmail.com>
        <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
        <1501008842.11979.7.camel@gmail.com>
Date:   Wed, 26 Jul 2017 15:29:07 -0700
In-Reply-To: <1501008842.11979.7.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 26 Jul 2017 00:24:02 +0530")
Message-ID: <xmqq1sp2q1cc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D74DA9CA-7251-11E7-8EE1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> b347d06bf09 (branch: deprecate --set-upstream and show help if we detect possible mistaken use,
>              Thu Aug 30 19:23:13 2012)
>
> Is there any possibility for it to be removed some time in the near
> future?
>
> I'm asking this because IIRC, the 'attr_only' parameter of
> "validate_new_branchname" was introduced to fix a regression
> (fa7993767560) caused by the "--set-upstream" option. In case it has
> been planned to be removed some time soon, it could make the word
> easier (?), not sure though.

I suspect that it would not make the refactoring that much less
work, but you are right---it is about time we started looking into
removing the --set-upstream optin whose 5th anniversary after
deprecation is only one month away.

