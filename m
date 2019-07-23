Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E77261F461
	for <e@80x24.org>; Tue, 23 Jul 2019 15:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfGWPmI (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 11:42:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63531 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfGWPmH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 11:42:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A333C16D5FF;
        Tue, 23 Jul 2019 11:42:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sU4+/PhtGthK9+3uhDH131Umf+A=; b=fTmHKm
        8aHK1HF1DQzkdXR0SKTi9vqCzfuduLvJYWj+6ORpTEb6Tz7Ho2WFtcaBMrfQWuXo
        lBKotx+g6HV6u7IwffHN/77IqXoqsoqGyTtM0/cm4ptuuhuuVrNU+M87e02AMpfd
        0IkiPavOrqqgQHx67wFuxPxzgkkDZP8K+bS3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p5nNcEA3F9mzg/08BnN2zq2kO2Xl4C+O
        tnyEVbZsD8pBrpqw+yKXWcu3p3VnC8tbLpadktjSMMMXqifjaIVwflKxQDIk1pqL
        lODvMWB4G3Ei2gPwnF8BkvSPPAN3Gi/fIxqvrUtOViYmn/fU66tEV7TbG6T8s9JT
        XGqE8lvV5go=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AF2216D5FE;
        Tue, 23 Jul 2019 11:42:03 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA89116D5FD;
        Tue, 23 Jul 2019 11:42:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: jk/test-commit-bulk,
References: <xmqqef2lvkg5.fsf@gitster-ct.c.googlers.com>
        <20190719215417.GA31841@sigill.intra.peff.net>
Date:   Tue, 23 Jul 2019 08:42:00 -0700
In-Reply-To: <20190719215417.GA31841@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 19 Jul 2019 17:54:17 -0400")
Message-ID: <xmqqsgqwu59z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6AA533C8-AD60-11E9-A525-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  Needs a bit more polishing.
>>  I think I spotted one unused command, which we may want to remove, though.
>
> I think these comments are out-of-date. The unused command was fixed up
> in v2 of the first patch, and then I did a little extra polishing in v3:
>
>   https://public-inbox.org/git/20190702051649.GA16344@sigill.intra.peff.net/

Thanks, indeed.  I've been a bit under the weather and my responses
may be a bit slow (haven't caught up with my mailbox, either X-<).

Will replace.  Thanks for all the help.

>
> Together with your SQUASH fixup, I think that covers all comments. For
> convenience, here's v3 again as a whole series which can replace what
> you have already (including the squash).
>
>   [1/6]: test-lib: introduce test_commit_bulk
>   [2/6]: t5310: increase the number of bitmapped commits
>   [3/6]: t3311: use test_commit_bulk
>   [4/6]: t5702: use test_commit_bulk
>   [5/6]: t5703: use test_commit_bulk
>   [6/6]: t6200: use test_commit_bulk
>
>  t/t3311-notes-merge-fanout.sh      |  10 +--
>  t/t5310-pack-bitmaps.sh            |  15 +---
>  t/t5702-protocol-v2.sh             |  10 +--
>  t/t5703-upload-pack-ref-in-want.sh |   4 +-
>  t/t6200-fmt-merge-msg.sh           |   7 +-
>  t/test-lib-functions.sh            | 123 +++++++++++++++++++++++++++++
>  6 files changed, 136 insertions(+), 33 deletions(-)
>
> -Peff
