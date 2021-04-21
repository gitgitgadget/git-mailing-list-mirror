Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB753C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA306613F6
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343631AbhDUXFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:05:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64812 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbhDUXFr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:05:47 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24E3A121B23;
        Wed, 21 Apr 2021 19:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=whyr7EOwoW8rENu+K3srlHzpaPE=; b=RUHszL
        GVHhxKUhpfuFsStW1g3KDCol27XtjBi3kNOiphsOD8g72SOZmoK2jSMqfahbjwDC
        tEXm14tGUaZ2iWpojR5hK6IIjzbJxStz2YjqTBUeWQbyWze/vLKQGAgJYBZzbQGT
        GP+d2ZmGi+6urLpxLaoJnmEA0eipIaXciqQAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dQsP4F3ZXPBeoEqJjVHJj02kbBzf35Ch
        hrc+de7Bu6oJStBpa0iRtFeq+GNxeqJuPyVEbdhdAMk73lwrJq+oTzLEkYAWEjJT
        ImvtoiYKYsjdkzdJyroll+YwvJdPVFUXusgv+xLjMeTYhGRKpQ7TnDfHN8jxSj34
        iWKbn9HSuYU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DEA0121B22;
        Wed, 21 Apr 2021 19:05:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FC04121B21;
        Wed, 21 Apr 2021 19:05:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: Random GitHub Actions added to git/git???
References: <xmqqmttt7q8f.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2104201748400.54@tvgsbejvaqbjf.bet>
        <xmqqzgxs4sed.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2104211437040.54@tvgsbejvaqbjf.bet>
Date:   Wed, 21 Apr 2021 16:05:08 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2104211437040.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 21 Apr 2021 14:38:06 +0200 (CEST)")
Message-ID: <xmqqlf9bxmqj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 05925730-A2F6-11EB-98F2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 20 Apr 2021, Junio C Hamano wrote:
>
>> How well are our refs protected from these random "Actions"?  Can
>> somebody spam us with a pull request with a new "workflow" that
>> advances one of our integration branches ;-)?
>
> The GITHUB_TOKEN that is used by the GitHub workflows is generated in two
> ways, depending whether a PR originated from the same repository or from a
> fork. If it came from a fork, the token has only read permissions.
>
> So I'd say we're still safe.

Yeah, their blog post came to my inbox, which was quite timely, this
morning ;-).

https://github.blog/changelog/2021-04-20-github-actions-control-permissions-for-github_token/

