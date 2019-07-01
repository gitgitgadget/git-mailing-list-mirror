Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 597F21F461
	for <e@80x24.org>; Mon,  1 Jul 2019 16:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfGAQ3s (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 12:29:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54348 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGAQ3s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 12:29:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 061F56DE9E;
        Mon,  1 Jul 2019 12:29:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BZRWYICAVcWOhH3nxfO8utdQ/Ig=; b=p0Jj+r
        PiCifouhj6JPXPs6BiWDAEgJfJ78JrRtozZo2XBgjMXmsedZcWJng996zV3V+WYR
        m6NyyzpLiWEhX34QhYkYXKS6fhn7d2nCg/35lG63xKTAIpg/O1U8nxewJdtr73Rw
        H6xfbTRYkkJGUBLZpjuSyLBW3IjvMYyWZpFX4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HFt0cUUIoE3c8uElxWfsxB980HAFiu6F
        Hz/GJtbqszpXgtBSWq4AiJiPQ2zlDcWiWMKelavogB+rcYR+l4GvJ5c0Lo072oHF
        Hlsx6AQ4AMJzpNJ0WXWAP/ChrWbnhfkF/B85zVvBUPakjArtNncIAUMyVH+okA/E
        PkQ2h10xdoM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F18F76DE9D;
        Mon,  1 Jul 2019 12:29:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 26B0A6DE9C;
        Mon,  1 Jul 2019 12:29:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Barret Rhoden <brho@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
        <20190628062457.GA18662@sigill.intra.peff.net>
        <4d466fce-15df-3a73-f5f9-f29bc5b79a04@google.com>
Date:   Mon, 01 Jul 2019 09:29:41 -0700
In-Reply-To: <4d466fce-15df-3a73-f5f9-f29bc5b79a04@google.com> (Barret
        Rhoden's message of "Mon, 1 Jul 2019 10:07:05 -0400")
Message-ID: <xmqqmuhx7m6i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E676372-9C1D-11E9-863E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Barret Rhoden <brho@google.com> writes:

> On 6/28/19 2:24 AM, Jeff King wrote:
>> On Wed, Jun 26, 2019 at 03:29:29PM -0700, Junio C Hamano wrote:
>>
>>> * br/blame-ignore (2019-06-20) 9 commits
>>>   - blame: add a test to cover blame_coalesce()
>>>   - blame: use the fingerprint heuristic to match ignored lines
>>>   - blame: add a fingerprint heuristic to match ignored lines
>>>   - blame: optionally track line fingerprints during fill_blame_origin()
>>>   - blame: add config options for the output of ignored or unblamable lines
>>>   - blame: add the ability to ignore commits and their changes
>>>   - blame: use a helper function in blame_chunk()
>>>   - Move oidset_parse_file() to oidset.c
>>>   - fsck: rename and touch up init_skiplist()
>>>
>>>   "git blame" learned to "ignore" commits in the history, whose
>>>   effects (as well as their presence) get ignored.
>>>
>>>   Will merge to 'next'.
>>>   cf. <20190620163820.231316-1-brho@google.com> (v9)
>>
>> My -Wunused-parameter branch complained about merging with this. Since
>> it's in 'next', we'd want something like this on top, I think (ideally
>> after Barret confirms my hand-waving below).
>
> Looks good to me.

Thanks for a quick response.  I'll queue Peff's fixup on top of what
is shown above.

The patches are already in 'next', so we'll go incremental to fix
any issues discovered in the series from here on, instead of
replacing the series wholesale.

Thanks.
