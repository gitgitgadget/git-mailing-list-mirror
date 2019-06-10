Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EA9A1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 20:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfFJUZW (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 16:25:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59607 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfFJUZV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 16:25:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C232E6ABF4;
        Mon, 10 Jun 2019 16:25:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Zp260ZnOupn95Qc7t3XSyzeSM0=; b=R304vm
        GrGJHiwyxkUGA6JecmjNbT7vSVXMipH39Yqlp/yfjr4w3/b4EhiXGF58kOXYQFnW
        oEcJurKKw3Yz1hWfiyt40sqOKDkeUOIPK8JJeTE6G1UL2+LpLGoYIz1GkvzuV58l
        9f2KOXcvzak+vJLxpL9oDEq1WDGa6wYpDEkzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=itqXetXwCt1g6w3TKSauRbMzPJQknlwW
        B3tmcpWdm60hh82wh+TrUxJWhrZKyew9LD0hC0je/GG/aJShsJoohMBe+u/XnT/k
        VpdpT4dY8ATPv3zan4+wf7qbl+rwbsnGhUC65uMpMItnzlSnBFUB0G4HLMTzbc7A
        sAYwqR5rsvk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAD266ABF3;
        Mon, 10 Jun 2019 16:25:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF8946ABEF;
        Mon, 10 Jun 2019 16:25:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] documentation: add tutorial for revision walking
References: <20190607010708.46654-1-emilyshaffer@google.com>
Date:   Mon, 10 Jun 2019 13:25:14 -0700
In-Reply-To: <20190607010708.46654-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 6 Jun 2019 18:07:08 -0700")
Message-ID: <xmqqef41mbmd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC245BEC-8BBD-11E9-9C87-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I'll also be mailing an RFC patchset In-Reply-To this message; the RFC
> patchset should not be merged to Git, as I intend to host it in my own
> mirror as an example. I hosted a similar example for the
> MyFirstContribution tutorial; it's visible at
> https://github.com/nasamuffin/git/tree/psuh. There might be a better
> place to host these so I don't "own" them but I'm not sure what it is;
> keeping them as a live branch somewhere struck me as an okay way to keep
> them from getting stale.

Yes, writing the initial version is one thing, but keeping it alive
is more work and more important.  As the underlying API changes over
time, it will become necessary to update the sample implementation,
but for a newbie who wants to learn by building "walken" on top of
the then-current codebase and API, it would not be so helpful to
show "these 7 patches were for older codebase, and the tip 2 are
incremental updates to adjust to the newer API", so the maintenance
of these sample patches may need different paradigm than the norm
for our main codebase that values incremental polishing.

