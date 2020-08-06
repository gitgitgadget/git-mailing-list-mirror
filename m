Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035C5C433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D842C2173E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 21:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cvUHtU3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHFVL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 17:11:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50383 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFVL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 17:11:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D97FEEC47;
        Thu,  6 Aug 2020 17:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VblJnFneFNUflC+pYlBGG2vJ6Ew=; b=cvUHtU
        3UuILV/idFJ2TtALY+OHphHI9VX+8hjOrKmETOrrWZS68tte+EzQdpg/SYtp2NLT
        LQQG0StPLTv8ptvlV5A4hKvcM1kMLbYnxSElH8uRsUDetS38/fdIwzZ/gU1Iu8yo
        2jIsRhqCLeSpWKjACxtuhelTEyxpHsumASd9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ufxfSrDQLArQKbRgjYwY2bDEjTa4bkz7
        ERDkk3Omw6W8GOvjbIN/lJo+ZIQzrMHVCDiXG5BelWUb2C/nV+rH/5npuYHWVe8o
        nmCQ2/qx+KVscj3j0xhs9Lp3PRiYOWcR9EtCRmoUN5HZf2FwiiOFa0g/3kb/MFhT
        Kwpqnn7vypg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 052E6EEC46;
        Thu,  6 Aug 2020 17:11:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4B234EEC45;
        Thu,  6 Aug 2020 17:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        chriscool@tuxfamily.org, me@ttaylorr.com, liu.denton@gmail.com
Subject: Re: [PATCH 4/4] t7401: add a WARNING and a NEEDSWORK
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200805174921.16000-5-shouryashukla.oo@gmail.com>
        <xmqqy2msn5b2.fsf@gitster.c.googlers.com>
        <20200806112702.GA15343@konoha>
Date:   Thu, 06 Aug 2020 14:11:53 -0700
In-Reply-To: <20200806112702.GA15343@konoha> (Shourya Shukla's message of
        "Thu, 6 Aug 2020 16:57:02 +0530")
Message-ID: <xmqqa6z7jx7q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74D0052C-D829-11EA-B040-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> On 05/08 02:36, Junio C Hamano wrote:
>> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>> 
>> > Add a WARNING regarding the usage of 'git add' instead of 'git
>> > submodule add' to add submodules to the superproject.
>> 
>> Is that a warning worthy thing?  As far as I know, using "git add"
>> to register a gitlink is perfectly fine and a supported way to start
>> a new submodule.  It may have to be followed by other steps like
>> "git config -f .gitmodules" (e.g. when operations that needs to use
>> the contents recorded in the .gitmodules file are to be tested), but
>> writing tests using lower-level ingredients for finer grained tests
>> is not all that unusual, is it?  I dunno.
>
> The thing is that 'git submodule {init,deinit}' fail when there is no
> .gitmodules. I can initiliase the .gitmodules separately using 'git
> config -f .gitmodules' but I think it will be better to use 'git
> submodule add' throughout the script rather than worry about it all the
> time.

On the other hand, we do want to make sure that the workflow using
lower-level tools continues to work, so that is a balancing act.

> But again, if the warning seems unnecessary, then I can obviously use
> 'git config' to initilaise the submodules and change this commit. What
> do you reckon?

If you need "git submodule init" etc. to work in this test, yes, you
can change the test to either use "git submodule add" instead, or
"git config -f .gitmodules" in addition.  If you don't, there is no
need to change anything, no?
