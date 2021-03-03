Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1B1C433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFBC64E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355376AbhCDAXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:23:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63599 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbhCCT0u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 14:26:50 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D7F9BD77E;
        Wed,  3 Mar 2021 14:25:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LnZBADVOFJaokgkT/keluiVjtBo=; b=iZLb4a
        4gOTtTWU7BElulgBHJjRY7vPVMHhYdkXeBjJNe/VJHEhQwONV3zMLs/2j5TKRbUz
        ISay91+Qn9g36bjzPMAAc9fdjepF3VojJ7FNxvhY3cSs46vmK5SEvXbLXi7EdvHT
        8zo8vAOkBibjB4F3/J82GTK0OR0jy2LYa18Hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p/VVaSjfilL3H24SICQqFnHxV3DIABRj
        GrgXOuyr1hUEa0R3Ss8ekoGZKQZ3oYPONogj48qPA103BGxhlkEzZyyP+9YptzKE
        YTDHhOiMDDwTArYr7ePu9v52LLNet+2MtcBmBnlZyGGHq58CPJMQzW2yuVLps2l9
        xbN1UUSEtWw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54704BD77C;
        Wed,  3 Mar 2021 14:25:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC464BD77B;
        Wed,  3 Mar 2021 14:25:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Teng Long via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v5] clone: document partial clone section
References: <pull.745.v4.git.git.1614244436547.gitgitgadget@gmail.com>
        <pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com>
Date:   Wed, 03 Mar 2021 11:25:11 -0800
In-Reply-To: <pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com> (Teng
        Long via GitGitGadget's message of "Tue, 02 Mar 2021 14:25:32 +0000")
Message-ID: <xmqqeegwjazs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CFA2BF2-7C56-11EB-8815-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Teng Long via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Dyrone Teng <dyroneteng@gmail.com>
>
> Partial clones are created using 'git clone', but there is no related
> help information in the git-clone documentation during a period. Add
> a relevant section to help users understand what partial clones are
> and how they differ from normal clones.
>
> The section briefly introduces the applicable scenarios and some
> precautions of partial clone. If users want to know more about its
> technical design and other details, users can view the link of
> git-partial-clone(7) according to the guidelines in the section.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>     clone: document partial clone section
>     
>     cc: Philippe Blain levraiphilippeblain@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v5
> Pull-Request: https://github.com/git/git/pull/745

Puzzlling.

This seems to be identical to v3.  Some "rebase-i / push -f"
accident, or something?

> Range-diff vs v4:
>
>  1:  6d543cc11378 ! 1:  681c5dcb7904 clone: document partial clone section
>      @@
>        ## Metadata ##
>      -Author: Teng Long <dyroneteng@gmail.com>
>      +Author: Dyrone Teng <dyroneteng@gmail.com>
>       
>        ## Commit message ##
>           clone: document partial clone section
>       
>           Partial clones are created using 'git clone', but there is no related
>      -    help information in the git-clone documentation. Add a relevant section
>      -    to help users understand what partial clones are and how they differ
>      -    from normal clones.
>      +    help information in the git-clone documentation during a period. Add
>      +    a relevant section to help users understand what partial clones are
>      +    and how they differ from normal clones.
>       
>           The section briefly introduces the applicable scenarios and some
>           precautions of partial clone. If users want to know more about its
>
>
>  Documentation/git-clone.txt | 69 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index c89831009989..15495675a8ce 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -308,6 +308,75 @@ or `--mirror` is given)
>  	for `host.xz:foo/.git`).  Cloning into an existing directory
>  	is only allowed if the directory is empty.
>  
> +Partial Clone
> +-------------
> +
> +By default, `git clone` will download every reachable object, including
> +every version of every file in the history of the repository. The **partial clone**
> +feature allows Git to transfer fewer objects and request them from the
> +remote only when they are needed, so some reachable objects can be
> +omitted from the initial `git clone` and subsequent `git fetch`
> +operations. In this way, a partial clone can reduce the network traffic
> +costs and disk space usage when git is working under a large repository.
> +
> +To use the partial clone feature, you can run `git clone` with the 
> +`--filter=<filter-spec>` option. If the repository has a deep history
> +and you don't want to download any blobs, the form `filter=blob:none`
> +will omit all the blobs. If the repository has some large blobs and you
> +want to prevent some large blobs being downloaded by an appropriate
> +threshold, the form `--filter=blob:limit=<n>[kmg]` omits blobs larger
> +than n bytes or units (see linkgit:git-rev-list[1]).
> +
> +When using a partial clone, Git will request missing objects from the
> +remote(s) when necessary. Several commands that do not involve a request
> +over a network may now trigger these requests.
> +
> +For example, The <repository> contains two branches which names 'master'
> +and 'topic. Then, we clone the repository by
> +
> +    $ git clone --filter=blob:none --no-checkout <repository>
> +
> +With the `--filter=blob:none` option Git will omit all the blobs and
> +the `--no-checkout` option Git will not perform a checkout of HEAD
> +after the clone is complete. Then, we check out the remote tracking
> +'topic' branch by
> +
> +    $ git checkout -b topic origin/topic 
> +
> +The output looks like
> +
> +------------
> +    remote: Enumerating objects: 1, done.
> +    remote: Counting objects: 100% (1/1), done.
> +    remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> +    Receiving objects: 100% (1/1), 43 bytes | 43.00 KiB/s, done.
> +    Branch 'topic' set up to track remote branch 'topic' from 'origin'.
> +    Switched to a new branch 'topic'
> +------------
> +
> +The output is a bit surprising but it shows how partial clone works.
> +When we check out the branch 'topic' Git will request the missing blobs
> +because they are needed. Then, We can switch back to branch 'master' by
> +
> +    $ git checkout master
> +
> +This time the output looks like
> +
> +------------
> +    Switched to branch 'master'
> +    Your branch is up to date with 'origin/master'.
> +------------
> +
> +It shows that when we switch back to the previous location, the checkout
> +is done without a download because the repository has all the blobs that
> +were downloaded previously.
> +
> +`git log` may also make a surprise with partial clones. `git log
> +--<path>` will not cause downloads with the blob filters, because it's
> +only reading commits. `git log -p -- <path>` will download blobs to
> +generate the patch output and git log --raw will download all blobs
> +that changed at recent commits in order to compute renames.
> +
>  :git-clone: 1
>  include::urls.txt[]
>  
>
> base-commit: e1cfff676549cdcd702cbac105468723ef2722f4
