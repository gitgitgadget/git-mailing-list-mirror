Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18E120899
	for <e@80x24.org>; Wed,  2 Aug 2017 21:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751136AbdHBV51 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 17:57:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59737 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751058AbdHBV50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 17:57:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB28B95034;
        Wed,  2 Aug 2017 17:57:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rmYsst9gmoJACnlYCK+cIZLUWvE=; b=Bxky38
        pFFcAghGRx8qEVdyEE9Ljzk59F3XfE+j+7IHuGo0ZBevbL//cSz7oeUvU/O2Soqu
        k2JiVhlffZocuTYZj8qTFuwhBdc9DwyJ44XroqLDcqMUtrskvJ1vUfz3FpQfjwwL
        ZfRbyYQEIRDQhWfe+JXn0U+e7t/JhRi0nKbzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HYZs6DkDi6FdxRrtBopc/jiHZ7THUdzz
        LK2T7NRV9oFr3QY/wt12W1lnw/N0yo0Cxvpoqxl33qRm4yL6NpznzotVJjY3vtbo
        woKp6jlUtQBp4p1RXvL2Z4KqL+uwTt7jcGFgxE9N9B2xVu/GV3/bQSGfIdVYhPT7
        aeG2ygHHL0M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E39A995032;
        Wed,  2 Aug 2017 17:57:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52FF395031;
        Wed,  2 Aug 2017 17:57:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 6/6] cherry-pick/revert: reject --rerere-autoupdate when continuing
References: <20170802104420.12809-1-phillip.wood@talktalk.net>
        <20170802104420.12809-7-phillip.wood@talktalk.net>
Date:   Wed, 02 Aug 2017 14:57:17 -0700
In-Reply-To: <20170802104420.12809-7-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Wed, 2 Aug 2017 11:44:20 +0100")
Message-ID: <xmqqpocdr5tu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D77C106-77CD-11E7-BE0A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> cherry-pick and revert should not accept --[no-]rerere-autoupdate once
> they have started.

Hmph, why shouldn't they?  In other words, shouldn't the usual "try
to carry forward from the original invocation (saved in the state
file), but allow overriding from the command line" rule apply?

I took a brief look at earlier steps and I thought 1-4/6 were all
good.  I am not sure (yet) about these last two patches.

Thanks for working on this topic.
