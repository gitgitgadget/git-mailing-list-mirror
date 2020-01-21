Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6923EC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBF62465A
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2+t1Dm1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAUWXo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:23:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60381 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUWXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 17:23:44 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B13A18EF7;
        Tue, 21 Jan 2020 17:23:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CiQQF5PktwAirviYcEmGZ2jGo1s=; b=d2+t1D
        m1AFz73pRiMeSnVQwVr2qZJarZPev61Vqz3qkBH1rhtg7Y28QCHLZr92QLHWSpx1
        6eHHOm8XChI7xmevEAjvZEZLaGHpTSigvFX9wEJcwSjX9oKh5p+w9gNkJOxcnI3e
        qeTHQ09gNzjtU+mnc6JqVk5cXx+kOEj+P10Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZKrsucmcNMbrBqOdmQTelrC3okqo66hw
        nhZbSMNUHVk3JDUqRGK0Drv/qI7ulATxJrJ30Nhg/x+vOU0uzdkpqU+lN3t9I0Qc
        1SOygcPzygWUYd5Ef5FYRasycZd/lPR2mtVgAdWcfCTaIm+CgG2ZQYkZOEyenN7W
        2aNnKibVcWo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23B1818EF6;
        Tue, 21 Jan 2020 17:23:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8495D18EF2;
        Tue, 21 Jan 2020 17:23:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 1/5] doc: move author and committer information to git-commit(1)
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
        <20200120173343.4102954-2-sandals@crustytoothpaste.net>
Date:   Tue, 21 Jan 2020 14:23:39 -0800
In-Reply-To: <20200120173343.4102954-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 20 Jan 2020 17:33:39 +0000")
Message-ID: <xmqqd0bc8n4k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD238DBE-3C9C-11EA-8249-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index 0557cbbceb..a1f80e823c 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -13,7 +13,7 @@ committer.email::
>  	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
>  	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
>  	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
> -	See linkgit:git-commit-tree[1] for more information.
> +	See linkgit:git-commit[1] for more information.

Makes sense---it is consistent with the goal of making the
documentation of "git commit" Porcelain the central place for
authorship and committer information.

> diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
> index 4b90b9c12a..adc2e0d4b7 100644
> --- a/Documentation/git-commit-tree.txt
> +++ b/Documentation/git-commit-tree.txt
> @@ -42,6 +42,10 @@ tend to just write the result to the file that is pointed at by
>  `.git/HEAD`, so that we can always see what the last committed
>  state was.
>  
> +A commit comment is read from stdin. If a changelog
> +entry is not provided via "<" redirection, 'git commit-tree' will just wait
> +for one to be entered and terminated with ^D.

This is copied from the end of the "commit information" section,
without the original getting removed (see the post-context of the
hunk that begins at l.79/l.82).  Intended?

I haven't seen anybody use the phrase "commit comment" in the
reviews on this list for long time; the phrase somehow feels
outdated.  The pretty formats section in "git log --help" calls
this "commit message".  "log message" may also be more common.

> @@ -69,7 +73,6 @@ OPTIONS
>  	Do not GPG-sign commit, to countermand a `--gpg-sign` option
>  	given earlier on the command line.
>  
> -
>  Commit Information
>  ------------------
>  
> @@ -79,26 +82,6 @@ A commit encapsulates:
>  - author name, email and date
>  - committer name and email and the commit time.
>  
> -While parent object ids are provided on the command line, author and
> -...
> -that file does not exist).
> -
>  A commit comment is read from stdin. If a changelog
>  entry is not provided via "<" redirection, 'git commit-tree' will just wait
>  for one to be entered and terminated with ^D.
> @@ -117,6 +100,7 @@ FILES

