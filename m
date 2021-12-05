Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BC5C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 10:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhLEKGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 05:06:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59442 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhLEKGH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 05:06:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA108FFB47;
        Sun,  5 Dec 2021 05:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=GvF238KdQN+kXCe4WR1wnAxezw/RSNbV1iXYe2htD0Y=; b=BFjZ
        5letI3wjoYTx756actwMzWuW6z+Hh2xyAXXlhM1rRrfEiOzDeESlc5mt9qqKdTcW
        /9SB3gOTd0VxjyYOU/zCnd8T4npk2kroM6RHmMC2g5MaAALHHFjZqKWDS8GqszMZ
        nzUW7QLXT1i6DFxxTF4CNFAwxJVV8C3ZQfajrl8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2148FFB46;
        Sun,  5 Dec 2021 05:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 203AEFFB44;
        Sun,  5 Dec 2021 05:02:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: t7900 failures when $HOME is symlinked
References: <4cf14040-c8e1-0f75-0ec4-fd8cf6bed0a5@gmail.com>
        <xmqq1r2tty13.fsf@gitster.g>
        <YapW/CfjFiPvsVbj@coredump.intra.peff.net>
Date:   Sun, 05 Dec 2021 02:02:38 -0800
Message-ID: <xmqqy24zl681.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B385790-55B2-11EC-98B9-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think it's lost. It becomes part of $TRASH_DIRECTORY in the
> first line, so the final line which prepends $TEST_OUTPUT_DIRECTORY
> makes it relative to that. E.g.:
>
>   $ cd t
>   $ ./t0000-basic.sh --root=foo --debug
>   [...]
>   $ ls foo
>   trash directory.t0000-basic/

Ah, OK.  Thanks.
