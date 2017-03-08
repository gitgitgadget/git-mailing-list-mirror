Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69C8202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbdCHRXV (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 12:23:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60887 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753825AbdCHRXU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 12:23:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4BB86BF5B;
        Wed,  8 Mar 2017 12:19:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GkdtV8jjC5LGIsr9nB85nwszRXo=; b=dSFiQ7
        RX4GXVDAqrNELOZyBeuaeDxnwvhQY8C+kqpNwS08v7iXriJBRSKvpuP6C2ec71xD
        VGQa7LrvE3KT0awwH66oiQEYx3g2z213YlXlHCQFU99jrjOYmjPR6RIKSipA6wZB
        xu32teDLsCUnMFmhMFAXusumBeZliLQnyl7+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Nt/vQVP1oMGH9FEFWt+VC7S7syy0tfC7
        Us9kU6XmwKoJAryKeu7Wf4WtlK2dW1qrJZOzXLHgzTdaTevZi3xCwNzAM4vGdtRJ
        dtivZetVeWdSTgL+Dt2TjOKoaqBdOfPrOa7TcFjUymc7cuVgGvPL3Pkx54qoUB4V
        kh9M2VjU8XA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DC5CB6BF5A;
        Wed,  8 Mar 2017 12:19:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36BA56BF59;
        Wed,  8 Mar 2017 12:19:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Horst Schirmeier <horst@schirmeier.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/6] send-pack: improve unpack-status error messages
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
        <20170307133736.4lpn7mgme26dqs3m@sigill.intra.peff.net>
        <xmqq37eo66hw.fsf@gitster.mtv.corp.google.com>
        <20170308054533.7wy52myrbpovyoet@sigill.intra.peff.net>
Date:   Wed, 08 Mar 2017 09:19:22 -0800
In-Reply-To: <20170308054533.7wy52myrbpovyoet@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 8 Mar 2017 00:45:33 -0500")
Message-ID: <xmqqtw733cv9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F99678A-0423-11E7-BDFF-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > And finally, neither message was marked for translation. The
>> > message from the remote probably won't be translated, but
>> > there's no reason we can't do better for the local half.
>> 
>> Hmm, OK.
>
> I'll admit that I don't actually use the translations myself, being a
> native English speaker.  So I am just guessing that somebody for whom
> English is a second language would rather see the first half in a more
> intelligible format. That at least tells them what the second half _is_,
> so they might be able to search for the error with more context.
>
> If my guess is wrong, though, I'm happy to retract that part or bump it
> out to a separate patch.

I was merely undecided between "at least half is in my language" and
"both are consistently untranslated" which one is easier to use by
my highschool friends who do not grok English.  And I still cannot
decide.  

When responding to a request-for-help that quotes messages that was
translated, I would imagine we would need one extra "git grep" to
find the message (without understanding that ourselves) from po/ for
the original before running "git grep" to find the code that
produced the message [*1*].

On the other hand, we get request-for-help from those having issues
in a setup where the software running on the other side is not even
ours, so I am (slightly) more inclined to agree that "half is in my
language" is better than nothing.

Thanks.


[Footnote]

*1* If the translation came from us, that is.  If I recall
correctly, some distros do their own po/ and core Git developers are
not likely to have them around, so "git grep" in our po/ may not see
any hit.



