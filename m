Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED9B520A10
	for <e@80x24.org>; Fri, 29 Sep 2017 02:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdI2CDS (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 22:03:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65347 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbdI2CDS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 22:03:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B11A799634;
        Thu, 28 Sep 2017 22:03:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M2Kkqfl6iWr7G7QIh39twsL/RPo=; b=QSdWvI
        oToy6+rW28d5/Ct+BcH7jZFxOaVw7Hf1FX/XltPoTB6E9+2QQvM+xzxQgynstzZB
        Y+DThwIt6C6e8FctOMqVTaXBxr0xrTgDRRfJZmyQNqfR/ghEsxhyesoh9LPsEHmU
        MQ0lQP1nwZyKRhVHlURgWNwmfXI4UDEEbSW1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZxSxER9FcWPnAt6tarkQzl2zLot6Vc0q
        r7Xcr3cZc3KxivVf33Z22K0vl0T0lY4oxLUNjVkYzX8bMBRKjKdSKmNnfdn1vRjJ
        mi7VsrMYWbqRDy8qvRwUHgiBWaRVjSt2RnEOQSns84FRRCKb/0IOw3D5bYe0+9EF
        5IQ5WNihO00=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A877299633;
        Thu, 28 Sep 2017 22:03:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0E1AB99632;
        Thu, 28 Sep 2017 22:03:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>,
        git@jeffhostetler.com
Subject: Re: RFC: Design and code of partial clones (now, missing commits and trees OK)
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
        <20170928175352.9a490564d47172568ea2f416@google.com>
Date:   Fri, 29 Sep 2017 11:03:15 +0900
In-Reply-To: <20170928175352.9a490564d47172568ea2f416@google.com> (Jonathan
        Tan's message of "Thu, 28 Sep 2017 17:53:52 -0700")
Message-ID: <xmqqfub6z2fw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BEFA33C-A4BA-11E7-BF77-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I've pushed a new version:
>
> https://github.com/jonathantanmy/git/tree/partialclone3

Just FYI, the reason why I commented only on the first patch in your
previous series at GitHub wasn't because I found the others perfect
and nothing to comment on.  It was because I found it extremely
painful to conduct review and comment in the webform and gave up
while trying to review the series that way just after doing a single
patch.

I also found it frustrating that it is not even obvious which one of
the many patches in the series have been already commented on,
without clicking to each and every commit (and back), even when the
result is to find that nobody has commented on them yet.
