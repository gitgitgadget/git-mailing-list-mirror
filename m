Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE9C433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 04:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408FF611B0
	for <git@archiver.kernel.org>; Sun, 16 May 2021 04:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhEPEBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 00:01:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57552 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhEPEBX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 00:01:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 100AE13193C;
        Sun, 16 May 2021 00:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oKkVJNrOdTqByNRyiuCpK/Ggiwlb56U2rjuIhF
        O8PJw=; b=BbE8cDpCXoy7UzC4GwcricY7lbXLNgf8AWe8Zki8MDd6W87pKKcR5H
        vDnMg26nG+Qtc0nSzzeMJgq0R5Y9ZbW6eS8dOw25LcneZAT+6ojAlLaGa0arZn0D
        xgArNJiQh/RdV0E8TMvrKeDC3VzGXCjLdurv18Xs7H6P8HQ8r7tpQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0895613193B;
        Sun, 16 May 2021 00:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E74B213192D;
        Sun, 16 May 2021 00:00:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, judge.packham@gmail.com
Subject: Re: [PATCH] merge: don't translate literal commands
References: <20210515200111.19912-1-alexhenrie24@gmail.com>
Date:   Sun, 16 May 2021 13:00:04 +0900
In-Reply-To: <20210515200111.19912-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sat, 15 May 2021 14:01:11 -0600")
Message-ID: <xmqqfsyn72gr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32DB8906-B5FB-11EB-85F9-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> These strings have not been modified in any translation, nor should they
> be.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/merge.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks correct.

I wish we could mark only parts of a single string for translation,
so that we can just ask translaters to translate "options" and
"commit", without having to teach them that "<>", "[]" and "..."
must be left intact because they have specific meanings as notation
(namely, "<>" are used to mark the words as placeholders, "[]" are
used to mark optional parts, and "..." means zero or more
repetitions).

Thanks.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index eddb8ae70d..a8a843b1f5 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -56,8 +56,8 @@ struct strategy {
>  
>  static const char * const builtin_merge_usage[] = {
>  	N_("git merge [<options>] [<commit>...]"),
> -	N_("git merge --abort"),
> -	N_("git merge --continue"),
> +	"git merge --abort",
> +	"git merge --continue",
>  	NULL
>  };
