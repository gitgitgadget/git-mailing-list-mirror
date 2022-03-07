Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D66C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 19:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbiCGTzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiCGTzT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 14:55:19 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1465748F
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 11:54:25 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47D1110E88C;
        Mon,  7 Mar 2022 14:54:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XuBocjHcvsG7Ux/MwE5XiI+qEer37dAMuVWJ8R
        SEgDQ=; b=tfMZuhFJeJ2AVeunWVAbgNL2td6I1raWTh2l7vqV12NQFxzIMDw5fo
        xpqrs8RMQMT4cJFgh008dGLirpBgBlMMCJyZjak6PSntYtasBI52lBI7JzWc3Kwb
        Gw1Uz+sYw+QAiigiP5WVClauQgjg8D/6xkvR3Soqd3eRYLKA3Jk8A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F15110E88B;
        Mon,  7 Mar 2022 14:54:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A97E710E88A;
        Mon,  7 Mar 2022 14:54:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
        <xmqqzgm5wafu.fsf@gitster.g>
        <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com>
        <xmqqv8wpu2fq.fsf@gitster.g>
        <85d434f8-0eb1-c6f7-dfd4-99bffbfbba57@github.com>
        <xmqq8rtlsg9h.fsf@gitster.g>
        <51fabaef-4849-2d9f-285a-3f442f803717@github.com>
Date:   Mon, 07 Mar 2022 11:54:22 -0800
In-Reply-To: <51fabaef-4849-2d9f-285a-3f442f803717@github.com> (Derrick
        Stolee's message of "Mon, 7 Mar 2022 14:49:53 -0500")
Message-ID: <xmqq35jtsfm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62FF4FBC-9E50-11EC-A180-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I've been trying this:
>
>  git clone --no-local --filter=$filter "file://$(pwd)" cloned &&
>
> which "succeeds" with this in the stderr:
>
>  warning: filtering not recognized by server, ignoring

Hmph, and we won't see it when going over ssh to the same
repository?  That is puzzling.

>>> an error condition into 'git clone' to say "Cannot currently clone
>>> from a filtered bundle" to help users understand the issue?
>> 
>> It would be a workable stepwise solution, I would think.  It is not
>> like we are robbing an existing feature from users---it merely is
>> that the support of partial cloning over different "transport" is
>> uneven, which is to be expected, especially in earlier phase of
>> introducing a new feature.
>
> That was my understanding, too.

Good to see us on the same page.  Thanks.
