Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E41020756
	for <e@80x24.org>; Sat,  7 Jan 2017 21:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbdAGVix (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 16:38:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61623 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdAGViw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 16:38:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A36F5D59F;
        Sat,  7 Jan 2017 16:38:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=15i2JDHElEOJ6XLufu4F++RbEU4=; b=X3EdBw
        W091wmbYhz7wWoFDUy/XJOjwn3Rn1UDi49a5Qn6bxfh9TcKvu39LEEiD1zdq4w3r
        GTCGHIY9+qpmsezKZEOIfxDkbsY4L4/oibARqnKzgTg+0ia1u3XpJf92FUfGk9mM
        syRMolh+Vyd5XEIckEThtMbW9SnRTYFKd1NjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YwT9qZpPDVhZttfKzv33IFB8U0ASYBpT
        EN3l9RZpwQ+U//9Om/Z1GArtdKLF5Bi/zYqQMLWt0rDniybjZ84Tx7BgF0I7VXhT
        5kLJEGyBoBKSCeAI6avctdc4+VTkQRc1BCHbKY+1ZB2GvM3rpAHtAu+Ka0Ux0z+K
        XSV8P6szRZA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 708085D59D;
        Sat,  7 Jan 2017 16:38:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D50135D59C;
        Sat,  7 Jan 2017 16:38:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 08/21] Documentation/git-update-index: talk about core.splitIndex config var
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-9-chriscool@tuxfamily.org>
        <xmqqpokd9ocw.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD06mxGiZmr4Lwv3M8CedBZaamswzz-Q+mOxuuUFet8KNQ@mail.gmail.com>
Date:   Sat, 07 Jan 2017 13:38:48 -0800
In-Reply-To: <CAP8UFD06mxGiZmr4Lwv3M8CedBZaamswzz-Q+mOxuuUFet8KNQ@mail.gmail.com>
        (Christian Couder's message of "Mon, 2 Jan 2017 10:39:06 +0100")
Message-ID: <xmqqshou35zr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD4314F8-D521-11E6-B8E0-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> It feels strange that when I do things one way, you suggest another
> way, and the next time in a similar situation when I do things the way
> you suggested previously, then you suggest the way I did it initially
> the first time...

Perhaps because neither is quite satisfactory and I am being forced
to choose between the two unsatifactory designs?  In any case, I
mostly am and was pointing out the issues and not saying the other
one is the most preferred solution in these threads.

I think there should just be one authoritative source of the truth,
and I have always thought it should be the bit set in the index file
when the command line option is used, because that was the way the
feature was introduced first and I am superstitious about end-user
inertia.  And from that point of view, no matter how you make this
new "config" thing interact with it, it would always give a strange
and unsatifactory end-user experience, at least to me.

Perhaps we should declare that config will be the one and only way
in the future and start deprecating the command line option way.
That will remove the need for two to interact with each other.

I dunno.
