Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9033C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE0C6198D
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 01:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1BmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 21:42:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61308 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhC1Blz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 21:41:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2466AA8B4C;
        Sat, 27 Mar 2021 21:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hErOEezOBefC0DyYxSzMML4yZys=; b=M+20Qn
        r0odRUl0xtp9oYI3HKrp6MpWzvKiGrNB9txVUp8DVQjg4mKpBu+SsCDAaAcSVf+m
        X349/cutbmsGk3C3EkW4xXXF2zYYCzwe8ucEcCi5yPH86syYFbZv8ODP0ZxnUM45
        R0qcrFR2WkHq1uU0itL8LEqL3ZbYw46JaBkTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kd02tl0G5BH3K7DTmg9omppSsVtrXQlE
        FdwVKpsViZ9cEkY1eUp1ciTBNw1u0mVrbR1ir6FHc00eoz9JBYeSH0XC1JGBEnZ1
        E5huDVHFVEYAEEuiLt4rr6K1kiFaebgLx2alMfIasvbR4I+1JhHxgEqD5FcPxayR
        nUe/Hpr4HaM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C635A8B4B;
        Sat, 27 Mar 2021 21:41:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C890A8B4A;
        Sat, 27 Mar 2021 21:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Georgios Kontaxis" <geko1702+commits@99rst.org>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4] gitweb: redacted e-mail addresses feature.
References: <pull.910.v3.git.1616347731514.gitgitgadget@gmail.com>
        <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
        <xmqqlfaf6nu9.fsf@gitster.g>
        <6f656f62497fb7c9322432b5eb151b86.squirrel@mail.kodaksys.org>
Date:   Sat, 27 Mar 2021 18:41:54 -0700
In-Reply-To: <6f656f62497fb7c9322432b5eb151b86.squirrel@mail.kodaksys.org>
        (Georgios Kontaxis's message of "Mon, 22 Mar 2021 18:58:41 -0000")
Message-ID: <xmqqczvkoxzx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C69D9A8C-8F66-11EB-BC18-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Georgios Kontaxis" <geko1702+commits@99rst.org> writes:

>> I'll defer to others who are more familiar with gitweb and Perl
>> ecosystem if this is warranted, but I have a feeling that importing
>> and using Mail::Address->parse() only because we want to see if a
>> given "<string>" is an address is a bit overkill and it might be
>> sufficient to do something as crude as m/^<[^@>]+@[a-z0-9-.]+>$/i
>> ...
>>> +	while ($line =~ m/(<[^>]+>)/g) {
>>> +		my $match = $1;
>>> +		if (!is_mailaddr($match)) {
>>> +			next;
>>> +		}
>>> +		my $offset = pos $line;
>>> +		my $head = substr $line, 0, $offset - length($match);
>>> +		my $redaction = "<redacted>";
>>> +		my $tail = substr $line, $offset;
>>> +		$line = $head . $redaction . $tail;
>>> +		pos $line = length($head) + length($redaction);
>>
>> Hmmmm, Perl suggestions from others?  It looks quite strange to see
>> that s/// operator is not used and replacement is done manually with
>> byte position in a Perl script.
>>
> If there's a more elegant way to do the above we can certain do that instead.

For example, if we do not insist on using overkill Mail::Address->parse(),
we could do something silly like this:

	$line =~ s/<[^@>]+@[a-z0-9-.]+>/<redacted@address>/ig;

no?
