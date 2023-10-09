Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1635CD611A
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 18:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377093AbjJISJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 14:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376898AbjJISJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 14:09:14 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B5194
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 11:09:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D0B61BA9F8;
        Mon,  9 Oct 2023 14:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=C0vTEl4hle+sILirvy5j8pmAQWUBY2T+dol0Mu
        smI0U=; b=NodjEeiHS3JMHm9/SFZZ2/X0eGvVm/2bDIQm+DgkkoqD+ARGRYQ9gI
        Awa26Z9AAd9SGJoVBYKNOuzacC0Lc5816SPsKeiIu8A3xBPGm++diqFy+LRpTg+b
        xso5CsD/RCLCZmA4L6+CDrpDOqQNIfa6eY1lAKXG5D7nfnEcQVSjE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 634341BA9F7;
        Mon,  9 Oct 2023 14:09:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 002901BA9F5;
        Mon,  9 Oct 2023 14:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
In-Reply-To: <ZSQnVnK0k3bdk5zX@nand.local> (Taylor Blau's message of "Mon, 9
        Oct 2023 12:16:22 -0400")
References: <xmqqh6n24zf1.fsf@gitster.g> <ZSQnVnK0k3bdk5zX@nand.local>
Date:   Mon, 09 Oct 2023 11:09:07 -0700
Message-ID: <xmqqfs2j1xdo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1296082-66CE-11EE-9A90-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Sat, Oct 07, 2023 at 01:20:02AM -0700, Junio C Hamano wrote:
>> * tb/repack-max-cruft-size (2023-10-05) 4 commits
>>   (merged to 'next' on 2023-10-06 at b3ca6df3b9)
>>  + builtin/repack.c: avoid making cruft packs preferred
>>  + builtin/repack.c: implement support for `--max-cruft-size`
>>  + builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
>>  + t7700: split cruft-related tests to t7704
>>
>>  "git repack" learned "--max-cruft-size" to prevent cruft packs from
>>  growing without bounds.
>>
>>  Will merge to 'master'.
>>  source: <cover.1696293862.git.me@ttaylorr.com>
>>  source: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>
>
> Thanks. On a semi-related note, did you want to pick up my patch in
>
>   https://lore.kernel.org/git/035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com/
>
> ? That should address a performance bug that occurs when a repository
> (incorrectly) chooses a cruft pack as its preferred pack source when
> writing a MIDX bitmap, significantly impeding the pack-reuse mechanism.

Isn't that in the above list already as b3ca6df3b9^2?


