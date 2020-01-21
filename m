Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E4EC2D0CE
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C755424653
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 22:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="woMswPcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAUWfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:35:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64190 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUWfq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 17:35:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C28837DFE;
        Tue, 21 Jan 2020 17:35:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fBN4PCPyHAKJQlJLjyFkBWg+w4g=; b=woMswP
        cPq6gHE2mC/SQolpRMwPbNpcfubYJTN/G7Rtyzd/75lU9bcg/GEVG7g2Eqtw+L/L
        +0FpSslB4mVi6W5Hec+FuI2F73NMEJchGYG9O70drHmhHTYBf0UWOKthff27fxKI
        G9sfcLfUNmTaTCsCkhp9B/VRyg21WJmuNTOFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NwI/bU8OhF+jfPkARQ0OJvr519DFGtKM
        fyz4KsS3cH8eqFtqPmTuxHxCi40U81a/mYhbqplywiaaqs78hXW3HlPhlHvEDNYm
        DBl86iqfTV6FXGjLdu2p0SJtYbrySxNIFHUKGFuJO/rJqVli5Jyw+MWhmiOZcrAJ
        3CDmhUMH9Bw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71C8E37DFB;
        Tue, 21 Jan 2020 17:35:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D284F37DFA;
        Tue, 21 Jan 2020 17:35:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 3/5] doc: provide guidance on user.name format
References: <20200120173343.4102954-1-sandals@crustytoothpaste.net>
        <20200120173343.4102954-4-sandals@crustytoothpaste.net>
Date:   Tue, 21 Jan 2020 14:35:42 -0800
In-Reply-To: <20200120173343.4102954-4-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 20 Jan 2020 17:33:41 +0000")
Message-ID: <xmqq4kwo8mkh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C457A36-3C9E-11EA-B2F8-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index a1f80e823c..f0edb06329 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -13,7 +13,12 @@ committer.email::
>  	Also, all of these can be overridden by the `GIT_AUTHOR_NAME`,
>  	`GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_NAME`,
>  	`GIT_COMMITTER_EMAIL` and `EMAIL` environment variables.
> -	See linkgit:git-commit[1] for more information.
> ++
> +Note that the `name` forms of these variables conventionally refer to
> +some form of a personal name.
> +See linkgit:git-commit[1] for more information on these settings and

The environment variables section of git(1) seems to be much more
detailed than what we have in git-commit(1) after the two previous
steps.  I do not mind keeping the reference to git-commit here, but
I think it is also OK to refer to the description in git(1) there,
too.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 7b61c9ba79..13f653989f 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -475,6 +475,12 @@ variables, if set:
>  
>  (nb "<", ">" and "\n"s are stripped)
>  
> +The author and committer names are by convention some form of a personal name
> +(that is, the name by which other humans refer to you), although Git does not
> +enforce or require any particular form. Arbitrary Unicode may be used, subject
> +to the constraints listed above. This name has no effect on authentication; for
> +that, see the `credential.username` variable in linkgit:git-config[1].
> +

Good.
