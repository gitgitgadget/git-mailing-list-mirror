Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB7AECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 17:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIPRhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIPRhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 13:37:09 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D07AB4E0
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 10:37:08 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 31D3B1A8F4B;
        Fri, 16 Sep 2022 13:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mqw9n+4mxAWjC/qBHOZEFfQ7mZW1EIvuT5kOw1
        FhsFQ=; b=WoAVZVE1cmyBAeYvzKUqwb1JG4YAIIUt06/BFzwC5hJMJwEZ2osvVv
        WuXD8jUooVEByv56lO+rn8Om00m/JswXddqb3TBU+fJyZ0T2SYNMHTQ0LhoLViOz
        hvxJrrIU+/4mR5WMg6AcQMNTEZYqcLm7W2Qi/sUYLRMB+nsAonbBc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A74B1A8F49;
        Fri, 16 Sep 2022 13:37:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C23FB1A8F48;
        Fri, 16 Sep 2022 13:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH v2] fuzz: add basic fuzz testing for git command
References: <pull.1351.git.1663078962231.gitgitgadget@gmail.com>
        <pull.1351.v2.git.1663349383852.gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 10:37:03 -0700
In-Reply-To: <pull.1351.v2.git.1663349383852.gitgitgadget@gmail.com> (Arthur
        Chan via GitGitGadget's message of "Fri, 16 Sep 2022 17:29:43 +0000")
Message-ID: <xmqqedwbi5kw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2DF48D36-35E6-11ED-833B-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Arthur Chan <arthur.chan@adalogics.com>
>
> fuzz-cmd-base.c / fuzz-cmd-base.h provides base functions for
> fuzzing on git command which are compatible with libFuzzer
> (and possibly other fuzzing engines).
> fuzz-cmd-status.c provides first git command fuzzing target
> as a demonstration of the approach.

As I said in my review on the previous round, please make the
"cleaning up of existing stuff" and "addition of new stuff" into two
separate patches, the latter building on top of the former.  That
will make it easier to review the former (as there shouldn't be
anything that would add or change the way how the moved stuff
interacts with the rest of the world) and also the latter (as the
scope of the second patch would be much smaller and more focused).

Thanks.
