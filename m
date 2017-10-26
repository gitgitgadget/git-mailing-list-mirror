Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 794682055E
	for <e@80x24.org>; Thu, 26 Oct 2017 02:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdJZCJ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 22:09:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60053 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751911AbdJZCJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 22:09:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB8099853B;
        Wed, 25 Oct 2017 22:09:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lhlJ2Lrxqq38JtkEvbQvOkvgzaQ=; b=Q62ku5
        uKatk1fmvjpQgykqS6K75knRzRHm7DrrQjV0g/CovyQc/TvmpU3YmNh/mV+kgoh3
        ZrgrmEfVjvJcGakcPNiMf3JslbxLmzGrWegA9wC6qy/Fli7KydycEgP1KYMrijfT
        ieBwB4Y+Pt0e2i09VoZ3Z3p/vwo659tnaT6wM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RBXCz771n3UKL+YVyW10vcSssFdOlvo3
        /yv2P5n5A4poVXiT0MYkbyeILOVt4CWMx+OBUnXxRYRhhh8A8cUUc7nC7xKUidiO
        TbOvx1x9Ema2EQf2iN63CEwlqAiL0phNgPDzZIzsrr/4lYxkkIw8aXINi4IRfRPT
        JtuV3zrN5+o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1FE69853A;
        Wed, 25 Oct 2017 22:09:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 073E198538;
        Wed, 25 Oct 2017 22:09:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 00/13] WIP Partial clone part 1: object filtering
References: <20171024185332.57261-1-git@jeffhostetler.com>
        <xmqqmv4fizyn.fsf@gitster.mtv.corp.google.com>
        <CAGf8dg+cK3WpEqosgkbdcrDzrMXJxVYHiBZda6UM7k8Ggq=eBw@mail.gmail.com>
        <4ac6ffd8-60bd-d2bc-6bc1-6c5bb1473416@jeffhostetler.com>
Date:   Thu, 26 Oct 2017 11:09:24 +0900
In-Reply-To: <4ac6ffd8-60bd-d2bc-6bc1-6c5bb1473416@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 25 Oct 2017 11:39:00 -0400")
Message-ID: <xmqq3766hd7v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0F991D8-B9F2-11E7-B1E2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> A question of mailing-list etiquette: in patch 9, I took Jonathan's
> ideas for adding the "extensions.partialclone" setting and extended it
> with some helper functions.  His change was part of a larger change
> with other code (fsck, IIRC) that I wasn't ready for.  What is the
> preferred way to give credit for something like this?

I think the note you left in the proposed log message

    This patch is part of a patch originally authored by:
    Jonathan Tan <jonathantanmy@google.com>

was a bit misleading.  The phrasing makes it sound as if it is
more-or-less verbatim copy (either of the whole thing or just a
subset) of Jonathan's patch, in which case, keeping the authorship
intact, i.e.

	From: Jonathan Tan <jonathantanmy@google.com>

	... log message taken from the original, with additional
        ... note to describe any adjustment you did

	Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
	Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>

would have been more appropriate.  But if you just were inspired by
the idea in his patch and wrote a one that is similar to but
different from it that suits the need of your series better, then a
note left in the log that instead does s/is part of/was inspired by/
would have been perfectly fine.

Thanks.



