Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82700C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 05:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8E064FC3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 05:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCKF2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 00:28:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60045 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCKF2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 00:28:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B59D8AF990;
        Thu, 11 Mar 2021 00:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0SPMOkdTFlUp2bjUKirQ5LVY+8M=; b=RxPZ0e
        5C1FIkwhleErVBsjElkAa6eTpSsI1uxgs7HXj1nVjfMsLh03+OjmhI+asPQtpoRO
        Xd0BPh80rstbVGdrXKKiE5DmZ93A5k93cnCRoY7b/3YTNnHr6ZYT6gd+aEepSPrJ
        YjYnptm7PDCOxFIPThwC87qYdHhQSjtWfdgzA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bpZG8/AkY1Fj/oOmqb8RaMnQbH40yAI9
        XCg79wqBts9KJVix3sHNWMhLjJcVqPJnkToMC+Xlh7f0j8Edcfan1hh1JIvYZeGo
        4ULulqYU+A1H5kA5u0HUyl9Mh8rp/54cwV8qEbsIIo/jn+vqrB5VgUVm9mi+bFUJ
        dYg2YPim+3s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACE4BAF98F;
        Thu, 11 Mar 2021 00:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3C3B8AF98C;
        Thu, 11 Mar 2021 00:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
References: <xmqqmtvafl62.fsf@gitster.g>
        <CAOLTT8SBv9QE22bMT2x6_DYNPZDaBjoEv8o6d2MenOnwKng8Xw@mail.gmail.com>
Date:   Wed, 10 Mar 2021 21:28:18 -0800
In-Reply-To: <CAOLTT8SBv9QE22bMT2x6_DYNPZDaBjoEv8o6d2MenOnwKng8Xw@mail.gmail.com>
        (ZheNing Hu's message of "Thu, 11 Mar 2021 13:20:33 +0800")
Message-ID: <xmqqeegmfedp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96A6349A-822A-11EB-8254-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

[ many many lines that you did not have to quote omitted; please be
  more considerate and save reader's time next time ] 

>> * zh/format-patch-fractional-reroll-count (2021-03-01) 1 commit
>>  - format-patch: allow a non-integral version numbers
>>
> I noticed that you used the'previous-count' version of
> "zh/format-patch-fractional-reroll-count" in seen.
>  Do you want me to deal with this version instead of the
>  previous version that Denton Liu and Eric Sunshine helped
> me complete?What
>
>  If you want me to deal with the `previous-count` version,
>  I will roll it back again and deal with some small details:
> use "strtol_i".

I do not have any preference.

I didn't even read the newer iteration as we are in pre-release
freeze and I've been busy dealing with issues necessary to resolve
before the upcoming release.

