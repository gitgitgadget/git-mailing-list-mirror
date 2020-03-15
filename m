Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EFAC10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 23:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CFC205ED
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 23:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T7eVMQBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgCOXen (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 19:34:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62125 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgCOXen (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 19:34:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAE4150CDA;
        Sun, 15 Mar 2020 19:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AKWR7VN3yeVi5k2puufmmFnrlJU=; b=T7eVMQ
        Bt2oKQjeI5iQiSz4gbLjeE9IonOlOrQ9GeFmqexHDh7pKmkbQh0X3Oia67HvmGKO
        Kv2d2eOdOw+YtwPrruGFAHo5XzUPETX82bH1f9s8p5RNMf7Nv8I259sSEMN1IEmB
        BXU8+EO95DNuH4/GqlbukyAlQBU4yvrx5fU7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QPVBnuYcyDZUOL2diylNhdW66RVvyVAU
        s9PIbR7oo1T5V49s4TzOACvv50o7SpUb1NHzpobJUrzxHIrtnMrKYSuhh60HByBl
        h6nN9PT6KOIHm3rt0GQmLCOxaRwKXexUAKqCkNodJL+WkuDv/JTYSkyKh4u0MzaT
        CQYrJLni7cs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C398B50CD9;
        Sun, 15 Mar 2020 19:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D69250CD8;
        Sun, 15 Mar 2020 19:34:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1] docs: add a FAQ
References: <20200315223923.170371-1-sandals@crustytoothpaste.net>
        <20200315223923.170371-2-sandals@crustytoothpaste.net>
Date:   Sun, 15 Mar 2020 16:34:34 -0700
In-Reply-To: <20200315223923.170371-2-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 15 Mar 2020 22:39:23 +0000")
Message-ID: <xmqqa74h9oqd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 877D2E5A-6715-11EA-9D85-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Note that the long lines for certain questions are required, since
> Asciidoctor does not permit broken lines there.

I didn't see "long lines", but was puzzled by a few lines with
ununiform indentation.

> +Configuration
> +-------------
> +
> +[[user-name]]
> +What should I put in `user.name`?::
> +  You should put your personal name; that is, the name that other humans call
> +	you.  This will be the name portion that is stored in every commit you make.

Shouldn't the first line "You should put ..." be indented to the
same level as the second line, like the entry for http-postbuffer we
see below?

> ++
> +This configuration doesn't have any effect on authenticating to remote
> +services; for that, see `credential.username` in linkgit:git-config[1].
> +
> +[[http-postbuffer]]
> +What does `http.postBuffer` really do?::
> +	This option changes the size of the buffer that Git uses when pushing data to
> +	a remote over HTTP or HTTPS.  If the data is larger than this size, libcurl,
> ...

> +[[http-credentials-environment]]
> +How do I read a password or token from an environment variable?::
> +  The `credential.helper` configuration option can also take an arbitrary shell

Likewise.

> +[[multiple-accounts-http]]
> +How do I use multiple accounts with the same hosting provider using HTTP?::
> +  Usually the easiest way to distinguish between these accounts is to use the

Likewise.

> +Most hosting providers use a single SSH account for pushing; that is, all users
> +push to the `git` account (e.g., `git@git.example.org`).  If that's the case for
> +your provider, you can set up multiple aliases in SSH to make it clear which key
> +pair to use.  For example, you could write something like the following,
> +substituting the proper private key file:
> ++
> +----
> +# This is the account for author on git.example.org.
> +Host example_author
> +   HostName git.example.org
> +	 User git

Here, shouldn't HostName entry be indented the same way as User and
other entries for this "Host" entry?

> +	 # This is the key pair registered for author with git.example.org.
> +	 IdentityFile ~/.ssh/id_author
> +	 IdentitiesOnly yes
> +# This is the committer for author on git.example.org.
> +Host example_committer
> +   HostName git.example.org

Likewise.

> +Common Issues
> +-------------
> +
> +[[last-commit-amend]]
> +I've made a mistake in the last commit.  How do I change it?::
> +	You can make the appropriate change to your working tree, run `git add <file>`
> +	to stage it, and then `git commit --amend`.  Your change will be included in
> +	the commit, and you'll be prompted to edit the commit message again; if you
> +	don't want to edit it, you can use the `--no-edit` option to `git commit` in
> +	addition, or just save and quit when your editor opens.

When the undesired part of the last change was "I added a junk
file", then instead of `git add`, `git rm [--cached]` would become
necessary.

I personally would prefer to say "if you want to use the original
commit message verbatim" instead of "you do not want to edit", but
it may be just me.  I just find the document to give more positive
attitude if it avoids phrasing end-users' wishes in terms of what
they do not want to do.

> +[[undo-previous-change]]
> +I've made a change with a bug and it's been included in the main branch.  How should I undo it?::
> +	The usual way to deal with this is to use `git revert`.  This preserves the
> +	history that the original change was made and was a valuable contribution, but
> +	also introduces a new commit that undoes those changes because the original
> +	had a problem.  The commit message of the revert indicates the commit which
> +	was reverted and can be edited to include an explanation as to why the revert
> +	was made.

Can we phrase "and can be edited" in a bit more opinionated way?
The users are encouraged to describe why and that is why we open an
editor by default for them to do so.

> +[[ignore-tracked-files]]
> +How do I ignore changes to a tracked file?::
> +  Git doesn't provide a way to do this.  The reason is that if Git needs to
> +	overwrite this file, such as during a checkout, it doesn't know whether the

Indentation.

> +----
> +# By default, guess.
> +*			text=auto
> +# Mark all C files as text.
> +*.c		text
> +# Mark all JPEG files as binary.
> +*.jpg	binary
> +----

The first entry text=auto is indented more deeply than others.  Intended?

Thanks.
