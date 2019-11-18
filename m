Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0945D1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 02:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfKRCRj (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 21:17:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52712 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRCRi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 21:17:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF9DE8D730;
        Sun, 17 Nov 2019 21:17:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nFYcn+NN5+jC4QGoMwzaN2EXxdM=; b=dlvsvq
        5lDm07T6lTBmPw5M9QuIQZ/ogP9hY5tmfzQU33Qcjpseirbr2jUXErZqVDOVfgQL
        wPL7OA+RlYNSHSn86mYsgCNeOVW1x1Nnmf9wXtmtB2y4rte/dEcah6RbeYbr9ySU
        b9/q86JMzL/Zb57kqiGJSW/T0+k47l3mktdrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SFi+tamzStChoMknzoL0peg29YGs29g5
        lLUw/RQ0aXsddmDD/TpG8HXHeBK93lwtYbSl7e0ZEh6gc+yYqSx7XBoDAh7TjjzU
        lROljZuOq62nySXV3WovWv2BpRZFX965hm3+eWC2a3Dzs+SlCMg4Hc4Nb3kid4zk
        bG3l5L4T5fs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC1658D72F;
        Sun, 17 Nov 2019 21:17:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9A7B8D72C;
        Sun, 17 Nov 2019 21:17:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/8] build-in add -i: implement all commands in the main loop
References: <pull.171.git.1573821382.gitgitgadget@gmail.com>
Date:   Mon, 18 Nov 2019 11:17:31 +0900
In-Reply-To: <pull.171.git.1573821382.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 15 Nov 2019 12:36:14
        +0000")
Message-ID: <xmqqwoby2ais.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94C75F5A-09A9-11EA-82D3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Based on the js/builtin-add-i branch, this patch series implements the rest
> of the commands in git add -i's main loop: update, revert, add_untracked, 
> patch, diff, and quit. Apart from quit, these commands are all very similar
> in that they first build a list of files, display it, let the user choose
> which ones to act on, and then perform the action.

So, this obviously depends on the previous "let's start the main
loop" series, in which I recall you found at least one remaining bug
after sending the latest round.

I'd prefer to queue this on top of the iteration of that series,
which would hopefully become the final one, which would let me avoid
one rebase of this series ;-)

Thanks.
