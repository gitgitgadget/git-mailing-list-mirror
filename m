Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8D8C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C646101D
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbhJMUcx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:32:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63535 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhJMUcx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:32:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F3A8F030B;
        Wed, 13 Oct 2021 16:30:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rsfpwQb1OyK6kKAWRRi86OhkvMmXhannGC/PkcuZzWE=; b=vtPS
        T0UX60h8HPMxdV0/6vZrb47cn7xWriq6tFKe/m9akiix2wigAg4v40SSOWC5Dan+
        5CdqJxdMYi7S+pB2WpQiv9SwleMrn4e+8HX433W/SEXw09oveJo7PwBooi7fbN7T
        ywGemAKQuZ5Ik5IXTBaucOKd0x7uqCduVnyBhhE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04485F030A;
        Wed, 13 Oct 2021 16:30:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65E11F0309;
        Wed, 13 Oct 2021 16:30:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Carlo Arenas <carenas@gmail.com>
Subject: Re: [PATCH] Documentation: specify base point when generating
 MyFirstContribution patchset
References: <20211013122234.448845-1-bagasdotme@gmail.com>
Date:   Wed, 13 Oct 2021 13:30:47 -0700
Message-ID: <xmqq1r4ofz0o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 734BD3EE-2C64-11EC-A573-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> +Some reviewers (notably testers) would like to know at what point your patchset
> +are based on (in particular to apply the patchset). In such cases, you can
> +mention the base point when preparing your email (see below section), or by
> +passing `--base=$(git merge-base master psuh)` to `format-patch`. If no base
> +point is specified, the patchset is assumed to be applied on top of current
> +tip of `master` branch.

This document is about contributing to _this_ project, so I think we
can and should be more explicit to say what is preferred, not "some
would like to know, and in such a case you give this extra piece",
as by definition, somebody who is making their first contribution
would not know whether the reviewer who looks at your work is among
these "some" or not.

    It would help those who review and test your patches to make it
    clear on what commit they are meant to apply.  To do so, use the
    "--base" option to record the commit on which you based the
    series when running "git format-patch".

If no base is given, what is assumed by default various by
recipient, so all we could say is "If no base is specified, nothing
is assumed", but let's rather not say anything to confuse the
readers.

We could say what we want to see the first-time contributors do,
but I do not think it is needed in this case.

	Side note. We want a new feature to be built on 'master' (or
	the last feature release, if nothing in flight conflicts
	with it)), and a bugfix to be built on one of the older
	release point (to be applicable to the maintenance tracks).
	But the section we are discussing, i.e. how to run
	format-patch, is not the place to do so, as it is too
	late---it must be decided before the contributor starts
	working on the series.  As the example of this document is
	about adding a new "feature", we should have a sentence to
	explain, in the "Set up your workspace" section, why we
	chose 'master' as the base point (and the existing text
	already says why).

Thanks.
