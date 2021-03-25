Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E64C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 20:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C66B61A27
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 20:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhCYUbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:31:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61320 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhCYUba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 16:31:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 539061329F3;
        Thu, 25 Mar 2021 16:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IMHad79t3ohPtO/wzpbxMcbc4kc=; b=XWES84
        NAleme6Kg6+HW1bp7qhT27OMccpUoTcKLK3uMqT8G6N/+hwlVuVaJicn1wEVGXoO
        phObpI8yw7BvDEI08YTg9QgaLTKRqwMTIJhuNZ9NTpECFUZ9f+trJCrwgQrYmyUo
        EnCNtsrMlGB62asqM0fSth8Lqc1oX+gHZ8+wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O6lSL9rwbhkdGAhailMr78vXkSO1fPIp
        /W5+TxsXYbFD29UcqXoItERIdd+l2XPXdqBatItKgmdNyRVrSiX23EwwbTiqcGt5
        CIwqR+iKl4Hb5J7wb9MGwAsvUAcD7V6lAVgt+knvPCoraXnV9Cqlmd9huXYIS3cS
        ibk83LmI7+A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C6961329F2;
        Thu, 25 Mar 2021 16:31:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6045B1329F1;
        Thu, 25 Mar 2021 16:31:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v7] builtin/clone.c: add --reject-shallow option
References: <pull.865.v6.git.1614878345754.gitgitgadget@gmail.com>
        <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com>
Date:   Thu, 25 Mar 2021 13:31:25 -0700
In-Reply-To: <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Thu, 25 Mar 2021 11:09:17
        +0000")
Message-ID: <xmqqa6qrug9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1315C980-8DA9-11EB-ACC9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ...
> This patch offers a new option '--reject-shallow' that can reject to
> clone a shallow repository.
>
> Signed-off-by: lilinchao <lilinchao@oschina.cn>
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
> Reviewed-by: Junio C Hamano<gitster@pobox.com>
> Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Reviewed-by: Jonathan Tan<jonathantanmy@google.com>

The Reviewed-by trailer means something quite different from what
you seem to think here.  It is only given by the reviewers to the
patch when they carefully reviewed and agrees what is in the patch.
The patch authors are in no position to add it, unless they are
explicitly told by reviewers that "this patch now can have my
Reviewed-by:" or some equivalent.

The (ideal) flow of events is

 0. The author comes up with an idea and writes a patch.

 1. The patch is sent to the list and Cc'ed to people who may be
    familiar with the area the patch touches.  For second and
    subsequent iterations, those who gave review comments to the
    previous iterations are also good people to Cc to.

 2. People give comments as reponses to the patch.

    (a) some may be happy with the iteration of the patch they
        reviewed, and may say "Thanks for contributing, this is now
        Reviewed-by: me".  For second and subsequent iterations,
        they may say "This was improved relative to the previous
        iteration, and it still looks good and you have my
        Reviewed-by:".

    (b) some may give constructive criticism, alternatives,
        enhancements, or outright "not a good idea, don't do this
        because ...".

    (c) some may just act as cheerleaders.

 3. The author thinks about the review comments and also may find
    improvement him/herself.

    (a) There may need an update to the patch.  If the patch has
        changed since the previous version in any way, ignore
        Reviewed-by: received in 2-(a).  When a significant help was
        given to update the patch, you may add "Helped-by:" trailer
        to credit the person's contribution.

        Your own "Signed-off-by:" appears the last in the trailers
        (i.e. "this iteration of the patch was written with help
        from these people, and then I am signing it off just before
        sending it out").

	Go back to 1. and repeat as many times as it takes.
    
    (b) There may not be a need for any update to the patch.  Only
        add the Reviewed-by: received in 2-(a) and otherwise do not
        change anything.  Your own "Signed-off-by:" appears the last
        in the trailers.  Send it to the list and to the maintainer
        (me).

 4. The maintainer applies the patch, unless there is no other
    comments received on that supposedly-the-final version sent in
    3-(b), but a late review comment may make us realize that it was
    premature, in which case we may go back to 3-(a).

