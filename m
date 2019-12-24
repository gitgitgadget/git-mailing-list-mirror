Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB0C2D0C3
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A5220663
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 18:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A1Lp6/0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfLXSjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 13:39:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53438 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfLXSjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 13:39:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1AB79B73BB;
        Tue, 24 Dec 2019 13:39:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H7lYFID5+kRdHKZGlpCcdYEUrcE=; b=A1Lp6/
        0xTBmpguaivbDbVHlyNlQbJ4Qddj+dxiu3f/YnI6Pu2XUevZrogkxiZeB2/Jalq/
        7s5yUdNE8pp4jtYpjrUIsU2mr2Rr1FA0pBwgjGLb5oEJiJM1HjdxeD+dLtGF/qbA
        3urP+ZB88Xh5pJ+XA5GBC5UP3uK6rV3WDcB5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k3ed5lrYke8XeReHuq1Alov0jsZsAG3b
        cfHPSiWEIqPE1FKZjhEfTMqqIbURbHiidUEctXQjfHcjLCTqohFqQ5CH6HwdvYao
        NdRmQuCUkGQhOXoz1fWIcQGStb1lrctlVpFsAqGtZTf0m3u5v+yRrxA1kdJsDjLX
        gZPnM5K7Xoo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F246AB73BA;
        Tue, 24 Dec 2019 13:39:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A79BB73B9;
        Tue, 24 Dec 2019 13:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] built-in add -p: add support for the same config settings as the Perl version
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <xmqqpngd60rx.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 24 Dec 2019 10:39:06 -0800
In-Reply-To: <xmqqpngd60rx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 24 Dec 2019 10:23:14 -0800")
Message-ID: <xmqqimm5601h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABF8FA40-267C-11EA-9614-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> base-commit: 2d4b85ddc76af3e703e6e3a6a72319b5e79c2d8b
>
> It is not generally helpful to those who reads this list to use a
> commit that is not part of history leading to my 'pu' or 'next' as
> the base.

I think there was only one spot that needed adjusting to the newer
iteration of the js/patch-mode-in-others-in-c series.

This may have started as "there are some configuration variables
that are ignored in the C version, fix them" and that may be why
the pull-request branch says "config-settings", but overall, I think
the bulk of the change ends up being a "how would we implement the
annoying-to-implement-portably single-key behaviour".

I think it is a mistake to write the lower-level terminal access
code without using established libraries (or write it with a higher
level abstraction offered by scripting languages like Perl and
Pythnon), and I would personally take, given a choice between
accepting such maintenance/porting liability and dropping of
single-key behaviour, the latter in any second.

I wonder if it makes sense to split this series into two so that the
early and easier part for leftover config bits can graduate
separately early in the next cycle, instead of letting the parts
that tackles the terminal nightmare (note that the problem being
nightmare is not the fault of this topic) which would inevitably
take more time to stabilize take the remainder of the series hostage
to it.

Thanks.
