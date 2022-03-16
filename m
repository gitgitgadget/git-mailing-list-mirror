Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E14C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbiCPU4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbiCPU4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:56:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B4B91
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:55:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2844179B8B;
        Wed, 16 Mar 2022 16:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2bF/zeRBVAJ7KwqOOHhbX2hKRSP36P8+Me+TXV
        /6uow=; b=JuRsxobYgd6Ufu004EFoSnCgby0mmjHckKIXz7acBNnDYQQCWrG5xx
        xEKRqaTvpsR7YVicFaysgrNaHjsn2tvJD//kO5oaO/lkVf6zgbygW5EXszycDzeO
        z09G75UJrTSRxY+0StrQdS1jIqyd2+v03Yx1c0kxwYgFeFq/QrUmw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB16E179B8A;
        Wed, 16 Mar 2022 16:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DC3CD179B89;
        Wed, 16 Mar 2022 16:55:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH v3 5/5] stash: make internal resets quiet and refresh index
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
        <4c45351a0c4b8b955a9101ed9445a763750ca3c3.1647308982.git.gitgitgadget@gmail.com>
        <xmqqee33h5ty.fsf@gitster.g>
        <a4a7c3ea-3a40-1110-1c1e-a089daf01281@github.com>
Date:   Wed, 16 Mar 2022 13:55:19 -0700
In-Reply-To: <a4a7c3ea-3a40-1110-1c1e-a089daf01281@github.com> (Victoria Dye's
        message of "Wed, 16 Mar 2022 13:07:09 -0700")
Message-ID: <xmqq1qz1lirs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 652D05D2-A56B-11EC-B3A9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I like having the "quietness" and "refresh" checks separate because they're
> not inextricably linked. One could fail while the other doesn't (or both
> could independently fail), where two separate results would be slightly more
> helpful information for a developer debugging the tests. The same reasoning
> applies to 'stash push' with 'stash apply' (they can fail independently, so
> they're tested separately). 

OK.

