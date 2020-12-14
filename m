Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56568C2BB40
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0362250F
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 23:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgLNXSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:18:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51166 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732947AbgLNXQu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 18:16:50 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DF8295184;
        Mon, 14 Dec 2020 18:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m8ZoAiIaegOuceWVFZm1WQa6/LQ=; b=g5LeEF
        POmarE/qeqqc9LXhDHdOgLM6RT0KT3i5eS7eGDrobGmNGIkAwthEQO35xb5QQQkM
        26U6JUY6SDDdwuHZTSOA8fizv6AHiqZcbDaLA015enWzIZ5jtbYGt6dZwpPqb/ZU
        3zYYpc0O5BTuFDSnfCKF/aGr8qV9/M+qWRJxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lSfsk9Zk7xl5eie0hh9ANk9EINofMIlP
        C7ltx41yN3WQYKxA4DxLX7qzjw1VPTdRRfJGQk51/+XxhCbsV6l27XXLLLVlhVbO
        NczoJw5y99iVnGJiNS3wYBEAuRmEhAHJjc57DkKVl9i3dKvzeKm8w+sFU4E0+MZ0
        3iRO5IrdrJM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 857CE95181;
        Mon, 14 Dec 2020 18:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12E6995177;
        Mon, 14 Dec 2020 18:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 3/5] pull: get rid of unnecessary global variable
References: <20201214202647.3340193-1-gitster@pobox.com>
        <20201214202647.3340193-4-gitster@pobox.com>
        <5fd7d22ceec2b_d4113208c1@natae.notmuch>
Date:   Mon, 14 Dec 2020 15:16:07 -0800
In-Reply-To: <5fd7d22ceec2b_d4113208c1@natae.notmuch> (Felipe Contreras's
        message of "Mon, 14 Dec 2020 14:59:24 -0600")
Message-ID: <xmqqv9d49dxk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58B5634C-3E62-11EB-9C7D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> It is easy enough to do,
>
> Yes.
>
>> gives a more descriptive name to the variable,
>
> I disagree.
>
>> and there is no reason to make the code deliberately worse by ignoring
>> improvement offered on the list.
>
> I doubt any person contributing to the mailing is making the code
> deliberately worse.

Oh, I doubt that you do so with what you send out.  I am saying that
you do so by not taking improvements.  It wastes reviewers' time,
raises noise ratio in the list traffic, and demotivates readers.

