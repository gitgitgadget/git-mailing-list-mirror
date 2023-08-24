Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C035AC3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 18:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbjHXSvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243167AbjHXSu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 14:50:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB251BCD
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:50:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 44EA03087A;
        Thu, 24 Aug 2023 14:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Y7Ku8a+MtgibsSE3rx98QrwyLOb5ecOcgGC1W
        ULMnU=; b=QAj75Rl8VEYwleygaDUmKxd8dD+tfTQpGDVjHIr3sihuK6Dl/7rTVE
        4P88CK6FDYs+cQKi7OS1Szf53Nehm+b+laOd2oLg2QxnRpiAqJ8MD4e1jy3JZFmc
        N+Li2e9+vPRnXUSSd9FmjKbObYpIq7/fEJo+ArgSjweZ+pVE0BKK0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25F7E30879;
        Thu, 24 Aug 2023 14:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C86DC30878;
        Thu, 24 Aug 2023 14:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/3] leak tests: mark remaining tests leak-free as such
References: <cover.1692902414.git.me@ttaylorr.com>
Date:   Thu, 24 Aug 2023 11:50:51 -0700
In-Reply-To: <cover.1692902414.git.me@ttaylorr.com> (Taylor Blau's message of
        "Thu, 24 Aug 2023 14:40:34 -0400")
Message-ID: <xmqqbkewb7g4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2689FA8C-42AF-11EE-A16C-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This series marks all leak-free tests as such, meaning that the above
> "make test" invocation will pass after this series. The bulk of the
> tests which are marked here in the first patch were always
> leak-free[^1]. The remaining two patches address a couple of special
> cases of tests which are also leak-free.
>
> Thanks in advance for your review!
>
> [^1]: At least as far back as v2.38.0, when the "check" mode of
>   GIT_TEST_PASSING_SANITIZE_LEAK was first introduced.

Nice to see "bugs" gone without any code changes ;-) It would have
taken a lot of patience from your part, though, and your effort is
very much appreciated.



> Taylor Blau (3):
>   leak tests: mark a handful of tests as leak-free
>   leak tests: mark t3321-notes-stripspace.sh as leak-free
>   leak tests: mark t5583-push-branches.sh as leak-free
>
>  t/t3321-notes-stripspace.sh | 1 +
>  t/t5571-pre-push-hook.sh    | 1 +
>  t/t5583-push-branches.sh    | 1 +
>  t/t7516-commit-races.sh     | 2 ++
>  4 files changed, 5 insertions(+)
