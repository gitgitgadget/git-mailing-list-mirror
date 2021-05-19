Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD79CC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 07:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAAB61244
	for <git@archiver.kernel.org>; Wed, 19 May 2021 07:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240548AbhESHkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 03:40:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60950 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbhESHkT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 03:40:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A040BCC6C6;
        Wed, 19 May 2021 03:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sWZNgutW9n7VovkBvfkqv5PoLWqLTxy+tQrFZy
        ndIIU=; b=p1t5wXGNbo+j4M9MDenBaZ3e459g6tbVUp7dZCUVrfvtQbadOtnP+Z
        /letGChvv933oKd6kjLrDXfnwmIBcAsAu2rxAuVLzvMRBii9VKEqPH9OYc0IGQK+
        NCyb1ys36i663Pyf55kNkyShJyxAfNXkEhvnaZM4dDkWR5hVQ2mP4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 89FA8CC6C5;
        Wed, 19 May 2021 03:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05D19CC6C4;
        Wed, 19 May 2021 03:38:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Reuven Y. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, "Reuven Y." <robi@post.jce.ac.il>
Subject: Re: [PATCH] docs: typo in glossary content
References: <pull.957.git.1621406381404.gitgitgadget@gmail.com>
Date:   Wed, 19 May 2021 16:38:48 +0900
In-Reply-To: <pull.957.git.1621406381404.gitgitgadget@gmail.com> (Reuven
        Y. via GitGitGadget's message of "Wed, 19 May 2021 06:39:40 +0000")
Message-ID: <xmqqtumzxjef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 400FFBB2-B875-11EB-B44C-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Reuven Y. via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 67c7a50b96a0..e75aed00ffe1 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -146,7 +146,7 @@ current branch integrates with) obviously do not work, as there is no
>  	<<def_revision,revision>> and you are "merging" another
>  	<<def_branch,branch>>'s changes that happen to be a descendant of what
>  	you have. In such a case, you do not make a new <<def_merge,merge>>
> -	<<def_commit,commit>> but instead just update to his
> +	<<def_commit,commit>> but instead just update to this
>  	revision. This will happen frequently on a
>  	<<def_remote_tracking_branch,remote-tracking branch>> of a remote
>  	<<def_repository,repository>>.

Actually, "his" is what was intended by the original introduced at
9290cd58 (Added definitions for a few words:, 2006-05-03).  

The "fast-forward" situation it describes happens when you try to
merge somebody else's history into your history, and if you do not
have anything of your own since the history of the other party
forked from your history.  In such a situation, instead of creating
a merge commit whose parents are the tip of your history and the tip
of the history of the other party, you just update the pointer that
points at the tip of your history (i.e. HEAD) to point at the commit
at the tip of the history of the other party.

One would refer to that commit, as "the tip of _HIS_ history", if
one does not bother trying to be gender neutral by repeatedly saying
"the other party".  So, "his" you touched is correct.  The
description that leads to this part talks about two "revisions"
(i.e. the one you have, and the other one you are merging), and
rewriting it to "this" revision makes it unclear which one is meant.

I do not mind neutering the expression with "the other party",
especially since that would help reduce confusion.  How about
phrasing

    In such a case, you do not make a new <<def_merge,merge>>
    <<def_commit,commit>>, but instead just update your branch to
    point at the same revision as the other party's.  This will
    happen often ...

perhaps?

Thanks.
