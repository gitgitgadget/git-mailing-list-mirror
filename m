Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C9FC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 17:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244665AbiA0RhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:37:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61641 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiA0RhN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 12:37:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC18B174275;
        Thu, 27 Jan 2022 12:37:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=845UhONWM12U4OOABcY0IAB2PBrjDnT80CWhmJ
        y3fHs=; b=HpKA3QWnxe5l7mMwJyHbxv74DEjeoJHllfG0Ow5DHIWNXuA+/G6DhS
        SUDP+gyRhSugOUiAemhAbOwVkOeet9Uy8x8YbDumTD/2Ksr0lKdlcx+A59Q08n2u
        nLMUg1ASZiePs65HLvJFknTIeFcXAoJPTIfKpiWrg5tDofiKRNdiE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2E8B174274;
        Thu, 27 Jan 2022 12:37:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1964D174273;
        Thu, 27 Jan 2022 12:37:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 00/14] rebase: reset_head() related fixes and
 improvements
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <xmqqtufhpk1a.fsf@gitster.g>
        <aedee582-7f00-7e12-c378-35b0cbc6b565@gmail.com>
Date:   Thu, 27 Jan 2022 09:37:08 -0800
In-Reply-To: <aedee582-7f00-7e12-c378-35b0cbc6b565@gmail.com> (Phillip Wood's
        message of "Wed, 26 Jan 2022 10:53:44 +0000")
Message-ID: <xmqqilu53wsb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C148AB54-7F97-11EC-A7CD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> So the theme started out as "convert 'rebase -i' to use reset_head()
> and stop forking 'git checkout'" which I thought would be one to two 
> patches. Then I started looking at the code and realized that
> reset_head() needed some work before we could use it for 'rebase -i'
> and that work ended up dominating the series. I've updated the cover
> letter as you suggested.

Great.

It helped me summarizing the topic in the "What's cooking" report.

 Use an internal call to reset_head() helper function instead of
 spawning "git checkout" in "rebase", and update code paths that are
 involved in the change.

Perhaps I'd rename the topic branch, but perhaps not.

Thanks.  
