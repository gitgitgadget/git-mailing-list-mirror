Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F172036D
	for <e@80x24.org>; Wed, 22 Nov 2017 05:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbdKVFZQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 00:25:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57772 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750959AbdKVFZP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 00:25:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B0C9BC8FC;
        Wed, 22 Nov 2017 00:25:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N9vGSx/kJ9+kRm5o75cmRvEuVuo=; b=xY4f6i
        XeOUmx/6VGExhxmJuLRO9Ksy3qnEIP1EEKT6l7tM2LlISgxTCNovIA5iJ3xH8qIF
        iq2ZQZ6PLQoDSb8HQWyPSdfOu2BkOTJZZbOIROVQ7e/GgL3OfRpVjBvAS4vx+gIG
        oz5qLFH3WYcXdmbEZZKthP0Gm7Za0wvu7A66E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UT0UU7ZBcy6/kQURIw3ec+ybh+RQtVaP
        BfxUzCGJzjx0MzFhp3rJgrdAr5w/FpKKk8BIEkZp0qw6/iSJgWTlhknZGGyXMHvW
        c/qftVT4tahcOw6iWCj8IfFlMfJi7ZcSMOCv5vFhljSfjfC3pl3AA0P1oosxYfFG
        66t+WTdyocI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 013A8BC8FB;
        Wed, 22 Nov 2017 00:25:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71F6DBC8FA;
        Wed, 22 Nov 2017 00:25:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 00/10] Partial clone part 2: fsck and promisors
References: <20171121210720.21376-1-git@jeffhostetler.com>
Date:   Wed, 22 Nov 2017 14:25:13 +0900
In-Reply-To: <20171121210720.21376-1-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Tue, 21 Nov 2017 21:07:10 +0000")
Message-ID: <xmqqy3myubpi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84BDDFA8-CF45-11E7-BCE6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This is V5 of part 2 of partial clone.  This assumes V5 of part 1
> is already present.  V5 includes minor cleanup over V4 and better
> separates the --exclude-promisor-objects and --missing arguments.
>
> Part 2 is concerned with fsck, gc, initial support for dynamic
> object fetching, and tracking promisor objects.  Jonathan Tan
> originally developed this code.  I have moved it on top of
> part 1 and updated it slightly.

Thanks, will replace/queue all three series.  I am getting a feeling
that the first one is already ready for 'next', while the other two
may want to see a bit more comments?
