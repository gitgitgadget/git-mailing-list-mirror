Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B8AC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 16:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbiGNQ2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239053AbiGNQ2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 12:28:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575C62A73
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 09:28:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D137D12D30E;
        Thu, 14 Jul 2022 12:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qbLvHVtX7BXhOjGE+BQRZthFKrrQfXcdpZSY4V
        zbcEI=; b=VijkYtwFjmpjGWMwR8jtsOdvfaBLcvSwPhnWpQBS1UrnLXIPucHo+V
        HzdYAQ2fjH/ogUzVqqMjVoGuMK0xbogSq+keh+6lkeNWNWSE5cmWUEeALAxhvaiT
        8EgBK95fSr42MZqVo1e24+jwYhBMWyYHOC+Ppm9n/uneTxjnOzeTE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C870F12D30C;
        Thu, 14 Jul 2022 12:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3760B12D30B;
        Thu, 14 Jul 2022 12:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: use a stable sort
References: <pull.1290.git.1657813429221.gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 09:28:11 -0700
In-Reply-To: <pull.1290.git.1657813429221.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 14 Jul 2022 15:43:49
        +0000")
Message-ID: <xmqqtu7j7j6s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F450E47A-0391-11ED-B1F5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> When sorting the output of `git shortlog` by count, a list of authors in
> alphabetical order is then sorted by contribution count. Obviously, the
> idea is to maintain the alphabetical order for items with identical
> contribution count.
> ...
>  	if (log->sort_by_number)
> -		QSORT(log->list.items, log->list.nr,
> +		STABLE_QSORT(log->list.items, log->list.nr,

Makes perfect sense.  Will queue.

Thanks.
