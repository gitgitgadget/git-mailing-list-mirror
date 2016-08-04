Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B981F855
	for <e@80x24.org>; Thu,  4 Aug 2016 23:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbcHDXcZ (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 19:32:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51342 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758187AbcHDXcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 19:32:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B67433159;
	Thu,  4 Aug 2016 19:32:05 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YrXYFMFl9rZyTWDnPw9D4o2xcJ4=; b=pt0kvy
	Ll7igpbommFvHcnlWeVp92M9maS+41AkwQHCJpRaZ9VF35dj0gGqhQrCC8a99o+x
	nhE6+Gjz5858QeJxLYvLYFBuxZRGYMiwouZhZCaoMrvam5fOIyBHa3Z3cnOT2Vqs
	7aBkmtPHoR0xQtz1h4tEk0UFk8IoHBGZiogTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hLjy3J+FGuHinRrBn5lyyHa32/rNy4jK
	z09SMod4nFAzzDgBg2wvhQcM10b0ZwHm3A3RezqwzPQYXxqgkr7lEo/ad23Thclr
	zUBxZIIWKVc9j9YxrNDyga5klHWNbIBajWFfHaL9zoKmmFz2SVGMVlXLgvUOgxNb
	7z9lJG8SOo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3255333158;
	Thu,  4 Aug 2016 19:32:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 97BA233157;
	Thu,  4 Aug 2016 19:32:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Mike Hommey <mh@glandium.org>
Cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
	<20160804225649.q77p4u6cbdo6q336@glandium.org>
Date:	Thu, 04 Aug 2016 16:32:02 -0700
In-Reply-To: <20160804225649.q77p4u6cbdo6q336@glandium.org> (Mike Hommey's
	message of "Fri, 5 Aug 2016 07:56:49 +0900")
Message-ID: <xmqqfuqkyutp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6CE51A6-5A9B-11E6-8CA3-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> On Thu, Aug 04, 2016 at 03:28:55PM -0700, Junio C Hamano wrote:
>> * mh/connect (2016-06-06) 10 commits
>>  - connect: [host:port] is legacy for ssh
>>  ...
>>  - connect: document why we sometimes call get_port after get_host_and_port
>> 
>>  Rewrite Git-URL parsing routine (hopefully) without changing any
>>  behaviour.
>> 
>>  It has been two months without any support.  We may want to discard
>>  this.
>
> What kind of support are you expecting?

The only rationale I recall you justifying this series was that this
makes the resulting code easier to read, but I do not recall other
people agreeing with you, and I do not particularly see the
resulting code easier to follow.

> FWIW, I have WIP cleaning up the code further, tha obviously depends on
> this series.

As this is not even in 'next', your cleaning-up does not have to
depend on it.  It can be part of a reroll, of course.

By the way, "discarding" is not equal to "rejecting".  The latter is
"it is a bad thing to do, don't even come back with a new version".
It is just "This hasn't made any progress, and it is not ready for
'next', either. Keeping it in 'pu' is eating my time without giving
much benefit to the project at this point".
