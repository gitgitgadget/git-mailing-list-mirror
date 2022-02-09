Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2849C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 21:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiBIVlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:41:06 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiBIVlE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 16:41:04 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5BDD94E42
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 13:41:03 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9F77F1780F4;
        Wed,  9 Feb 2022 16:41:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d8ZQDKb24b2kDiFUU3KSKGejhkrZSIMA1bJ9HB
        sy4Pc=; b=ygozNQtSOJhBYuoJ2ujKFy/WqBrwcNe0SLxIwl9iTX8ZHYVwGp9COg
        uuaVMIZ4D3SGW0gET6CVukb+QNKGynXkmJqfQZkxC90ND72hx/gALBR0eHulln1f
        fbSuj7Kf3ytqkUhVVR/82eTiz3WHtb7P15dVVL1UPF3bEWME1XIdg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 970931780F3;
        Wed,  9 Feb 2022 16:41:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0348C1780EF;
        Wed,  9 Feb 2022 16:40:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 0/3] Add cat-file --batch-command flag
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
        <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 13:40:58 -0800
In-Reply-To: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Tue, 08 Feb 2022 20:58:01 +0000")
Message-ID: <xmqqa6ez7m6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8C2854C-89F0-11EC-8BDA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> John Cai (3):
>   cat-file: rename cmdmode to transform_mode
>   cat-file: introduce batch_command enum to replace print_contents
>   cat-file: add --batch-command mode
>
>  Documentation/git-cat-file.txt |  24 ++++
>  builtin/cat-file.c             | 154 ++++++++++++++++++++++--
>  t/t1006-cat-file.sh            | 207 ++++++++++++++++++++++++++++++++-
>  3 files changed, 373 insertions(+), 12 deletions(-)

Does t1006-cat-file.sh pass the --stress test?  I have no time to
test it for you but I've seen "make test" got stuck and this is the
only cat-file related change in flight.

