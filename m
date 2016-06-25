Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 823E21FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 19:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbcFYTtV (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 15:49:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751623AbcFYTtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 15:49:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BE0C24819;
	Sat, 25 Jun 2016 15:49:19 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JH5G8pVHhmtL1K2TARJH0ABmsno=; b=sL1V4/
	khmxyka2lFQZJmMEyUtb4Mb6vmDtEsRsFZLaV5Ktxc0tBS3DfazlhfGXr6aaJ2XV
	j8IQlarr+gj0CJl8CsmxHGRB5Jfgy+X5+7Q1TOTtE7xrykOpprQEs7VIXOxeqziI
	FUEw+7YZw8EM2ZXiFybo/HmLc6BUkm2t81DCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xb/UowQbrC5jZWTxvKjrMi9kfHKulH0D
	F9CZJFvQxSd7iilPskioAKLi6fWEIUhZO8RR8ufjz/q5kIP8FACewaEzSCKrtZ9J
	ajlsBgZuL6P0Ajq6gu9LKhCq8Bu9CgoQ53keFy2BWfFIDGxwUTYUogFI6kt3+HzH
	wskkC1UCLHk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6412724817;
	Sat, 25 Jun 2016 15:49:19 -0400 (EDT)
Received: from pobox.com (unknown [104.133.2.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CED7A24816;
	Sat, 25 Jun 2016 15:49:18 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"Jeff King" <peff@peff.net>, "Git List" <git@vger.kernel.org>
Subject: Re: name for A..B ranges?
References: <0648000B273C412AB7140AE959EBC99A@PhilipOakley>
	<20160624160943.GA3170@sigill.intra.peff.net>
	<xmqqh9cih6ym.fsf@gitster.mtv.corp.google.com>
	<E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley>
Date:	Sat, 25 Jun 2016 12:49:16 -0700
In-Reply-To: <E61B46FFA8874DD3973AA96BE5B36790@PhilipOakley> (Philip Oakley's
	message of "Sat, 25 Jun 2016 14:50:16 +0100")
Message-ID: <xmqqwpldcamb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7A88F28-3B0D-11E6-AA90-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> Yup, I think "range" is the commonly used word in discussions here.
>> When inventing A...B as a new thing in addition to A..B, we called
>> the former "symmetric difference", and what is implied by that is
>> the latter is "asymmetric difference"; we do not say that unless we
>> are contrasting between the two, though.
>>
> I asked because the man page does indicae that it (A..B) is a special
> sort of revison range and "there is a shorthand for it", but then
> didn't have a way of naming it.

I do not see "is a special sort of revision range" improved in your
two patches, though.

Knowing that A..B is merely a short-hand for ^A B is important to
understand how revision ranges work (e.g. "A..B C" is not "union of
A..B and C"), so I think it is worth addressing if the existing
description appeared to you that it may confuse readers.

> The symmetric difference is then brought in as a further similar
> notation. There are a number of Stackoverflow questions about the
> differences betwee 'two dots' and 'three dots' as well, so having a
> word/phrase for it could help.
>
> I was thinking that maybe "single-sided difference (two dots)" maybe
> one choice that is relatively neutral (or even a "two-dot range"...).

When contrasting .. and ..., we have always used "asymmetric" vs
"symmetric".  I'd prefer to see usnot invent new phrase nobody has
used, which leads to unnecessary confusion and learning burden.
