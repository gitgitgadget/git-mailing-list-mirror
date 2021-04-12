Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2EFC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728AD6134F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbhDLUnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:43:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57791 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbhDLUnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 16:43:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0713413003D;
        Mon, 12 Apr 2021 16:42:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1DT2J7c3PhVdRpqZwdAjmv/3yQQ=; b=j5510o
        QyarsbGWuX37y61xn0B1YTXoPrCQ3cQggDJ95nJy9Zb7hIs/S5P2UsPyh3L6MAZ7
        Yk0eYXpbLeKf2X4BZ4Zia9r5JbAENsnsyyuX1M809cjsltKVHucjml3kvwEoZx9i
        E8xnDF+QbwVAcR1qG8rBZ0pqFAX6dAZ/qLzz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XQFcxbmqk5mzmB66ZWeae+SPqH7a3yCl
        tKiz6JqscJu2lbnaCWkStB2U6eVs2pQL0FHPPaZ/cNcFK6fnS+aee3ZbU6Krda5Q
        p3p7hKv0WIMah3CtaInZKU/VSMESbgsNEdSU6/35P/a10rub+rqIfKoZf5tOKgea
        5Cc8+OtVmhA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F38BE13003C;
        Mon, 12 Apr 2021 16:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4855113003B;
        Mon, 12 Apr 2021 16:42:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v9 1/2] [GSOC] docs: correct descript of
 trailer.<token>.command
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
        <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <8129ef6c476b4f35be59eae71367de5b83888068.1618245568.git.gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 13:42:43 -0700
In-Reply-To: <8129ef6c476b4f35be59eae71367de5b83888068.1618245568.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Mon, 12 Apr 2021 16:39:26
        +0000")
Message-ID: <xmqqwnt7b5fg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2947528-9BCF-11EB-8588-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  trailer.<token>.command::
> +	This option can be used to specify a shell command that will be called:
> +	once to automatically add a trailer with the specified <token>, and then
> +	each time a '--trailer <token>=<value>' argument to modify the <value> of
> +	the trailer that this option would produce.
>  +
> -When this option is specified, the behavior is as if a special
> +When the specified command is first called to add a trailer
> +with the specified <token>, the behavior is as if a special
> +'--trailer <token>=<value>' argument was added at the beginning
> +of the "git interpret-trailers" command, where <value>
> +is taken to be the standard output of the command with any
> +leading and trailing whitespace trimmed off.

So, with

	[trailer "foo"] command = "echo $ARG"

in your .git/config

    $ git interpret-trailers </dev/null

gives 'foo:'.

> +If some '--trailer <token>=<value>' arguments are also passed
> +on the command line, the command is called again once for each
> +of these arguments with the same <token>. And the <value> part
> +of these arguments, if any, will be used to replace the first
> +occurrence of substring `$ARG` in the command. This way the
> +command can produce a <value> computed from the <value> passed
> +in the '--trailer <token>=<value>' argument.
>  +
> +For consistency, the first occurrence of substring `$ARG` is
> +also replaced, this time with the empty string, in the command
> +when the command is first called to add a trailer with the
> +specified <token>.

And then

    $ git interpret-trailers --trailer=foo:F </dev/null

would give you

    foo:
    foo: F

The above is quite an easy to read explanation of the behaviour.

I somehow wonder if this "run with empty even without anything on
the command line" a misfeature, and I'd prefer to iron it out before
we add .cmd, because we may not want to inherit it to the new .cmd,
just like we avoided '$ARG' that does not properly quote and
replaces only once from getting inherited by .cmd mechanism.

The reason why I suspect this may be a misfeature is because I do
not see any way to avoid 'foo' trailer once trailer.foo.command is
set.  Which means I cannot use this mechanism to emulate "commit -s",
which would hopefully be something like

	[trailer "signoff"]
		command = "git var GIT_COMMITTER_IDENT | sed -e 's/>.*/>/"
		ifexists = addIfDifferentNeighbor

And trailer.signoff.ifmissing=donothing would not help in this case,
either, I am afraid, as that would not just suppress the automatic
empty one, which is fairly useless, but also suppresses the one that
is made in response to the option from the command line.

Christian?  What's your thought on this?

I can understand that it sometimes may be useful to unconditionally
be able to add a trailer without doing anything from the command
line, but it feels fairly useless that an empty one is automatically
added, that the only way to hide that empty one from the end result
is to use ifexists=replace, and that there is no apparent way to remove
the empty one.

The --trim-empty option is a bit too crude a band-aid to use, as the
existing log message may have an unrelated trailer for which it is
perfectly valid not to have any value.

The fix we'd do when introducing .cmd should also get rid of this
initial "run with an empty even when not asked"?

Or if the execution without any input from the command line were
truly useful sometimes, a configuration variable that disables this
behaviour, i.e.

	[trailer "signoff"]
		command = "git who"
		ifexists = addIfDifferentNeighbor
                implicitExecution = false		

so that

	git commit --trailer=signoff:Couder --trailer=signoff:gitster@

would give us two sign-offs without the empty one, perhaps?


In any case, the documentation update in this step looks reasonably
well written.

Thanks.
