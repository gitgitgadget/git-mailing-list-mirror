Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC7EC07E9C
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17108613C2
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhGIPZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:25:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65253 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbhGIPZu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 11:25:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95C96146CD9;
        Fri,  9 Jul 2021 11:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gU2/E7DCnMyhDezT3FupzpJ5/YpjoGPjH+XH7n
        B4kOo=; b=Fy22xFJoa/MakCTK4cPlDrXRyl8i2uSutcPlWPLRKrzrh1Ujr+a4D2
        bpw1c8d9SxleiYATQVrhQxxDb+2clU0W7cFi9dH51nBjT2KclBcWPxwXh8Z+OAXy
        MXH/56XjBA1LC8yCWD/Psgr8UoytGPKWs/ulRgcDn8G8t//eJgnfI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E526146CD7;
        Fri,  9 Jul 2021 11:23:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA8E6146CD5;
        Fri,  9 Jul 2021 11:23:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stephen Manz <smanz@alum.mit.edu>
Subject: Re: [PATCH] worktree: teach `add` to accept --reason <string> with
 --lock
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
        <CAPig+cSsPrQrP9xk8M8H339_NpYqKh1okeo1V-fAJ2zk3QeOjQ@mail.gmail.com>
        <xmqq7di3jkki.fsf@gitster.g>
        <CAPig+cQbBPGN+Dcvmy+ZAZeKLpffRrN4-2PNjRHzDHj56axcJg@mail.gmail.com>
Date:   Fri, 09 Jul 2021 08:23:02 -0700
In-Reply-To: <CAPig+cQbBPGN+Dcvmy+ZAZeKLpffRrN4-2PNjRHzDHj56axcJg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 9 Jul 2021 02:11:34 -0400")
Message-ID: <xmqqczrr8qax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DE324FA-E0C9-11EB-81B9-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> "reasons". That possibility suggests that this particular
> reason-giving option of `git worktree add` ought to be named
> `--lock-reason`, but `git worktree add --lock --lock-reason=<reason>`
> feels clunky and redundant, which is why I was wondering if `git
> worktree --lock[=<reason>]` would be a better (and more convenient)
> UI.

Sure, but

    $ git worktree add --lock --reason=why-do-i-want-to-lock \
		--frotz --reason=why-do-i-want-to-frotz

would work just fine, no?
