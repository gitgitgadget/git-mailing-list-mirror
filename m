Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277EEC4332D
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DD864FDE
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 16:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhCAQ5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 11:57:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54885 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhCAQzP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 11:55:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B72F1133E7;
        Mon,  1 Mar 2021 11:54:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h+XzWYIlSeWV4UgfQsPd6IrcJTs=; b=QjruQ+
        RELj881NYPss6HzJZKtEezjdjUt1r3+NtRI1vzCwmexGRqF7WVH8cAo0L03cG5QX
        +2klJh5hpE/fLLkBj9ezjQ3ZMYFFrbJsXOfbywRp2AHMIqlc0OXdHkGkHBtCjpog
        F6fGVv9qccdTucMSNjiRdFq74EXBcLTS5afRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ctf8Xp3PBRIJ51pGHQ6FYSo1grzqd/H9
        wKJm1VjSSiQNwm21ybBHZMh5YH0h2an6r/upcDMjnIAJO96oLJ00EACGBhZ+cQFh
        XotKe5JAqZ3/IEI0+8VR6slrXcG9AJ/67D3XkR9BwW0gS4bAU3KSJw0fKt5cR6db
        sl+tjiUgvtg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 444371133E6;
        Mon,  1 Mar 2021 11:54:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8C1C21133E3;
        Mon,  1 Mar 2021 11:54:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>
Subject: Re: [PATCH v2 2/2] githooks.txt: Clarify documentation on
 reference-transaction hook
References: <c30d41de55b8991a09e1d550e853f582b5394dee.1614232040.git.ps@pks.im>
        <55905b8693dd49637d0516ee123405cbfb58b6c6.1614591751.git.ps@pks.im>
Date:   Mon, 01 Mar 2021 08:54:15 -0800
In-Reply-To: <55905b8693dd49637d0516ee123405cbfb58b6c6.1614591751.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 1 Mar 2021 10:43:55 +0100")
Message-ID: <xmqqo8g2stl4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2CA84AA-7AAE-11EB-8896-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> The reference-transaction hook doesn't clearly document its scope and
> what values it receives as input. Document it to make it less surprising
> and clearly delimit its (current) scope.

Sounds good (especially "that may change in the future" part is a
nice touch).

Thanks.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/githooks.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 4dad80052e..b51959ff94 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -473,7 +473,8 @@ reference-transaction
>  
>  This hook is invoked by any Git command that performs reference
>  updates. It executes whenever a reference transaction is prepared,
> -committed or aborted and may thus get called multiple times.
> +committed or aborted and may thus get called multiple times. The hook
> +does not cover symbolic references (but that may change in the future).
>  
>  The hook takes exactly one argument, which is the current state the
>  given reference transaction is in:
> @@ -492,6 +493,14 @@ receives on standard input a line of the format:
>  
>    <old-value> SP <new-value> SP <ref-name> LF
>  
> +where `<old-value>` is the old object name passed into the reference
> +transaction, `<new-value>` is the new object name to be stored in the
> +ref and `<ref-name>` is the full name of the ref. When force updating
> +the reference regardless of its current value or when the reference is
> +to be created anew, `<old-value>` is the all-zeroes object name. To
> +distinguish these cases, you can inspect the current value of
> +`<ref-name>` via `git rev-parse`.
> +
>  The exit status of the hook is ignored for any state except for the
>  "prepared" state. In the "prepared" state, a non-zero exit status will
>  cause the transaction to be aborted. The hook will not be called with
