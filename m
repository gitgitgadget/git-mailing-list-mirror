Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DE81F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 20:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJBUKl (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 16:10:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62382 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJBUKk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 16:10:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7B1B82073;
        Wed,  2 Oct 2019 16:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BX1rfwsd/0y7YHlx2ExODtaLm6w=; b=CJ2Pkz
        q7aLBf1Hzj/EpJ/wrrodXyH8NkE+qV7EAlIOm79tjW90GgNWFYiDlvw5WQFErMro
        XxSzRH9W2HjvAg6Xz8CfhHr/+UMsU/ArGOn2SxyQdeuYOt6RgxQHTKbIld3D/bsR
        b3mLBrW9mo75R6tPRNC2WDDJzAPDbWjhdr6MM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cA4urMhvr4JN1IN+4wi5rV44qM6Rjp8f
        XerVtm1LE3AFZB3GdBgG7RyoyEAIHjwT+l5K+2OiUYyrMmBUcGfES/D2fkRlHCkk
        Yd1LmpsJd7ouqO/5JenD4t5aGBbtj8R0PIHEr8tiMQ8R6CWQrFxcmk014Rrh7kND
        ScPQMS0RbUU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 980DB82072;
        Wed,  2 Oct 2019 16:10:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BCF7D82070;
        Wed,  2 Oct 2019 16:10:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] fast export/import: handle nested tags, improve incremental exports
References: <20190925014005.17056-1-newren@gmail.com>
        <20190930211018.23633-1-newren@gmail.com>
        <CABPp-BFckDZL4iAqhHmrXDpFi3eQgvOkbgjJdGRZE4ePUwNDuw@mail.gmail.com>
Date:   Thu, 03 Oct 2019 05:10:33 +0900
In-Reply-To: <CABPp-BFckDZL4iAqhHmrXDpFi3eQgvOkbgjJdGRZE4ePUwNDuw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Oct 2019 08:54:02 -0700")
Message-ID: <xmqqzhiidi2u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1FE6D8E-E550-11E9-AF55-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I see you picked up this corrected series in pu; thanks.  However,
> your merge commit, 2a99d6b6ff7c ("Merge branch
> 'en/fast-imexport-nested-tags' into pu", 2019-10-02), claims "Seems to
> break t9300 when merged to 'pu'.".  I know v1 did that and I could
> reproduce, but I can't reproduce any failures here.  Was this message
> just left over or is there some problem you are seeing?

I thought that the latest What's cooking written after you sent the
corrected version hasn't been sent yet.

And the draft copy I locally have for the next issue of what's cooking
has the comment removed already.

Anything I missed?

