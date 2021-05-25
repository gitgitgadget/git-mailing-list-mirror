Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E0AC2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F3561284
	for <git@archiver.kernel.org>; Tue, 25 May 2021 07:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhEYHQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 03:16:03 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59532 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEYHQC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 03:16:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89636136273;
        Tue, 25 May 2021 03:14:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tC+zRFrL/k+LXPF3kGMxOrbxfktTEUea4H299o
        abjzI=; b=MDE+xqtlk7MwFqJBHadNCwdZPT+IOOtEmjU6i+BFn+b/q1IjM0jCGD
        h4hrMTyxzZyWVFvyIugZuXrs5r9wT0hgfTkNL4Y6O7muJeHn5SIaL0HKo1n2qDLZ
        3t+mg0ChNgxeKwpkCN1bTO349ZvQZz+88O/rpjuAS41RdUbddaNrg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81EE5136271;
        Tue, 25 May 2021 03:14:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C776913626D;
        Tue, 25 May 2021 03:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 00/12] doc: cleanup old cruft and asciidoctor revamp
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
        <xmqq1r9wj9im.fsf@gitster.g> <60abfd46a8ca3_1b20920823@natae.notmuch>
        <xmqqlf83fge2.fsf@gitster.g>
Date:   Tue, 25 May 2021 16:14:29 +0900
In-Reply-To: <xmqqlf83fge2.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        25 May 2021 15:59:17 +0900")
Message-ID: <xmqqeedvffoq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D961812A-BD28-11EB-A12E-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Apparently my scripts call `git format-patch` with -D, which doesn't
>> generate appliable patches when files are deleted.
>
> Don't call format-patch with -D, then ;-).
>
>> Do you want me to send it again without -D?
>
> Sure, if a collection of patches want to be reviewed and applied, I
> would think it helps for them to be appliable to a common tree (like
> my 'master') with tools reviewers and the maintainer are know to use
> (like "git am").  As more roadblocks are added before the changes
> can become reviewable in the reviewers' trees, less chances they
> have to get reviewed.

Oh, I didn't answer the question.  Do I want you (or anybody) to?
Not really, especially during the pre-release freeze period.

I wasn't heavily involved in the "let's use asciidoctor-native to
bypass xmlto" or "asciidoc is not exactly abandoned, but we should
prepare ourselves to make asciidoctor the default" discussion, but
I've seen people I trust voice their opinion and trust them enough
to believe that a concensus among them would lead to an acceptable
future, so I'd rather stand on the sideline, and see people discuss
and come up with a concensus before I pick the final product when
the next cycle opens.

And it would help to make sure reviewers can pick it up and apply it
to their trees, if a patch series, even as a discussion material and
not a final submission, wants to lead to such a concensus.

Thanks.
