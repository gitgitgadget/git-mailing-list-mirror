Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E96D51F454
	for <e@80x24.org>; Sat,  2 Nov 2019 06:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfKBGNp (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 02:13:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60835 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKBGNo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 02:13:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DA2B9D2D8;
        Sat,  2 Nov 2019 02:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a2qZurAxD46b3GwvoXFEajRT3Xo=; b=rHnHhQ
        Y5HaWSL/MUfzqDWBW+8bzmYhY14yqem7Es9iptum62sjZvDKUtTKKe0twg8xQMVV
        pfqU8AbYmONOieziOvtKXDmewYS8WYi1jNc2xvPs74ovlmkm3gWUBYu0dx1Qk9fC
        9YkjF8a0tf/u1uQCW7IvN+Qq9LJ2dkNFjFGq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h+HfSp12bfaw5+NL2mc5m0iEFoMLS/4b
        xFysbae5/9mxCbdVmYQpTGXXRoitGSfqAIfehUhU7rq2iFSjrt8dFC6N+fFHoK6b
        Kid9R4vtscejXMTqeGXu8w4GS5uPAqdOHbd6oNVPL8tyFgUoVKtUOt8ZFrbUggJ5
        hHZMAuLvvsI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 956829D2D7;
        Sat,  2 Nov 2019 02:13:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C671E9D2D6;
        Sat,  2 Nov 2019 02:13:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/commit-graph-on-fetch (was Re: What's cooking in git.git (Oct 2019, #07; Wed, 30))
References: <xmqqd0ee3du9.fsf@gitster-ct.c.googlers.com>
        <afec0f94-466a-2901-4dd7-528d0ae587fa@gmail.com>
Date:   Sat, 02 Nov 2019 15:13:38 +0900
In-Reply-To: <afec0f94-466a-2901-4dd7-528d0ae587fa@gmail.com> (Derrick
        Stolee's message of "Wed, 30 Oct 2019 08:39:26 -0400")
Message-ID: <xmqqlfsy3iwd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA59A8A2-FD37-11E9-9503-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> * ds/commit-graph-on-fetch (2019-10-25) 2 commits
>>   (merged to 'next' on 2019-10-30 at 3ca711f743)
>>  + commit-graph: fix writing first commit-graph during fetch
>>  + t5510-fetch.sh: demonstrate fetch.writeCommitGraph bug
>> 
>>  "git commit-grph write" hit BUG() in corner cases.
>
> s/grph/graph/

Thanks.

> I had thought this bugfix was worthy of making the release, as it
> may affect more users than I realized (anyone with a submodule, fetching
> after first clone).

Ah, I somehow mistook that this was a fix for an old corner case bug
that has left undiscovered for some time, but writing commit graph
after fetching is a fairly recent thing, so it is a regression fix.

Thanks.
