Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AEBA1F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933991AbdA0RwT (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:52:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59801 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934102AbdA0Rvz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:51:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B48EA612B1;
        Fri, 27 Jan 2017 12:51:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uwObAeD5ysEORRnZ08wB6cZDYao=; b=r+geC3
        kH+N4HcyfZXDIoiX/DrSYkKQKIg99q0QnpXQYlV/HyVk26+IFi4qfHq8z0BWsgbZ
        QW5rph45FCUQxAxgDgHqFiQ2EHN5dERKLs+WkqaDHoDikwM6K2h2dj6H/Ej2vS6v
        lztBBnvGJDMXrp0YZLAhmXPF73m53XcX2x3YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ggD3wsbdnIH42mTbTxGrAI2hMmOhfNqp
        IiTbHHMuME0uxDLk2HRXVQnBGerpsI1LoRTmjSWmTaXHrLfK+Pd1mazQWIjkIUDN
        LZkpmgIGRj+41WwBO0rVn7MZV1xXKy3XOSOibXIuxODtit3brZL7aXl6AQXyDYql
        GO4o8WmCqJk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB424612B0;
        Fri, 27 Jan 2017 12:51:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 22AC4612AE;
        Fri, 27 Jan 2017 12:51:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] fixup! worktree move: new command
References: <4f4ae057cd4d72d5b945a856deacd921fb5e7977.1485349447.git.johannes.schindelin@gmx.de>
        <alpine.DEB.2.20.1701271150200.3469@virtualbox>
Date:   Fri, 27 Jan 2017 09:51:53 -0800
In-Reply-To: <alpine.DEB.2.20.1701271150200.3469@virtualbox> (Johannes
        Schindelin's message of "Fri, 27 Jan 2017 11:53:04 +0100 (CET)")
Message-ID: <xmqqwpdgz8zq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49EA4E1A-E4B9-11E6-925E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> always been discussed on the mailing list, I would like to kindly ask you
> to please add this patch to the nd/worktree-move branch for the time being
> (i.e. until Duy responds),

The tip of 'pu' (or anything beyond the tip of 'jch') is not always
expected to pass test or even build, and unless I know the OP is
leaky or usually slow, a "fixup!" that directly addresses the OP
tends to be left for the OP to pick up [*1*] to avoid "ah, you sent
a reroll but I already had one squashed locally", which is confusing
to both myself and OP (and adds burden to me).

It seems that OP is slower to respond than his usual, so I'll add it
to the tip of the topic so that it won't be lost.


[Footnote]

*1* It still is used on my end to leave a mental note to myself that
    the topic is expected/waiting to be rerolled, but that is not
    something you can read in "git log --first-parent master..pu".
