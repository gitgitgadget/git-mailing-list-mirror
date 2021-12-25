Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CDDC433F5
	for <git@archiver.kernel.org>; Sat, 25 Dec 2021 01:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhLYBzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 20:55:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59899 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLYBzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 20:55:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 502C3164F42;
        Fri, 24 Dec 2021 20:55:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OOGev56zDjNg7Jft2+kfetFCdk3iACjlBfJABg
        g2qeQ=; b=dc242PNmYp455sQnvmozrDmpQQIUTCjjDAuXJlTkvbHlL09EjvCj9H
        f7QWaZQ2D6ryfJ0uTCjX/C7gBKwmgtSfr8Oi86+yXedNDcmQRI5+WjVgwJADlaeK
        S1uX4CL5aVIxAnpkHvZd+yPaj/AFbu8jsl6igpvdo675ekHTni0S8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48C9F164F40;
        Fri, 24 Dec 2021 20:55:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A71CC164F3F;
        Fri, 24 Dec 2021 20:55:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2021, #05; Thu, 23)
References: <xmqqsfui6g7q.fsf@gitster.g>
Date:   Fri, 24 Dec 2021 17:55:11 -0800
In-Reply-To: <xmqqsfui6g7q.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        23 Dec 2021 15:42:33 -0800")
Message-ID: <xmqqsfuh5tz4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2A4F0C6-6525-11EC-98FA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
>  - sparse-checkout: use repo_config_set_worktree_gently()
>  - config: add repo_config_set_worktree_gently()
>  - worktree: add upgrade_to_worktree_config()
>  - config: make some helpers repo-aware
>  - setup: use a repository when upgrading format
>
>  "git sparse-checkout" wants to work with per-worktree configration,
>  but did not work well in a worktree attached to a bare repository.
>
>  Expecting a redesign?
>  cf. <CABPp-BG7nwsdEYrnfqhAbWU4ndJHcqGf6RS_6DzJittuNVLvoA@mail.gmail.com>
>  source: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>

FWIW, this topic by itself passes its self test, but when queued
near the tip of 'seen', it seems to break t1091.

For an example run that fails on win+VS test (8), see
https://github.com/git/git/runs/4629824103

