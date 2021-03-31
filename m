Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0560C433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8940261002
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhCaTPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:15:15 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56407 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhCaTO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:14:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26D251232CE;
        Wed, 31 Mar 2021 15:14:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AS2juRznbvpFcAjuJcM/eAIp8kU=; b=v3PjLJ
        IZ9kq/jR6YEzQ2LChHrgy1UmPtweHOMWhkhJ1RUv317qbdqoW+9mq/HZ4Olbl4gS
        rkaWEeOqu9ol44EuckpwlXp0aP17a58eB5B10zitTffJMbIKNPHkpR3C0aDqsb8n
        2gv69Hmetr4HzwF4/OJd+v3Psyn4Gq3cqy9oA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rxHNzPWKIgaN1fuXjh4RmrbL2030trVt
        FSYSqxzR9PDI3UthKe4+S1/gBubvHtKMiohUYsLO7TsoV7Q1CV0vNv2wPowDYfka
        1QMQs6mrCNzvdBnf7RHybmkSglKejCGwX/QeMSpKI0whJZ+08FPa10DChssLKjwq
        y8jxDFFIoFE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1ED461232CD;
        Wed, 31 Mar 2021 15:14:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B52181232CC;
        Wed, 31 Mar 2021 15:14:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "lilinchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        lilinchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v9] builtin/clone.c: add --reject-shallow option
References: <pull.865.v8.git.1617013145206.gitgitgadget@gmail.com>
        <pull.865.v9.git.1617205915876.gitgitgadget@gmail.com>
Date:   Wed, 31 Mar 2021 12:14:48 -0700
In-Reply-To: <pull.865.v9.git.1617205915876.gitgitgadget@gmail.com> (lilinchao
        via GitGitGadget's message of "Wed, 31 Mar 2021 15:51:55 +0000")
Message-ID: <xmqqim576spj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DBE956A-9255-11EB-8FD4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: lilinchao <lilinchao@oschina.cn>

This is not corrected, and no longer matches your sign-off.

I can edit your 'From:' to match this time, but please make sure
they match for the next time.

> In some scenarios, users may want more history than the repository
> offered for cloning, which happens to be a shallow repository, can
> give them. But because users don't know it is a shallow repository
> until they download it to local, users should have the option to

I find the "should" too strong, but let's keep reading.

> refuse to clone this kind of repository, and may want to exit the
> process immediately without creating any unnecessary files.

Yes, that is too strong and also redundant.

> Althought there is an option '--depth=x' for users to decide how
> deep history they can fetch, but as the unshallow cloning's depth

"Although"; if you begin with "although", you shouldn't write "but".

> is INFINITY, we can't know exactly the minimun 'x' value that can
> satisfy the minimum integrity,
> so we can't pass 'x' value to --depth,
> and expect this can obtain a complete history of a repository.

If the argument were "we might start with depth x, and the source
may be deep enough to give us x right now, but we may want to deepen
more than they can offer, and such a user would want to be able to
say 'I want depth=x now, but make sure they are not shallow'", I
would understand it, but I do not see where the "minimum integrity"
comes from---there doesn't appear to be anything related to
integrity here.

> In other scenarios, if we have an API that allow us to import external

"allows"

> repository, and then perform various operations on the repo.
> But if the imported is a shallow one(which is actually possible), it
> will affect the subsequent operations. So we can choose to refuse to
> clone, and let's just import a normal repository.

I'd suggest dropping this entire paragraph.  That is not any new
scenario at all.  API or not, you essentially just said "you can do
various things on your clone once you have it, but some things you
may want to do you would want a full history".  That is what you
started the whole discussion above and does not add any new
information.

> This patch offers a new option '--reject-shallow' that can reject to
> clone a shallow repository.

	Teach '--reject-shallow' option to "git clone" to abort as
	soon as we find out that we are cloning from a shallow
	repository.

perhaps?  cf. Documentation/SubmittingPatches[[describe-changes]]
especially [[imperative-mood]].


> Signed-off-by: Li Linchao <lilinchao@oschina.cn>
> ---
>     builtin/clone.c: add --reject-shallow option
>     
>     Changes since v1:
>...
>     Changes since v6:
>     
>      * use _() for warning/die statement

What are the more recent changes?

>     Signed-off-by: lilinchao lilinchao@oschina.cn

> @@ -858,6 +861,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
>  		free(remote_name);
>  		remote_name = xstrdup(v);
>  	}
> +	if (!strcmp(k, "clone.rejectshallow") && option_reject_shallow < 0)
> +		option_reject_shallow = git_config_bool(k, v);

Does this "single variable is enough" really work?

Imagine that the first time around we'd read from $HOME/.gitconfig
that says true (flips the variable from "unspecified").  Further
imagine that we are running "git clone -c config.rejectShallow=no"
to countermand the global config.  We call write_config() to write
the extra configuration value out, and then call git_config() to
read from the repository configuration again.

Because of the value taken from $HOME/.gitconfig, however, the
attempt to override is silently ignored, isn't it?

Other than that, the changes to the code from the previous round
looked sensible.


