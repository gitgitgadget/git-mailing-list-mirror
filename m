Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65122C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 20:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiADUNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 15:13:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57921 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiADUNm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 15:13:42 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E71F3F96BF;
        Tue,  4 Jan 2022 15:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sEQBu0SZd860GLdqyZi5lqARpzcN+nJZUfZXOg
        cQ4ng=; b=XfjrEJdy91tF7WipVCDSFAfR3FTenddQqF3rHXXA6ONfRfzcjjRoYA
        eTm5cO1S8MEjzyxvHh6MleNnGXF2MuO3jojYtK7Vm4+QPhSA8KnosfTdOyg+CWgm
        N19i/M3Kz+Ap78mtvfBr+hEFMXje9EU82iFcTYnxfogHTGuwMu4YI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE340F96BE;
        Tue,  4 Jan 2022 15:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FAB3F96BC;
        Tue,  4 Jan 2022 15:13:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: tb/midx-bitmap-corruption-fix
References: <xmqqsfu4duxl.fsf@gitster.g> <YdSExm8fIiRePHI4@nand.local>
Date:   Tue, 04 Jan 2022 12:13:39 -0800
In-Reply-To: <YdSExm8fIiRePHI4@nand.local> (Taylor Blau's message of "Tue, 4
        Jan 2022 12:32:54 -0500")
Message-ID: <xmqq7dbfcl8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF44FFDC-6D9A-11EC-95C9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Jan 03, 2022 at 07:46:46PM -0800, Junio C Hamano wrote:
>> * tb/midx-bitmap-corruption-fix (2021-12-23) 9 commits
>>  - midx: read `RIDX` chunk when present
>>  - t/lib-bitmap.sh: parameterize tests over reverse index source
>>  - t5326: move tests to t/lib-bitmap.sh
>>  - t5326: extract `test_rev_exists`
>>  - t5326: drop unnecessary setup
>>  - pack-revindex.c: instrument loading on-disk reverse index
>>  - midx.c: make changing the preferred pack safe
>>  - t5326: demonstrate bitmap corruption after permutation
>>  - Merge branch 'tb/cruft-packs' into tb/midx-bitmap-corruption-fix
>>  (this branch uses tb/cruft-packs.)
>>
>>  A bug that made multi-pack bitmap and the object order out-of-sync
>>  (hence the .midx data gets corrupted) has been fixed.
>>
>>  What's the status of this thing?
>>  source: <cover.1639446906.git.me@ttaylorr.com>
>
> I have a small reroll that I'll send shortly which contains a minor
> fixup and one new patch on top.
>
> I'm assuming that the "uses tb/cruft-packs" is related to the two topics
> both squatting on t5327's real estate?

It refers to the fact that the patches of this topic are queued on
top of a merge of that branch into (back-then-current) master, as
they didn't cleanly apply to (back-then-current) master.

> Otherwise, the version I am going to send is based off of dcc0cd074f
> (The sixth batch, 2022-01-03) in your tree, so it should apply cleanly
> onto master without the other topic.

OK.
