Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E8C433B4
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 19:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E410610CC
	for <git@archiver.kernel.org>; Sun, 18 Apr 2021 19:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhDRTSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Apr 2021 15:18:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56727 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhDRTSM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Apr 2021 15:18:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C57F1126877;
        Sun, 18 Apr 2021 15:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KwKZAGeUOMOudEa+yLg9HNWST8Q=; b=HX+vpm
        +hVEA60yqVSJQUO6QCyKTYgNgLJegBFpUmKJFIJgxq5bGi1cMhRGfSklmIVSbI6v
        NJVvGL8hGhYyM5h6p9VZoJddK73wJmDjoSvAsxc2J5tbnj/GOmvKVyKYmr8S9uE9
        Hl3CkR44zjmef47tNFxuopdLXjmuFWsuLQ92c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sy72uV/s4Pk3Z415tqaLtyUEeRFGom4k
        Bi9dtqVrIZZ2/M4sWnIPh8HmMNVe1bhGcptX/SB/k2F3Tt+lXrdSUBiqv5uz1EwD
        AgVo7dxty2D5Z5kGf9oYRQNipnfTP8cSPIoRteIxAn2yHDVn8rusYFr3ooVIUDna
        UDLV8mQlre0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B084E126876;
        Sun, 18 Apr 2021 15:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8A91126875;
        Sun, 18 Apr 2021 15:17:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH] git-merge: move space to between strings
References: <pull.934.git.1618770806366.gitgitgadget@gmail.com>
Date:   Sun, 18 Apr 2021 12:17:38 -0700
In-Reply-To: <pull.934.git.1618770806366.gitgitgadget@gmail.com> (Josh Soref
        via GitGitGadget's message of "Sun, 18 Apr 2021 18:33:25 +0000")
Message-ID: <xmqqpmyr9zcd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE090418-A07A-11EB-AA66-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>     git-merge: move space to between strings
>     
>     GitHub Actions show things like:
>     
>      * branch                  master     -> FETCH_HEAD
>      (nothing to squash)Already up to date.
>     
>     
>     The expected results are:
>     
>      * branch                  master     -> FETCH_HEAD
>     (nothing to squash) Already up to date.

I am not sure if that is THE expected results, though (you wouldn't
have got this reaction if you said "I would expect to see").  

Usually, it is easier to read a message if it makes its primary
point first, before giving a parenthetical note.  I.e.  I would
expect that

	Already up to date (nothing to squash).

would be easier to understand to users.

Thanks.
