Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A931FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbcHJWli (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:41:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751359AbcHJWlh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:41:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4684C34193;
	Wed, 10 Aug 2016 18:41:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aA/QJbivNGUyc5wrlxhYOXu/QWQ=; b=glhq4e
	mD+Vmoj+5lasOB336vMnZwowRwCFjNInuvNkEZJuyavzyxegmxS8KfqzfSQfc67/
	UdfWTKJ2izDJHlGPuxE9+2M4ogxltC5tahO84oDdLjjTCVgmTWQPdTIPMg4rF979
	i6KBwEmHb8iJZbaS7zRX3Q3rqMzUj11GAmqIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QMSkz8czRHUEbTxqQMp7ywriJ0O7WC3f
	z6JWAowiRYK6K1xRMgPCjgo2dHI02ucx1jeC+a45OqPijiCYrIkqdfGO0yJMqNFQ
	wZ69IXuH6Xvj4Lqs4/yQDkyb2loDS4NlXJX+hdh2KiCxN+P71GvayaDI904lzPul
	OPtleqzvUiE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E69034192;
	Wed, 10 Aug 2016 18:41:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3A0134191;
	Wed, 10 Aug 2016 18:41:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff Hostetler <git@jeffhostetler.com>
Cc:	git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 9/9] status: unit tests for --porcelain=v2
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
	<1470434434-64283-10-git-send-email-git@jeffhostetler.com>
	<xmqq4m6vgpf9.fsf@gitster.mtv.corp.google.com>
	<57AB9C61.5060409@jeffhostetler.com>
Date:	Wed, 10 Aug 2016 15:41:33 -0700
In-Reply-To: <57AB9C61.5060409@jeffhostetler.com> (Jeff Hostetler's message of
	"Wed, 10 Aug 2016 17:28:01 -0400")
Message-ID: <xmqqvaz82qn6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97ED3918-5F4B-11E6-866D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> In my brief testing, the existing porcelain status reports it as "AM"
> (for both a file with content and an empty file).
>
> The V2 code outputs the following:
> 1 AM N... 000000 100644 100644

OK, so they are consistent, which is good.

>> Having said all that, it is OK to fix their titles after the current
>> 9-patch series lands on 'next'; incremental refinements are easier
>> on reviewers than having to review too many rerolls.
>
> I'll change the test titles to have all that info.

OK.  As I said, if the retitling is the only change, then doing so
as a follow-up to the existing 9-patch series would be easier to
review.  If there are other changes needed, a reroll of the full set
is probably better.

>> This is a small point, but doesn't the lowercase 'u' somehow look
>> ugly, especially because the status letters that immediately follow
>> it are all uppercase?
>>
>
> Since we are inventing a new format and my column 1 is completely new
> I didn't think it mattered.

Wrong assumption ;-)  We want the resulting code to be consistent.

> And I used a lowercase 'u' to distinguish
> it from the "U" in the X and Y columns since they mean different
> things.

I thought they both mean "Unmerged"; that is why I thought seeing a
lowercase there was very strange.

Thanks.
