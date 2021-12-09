Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85252C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbhLIWpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:45:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52659 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhLIWpz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:45:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29DA9168ADF;
        Thu,  9 Dec 2021 17:42:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zJCcfN+H2QwdcUMbuAddi5UZiu/6L3kCoKLCZR
        x6ODo=; b=yFSBZcAc5GfAqEiPuXI800qpyOmPNV/U5bkm8a0tE1iHTI20fN0HVS
        OeU3JJbz5mEEp1yfcZ/KUaSmLDu6smy9J+A0X+Nzn2zSzQmkP3qq4jVyQWX4NJmj
        V+pu/cmWLOkIW5IgoI4zsW5ecWpSYyThd7ntHnAR9cg8uSJPmGNUI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 22319168ADD;
        Thu,  9 Dec 2021 17:42:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 708CB168ADC;
        Thu,  9 Dec 2021 17:42:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] git-p4: Always pass cmd arguments to subprocess as
 a python lists
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
        <20211209201029.136886-2-jholdsworth@nvidia.com>
Date:   Thu, 09 Dec 2021 14:42:15 -0800
In-Reply-To: <20211209201029.136886-2-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Thu, 9 Dec 2021 20:10:24 +0000")
Message-ID: <xmqqo85po0xk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43137632-5941-11EC-AED3-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> Subject: Re: [PATCH 1/6] git-p4: Always pass cmd arguments to subprocess as a python lists

Style: downcase "Always" or anything that comes after the initial
"area" designator, i.e. "git-p4:".

The most important bit is missing from the proposed log message.

It says what the updated code does clearly (i.e. if we find a code
that still passes cmd arguments to subprocess not as a list, the
title tells us that this patch did not do a thorough job at it),
which is good.

But it does not explain why we want to do so.  There must be some
backstory about wanting to do so (e.g. "because it is more Python3
way of doing things") that we can explain to the future readers of
"git log" output.  Being aware of the general direction these
patches are taking us early would help the readers.
