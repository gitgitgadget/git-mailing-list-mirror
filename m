Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0108C433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbhLPVkC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:40:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50433 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241625AbhLPVkB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:40:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4572E178457;
        Thu, 16 Dec 2021 16:40:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8HJPysGRZ1/12BabFo/nnO+/i8CjYjo9e2mXG+
        8ym6Y=; b=dHPJehyPns+e9TC5OJhfOg7YHK3qGLatgUXOayLbM8DaXYH3X24AfR
        yh3m+IHKgUU6GdEmfsiKdU0VQq++xlZWYAEntUv1dZMAzkNVS1ILBOAq6ythGXJb
        JaleiJW6a6PgqheD1c8P3YW+cAPLqqwJf2yJnIuu+blpeYiuEePPM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D298178456;
        Thu, 16 Dec 2021 16:40:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 69D38178455;
        Thu, 16 Dec 2021 16:39:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kashav Madan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Altmanninger <aclopte@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kashav madan <kshvmdn@gmail.com>
Subject: Re: [PATCH v3 1/4] bisect--helper: normalize format string of
 yes/no prompts
References: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
        <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
        <e7672e70cc937ef3aaab9a36199470e01f6676a8.1639678735.git.gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 13:39:56 -0800
In-Reply-To: <e7672e70cc937ef3aaab9a36199470e01f6676a8.1639678735.git.gitgitgadget@gmail.com>
        (Kashav Madan via GitGitGadget's message of "Thu, 16 Dec 2021 18:18:51
        +0000")
Message-ID: <xmqqy24k8c0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6BD258E-5EB8-11EC-BEEC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kashav Madan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kashav Madan <kshvmdn@gmail.com>
>
> Both callers of git_prompt in bisect--helper.c ask the user for yes/no
> confirmation. They both place the question mark after the choices,
> however this is inconsistent with how most UNIX-y tools do it. Update
> the format string to exclude the choices from the question.

Is there somewhere that the claim can be confirmed?  I am not having
much luck with queries like

https://www.google.com/search?q=prompt+question+mark+and+choices

that gave https://home.csulb.edu/~murdock/choice.html the most
relevant page X-<.

I personally do not think this step is worth doing, but in any case,
NEVER touch po/* directory when you are updating code and strings in
the code.  It is something our i18n coordinator will do at certain
point in the release cycle.
