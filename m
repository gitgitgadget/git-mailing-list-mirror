Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DB3C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 00:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhLPACn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 19:02:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54689 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhLPACm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 19:02:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 577BA170C4B;
        Wed, 15 Dec 2021 19:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3I170mtAh8mUma714j+RBoVgjiLAZU4gTcK+b8BPmns=; b=N9rk
        vToNT7DXZvIJBCtqOV9DTmgHb5CGMN2rGk56eP6tvkm0j+w8fYQHcN3na/MMLrWX
        s6X/23p9BKSgbw6VBElROwArG0l+oz3krH6SURey9BjUg9V88eOXNqG83dHqE74k
        ikXqpf9Thuo6yDEmjItc95E2fe51UR3x+j9KUPE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 505B8170C4A;
        Wed, 15 Dec 2021 19:02:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AAA68170C3F;
        Wed, 15 Dec 2021 19:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>, chooglen@google.com
Cc:     git@vger.kernel.org, avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v6 0/3] branch: inherit tracking configs
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <cover.1639524556.git.steadmon@google.com>
Date:   Wed, 15 Dec 2021 16:02:37 -0800
Message-ID: <xmqqsfutzaaq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B3CBC6E-5E03-11EC-950B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Changes since V5:
> * Greatly simplified BRANCH_CONFIG_VERBOSE output to not require nearly
>   so many conditionals.
> * Note that rebasing is not compatible with inheriting multiple upstream
>   branches.
> * Moved the change to case-sensitivity for branch.autosetupmerge to its
>   own commit.
> * Improve advice on failed tracking setup when multiple branches are
>   involved.
> * Make better use of string_list API.
> * Make better use of config API.
> * More straight-forward use of the `struct tracking` API.
> * Numerous style fixes.

I've queued this, and rebased Glen's "branch --recurse-submodules"
on top, and parked both of them near the tip of 'seen'.  I do not
have much confidence in the conflict resolution needed during the
rebasing or the other branch or merges into 'seen', and I would
appreciate it if you two can take a look to sanity check the result.

Thanks.
