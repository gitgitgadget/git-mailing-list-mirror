Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC8C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245620AbiCJSyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbiCJSyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:54:52 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD8155C1D
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:53:51 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E97CA182097;
        Thu, 10 Mar 2022 13:53:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CIcB2jHkLYDSplgmrojBp5aFf6EF1RaLKWk9H5
        EdEMg=; b=rQ4pwOjlfRJFZN3yySCdpqSmI7LSNErwmfZXkNdwgH9OwtCbr1q2pY
        m1NF4554TXdvIv9xSNvhw1/1oOVtrJ8PpcvUr60nyb2dnmCy3MiCmhHccABCmUOI
        XY6hpvKnQE9bk2pU+I3IHrE6w0j3ftjkjATCoG50QH1dEl/Cottwc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2E5A182096;
        Thu, 10 Mar 2022 13:53:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 65891182095;
        Thu, 10 Mar 2022 13:53:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/4] builtin add -p: hopefully final readkey fixes
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
        <20220309110325.36917-1-phillip.wood123@gmail.com>
        <xmqqilsmlo31.fsf@gitster.g> <xmqqzglyk89e.fsf@gitster.g>
        <93d197db-c52c-101b-bdb0-3b4c9b073705@gmail.com>
        <a1e51433-71b1-b32d-0475-192b83bac43a@gmail.com>
Date:   Thu, 10 Mar 2022 10:53:47 -0800
In-Reply-To: <a1e51433-71b1-b32d-0475-192b83bac43a@gmail.com> (Phillip Wood's
        message of "Thu, 10 Mar 2022 18:18:31 +0000")
Message-ID: <xmqqo82dej0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B71668A-A0A3-11EC-B683-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Looking more closely that should be "break" not "return 0". I think
> what has happened is that I accidentally based these on an old version
> of pw/single-key-interactive which did not contain 24d7ce383a
> ("terminal: always reset terminal when reading without echo",
> 2022-02-22)

I thought the base pw/single-key-interactive topic is solid enough
and ready for 'next'?  It probably is a good idea to rebase these
follow-on patches on top of a merge of the base topic into 'master'.

I'll keep v2 in 'seen' but mark the topic as "Expecting a reroll"
in the draft of the next issue of the "What's cooking" report.

Thanks.
