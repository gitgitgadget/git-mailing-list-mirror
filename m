Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FE2C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C9820707
	for <git@archiver.kernel.org>; Wed, 27 May 2020 17:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HkALFKge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403782AbgE0RgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 13:36:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61108 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403778AbgE0RgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 13:36:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40223CA836;
        Wed, 27 May 2020 13:36:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F3OkQUYteqD0iKLhs61IP3RNaZY=; b=HkALFK
        geyT4r5zurnlbWpW4HNAQ/cOQJNBMqKnKDkyNWAT9Mut05TwwzI0oTUDPhVvH5CU
        mNM1Hek6Je9+jNgW4QaASYZ/FWy4f6qGKHkovq9Mfd/Rgck4Ss5PXyIKqhYCZZG6
        O6kuENfmiL8N+teyh8m6pzdh8Py4VpLhn+Tyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xMjO+bEzHpOP1HbtXrtOoiDYu6U9OcCg
        OS2Z8EFQFW+p6xD2GkwVrV2MCff2eZtEc2j7cGE1iLnOuBCSsoLZFxUTB2alSzaM
        m6FOu/h0UX0Z3hn5NE0K0C+oBOSY3C9js0XBfas+ImyKPwkDbawkSfGZq2xr+080
        vUA9Dmzu/FU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39F9BCA835;
        Wed, 27 May 2020 13:36:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 77B7BCA830;
        Wed, 27 May 2020 13:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: fixup/squash: clarify use of <oid-hash> in subject line
References: <9a9e7432-7a74-f46e-9a77-b8acaa9a974f@iee.email>
        <20200525213632.1626-1-philipoakley@iee.email>
        <20200525213632.1626-2-philipoakley@iee.email>
Date:   Wed, 27 May 2020 10:35:57 -0700
In-Reply-To: <20200525213632.1626-2-philipoakley@iee.email> (Philip Oakley's
        message of "Mon, 25 May 2020 22:36:31 +0100")
Message-ID: <xmqqmu5tl1qa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8736933C-A040-11EA-8368-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> The use of ellision `...` isn't great, as it gives no hint or clue,
> leaving the subsequent test with a difficult explanation.

True.  If you are planning to correct it in 2/2, then I think it
makes more sense to squash that in to have a single patch.

> Clarify if a full oid has is required, or a unique abbreviation within
> the respository, or just uniques within the rebase instruction?

Puzzled.  You must know the answer to "do we need a full object
name, or is it sufficient to have anything that gives us a unique
commit object name?" so why not write it in the patch instead of
asking the question here?  Or do you not know the answer and this is
a RFC/WIP patch????

> This is a minimal change that sidesteps the chance to rewrite/clarify
> the potential wider confusions over specifying the <commit> being
> referred to in the fixup/squash process.

Hmph.  So this step cannot be reviewed to judge if it is a good
change by itself?

Let me locally recreate a squashed single patch and review _that_
instead.

>  Documentation/git-rebase.txt | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 4624cfd288..462cb4c52c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -571,16 +571,18 @@ See also INCOMPATIBLE OPTIONS below.
>  
>  --autosquash::
>  --no-autosquash::
> -	When the commit log message begins with "squash! ..." (or
> -	"fixup! ..."), and there is already a commit in the todo list that
> -	matches the same `...`, automatically modify the todo list of rebase
> +	When the commit log message begins with "squash! <line>" (or
> +	"fixup! <line>"), and there is already a commit in the todo list that
> +	matches the same `<line>`, automatically modify the todo list of rebase
>  	-i so that the commit marked for squashing comes right after the
>  	commit to be modified, and change the action of the moved commit
> +	from `pick` to `squash` (or `fixup`).
> ++
> +A commit matches the `<line>` if
> +the commit subject matches, or if the `<line>` refers to the commit's
> +hash. As a fall-back, partial matches of the commit subject work,
> +too.  The recommended way to create fixup/squash commits is by using
> +the `--fixup`/`--squash` options of linkgit:git-commit[1].
>  +

Overall it looks much better than the original.

The original did not even attempt to define what is a "match" for
the purpose of this option, so the ellipses may have been OK, but
once we need to refer to what is there, we need a name to refer to
it and ellipses no longer are sufficient, and using the step 1/2
alone would not make any sense.  We definitely should take the step
2/2 together with it.

"A commit matches the <line> if the commit subject matches" is not a
great definition of what a "match" is, though.  The readers are left
in the same darkness about what constitutes a "match" of <line>
against "the commit subject".  If you define this "subject matches"
as a substring match, for example, you do not even have to say "as a
fall-back"---it is by (the updated version of your) definition that
how the commit subject and <line> matches so there is no need to
allow any fall-back involved.



