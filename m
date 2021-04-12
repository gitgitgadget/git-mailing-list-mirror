Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B343C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C69A6105A
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbhDLVbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:31:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60437 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbhDLVbo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:31:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CA2E119A4A;
        Mon, 12 Apr 2021 17:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bh583f1lG7gC4+Ii3E65ooNaCOk=; b=cLv3Ns
        u1kFEywsLAa/k5jdteMRk2SvuoUySFkZCYuJh0/EDNuP6x/tg1jS0tVGD4Z8JNVL
        JowJksTEjRijcD+LY7ud4Z82dQ6qB3TljntIFknR00MAPOiUoBcLLJSyNmatIa+g
        u+GXuZtb0vhmoeuBJJGwJCGE7uoxS/60LBi/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tRFQR0CiNtkK8sbz/LowqAeHLTmDhJuK
        SavLnkrxXcnrOG29AgRccgJqqVybQqeYHh4wSOc+YDZnGC5fnw0YOITG0WKE5app
        4tI7ky6vx/AACJPFCyNjUchijGkjCHEHRf3XnNZ29txp67IY+8sxPDCWe98BHn+q
        I3/T/hdCSK4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 851FD119A49;
        Mon, 12 Apr 2021 17:31:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD27B119A48;
        Mon, 12 Apr 2021 17:31:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] reftable: document an alternate cleanup method on Windows
References: <pull.1001.git.git.1618254757074.gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 14:31:21 -0700
In-Reply-To: <pull.1001.git.git.1618254757074.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Mon, 12 Apr 2021 19:12:36
        +0000")
Message-ID: <xmqqfszvb36e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D91E26E-9BD6-11EB-A294-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The new method uses the update_index counter, which isn't susceptible to clock
> inaccuracies.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>     reftable: document an alternate cleanup method on Windows
>     
>     The new method uses the update_index counter, which isn't susceptible to
>     clock inaccuracies.
>     
>     Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Thanks, will queue.



>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1001%2Fhanwen%2Fwindows-2-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1001/hanwen/windows-2-v1
> Pull-Request: https://github.com/git/git/pull/1001
>
>  Documentation/technical/reftable.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
> index 3ef169af27d8..d7c3b645cfb0 100644
> --- a/Documentation/technical/reftable.txt
> +++ b/Documentation/technical/reftable.txt
> @@ -1011,8 +1011,13 @@ reftable stack, reload `tables.list`, and delete any tables no longer mentioned
>  in `tables.list`.
>  
>  Irregular program exit may still leave about unused files. In this case, a
> -cleanup operation can read `tables.list`, note its modification timestamp, and
> -delete any unreferenced `*.ref` files that are older.
> +cleanup operation should proceed as follows:
> +
> +* take a lock `tables.list.lock` to prevent concurrent modifications
> +* refresh the reftable stack, by reading `tables.list`
> +* for each `*.ref` file, remove it if
> +** it is not mentioned in `tables.list`, and
> +** its max update_index is not beyond the max update_index of the stack
>  
>  
>  Alternatives considered
>
> base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
