Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B891F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 19:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932931AbcJNTA7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 15:00:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64740 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753947AbcJNTAz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 15:00:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D70146157;
        Fri, 14 Oct 2016 15:00:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K20mHexIxNtV
        N9H7fMeAh1aiW6k=; b=PcLYRMyTv6UrZQYchV837P+Eqt5r3dcjiAQKXWDLzlMh
        4Fxjy72YCBPSatgyOJiqJ+2MBy/Oo2QfCmwXXw12lXharE+4U6VkWVZH/VQNzXa8
        KloiGenw/gCxSQX4rEURfh/nQPZGx8E2+De3cweq2uDpjdK9jt5oPuh7CC3gMDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JJemBw
        D0VHcBYDZik0jBwT2VEu3nub2IalZoqO6gbIiamVbNW5Et7EBrhkjKs0eqy3OIwh
        nQgYOU3ULTtjMxoIJ5M2OiNH09dE3DP94zacGF5flVaOMJmfjKlFACVYRXlOrK6f
        d3eWT/3tpzNftFI0E/4foCVlSqBWI3HZZqjRQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 434B946156;
        Fri, 14 Oct 2016 15:00:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A038546152;
        Fri, 14 Oct 2016 15:00:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 3/3] gitweb: Link to "git describe"'d commits in log messages
References: <20161006091135.29590-1-avarab@gmail.com>
        <20161006091135.29590-4-avarab@gmail.com>
        <xmqqy421i7dg.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5mnCmzT3N35YKpr2t1LT-hh-H7eS-+XTjudguedJL5Zw@mail.gmail.com>
        <CACBZZX4HPci=n193WPm1RCes4PZfFXQtAdJuwxMwvTvF2NBVMA@mail.gmail.com>
Date:   Fri, 14 Oct 2016 12:00:51 -0700
In-Reply-To: <CACBZZX4HPci=n193WPm1RCes4PZfFXQtAdJuwxMwvTvF2NBVMA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 14 Oct
 2016 19:50:46
        +0200")
Message-ID: <xmqqvawuycv0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 87E2E2FC-9240-11E6-8B42-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I just ran into an example of a better reason for doing it like my
> patch is doing, which is that if you have some tag like:
>
> deployment-20160928-171914-16-g42e13d8
>
> With my patch the whole thing will be a link to the 42e13d8 commit,
> but with this suggestion both 20160928 and 42e13d8 would become commit
> links, the former one would be broken.
>
> Of course we could have some code that would detect that the whole \S+
> is part of one thing that ends in g<commit>,...

I think that this example shows a flaw not in the "suffix that looks
like an object name" approach, but more in the boundary regexp,
namely, the \b part; it is probably too loose.

And \S+ is not the right cue, either, for that matter.  IOW, "we
only should take hexstring, optionally prefixed with 'g', that
appears before the whitespace" is too strict, as a sentence

    We broke the system with deployment-g42e13d8.

does want to link to 42e13d8, even though full-stop at the end is
not whitespace, and the existing regexp uses \b there as a rough
equivalent to saying "Here must be a whitespace or punctuation".

An attempt to tighten "what a punctuation is" by excluding '-' may
make that "timestamp is in the tagname" example work, but is not a
good solution, either, because two sentences can be concatenated
with an em-dash that is often typed as two hyphen in plain text,
resulting in something like

    We broke the system with deployment-g42e13d8--sigh.

and we do want to treat the '-' after 42e13d8 as a punctuation after
a described object name.
   =20
So I agree 3/3 is good thing to do as-is.

Thanks.

