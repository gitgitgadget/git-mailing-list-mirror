Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FFC1F43C
	for <e@80x24.org>; Sun, 12 Nov 2017 01:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbdKLBSM (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 20:18:12 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60883 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752308AbdKLBSL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 20:18:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD7F3B485C;
        Sat, 11 Nov 2017 20:18:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=St2rENFaeK1bhJwnirG0LwKIBwI=; b=usQ7hD
        d6nGgcG16yzOiCc4oLauAuIkMPrPjORt1wyghDbTMnN5aAVS2bfHp7v2zCAS3pKg
        8MvoZ6O5OpgwLWvGo+zLqD4wqEglybNZdA8b5900SlLL8oWVqo0laNks8P0bqUrx
        6I+ymTTxHQc2pDZAPs2IZyvfbE+k95y2DMp3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SpfvWvXKvcVNfnH043pgMDBYcf/QaoAC
        k96iEif8iFad6Avu67gErvjOy+4vt0Asp5f65FEig89FGUKTTjvKavqTrFIgwjxR
        tdZfPG2cobFlunDfc/b+cFpaApJPC1dVcvz/09ZXh0h+pjZ74ONLduvQZrt8X6Op
        fYdtiZkE3gA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5DE4B485B;
        Sat, 11 Nov 2017 20:18:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3947EB485A;
        Sat, 11 Nov 2017 20:18:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: is there a stylistic preference for a trailing "--" on a command?
References: <alpine.LFD.2.21.1711100855140.3617@DESKTOP-1GPMCEJ>
        <CAGZ79kavxFA_wBzcSbR8LT4uZGkdv4c07ZMfE4TK0tkooMGg6Q@mail.gmail.com>
        <20171111151907.owrbpnn35aepj4ha@sigill.intra.peff.net>
Date:   Sun, 12 Nov 2017 10:18:08 +0900
In-Reply-To: <20171111151907.owrbpnn35aepj4ha@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 11 Nov 2017 15:39:54 +0000")
Message-ID: <xmqqzi7scn1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58AE07E0-C747-11E7-9D52-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Nov 10, 2017 at 10:12:39AM -0800, Stefan Beller wrote:
>
>> On Fri, Nov 10, 2017 at 5:57 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> >
>> >   just noticed these examples in "man git-bisect":
>> >
>> > EXAMPLES
>> >   $ git bisect start HEAD v1.2 --      # HEAD is bad, v1.2 is good
>> >   ...
>> >   $ git bisect start HEAD origin --    # HEAD is bad, origin is good
>> >   ...
>> >   $ git bisect start HEAD HEAD~10 --   # culprit is among the last 10
>> >
>> > is there some rationale or stylistic significance to those trailing
>> > "--" on those commands? i assume they have no effect, just curious as
>> > to why they're there.
>> 
>> By having the -- there, it is clear that the strings are ref specs and not files
>> of such a name. (Who would want to store a file named HEAD~10 in their
>> repo?)
>
> Just to be explicit, that makes it not just clear to the user but clear
> to Git. Without a "--" there heuristics that kick in. The first section
> of the "gitcli" manpage talks about this, though I don't know that we
> explicitly document the heuristics anywhere (and I think that is
> intentional -- we promise only to try to do what you meant, and scripts
> that want exact behavior should use a disambiguating "--").

It is funny that your "Just to be explicit" reads two ways, and both
readings turn out to be correct ;-)

Yes, the use of these "--" in the examples are just to be explicit
that the arguments that come before "--" are revisions (and not
pathspecs); doing so prevents Git from complaining of ambiguity even
when a file whose name is HEAD happens to be in your working tree.

And it is good that you explicitly teach that these are not to
clarify for the end users' who read the examples, but to encourage
users to get into the habit of using them to make their intention
clear when writing their scripts.

;-).
