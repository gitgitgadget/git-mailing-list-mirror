Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B34520444
	for <e@80x24.org>; Wed, 11 Oct 2017 10:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756811AbdJKKm2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 06:42:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60781 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753345AbdJKKm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 06:42:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83797ACADD;
        Wed, 11 Oct 2017 06:42:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qX2Kk7njKb/oxelmeCpXKqfIe1U=; b=n1GTZG
        3x/PR3PmDMs25yivvR28mYlbQGuz09jl2I5LEiYeHGitaNvyaGR78YOYIL6YqzVK
        NcZc2fIdmvSy0yS4EEaGt62DBCoP8JJxB2SYbXouGnxkFIyOFX1Zp+772putohug
        cotdFRNm83JoP3+tH3G80Rh9hIqllt5/so/hE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V+mTUINeCdiCKA67YQd2TXOJRrjhLVJ6
        bPXbsPyISHhFEdlTtQPdKuMJJ/17FQZ/xKCff+GcxrfuAaHbTHIQy4Mb9dhhG80J
        Aq4oYLzlBER0xeVFBZTiseilW29ul/iAB4zqgjL4egFznRNP030wPdLrgKH8aR2I
        OqZ2Qb9IbtM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C3D4ACADC;
        Wed, 11 Oct 2017 06:42:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB92BACADB;
        Wed, 11 Oct 2017 06:42:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 00/24] object_id part 10
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
        <9e44abcf-abcb-4868-d1cd-2326ea8df3ed@alum.mit.edu>
Date:   Wed, 11 Oct 2017 19:42:25 +0900
In-Reply-To: <9e44abcf-abcb-4868-d1cd-2326ea8df3ed@alum.mit.edu> (Michael
        Haggerty's message of "Wed, 11 Oct 2017 12:05:50 +0200")
Message-ID: <xmqq8tgim0dq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFA54050-AE70-11E7-9D63-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I took a stab at rebasing this patch series on top of current master
> using `git-imerge`. I pushed the results to my GitHub fork [1] as branch
> `object-id-part-10-rebased`. I didn't check the results very carefully,
> nor whether the commit messages need adjusting, but I did verify that
> each of the commits passes the test suite. Junio, it might serve as
> something to compare against your conflict resolution.
>
> Michael
>
> [1] https://github.com/mhagger/git

2f0e14e6 ("Merge branch 'js/rebase-i-final'", 2017-10-09) is where
your -rebased series has forked from the mainline.  I checked that
fork-point out, merged bc/object-id I queued to it, with the help
from rerere I earlier taught.  The resulting tree was identical to
the tip of your rebase.

So hopefully both of us should be good ;-)  I do not know about the
intermediate steps, though.

Thanks.
