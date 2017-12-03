Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA3620A40
	for <e@80x24.org>; Sun,  3 Dec 2017 05:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751380AbdLCFfO (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 00:35:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57931 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750750AbdLCFfN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 00:35:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF8A5BAD0D;
        Sun,  3 Dec 2017 00:35:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x+tfWUPMkkq34I1agRpKkNuf5g4=; b=GOwvb+
        6tJdoxzBQzKexkXN4Xg3IOk+hr8CsVHnNjoNofe4gymuHnTMF8TyYEyHgfsBYkA2
        wrqKNiQSm0z0PG9ULDytJyTNUGF6aL1jPfNzK6T1XTtqnr8Uza6X1Xjl2Gofq1l4
        6rPsIvxW0M4NW7VojCeTfS8u7UKtvRlv8F91A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o/Dj5wBwntpy96iWT9CVOm6Lu+763i/y
        Ar9Ol8+sxOWbA+AQgnOK+/ZhU7q/q5fOYaiLHoB47u54vqQLPKsXnPecpp9s78GI
        xxd4KeHxcib85AN/rGAKLEZv+RmNpyrIHf/CSgGi+GuB2x/2T8QuEkTkevDCj6lk
        ND69edvIer8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7019BAD0C;
        Sun,  3 Dec 2017 00:35:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2983BBAD0A;
        Sun,  3 Dec 2017 00:35:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] hashmap: adjust documentation to reflect reality
References: <466dd5331907754ca5c25cc83173ca895220ca81.1511999045.git.johannes.schindelin@gmx.de>
        <20171130030727.GA24732@sigill.intra.peff.net>
Date:   Sat, 02 Dec 2017 21:35:10 -0800
In-Reply-To: <20171130030727.GA24732@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 29 Nov 2017 22:07:28 -0500")
Message-ID: <xmqqindojrw1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB8B5E26-D7EB-11E7-A928-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> My second suggestion (which I'm on the fence about) is: would it better
> to just say "see t/helper/test-hashmap.c for a representative example?"

I also had the same thought.  It is rather unwieldy to ask people to
lift code from comment text, and it is also hard to maintain such a
commented out code to make sure it is up to date.

> I'm all for code examples in documentation, but this one is quite
> complex. The code in test-hashmap.c is not much more complex, and is at
> least guaranteed to compile and run.

Yup.  Exactly.

> It doesn't show off how to combine a flex-array with a hashmap as
> well, but I'm not sure how important that is. So I could go either
> way.

Likewise.

In any case, keeping a bad example as-is is less good than replacing
it with a corrected one, so I do not mind taking this patch as an
immediate first step, whether we later decide to remove it and refer
to an external file that has a real example that will be easier to
maintain and use.

Thanks.
