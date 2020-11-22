Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49FFC63777
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E1720771
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="REnYkqKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgKVXkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 18:40:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54496 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgKVXkH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 18:40:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A302B11760B;
        Sun, 22 Nov 2020 18:40:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dGLsn6W7anuXzGOsyn+aE4v7CDo=; b=REnYkq
        Kh9ZJged0iCpZ2XBKuzgvueJiH5bEyip5+It397IFZME41WHriDWs2PCvuZoxAFn
        eNiIKwBNvqG8vxet3cTLtUjW9VrnVuzipE/rHV68li/WYT0382LFT16jQcoIlZKp
        AVZzA4wXPwHX5baNL86r0bs7isCrebhGLRwvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vwFKnOFADQuWTGMwbtOS1Hk+oDuyl5vx
        NSyIoHCmss0PBwid3hnC1Vha+GsNEmMIf/BSkImUp64svH48m9koSY/rGQ7AlqqC
        Ab3VwC+jgRX5kep/q6VPhzz/lAZ46gdE2xVG0rPWefzT95YbUlpTg4Gjs8NoCraZ
        ykXHwr3DnYQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BB3E11760A;
        Sun, 22 Nov 2020 18:40:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DB113117609;
        Sun, 22 Nov 2020 18:40:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] init: document `init.defaultBranch` better
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <1518387eaa95098707878459bc74bd5ef2179386.1606087406.git.gitgitgadget@gmail.com>
Date:   Sun, 22 Nov 2020 15:40:02 -0800
In-Reply-To: <1518387eaa95098707878459bc74bd5ef2179386.1606087406.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Sun, 22 Nov 2020
        23:23:24 +0000")
Message-ID: <xmqqk0udot9p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B6F41E0-2D1C-11EB-BF17-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Our documentation does not mention any future plan to change 'master' to
> other value. It is a good idea to document this, though.
>
> Initial-patch-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

It would have been nicer to have a reference to the original patch
<xmqqd00a36wc.fsf@gitster.c.googlers.com> here after the three-dash
lines, which would have made it easier for me to say that the
updated phrasing is much better.

I do not think I deserve credit for this step in the series.  Please
drop "initial-patch-by" when you do a v2.

>  Documentation/git-init.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> index 59ecda6c17..19f9f16e6b 100644
> --- a/Documentation/git-init.txt
> +++ b/Documentation/git-init.txt
> @@ -20,8 +20,9 @@ DESCRIPTION
>  
>  This command creates an empty Git repository - basically a `.git`
>  directory with subdirectories for `objects`, `refs/heads`,
> -`refs/tags`, and template files.  An initial `HEAD` file that
> -references the HEAD of the master branch is also created.
> +`refs/tags`, and template files.  An initial branch without any
> +commits will be created (see the `--initial-branch` option below
> +for its name).

"branch without any commits" is certainly easier to understand than
"unborn branch", which was in my weatherballoon patch.  

Stepping back a bit more, I wonder if we want to make reference to
implementation details even less, e.g.

    ... an empty Git repository---a `.git` directory to store
    objects, branches and tags, hooks, and template files.

which would be in the same spirit as not mentioning 'HEAD file'.

> @@ -73,8 +74,10 @@ If this is reinitialization, the repository will be moved to the specified path.
>  -b <branch-name>::
>  --initial-branch=<branch-name>::
>  
> -Use the specified name for the initial branch in the newly created repository.
> -If not specified, fall back to the default name: `master`.
> +Use the specified name for the initial branch in the newly created
> +repository.  If not specified, fall back to the default name (currently
> +`master`, but that will be changed in the future; The name can be customized
> +via the `init.defaultBranch` configuration variable).

s/The/the/ after semicolon that ends a half-sentence.  Or
alternatively, s/in the future;/in the future./


>  
>  --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
