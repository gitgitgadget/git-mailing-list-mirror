Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787DCC4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302A220780
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 23:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GTUKubzA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgI3XzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:55:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64292 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3XzI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 19:55:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14148103384;
        Wed, 30 Sep 2020 19:55:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8VnEp6xtv2pd1dwQtUTYjCxsW0s=; b=GTUKub
        zAApsOJDWwBM0AbzKeFKcuUM4lTtfDYNT3cGE296M8DYkVZHQIRnlG0bg9dmi0xX
        VkjrjpjzyPFzcvc9M89l3t6eesAIO8LnwODg6CFD5eQH7RYDXPwMkARyfJ1yOEIJ
        nC+EiJdHI5P0hLZFH0n80ZjFb+8/P0Zx5S7Po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qaXmEdK3A8S+9X1Cy5JibSKpF5itmXk0
        B4+GXshV3OdSXcmfShNGW6dCIomb3UQQo3eZzGD7mty4PzLTywb16LH8aImTgC39
        T7hF7U7pXLGUZLLUNY47khmBXqD7WnB8wa7QK/9qw4tOk7W9+MPIfVDwNtpq1kjZ
        F03wVsuuIVA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0C588103383;
        Wed, 30 Sep 2020 19:55:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39E11103382;
        Wed, 30 Sep 2020 19:55:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 1/1] hideTimezone: add a user.hideTimezone config
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <20200930232138.3656304-2-shengfa@google.com>
Date:   Wed, 30 Sep 2020 16:55:02 -0700
In-Reply-To: <20200930232138.3656304-2-shengfa@google.com> (Shengfa Lin's
        message of "Wed, 30 Sep 2020 23:21:38 +0000")
Message-ID: <xmqqh7rees6h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C2FF110-0378-11EB-84E3-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shengfa Lin <shengfa@google.com> writes:

> Users requested hiding location in the world from source control
> trail. This is an implementation to read user.hideTimezone in
> cmd_commit and set timezone to UTC if it's true.

Not a very good proposed log message, that sounds as if "it is
what 'Users' requested, so it must be a worthwhile thing to do",
which is not the line of thinking to go by.




>
> Added a brief explanation of the new field in Documentation
> and added tests for true/false and reset-author
>
> Signed-off-by: Shengfa Lin <shengfa@google.com>
> ---
>  Documentation/config/user.txt   |  4 ++++
>  builtin/commit.c                |  5 +++++
>  t/t7527-commit-hide-timezone.sh | 37 +++++++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100755 t/t7527-commit-hide-timezone.sh
>
> diff --git a/Documentation/config/user.txt b/Documentation/config/user.txt
> index 59aec7c3ae..bd6813f527 100644
> --- a/Documentation/config/user.txt
> +++ b/Documentation/config/user.txt
> @@ -36,3 +36,7 @@ user.signingKey::
>  	commit, you can override the default selection with this variable.
>  	This option is passed unchanged to gpg's --local-user parameter,
>  	so you may specify a key using any method that gpg supports.
> +
> +user.hideTimezone::
> +  Override TZ to UTC for Git commits to hide user's timezone in commit
> +  date
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 42b964e0ca..fb1cbb8a39 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1569,6 +1569,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>  	s.colopts = 0;
>  
> +  git_config(git_default_config, NULL);
> +  int hide_timezone = 0;
> +  if (!git_config_get_bool("user.hideTimezone", &hide_timezone)  && hide_timezone)
> +    setenv("TZ", "UTC", 1);
> +
>  	if (get_oid("HEAD", &oid))
>  		current_head = NULL;
>  	else {
> diff --git a/t/t7527-commit-hide-timezone.sh b/t/t7527-commit-hide-timezone.sh
> new file mode 100755
> index 0000000000..41ed9c27da
> --- /dev/null
> +++ b/t/t7527-commit-hide-timezone.sh
> @@ -0,0 +1,37 @@
> +#!/bin/sh
> +
> +test_description='git-commit can override local timezone setting by reading user.hideTimezone from config'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'commit date shows timezone offset +0300 when user.hideTimezone is false' '
> +        git config user.hideTimezone false &&
> +        echo test1 >> file &&
> +        git add file &&
> +        # unset GIT_AUTHOR_DATE from test_tick
> +        unset GIT_AUTHOR_DATE &&
> +        TZ=Europe/Istanbul git commit -m initial &&
> +        git log -1 > output &&
> +        grep "Date: .* +0300" output
> +'
> +
> +test_expect_success 'commit date shows timezone offset +0000 when user.hideTimezone is true and reset' '
> +        git config user.hideTimezone true &&
> +        git commit --amend --reset-author &&
> +        git log -1 > output &&
> +        grep "Date: .* +0000" output
> +'
> +
> +test_expect_success 'commit date shows timezone offset +0000 even TZ setting says otherwise' '
> +        git config user.hideTimezone true &&
> +        echo test2 >> file &&
> +        git add file &&
> +        # TZ setting corresponding to -0600 or -0500 depending on DST
> +        # unset GIT_AUTHOR_DATE from test_tick
> +        unset GIT_AUTHOR_DATE &&
> +        TZ=America/Chicago git commit -m test2 &&
> +        git log -1 > output &&
> +        grep "Date: .* +0000" output
> +'
> +
> +test_done
