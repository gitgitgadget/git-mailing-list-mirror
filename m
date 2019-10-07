Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8AA91F4BF
	for <e@80x24.org>; Mon,  7 Oct 2019 01:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfJGBY7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 21:24:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53152 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJGBY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 21:24:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC1E68DA9E;
        Sun,  6 Oct 2019 21:24:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iqZzx42lErwafZKtuHq1/qVVA50=; b=uaxqjJ
        ENIwmo5KdFQINz3msCi7sCPX57fPjaM4ZicYNFLvgenv/NIgXFUCHPtseaLmtcJ7
        SVs84H+XaLKCFxCnCDcgfRS+wPYba9X7HBRse1Bwr82BEkWcRjEaUGml8W2dYcm2
        /NZItxhUhWPnsa9TYBetA3V8UbqBcn6xVbukQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Txk4o2FX+UgfUI6FgQn6zv2eIPoqqZpm
        N9EHH5RyrZKb6rukIpKdvTWnh+6/4iQyDDnB7Oc1Yn8N568YZ5LyqgRwrWKj514X
        Z6vwV6YYg/53PvzKhfcxmEuWtkLq7Axs/SLMIGIzTOT1LtSAlrLUd2GUuq7YEM5Z
        UkjwZCh/Qvo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C35428DA9D;
        Sun,  6 Oct 2019 21:24:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0DF98DA9B;
        Sun,  6 Oct 2019 21:24:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 00/20] hashmap bug/safety/ease-of-use fixes
References: <20191006233043.3516-1-e@80x24.org>
Date:   Mon, 07 Oct 2019 10:24:51 +0900
In-Reply-To: <20191006233043.3516-1-e@80x24.org> (Eric Wong's message of "Sun,
        6 Oct 2019 23:30:23 +0000")
Message-ID: <xmqqo8yt4aak.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4403E60C-E8A1-11E9-8257-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> v3 changes:
> - use __typeof__ to avoid invalid clang warning on uninitialized var
> - formatting fixes recommended by Stolee
> - add Reviewed-by for Stolee
> - add patch 20 to update docs to drop first member requirement

I just did

	git checkout ew/hashmap
	git checkout master...
	git am -s <mbox-with-these-patches
	git diff @{-1}

and all the differences between them I agree with (and needless to
say, I looked at all the changes in the previous round).

Looks much nicer.

Thanks.
