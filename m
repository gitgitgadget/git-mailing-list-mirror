Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87161C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 00:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3DE206C3
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 00:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cQsfyIwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFJAQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 20:16:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61804 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgFJAQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 20:16:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4E89C6669;
        Tue,  9 Jun 2020 20:16:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xo4fWnR72h/+jKH220Np0aF+uUo=; b=cQsfyI
        wS4hBChFDNQmgWL36iivCcv5xZ7Gk6R6Oga6wRIDcTCroIfuXRWRg4fxOxhO4sw8
        0+BtCv/R4P5z4H3F8nZ8lKq9wjM5mxVKGlTQMlqsN+YMIXw78Bh6uDO57SRVxd0g
        Bm5GBRvm5MwI6HovsCw2blhCN7+vx/jx0Qb7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nPKqdTcK454plt5bnHB4eMw+DXjQH2hJ
        K3fS/dFCfTq6H7O0+xplYQ8gcdT3pPeyVJuq6UJShZwBgj66hzlKxhfO5lVBnJ52
        JhDRflgVSMF2SoS31IhPdRGZN2gQFftiW6tQM3aABwigSNxHO5WZAXrzNOJCfHRs
        wXtUZmJZnwc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CFAEC6668;
        Tue,  9 Jun 2020 20:16:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCBF5C6666;
        Tue,  9 Jun 2020 20:16:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luigi Cantoni <luigic@fgcint.com>, David Aguilar <davvid@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Auto Rescan - as plain text
References: <37bd22ee8bcb9c91969d68cbc5e6852a8a70ab36.camel@fgcint.com>
        <bf895dc550881b35baea45cd269bf9b0518ade35.camel@fgcint.com>
        <816ce248ab1708d41b5233abdb998ff2d4cb3400.camel@fgcint.com>
        <36bd7dc26883017770c28da94a251be2d5019f75.camel@fgcint.com>
Date:   Tue, 09 Jun 2020 17:16:42 -0700
In-Reply-To: <36bd7dc26883017770c28da94a251be2d5019f75.camel@fgcint.com>
        (Luigi Cantoni's message of "Wed, 10 Jun 2020 08:09:26 +0800")
Message-ID: <xmqq3673hj11.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AA2B4DDC-AAAF-11EA-BEE3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luigi Cantoni <luigic@fgcint.com> writes:

> Hi All,
> I have been using git for several years now and using git-cola.
> I just started up git gui and that is quite self explanatory and all
> the functions I use with git-cola appear to be there.

We used to see the maintainer of that project around here quite
frequently but haven't seen him for a while [jch: David Cc'ed].

By reading https://git-cola.github.io/about.html it seems that they
prefer to see problem reports and feature requests at
https://github.com/git-cola/git-cola/issues and not on this list.

>
> One thing I liked in git-cola was that it very quickly reflected my
> changes in its display window.
> I have looked in the options and I cannot see either a flag to set it
> to auto rescan or set a time for the auto rescan.
>
> Have I missed it and there is a way turn this on or give it a shorter
> time (if in fact it is does do it).
> If it is not offered could it become an option.
> I can see that some people may not feel the overhead for distributed
> system is worth having this on so they would want if off.
> It is not critical (just nice) as I know I can
> 1) rescan
> or 2) go off the file and back on again.
> It then displays the correct diff/updated contents.
>
> Thanks for any advise or help.
> -- 
>
> Thanks
> Luigi Cantoni
> M: +61 421 624 804
> T: +61 8 9418 3777
> Email: luigic@fgcint.com
