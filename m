Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4FC49361
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 03:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532D461206
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 03:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFUDqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 23:46:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54586 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhFUDqI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 23:46:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31059D1609;
        Sun, 20 Jun 2021 23:43:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=/VaotT4wy4eR8ASYxFe7Q/1bjdA5hyfZGGN0BmQ2v4g=; b=lIf5
        1QCUZzA9jf/O4YWGg2O+NIMb/iLY+wFPqNXYpEm9jnkVGVloqDCQu1mAi02Yee/m
        gP02zOKhBkj1vxOp7gYg1cuIwpNsdBHjKVSy/t+7If/avSuXvT7j2MLs1Yjwt0q+
        avO1M/c6DnEtxLGfI7L6SZxjSMbGVCbGdQOMnpE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 187C3D1608;
        Sun, 20 Jun 2021 23:43:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85613D1607;
        Sun, 20 Jun 2021 23:43:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "dorgon.chang" <dorgon.chang@gmail.com>
Cc:     dorgonman@hotmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH] git-p4: fix failed submit by skip non-text data files
References: <xmqq35tel5ad.fsf@gitster.g>
        <20210620075607.1228-1-dorgonman@hotmail.com>
Date:   Mon, 21 Jun 2021 12:43:53 +0900
Message-ID: <xmqqr1gvj30m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E62277DC-D242-11EB-AF04-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"dorgon.chang" <dorgon.chang@gmail.com> writes:

> The skip  will not affect actual submit files in the resulting cl,
> the diff line description will only appear in submit template, 
> so you can review what changed before actully submit to p4.
> ...
> I don't know if add any message here will be helpful for users, 
> so I choose to just skip binary content, since it already append filename previously. 

These are both good things to write in the proposed log message.

Thanks.
