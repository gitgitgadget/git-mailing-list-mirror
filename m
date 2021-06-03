Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6070C47083
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 03:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38F6613F0
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 03:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhFCDCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 23:02:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53445 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhFCDCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 23:02:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57663C4FF5;
        Wed,  2 Jun 2021 23:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=zk0WdLRortUyX5nqbns3AwUk6TRcKDJMPysYR9IwcCQ=; b=moma
        Sh62InePNrcFCwzpysXMlQQeOZsJkHEHYvnPK9dec8lZd5LtbKqnKb/f3VuXBtG3
        MKnhjJk/JnUNdrpFArn0DpFgnSmefX0V18oRm4ODXfi1CMm3kWhITgD/jCt9ivLy
        Z6UKwi4Xa6T/lsSVeCONTzjfUUPE4Bmp1YGjiks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E8CAC4FF3;
        Wed,  2 Jun 2021 23:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C94B1C4FF0;
        Wed,  2 Jun 2021 23:00:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: The git spring cleanup challenge
References: <60b5d281552d6_e359f20828@natae.notmuch>
        <CAJDDKr7AG_qs2ZmNCuS9zS0oqCT9cWU=CSCfxALEkGuLHBH=OQ@mail.gmail.com>
        <xmqqzgw9qky5.fsf@gitster.g> <60b6bef41791a_404420881@natae.notmuch>
        <87im2wtqg2.fsf@osv.gnss.ru>
Date:   Thu, 03 Jun 2021 12:00:25 +0900
Message-ID: <xmqqmts764ae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8600FA8-C417-11EB-9A8C-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I'm second here. Wanted to get rid of some recorded resolutions, but
> didn't find a suitable way to.

J6t gave a good summary on a side thread.  "rerere forget" followed
by "checkout -m" is your friend (alternatively you can redo the
operation that applied a "wrong" resolution after doing the "rerere
forget" step, of course).
