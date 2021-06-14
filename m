Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B63AC48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 07:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D59361370
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 07:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhFNH2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 03:28:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62725 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhFNH2W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 03:28:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1217ABF2B8;
        Mon, 14 Jun 2021 03:26:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fmadfQTF9A2gTjCF7w2xaXj6X7A79if1eG6YSp
        Bz6nc=; b=YJM1bIdjMAEM3E1kCXCdookE0EwseMvKAibM+UEh0RdtZ5lnBpw+F3
        /OlWBOZX3tj1a4ncppbh7tzvM+2teUWpVUaU8xonwk6j5DQhhRNb8TCsEHOuJ/8E
        v5ILCqrYWPBuh4EMzagXV8EP101SQybQ2yTRyqZfR3zccwJ09nkq0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBC23BF2B6;
        Mon, 14 Jun 2021 03:26:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3A325BF2B5;
        Mon, 14 Jun 2021 03:26:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [RFC PATCH 0/4] cache parent project's gitdir in submodules
References: <20210611225428.1208973-1-emilyshaffer@google.com>
Date:   Mon, 14 Jun 2021 16:26:17 +0900
In-Reply-To: <20210611225428.1208973-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 11 Jun 2021 15:54:24 -0700")
Message-ID: <xmqqo8c8zz3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF4EB306-CCE1-11EB-A554-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It's necessary for a superproject to know which submodules it contains.
> However, historically submodules do not know they are anything but a
> normal single-repo Git project (or a superproject, in nested-submodules
> cases). This decision does help prevent us from having to support
> divergent behaviors in submodule projects vs. superprojects, which makes
> sure Git is (somewhat) less confusing for the reader, and helps simplify
> our code.

https://github.com/git/git/actions/runs/934803365 is the CI run of
'seen' that passes.  With this and another topic merged to 'seen',
as can be seen in https://github.com/git/git/actions/runs/934680687,
a handful of tests fail.

Thanks.

