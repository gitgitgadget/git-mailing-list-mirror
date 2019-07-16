Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC761F4B6
	for <e@80x24.org>; Tue, 16 Jul 2019 20:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbfGPUJC (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 16:09:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54700 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbfGPUJB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 16:09:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A24878C62C;
        Tue, 16 Jul 2019 16:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5c3rfBF6xmRMj+ZHwTE+ExOHhG0=; b=TYZoh2
        J4wPxevNzNP+rxdKRO+HDGHx53Bj7ymhuvweZX+kt/co8mOuZJlupeXarRZ774aN
        s1V5BaZwmznPR7qAlxbwdtBc3x0KPC7uI0kulhIeX5WZzq91c0EebcfhQ198TLLd
        S8f+rAHEIcq1T8fzX4y2N+IkYlkVpjGjCraMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qQNr+aTjOZZ8II2Bf5zrEWVmIittsXr5
        z2yVIvIgO1yZyROGKjS6hfE6cUABrVmNjV2mtRfslFQb6akxt3HWAPYjQhmG7/Hw
        XGP6cCk3iWMe2+fr3LDVX6QwSjKoa//S6nHbEyw7GPQl/yOLlAUFZ0ICOgxsiAm6
        k65CMc1cTrA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A6C88C62B;
        Tue, 16 Jul 2019 16:08:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE0158C62A;
        Tue, 16 Jul 2019 16:08:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Martin Nicolay <m.nicolay@osm-ag.de>, git@vger.kernel.org
Subject: Re: [PATCH v2] stash: fix handling removed files with --keep-index
References: <alpine.LSU.2.20.1907111452560.3570@cpza.bfz-tzou.qr>
        <20190711174828.GF15477@hank.intra.tgummerer.com>
        <20190716142322.GH15477@hank.intra.tgummerer.com>
Date:   Tue, 16 Jul 2019 13:08:54 -0700
In-Reply-To: <20190716142322.GH15477@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 16 Jul 2019 15:23:22 +0100")
Message-ID: <xmqq7e8h3fop.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ACE4DD4-A805-11E9-A030-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> git stash push --keep-index is supposed to keep all changes that have
> been added to the index, both in the index and on disk.

Thanks, will queue.
