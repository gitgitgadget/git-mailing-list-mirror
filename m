Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783DAC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 23:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiFFXAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiFFXAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 19:00:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E48BC03
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 16:00:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09B50191969;
        Mon,  6 Jun 2022 19:00:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EMfZ31ws8ww7uG4E2r1WnTj2q0CJX04TIeCUFS
        3PZ4Y=; b=rB0pO93PpgCyNvMxs7tDV+LFwMLeeTsXI7Noc4LrK36AphtYaERFq/
        uvb1OPLZ9xG7gyAVrXWWOHA3rGUJO57nKyTL4oE4ROuHr5bWNC2EbYfIK0uDSRCS
        Pumobo/emKNEQzduwjPmghIDeh8uRPWVVEJtDJlXmimdV4nGrQ+zo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02398191964;
        Mon,  6 Jun 2022 19:00:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A2AAF19195F;
        Mon,  6 Jun 2022 19:00:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH 0/2] builtin/show-ref.c: support `--count` for limiting
 output
References: <cover.1654552560.git.me@ttaylorr.com>
        <xmqqo7z54d7g.fsf@gitster.g> <Yp6GRccc5UElNrZb@nand.local>
Date:   Mon, 06 Jun 2022 16:00:00 -0700
In-Reply-To: <Yp6GRccc5UElNrZb@nand.local> (Taylor Blau's message of "Mon, 6
        Jun 2022 18:57:09 -0400")
Message-ID: <xmqqk09t4cun.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65EDEC54-E5EC-11EC-BCC5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> If you're strongly opposed to having `show-ref` match `for-each-ref`'s
> `--count` option, I won't be too sad. But I'm not in a huge rush to
> replace this series with `git --pipe-to-head-N=<n>` either, FWIW.

Heh, to me "git --pipe-to-head-N=<n>" smells equally absurd, too ;-)
