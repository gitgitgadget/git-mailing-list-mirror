Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4899BC4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A6823D20
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 02:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgLJCaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:30:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59483 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLJCaA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 21:30:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E0F2A0956;
        Wed,  9 Dec 2020 21:29:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tEMw1ko/JUvxlsTNucFhTkGtOWc=; b=ib/Hd4
        rrA/2xzQu9Y6T4y1DO96z6OIyf4H6tVngVYrgdO+1Q2gbP3tS38mBFESJkWiqpxj
        W2rtefA8ybIbmRO/R5iVLvKQpCd7OhK98rm1sX/pBesEptbc/XQzDr9ACiw5Kh0u
        A4CfSvb2uTptGG7Uk/tcHtOcMKVohfztRChG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fjEB/Sb5CmrI+dfp85BIVCZQ3pc1Ppe/
        nM8zL+LAohczgcOBIl/Vf8V/nMGTTOdNd8cab8hKtw2j8yCkur5bdzC3ULW52dn/
        Rk7EuiTXXCsgjQH97uicjwFshzfcPgRDy4hbrHafhx7j9z3HWD2JhDW2oqJQSTRR
        yjR47b0yTKs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3613DA0955;
        Wed,  9 Dec 2020 21:29:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0E8BA0954;
        Wed,  9 Dec 2020 21:29:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/7] diffcore-rename: change a few comments to use 'add'
 instead of 'create'
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
        <77ca4656ed442321b41e653505c85d0be31b8045.1607223276.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 18:29:15 -0800
In-Reply-To: <77ca4656ed442321b41e653505c85d0be31b8045.1607223276.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 06 Dec 2020
        02:54:33 +0000")
Message-ID: <xmqqlfe6xukk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F6B5270-3A8F-11EB-971B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> As with the last commit, it feels odd to talk about "creation" (which to
> me implies a brand new file, i.e. one not associated with an existing
> file, and thus one that could not have been a rename) when we are using
> the files to look for renames.  Use the term "addition" instead.

Hmph, to me "create" and "add" mean the same thing in all the
sentences this patch updates.

We first notice the differences in two trees, some paths have
contents in both trees so they cannot be creation or deletion.  Some
paths only exist in one of the trees and they are initially labelled
as "created" or "deleted".  If there were no request by the caller
to detect renames, then that's the end of the story.

Only after we match up a path in the new tree that did not exist in
the old tree with another path in the old tree that no longer exists
in the new tree, what initially got labelled as creation of one and
deletion of another may become a rename.

And in the above two paragraphs, if I replace "to create" with "to
add" and "to delete" with "to remove", I do not see how the story
becomes more natural or logical or intuitive.  Perhaps I am not
getting the subtle difference you find in these two words?  This
looks like a totally meaningless churn to me.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  diffcore-rename.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 655a67759c8..7270eb6af48 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -173,7 +173,7 @@ static int estimate_similarity(struct repository *r,
>  {
>  	/* src points at a file that existed in the original tree (or
>  	 * optionally a file in the destination tree) and dst points
> -	 * at a newly created file.  They may be quite similar, in which
> +	 * at a newly added file.  They may be quite similar, in which
>  	 * case we want to say src is renamed to dst or src is copied into
>  	 * dst, and then some edit has been applied to dst.
>  	 *
> @@ -652,9 +652,9 @@ void diffcore_rename(struct diff_options *options)
>  		}
>  		else if (!DIFF_FILE_VALID(p->one) && DIFF_FILE_VALID(p->two)) {
>  			/*
> -			 * Creation
> +			 * Addition
>  			 *
> -			 * We would output this create record if it has
> +			 * We would output this add record if it has
>  			 * not been turned into a rename/copy already.
>  			 */
>  			struct diff_rename_dst *dst = locate_rename_dst(p->two);
> @@ -664,7 +664,7 @@ void diffcore_rename(struct diff_options *options)
>  			}
>  			else
>  				/* no matching rename/copy source, so
> -				 * record this as a creation.
> +				 * record this as an addition.
>  				 */
>  				diff_q(&outq, p);
>  		}
