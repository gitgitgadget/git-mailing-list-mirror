Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC62DC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 21:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37427214DB
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 21:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NkCaxV1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbgJPV74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 17:59:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55202 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732262AbgJPV74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 17:59:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CDC793671;
        Fri, 16 Oct 2020 17:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZOcu5DfQTQ8mkw0EJovgLFy3hKY=; b=NkCaxV
        1y9S6PI3QL7+PH3Q4LGN/nkdouZDAraYdyVyNjs36H83FBwQFM+Wfqw1aLm5q9K6
        BYfv8jmXPGTyFesXP60UvWIXg9nqv9Fx8p9QeRgKPh8sfTS/QBeitq5XCCiL69Qz
        s7FTzEf6lpvllpO4OQoIAPntxwbeuvZUkEAmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZgElnFOgyWT6G8aEnz/BAB6Y6XL0qINe
        8iFXow9mpdA8dQ7TGHN6qlmTa1n7D+t3HH8cwzrcXVttlKn7P3ajnvNX4unGD1sp
        wkcAkMuPSNbSM0YYIgwCn80vamzHsWXo0yMRibD0OTFyci10gKAEfosl5Cx8y7P+
        PrR1XrgGszk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52FB193670;
        Fri, 16 Oct 2020 17:59:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C33599366F;
        Fri, 16 Oct 2020 17:59:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: demonstrate difference between 'am' and 'apply'
References: <20201016205232.2546562-1-emilyshaffer@google.com>
        <20201016205232.2546562-3-emilyshaffer@google.com>
        <xmqqk0vpalcy.fsf@gitster.c.googlers.com>
Date:   Fri, 16 Oct 2020 14:59:53 -0700
In-Reply-To: <xmqqk0vpalcy.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 16 Oct 2020 14:53:33 -0700")
Message-ID: <xmqqft6dal2e.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBDA6708-0FFA-11EB-B3CD-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So, I am moderately against everything under 'use git apply' line of
> the patch.  However, I do think it is a good idea to add a note
> somewhere in the manual of "am" to say something along the lines of
> the following (placed around here, or even immediately before we
> give the sample patch we used in the above example):
>
>     While an output of "diff format-patch" (see above/below for an

Gaah, too many cycles of wordsmithing and copyediting without the
final proofreading.  The above should read "git format-patch", of
course.

>     example) is meant to be made into a commit with "git am",
>     what you have may only be an output of "git diff" without log
>     message and is not meant to be directly made into a commit.  In
>     such a case, you may want to refer to git-apply[1] to learn how
>     to apply such a change to your working tree (and optionally to
>     the index).
>    
> It would be a good idea to redirect those readers who are looking at
> "git am" when (perhaps realizing) they should rather be looking at
> "git apply" earlier rather than later, so perhaps taking "see below"
> side and giving it as a side-note before the example starts might be
> better.

