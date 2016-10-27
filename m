Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1945B2035F
	for <e@80x24.org>; Thu, 27 Oct 2016 06:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932605AbcJ0GrZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 02:47:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64728 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755201AbcJ0GrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 02:47:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE186429A1;
        Thu, 27 Oct 2016 02:47:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jnVITkcLksypvwpnt9tqZmbLJ2s=; b=cL3GAT
        yNhkilTZ7EvK27P+KK+Q4Jq/Wbzcvt92Leojft50SXs6Ihi8BwPXHT2XNTJrt09g
        gV1hMkjJj7yuIG0w4Z9DtnTOMjpkUCkT7DjU+OlrKuS3QIVrGDH6U4MboHXAAHPc
        FLGZUYtmGavrjxzJYG4tobUsN76f38Yoa8Fyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SdHtEku7R3SVqQ3liUSCTD5QCsDVQxes
        RgHMMyCfHgqmsvkqYOaA/AWw7syn1mn4EOI437+b6Msl9bCtF1OZMGdgvAuatpQX
        OqnEso98++25u25QYwr3b4cKvVps35xOo/hq5cqTxDCUaejr+4FYihO69F9cMvi8
        ad0Fg9nuzXs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A54EF429A0;
        Thu, 27 Oct 2016 02:47:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 205FF4299F;
        Thu, 27 Oct 2016 02:47:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cody Sehl <cody.sehl@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Update git rebase documentation to clarify HEAD behavior
References: <010201580457bdd2-99237b54-5e36-4430-bb8d-7e9088aed522-000000@eu-west-1.amazonses.com>
Date:   Wed, 26 Oct 2016 23:47:10 -0700
In-Reply-To: <010201580457bdd2-99237b54-5e36-4430-bb8d-7e9088aed522-000000@eu-west-1.amazonses.com>
        (Cody Sehl's message of "Thu, 27 Oct 2016 04:13:28 +0000")
Message-ID: <xmqq8tta8f0x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30629B14-9C11-11E6-A1D9-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cody Sehl <cody.sehl@gmail.com> writes:

> The first few paragraphs in the git-rebase.txt documentation lay out the steps git takes during a rebase:
> 1. everything from `<upstream>..HEAD` is saved to a temporary area
> 2. `HEAD` is set to `<upstream>`
> 3. the changes held in the temporary area are applied one by one in order on top of the new `HEAD`
>
> The second step was described using the phrase `The current branch is reset to <upstream>`, which is true (because `HEAD` == current branch), but not clear.
> ---

Please wrap your lines to reasonable lengths like 70 columns or so.
Please sign off your patch.

>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index de222c8..c47ca11 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -33,7 +33,7 @@ of commits that would be shown by `git log <upstream>..HEAD`; or by
>  description on `--fork-point` below); or by `git log HEAD`, if the
>  `--root` option is specified.
>  
> -The current branch is reset to <upstream>, or <newbase> if the
> +HEAD is reset to <upstream>, or <newbase> if the
>  --onto option was supplied.  This has the exact same effect as
>  `git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
>  to point at the tip of the branch before the reset.

This is describing an ancient behaviour before 6fd2f5e60d ("rebase:
operate on a detached HEAD", 2007-11-08) in v1.5.4 timeframe.  We
apparently failed to update the description.  

This depends on the desired technical detail of the description, but
a correct rewrite would be "HEAD is detached at <upstream>, or
<newbase>, and ORIG_HEAD is set to point at the tip of the branch
before this happens".  Detaching the HEAD at <upstream> no longer
has the same effect as "git reset --hard <upstream>" (or <newbase>),
so that sentence must go.  It was the primary point of the ancient
change at 6fd2f5e60d after all.

And then there is a new step (to be numbered 4. in your description
in the proposed log message), which updates the tip of the branch to
the resulting HEAD (after replaying all these changes) and check the
branch out, which needs to be added.  Perhaps after "one by one, in
order."  Oh, the mention of "reapplied to the current branch" also
needs to be updated to "reapplied to the detached HEAD", too.

On the other hand, if we do not aim for that deep level of technical
correctness, but want to tell a white lie to make it easier to
understand at the conceptual level to new readers who haven't
grasped the detached HEAD, then the current description is fine.  By
bringing up "HEAD", you seem to be aiming for techincal correctness
(which I tend to agree is a good direction to go in this part of the
documentation), so the existing text needs a bit more work than your
patch to be brought to the modern world.


