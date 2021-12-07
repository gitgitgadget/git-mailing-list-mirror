Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A8C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236640AbhLGUlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:41:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53807 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbhLGUlR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:41:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADF78E1DCA;
        Tue,  7 Dec 2021 15:37:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VxdcpAuPm0m/k+Bojg0fHzpjgjKk4svBQzJS+H
        x6x2M=; b=Gcc4q/Zb7zofp046/sRcKiKvzkpTwpvZ5Fgo/vS90LLbgo0QuDohv6
        H1BAolPH2NkC+0QL4wvaBK4SwYxIlB5Bsu/7Jnz0MRvwA6d2tdxcx45HciJvXJAF
        rhMFRnHkccPuM/t116MzoL8CghVQkBPr9xqa6hpFLu0FUyEuoFU3s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3297E1DC9;
        Tue,  7 Dec 2021 15:37:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10544E1DC8;
        Tue,  7 Dec 2021 15:37:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revision: use C99 declaration of variable in for() loop
References: <20211113122833.174330-1-gotlouemail@gmail.com>
        <20211113130508.zziheannky6dcilj@gmail.com>
        <2b2386b9-045d-a0b8-6dbc-8a9d0c446bea@gmail.com>
        <xmqq7ddbme7q.fsf@gitster.g>
        <211114.868rxqu7hr.gmgdl@evledraar.gmail.com>
        <xmqqilwulims.fsf@gitster.g> <xmqqpmr2j5lq.fsf_-_@gitster.g>
        <61518213-9ce8-00d2-efd9-7f2091c574c4@gmail.com>
        <xmqq1r3eym7f.fsf@gitster.g>
        <836296d0-6eee-7c6b-04d0-d93909948611@gmail.com>
Date:   Tue, 07 Dec 2021 12:37:44 -0800
In-Reply-To: <836296d0-6eee-7c6b-04d0-d93909948611@gmail.com> (Phillip Wood's
        message of "Tue, 7 Dec 2021 11:10:14 +0000")
Message-ID: <xmqq35n46tif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88F42AC0-579D-11EC-912F-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... I guess that means we
> have not had any warning flags set (because no such flags exist?)  to
> protect against the accidental introduction of the construct that this
> patch is testing compiler support for.

I think we actually saw some instances of "for (type var = ..."
slipped through the review process, only to later get caught by
some other means.

