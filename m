Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D71C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 00:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3616561042
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 00:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhDIADb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 20:03:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64913 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDIADb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 20:03:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30D2EC6253;
        Thu,  8 Apr 2021 20:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7BRP4x3SQaT2oaf5lozHJ7xluzA=; b=fmKNPM
        G0dkijSTHTMCZXfw9KLkbxsBuGkbgql1Z5hEgNLty4DXpqPCmF/xT2WN2C1jffYH
        9FtXXbPjnXlu2hl0MRf+b7sIKZFaWuiijv2zd2PK3OCKpB5IuJXsXQleNQHuPjYe
        ir4lgu9FxURevuzYVL6AlVE2CFOmsm+5OLkpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yw2KAwCc1FCwERy/nFV6T52sdUF29O7y
        iOPOD3Gy3xb+Y8mG7cPT42dR/v3NhKbah3+v//GuoYhs0gBIt9JgRNf/oNRPoWb0
        v6fMmofqzlxiLUPxdNHHsWSOcrfzWXh6nX/Qmk/KUZSjF4DHh/3qwYKmV8BvvG/p
        xL2v3iQtwfc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26CABC6252;
        Thu,  8 Apr 2021 20:03:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AECBEC6251;
        Thu,  8 Apr 2021 20:03:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8 37/37] docs: unify githooks and git-hook manpages
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-38-emilyshaffer@google.com>
        <xmqq5z0y2540.fsf@gitster.g> <YG+VxDvlov81PfK3@google.com>
Date:   Thu, 08 Apr 2021 17:03:18 -0700
In-Reply-To: <YG+VxDvlov81PfK3@google.com> (Emily Shaffer's message of "Thu, 8
        Apr 2021 16:46:12 -0700")
Message-ID: <xmqqft00pbnd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD67AA62-98C6-11EB-9257-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I got bitten by this same issue with native-hooks.txt while addressing
> comments, too. Another commenter suggested to not inline those hook
> definitions into "git help hook" - so I plan to drop that part of this
> patch. If it makes it easier for you, I think you could revert this last
> commit; if we decide later that we want to have "git help hook" share
> the hook definitions after all, I think we should do that separately and
> as a quick change not stuck behind 36 other complicated patches.

I've already discarded the step, and then I had to eject the whole
topic from 'seen' for now (see my other message to you earlier
today).  The "other complicated patches" need to be whipped into
shape to be at least in 'next' first; I do not know how close the
last round is from that state.

Thanks.

