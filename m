Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760E3C432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF036101D
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 20:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhHKU5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 16:57:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62834 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhHKU5y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 16:57:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6852143DBC;
        Wed, 11 Aug 2021 16:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NQP09hx6nY6HXu8fOMO/aeJ/axylCH9294KBpy
        WxNWo=; b=W40Zikgv0QcLaRUme8VVymkCxuUV4TKC0POVSXMOeeGwZNJMAFvYU3
        mc5fN+OUea+Bk+6iKNqoN5M+GexkNCEw/sdix+WbGDdEuVu0f12nbSgdHjFS5vyw
        0gOIRcAxwBKTn3nWMjbTrDYIgn5l8AlqCZpgR70wfAh+DslzFU850=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE772143DBB;
        Wed, 11 Aug 2021 16:57:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F3B86143DBA;
        Wed, 11 Aug 2021 16:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Jeff King <peff@peff.net>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
        <20210811045727.2381-7-felipe.contreras@gmail.com>
        <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
        <xmqqzgto9dkd.fsf@gitster.g>
        <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
        <162871314612.7067.6886805754107701040.git@grubix.eu>
Date:   Wed, 11 Aug 2021 13:57:24 -0700
In-Reply-To: <162871314612.7067.6886805754107701040.git@grubix.eu> (Michael
        J. Gruber's message of "Wed, 11 Aug 2021 22:19:06 +0200")
Message-ID: <xmqq7dgr8zt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB8149BE-FAE6-11EB-8F80-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> I still think it's very worthwhile to fantasize about a git which has
> only verb-like commands (such as diff, add, checkout, checkin) and a
> consistent way of specifying the objects to act upon (possibly amended
> by "git pluralnoun" being synonymous to "git ls noun" or similar
> convenience shortcuts).

It is nice to fantasize that the world were without confusing
mixture of variety of things.

I am not sure if a single "git create" command that can be used to
create a new commit (aka "git commit"), a new tag (aka "git tag"),
or a new worktree (aka "git worktree add"), or a single "git remove"
command that can be used to remove a branch (aka "git branch -d"), a
tracked file (aka "git rm"), would create a more easy to learn and
explain UI.  At some point, I suspect that we would run out verbs
more quickily than we can organize commands and concepts in a way
that is easy to understand and explain by using them.

