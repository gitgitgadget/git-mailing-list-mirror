Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F5AC4743F
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501B613C8
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 00:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFGAWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 20:22:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60257 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFGAWC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 20:22:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC2FCD94DD;
        Sun,  6 Jun 2021 20:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+EoQmNoueYmJ
        JbYcnR4RtInVm0CK0mt+ifzpTvaUDc4=; b=T0M3nTAnOmlvOIj9WeiJmPFYZn93
        70psfroVOz0Cn/aZXj6b12+resI970HWspdVDesOZ0qtHO3yrFyyjMkI4yjsLvZS
        1nvceays1e5NS+v+FuYN5G6yTsVz0UwE5a+i71S0Tl9oy+9TZ+y16E2e3y2WxFhr
        Ziebfuw+6HJFIa4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A332AD94DC;
        Sun,  6 Jun 2021 20:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BD78D94DB;
        Sun,  6 Jun 2021 20:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] t: use user-specific utf-8 locale for testing
References: <20210602114646.17463-1-congdanhqx@gmail.com>
        <20210606163316.8630-1-congdanhqx@gmail.com>
        <20210606200613.muanikoqgpjsgk66@tb-raspi4>
Date:   Mon, 07 Jun 2021 09:20:10 +0900
In-Reply-To: <20210606200613.muanikoqgpjsgk66@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sun, 6 Jun 2021 22:06:13
 +0200")
Message-ID: <xmqqtumawmo5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1F40E242-C726-11EB-8543-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> This all looks good.
> Some suggestions about the commit message are inline.

All good comments.

I have another one on the title.

> Subject: Re: [PATCH v2] t: use user-specific utf-8 locale for testing

If we auto-detect to customize which locale to use per user, that is
already user-specific; letting the user to explicitly tell us which
locale to use, that is "use user-specified UTF-8 locale".

This affects only SVN tests and the change is in lib-git-svn, so
when we test other parts of the system for UTF-8, this change will
not directly help, right?  Perhaps we want to mention SVN somewhere
on the title?  Perhaps "for testing git-svn"?

Thanks.


