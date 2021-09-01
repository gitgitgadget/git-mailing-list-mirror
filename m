Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE78C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 22:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C014A61075
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 22:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242364AbhIAW0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 18:26:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60063 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbhIAW0M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 18:26:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A698AE7876;
        Wed,  1 Sep 2021 18:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RoCMrdof3xjpORtepNO0wT/pCGZkDGE5n57VC6
        IjGBA=; b=bAE/5neaaieX89ozJAF8D8HVGQ98PdXDxm4H0kTUiRqMHx4Y+3m7j9
        VDFQarsVAbkGHWyasdZNZObgIrVf32B/NFgVF4UZUoANcayS1+KwAHnC/DlWQ2Fw
        tHgZvaC+v8HP4fwNFjuN2gGPIX3HE3vg2cgvulje2yFXCquYAO++g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C524E7875;
        Wed,  1 Sep 2021 18:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A199E7873;
        Wed,  1 Sep 2021 18:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
        <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 15:25:13 -0700
In-Reply-To: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 01 Sep 2021 11:57:07
        +0000")
Message-ID: <xmqqk0k0ndbq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A2D58C0-0B73-11EC-AD1E-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which was
> included in v2.22.0), we officially deprecated the --preserve-merges
> backend. Over two years later, it is time to drop that backend, and here is
> a patch series that does just that.

A good goal.  There is no remaining use case where (a fictitious and
properly working version of) "--preserve-merges" option cannot be
replaced by "--rebase-merges", is it?  I somehow had a feeling that
the other Johannes (sorry if it weren't you, j6t) had cases that the
former worked better, but perhaps I am mis-remembering things.

Thanks.

