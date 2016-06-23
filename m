Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234A21F728
	for <e@80x24.org>; Thu, 23 Jun 2016 06:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbcFWGRR (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 02:17:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053AbcFWGRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 02:17:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF39D247A1;
	Thu, 23 Jun 2016 02:17:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SfBd6GpI4L8ZG5Ki/PsIZerJZpc=; b=LAc/ff
	JgV0NxELVWPjxmf4LastXtNTQsMOyKI/ozrhjZauC/wjfgsklO7a+UxofV5e0nOm
	LS25tPrdMpwJQTRpwZcpZdXdKYRHbl7iePB2mzf9qUC9sYGNaKzezCeF+zmUNL0P
	bj3zeYa5Rifh2coaq9yXOkJCilCZM9CciAax4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rS/LsXQjfrpn8kix4zyuGAPf2tPNR8nX
	DC4T0O8t+T/MhqyxZ95noQNJ9rjS1Hcvpzmn87l2lFkh/zPQzKtL0bfbUDjXjqUm
	F23nEbbT8VVS/yBEzbAbGHl4ez9y20wAocbAfKzexI8fZdegR/vLQNFRq7x8VjJx
	fjQcL2kHSQk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D83972479F;
	Thu, 23 Jun 2016 02:17:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E1A52479E;
	Thu, 23 Jun 2016 02:17:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Emily Xie <emilyxxie@gmail.com>
Cc:	git@vger.kernel.org, David Turner <novalis@novalis.org>
Subject: Re: [PATCH] pathspec: warn on empty strings as pathspec
References: <20160622230024.24034-1-emilyxxie@gmail.com>
	<xmqqmvmckebv.fsf@gitster.mtv.corp.google.com>
	<CAAin2AQR3yP7X=NLQ=9+0QGJZMCN7=xbpZ=H7r56RvvBfLJSEg@mail.gmail.com>
Date:	Wed, 22 Jun 2016 23:17:12 -0700
In-Reply-To: <CAAin2AQR3yP7X=NLQ=9+0QGJZMCN7=xbpZ=H7r56RvvBfLJSEg@mail.gmail.com>
	(Emily Xie's message of "Wed, 22 Jun 2016 19:48:47 -0400")
Message-ID: <xmqqh9ckjuon.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20CA7C4A-390A-11E6-BB0D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Emily Xie <emilyxxie@gmail.com> writes:

> Awesome. Thanks, Junio---this is exciting!

No, thank _you_.

> As for step 2: do you have a good sense on the timing? Around how long
> should I wait to submit the patch for it?

Not so fast.  We'll wait for others to comment first.

I am queuing this change but that does not mean anything more than
that I am not outright rejecting the idea.

It is possible that others may assess the cost of having to do the
two-step migration differently, and the list concensus may end up
being "if it hurts, don't pass an empty string", i.e. we'd better
without this patch or subsequent second step.  If that happens, the
first step dies without hitting 'next'.  I'd say we'd wait at least
for a week.

Otherwise, if the change is received favourably, we'll merge it to
'next', do the same waiting for comments.  Repeat the same and then
merge to 'master'.  After it hits the next feature release (probably
at around the end of August), the change will be seen by wider
general public, and at that point we may see strong opposition from
them with a good argument neither of us thought of why we shouldn't
do this change, in which case we might have to revise the plan and
scrap the whole thing.

So, we'll wait and see.

