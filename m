Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4181F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390910AbfGYRKi (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:10:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58056 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbfGYRKh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:10:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E17F96CB16;
        Thu, 25 Jul 2019 13:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tjV9l16Lv2E9MttD1QY5sKDGsNI=; b=YJGcCG
        1kfUS03th9aaUyJ2JOZS8Ia4Caf45r8YwkWcELXczDcQU9nrEDoGN+XT9N9yidZ4
        iJOzByHDxB3qGI1NsYLGwYuZ4hI55XoU/4hVrCHQQwJ0cKjkvBq/Hiz753sXUbEE
        i2S9tDBRv918ZNDaWuT3zRUd9YxaF2yUC+Adk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ku8evui8WnAXJF32rx8THxJ/2XHjQuMV
        ArkroxloBOYQFPiOWfGrzBJUBSiEym9NyaOs9ix8huK/ceK0xZEOS4ravjgMK1MT
        LilN6KeqmEug0ukAorQP3T5f9voYYJuNAeTYkYQ6Ck54EuvtT4B0QzhazdJJp6yj
        prRmgSb12+E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9EBD6CB14;
        Thu, 25 Jul 2019 13:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B56AC6CB13;
        Thu, 25 Jul 2019 13:10:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/12] rebase -r: support merge strategies other than recursive
References: <pull.294.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Jul 2019 10:10:30 -0700
In-Reply-To: <pull.294.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Thu, 25 Jul 2019 03:11:14 -0700 (PDT)")
Message-ID: <xmqqftmuoxa1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C61F99E-AEFF-11E9-9905-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> ... As a consolation to myself, this work was actually worth it, surprising as
> that may look. Not only is t3427 now really easy to understand, adding that
> test case for --rebase-merges -Xsubtree tickled the sequencer enough to
> reveal a long-standing bug: the --onto option was simply ignored when passed
> together with --rebase-merges and --root. For good measure, this patch
> series addresses this bug, too.

Very nice.

> base-commit: 082ef75b7bfc90ac236afbb857a9552a026832b8
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-294%2Fdscho%2Frebase-r-with-strategies-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-294/dscho/rebase-r-with-strategies-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/294
