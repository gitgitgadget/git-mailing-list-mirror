Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483C4C433DF
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03E22074F
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 20:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="stbmKAax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgJLUT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 16:19:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65247 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgJLUT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 16:19:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C84E68E12;
        Mon, 12 Oct 2020 16:19:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g6FK9DOZsko01xra0JbIup3apdo=; b=stbmKA
        axBSm1Cy99zH8wREpjNWfzB6iJLMhYFvHa6y6P7HHYg0437wv4W5Gf2eJDJoVNo7
        63PRyKkY/X2AlO5gctRpB5L/yaBi6ApzPbou9fgzz8+uQNh8+9x3ch6uoxlbhPVh
        3wx4iMHtLxNncxU8JPNQox4MtSpfBaQWs2aiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kGu8N65TfMo0b3m7KV6wcjyEY2My3dix
        SF6Bb3bFqi4mQad/3708Mx8Z39ik2QKKHakquBJk1DUDvtsPyhL8xxlw39KD8CKd
        AIi9qMBD6QV05B32gFM1H9Y0Rkz9fHkuJSPYEEefIvcDemHYXSu+7LsOU8vVwSFy
        H17jvafgvCo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 750BC68E0F;
        Mon, 12 Oct 2020 16:19:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB3EC68E0E;
        Mon, 12 Oct 2020 16:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Cedric Schwyter <cedricschwyter@bluewin.ch>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] Alias 'list'-subcommands to 'ls'
References: <20201012195335.189194-1-cedricschwyter@bluewin.ch>
Date:   Mon, 12 Oct 2020 13:19:53 -0700
In-Reply-To: <20201012195335.189194-1-cedricschwyter@bluewin.ch> (Cedric
        Schwyter's message of "Mon, 12 Oct 2020 21:53:34 +0200")
Message-ID: <xmqqblh7nqmu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A05A4B8-0CC8-11EB-AA3F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cedric Schwyter <cedricschwyter@bluewin.ch> writes:

> Since many CLI-tools make use of this alias and many programmers are
> used to it I thought I'd add it to git since I was missing such an alias.

Is there a "git somecmd" that allows "git somecmd ls" form, while
these "git stash list", "git worktree list" subcommands take "list"
and not "ls"?  If so, this change may make sense, but otherwise, not
really.

>
> I only added it to built-in subcommands for now, might add it to some
> more commands in the future.
>
> Cedric Schwyter (1):
>   subcommands: alias 'list'-subcommands to 'ls' where applicable
>   docs: update docs with new alias
>
>  Documentation/git-bundle.txt          | 4 ++++
>  Documentation/git-sparse-checkout.txt | 3 +++
>  Documentation/git-stash.txt           | 5 +++++
>  Documentation/git-worktree.txt        | 5 +++++
>  builtin/bundle.c                      | 3 ++-
>  builtin/sparse-checkout.c             | 3 ++-
>  builtin/stash.c                       | 4 +++-
>  builtin/worktree.c                    | 3 ++-
>  8 files changed, 26 insertions(+), 4 deletions(-)
