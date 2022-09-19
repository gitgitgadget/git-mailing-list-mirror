Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0854AECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 16:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiISQiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISQiI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 12:38:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEBC356E0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 09:38:07 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D4141BE954;
        Mon, 19 Sep 2022 12:38:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VZ4MueUX49G//sfscTRq67ZZOpadis0dU3CVF+
        so898=; b=cYeoz6lgb8EJYn+DtaY1Tb9haFTum+E78rwlbyjHjVZnASS5KVlTqk
        no6I7JAK7zVIKXYg4FfYQquE8tfxfTEyvshcer6XLa7KuWnMYnpsHD6plwffePXq
        NRBhOuekbefRzY/p0z3MzEUri82UqOyGEGm7J+cgj16qHs40AMaes=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0626B1BE953;
        Mon, 19 Sep 2022 12:38:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC2441BE952;
        Mon, 19 Sep 2022 12:38:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH v4] fuzz: reorganise the path for existing oss-fuzz fuzzers
References: <pull.1353.v3.git.1663542495094.gitgitgadget@gmail.com>
        <pull.1353.v4.git.1663598215154.gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 09:38:02 -0700
In-Reply-To: <pull.1353.v4.git.1663598215154.gitgitgadget@gmail.com> (Arthur
        Chan via GitGitGadget's message of "Mon, 19 Sep 2022 14:36:54 +0000")
Message-ID: <xmqqbkrbcob9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E9414A6-3839-11ED-93DA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Arthur Chan <arthur.chan@adalogics.com>
>
> This patch is aimed to provide a better organisation for oss-fuzz
> fuzzers and to avoid top-level clustters in the git repository when
> more fuzzers are introduced. In addition, grouping the fuzzers into
> their own directory separate their application on fuzz-testing from
> the core functionalities of the git code. It also provide better
> and tidier structure the oss-fuzz fuzzing library to manage, locate,
> build and execute those fuzzers for fuzz-testing purposes in future
> development.
>
> A new direrctory oss-fuzz has been created and existing fuzzers are
> moved into the new directory. Makefile and .gitignore have been
> fixed accordingly.
>
> CC: Josh Steadmon <steadmon@google.com>
> CC: David Korczynski <david@adalogics.com>
> Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
> ---

Thanks.  Will queue with a bit of rephrasing of the above.
