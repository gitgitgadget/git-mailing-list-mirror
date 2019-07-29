Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41B731F462
	for <e@80x24.org>; Mon, 29 Jul 2019 16:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfG2QHs (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 12:07:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57839 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfG2QHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 12:07:48 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20674169D6B;
        Mon, 29 Jul 2019 12:07:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z86VTk7ThgeqBwk8imT3AHr7eJ4=; b=PjXGWi
        4PGnt7YlXfj+oxuaqv6KGidlYsxNrfTb8mCvA/bUWxCQ4sHhG2Mu3iWl5GupzWkX
        8MCPQbTOGRS7WUV1peaamd4TiDxMUmhp5C9UF0BaxnC+gCaK6kk8eOwqWTmWrG8u
        +u1/3XOR4+FGy86CaFxGm8mZF5OwUFKDEY+6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KWeJiTbnBDWTd78D1K4SZn3aW/bDaWHE
        v2EbtWTR72Si7mLuEcvLUMmrkJyAKsuyzEd+pqj1IcA0d0vE+I5eYj5lKOeAIRKC
        nlM7SC4rbtuIV9P2eZuQPs0XLtnosScQaRMpAIWBBkVeow3gcMLtO5E0ULpZL6cQ
        ZZ5gvvH41iU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17F7C169D69;
        Mon, 29 Jul 2019 12:07:46 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B767169D68;
        Mon, 29 Jul 2019 12:07:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2] reset: unstage empty deleted ita files
References: <20190712150235.12633-1-vcnaik94@gmail.com>
        <20190726044806.2216-1-vcnaik94@gmail.com>
        <xmqqsgqsodyu.fsf@gitster-ct.c.googlers.com>
        <CAK_rgsFDpW3JhMAc=VBm=WD3drFnV0g=QN15+uZYdsnBTnX_Cg@mail.gmail.com>
Date:   Mon, 29 Jul 2019 09:07:44 -0700
In-Reply-To: <CAK_rgsFDpW3JhMAc=VBm=WD3drFnV0g=QN15+uZYdsnBTnX_Cg@mail.gmail.com>
        (Varun Naik's message of "Sun, 28 Jul 2019 23:52:20 -0700")
Message-ID: <xmqqtvb4vn73.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00961776-B21B-11E9-9458-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

> To guard against changes to the test cases in the future, would it be
> better if I write something like the following instead?
>     git diff --cached --exit-code HEAD nonempty empty

Hmph, that is probably a good idea, as it matches the kind of
"reset" we just did, which is what we are testing.

