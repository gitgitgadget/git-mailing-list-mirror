Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE5E2018A
	for <e@80x24.org>; Wed, 29 Jun 2016 02:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbcF2Cjv (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 22:39:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54715 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752537AbcF2Cju (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 22:39:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 41A1826DB4;
	Tue, 28 Jun 2016 22:39:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gq5SglWD8dZXuJqB6seKLhxLfEs=; b=X8SJtM
	TNe06W+D7K4aZcY1ImHN5+o9j95SI5v276yUzw2xyDB04elXeiREjrNtmaJk+qRC
	XAGHuvYRYZ9Xs3TgRq9ke1DdQ3SZw873Znv1UVV05NEB0HT6eIjhIXQ8dX3K6KUt
	KgS9wY2Ehh0/3lscGWLWUTr7YZYRmdcAGk2ow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OEtm2qalN0ZVIpdy7xlLfnzUJfH/FriC
	5DNKZYlGEZfzeLmdfI6ZpfwiK7XC1k7cOmrRmpNvKNhEbJLL+NWIZJSIJQZedbxt
	y6pKclm4SyD+XHzP+p3DC+JdKYERAp4CAsxjTbbhdM7AsacBVpqDQ6DXVe6zhyTM
	x/V7Cq6346E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 39FF226DB3;
	Tue, 28 Jun 2016 22:39:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB20826DAF;
	Tue, 28 Jun 2016 22:39:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: preview: What's cooking in git.git (Jun 2016, #10; Tue, 28)
References: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
	<20160629014342.GA28661@sigill.intra.peff.net>
Date:	Tue, 28 Jun 2016 19:39:46 -0700
In-Reply-To: <20160629014342.GA28661@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 28 Jun 2016 21:43:43 -0400")
Message-ID: <xmqqziq467m5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF796058-3DA2-11E6-BF38-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Johannes pointed out that matching "3" for Windows is overly broad (it
> only happens due to raise(), not regular signal death).
>
> What do we want to do there?
>
> I _think_ matching "3" just makes us slightly less careful, and will not
> cause false positives (it may cause false negatives in very specific
> cases, though). So one option is to proceed as-is.
>
> Another is to just put the posix/ksh schemes into the helper function,
> and let Windows people sort it out later if they want to.

Probably the latter.  Thanks for stopping me ;-)
