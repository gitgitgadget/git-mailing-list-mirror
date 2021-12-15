Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E07AC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 22:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhLOW6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 17:58:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60800 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhLOW6L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 17:58:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2793DF316F;
        Wed, 15 Dec 2021 17:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=uPC6Vg7gtD5Jn9q6bF5BRcKwRXu4RPUiwOz9RDcR4x8=; b=Kwbb
        LGHLM1xL69Q3s4SeJ760B65Uem/yJUiL5alc+HtvVw8GI156fxyf4JiCtNZ/W0rJ
        mOkKFZ61MKnQDuAbvVKVa4ujA1MlbdijV3HYUMCrPGmxmdV69QfHd3iE4KMCO/IH
        sJa7/c1Xp3Lh4l8eHj86Yz1V8dFGXhrk4AwEjF4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E70CF316E;
        Wed, 15 Dec 2021 17:58:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 49B19F316C;
        Wed, 15 Dec 2021 17:58:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
References: <cover.1638991570.git.me@ttaylorr.com>
        <cover.1639446906.git.me@ttaylorr.com>
Date:   Wed, 15 Dec 2021 14:58:07 -0800
Message-ID: <xmqqzgp11nnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 78E68E26-5DFA-11EC-ACED-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>  Documentation/technical/multi-pack-index.txt |   1 +
>  Documentation/technical/pack-format.txt      |  13 +-
>  midx.c                                       |  31 +++-
>  midx.h                                       |   1 +
>  pack-revindex.c                              |  20 ++
>  t/lib-bitmap.sh                              | 186 +++++++++++++++++++
>  t/t5326-multi-pack-bitmaps.sh                | 144 +-------------
>  t/t5327-multi-pack-bitmaps-rev.sh            |  23 +++
>  t/t7700-repack.sh                            |   4 -
>  9 files changed, 271 insertions(+), 152 deletions(-)
>  create mode 100755 t/t5327-multi-pack-bitmaps-rev.sh

As 5327 is taken by the tb/cruft-packs topic, I'll move it to 5328.

Thanks.

