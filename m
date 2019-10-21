Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8FA41F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 03:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfJUDzZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 23:55:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54270 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfJUDzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 23:55:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E03A23E27;
        Sun, 20 Oct 2019 23:55:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fv6FsvQGJZSMbv+tPCZyCfpnFNU=; b=nOfIYg
        0ED8NqgCKz+yMqgLE3vq9P3ZHuMjv+L7+2NH0Cf49BAV4pf18mAJv4kZYYR1acaD
        pNTsaZh0uTnY7KvrjdnAk8LQBl+Hija4u0jjzi8FwPXK1cYCmHxlRd3J0rQF9LDg
        NEcwXCJkGqTte1Kg5vInKs0cb1Yy02cCjSoV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jm9ROIawcJ4k/sBVLG0FI7YDiT0ti+Ha
        ZlBG5yELLIHoV9u7mW1xmhyjqVmKcwk3vIdR7Dj3aP5BZGCojS1Ldl8FZJm2dAP7
        Va8M9VfOd0gSXP9tYlA3plOJJh8uEeTrpjrzOOuLbR1/yCsi5jaim96rn63zNgR0
        ZAqOjxKcGbs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35CE223E26;
        Sun, 20 Oct 2019 23:55:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A003D23E25;
        Sun, 20 Oct 2019 23:55:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2] t/README: the test repo does not have global or system configs
References: <dc8afd1b-2e69-e54d-aee9-e5d6c4b729f5@iee.email>
        <20191018140049.2183-1-philipoakley@iee.email>
Date:   Mon, 21 Oct 2019 12:55:21 +0900
In-Reply-To: <20191018140049.2183-1-philipoakley@iee.email> (Philip Oakley's
        message of "Fri, 18 Oct 2019 15:00:49 +0100")
Message-ID: <xmqqpniqlpli.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B4EB520-F3B6-11E9-A05A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 899e92a1c9..d4c792076d 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -107,7 +107,7 @@ OPTIONS
>  	For writing options: write to global `~/.gitconfig` file
>  	rather than the repository `.git/config`, write to
>  	`$XDG_CONFIG_HOME/git/config` file if this file exists and the
> -	`~/.gitconfig` file doesn't.
> +	`~/.gitconfig` file if it doesn't.

The original is not easy to read, but this is not that much of an
improvement.  I think what the original wants to say is

    - write to global `~/.gitconfig`

    - but write to the XDG place instead, if XDG one exists and
      ~/.gitconfig does not exist

How about touching a bit more, e.g.

	For writing, rather than writing the per-repository config
	file .git/config, write to the global config file, which is
	$XDG_CONFIG_HOME/git/config (if it exists), or
	$HOME/.gitconfig (otherwise).

to streamline the description?

> diff --git a/t/README b/t/README
> index 60d5b77bcc..71946902d7 100644
> --- a/t/README
> +++ b/t/README
> @@ -485,6 +485,13 @@ This test harness library does the following things:
>     the --root option documented above, and a '.stress-<N>' suffix
>     appended by the --stress option.
>  
> + - The test framework sets GIT_CONFIG_NOSYSTEM=1, thus ignoring any
> +   --system config files. The --global config is redirected through
> +   the environment variables. It unsets the $XDG_CONFIG_HOME variable
> +   and sets HOME="$TRASH_DIRECTORY" for the tests.
> +   A basic --local config is created in the test repository.
> +   See linkgit:git-config[1].

Correct, even though I would say s/thus ignoring/in order to ignore/
instead ;-)

Thanks.
