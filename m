Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4BFC433FE
	for <git@archiver.kernel.org>; Thu, 29 Sep 2022 20:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiI2UPU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Sep 2022 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiI2UPS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2022 16:15:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E65F225
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 13:15:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D5E613914A;
        Thu, 29 Sep 2022 16:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yWeUc39ZjMHndO1KISZLSp8nN/AOOcV4P1WY2L
        gEY3g=; b=F5obPY/8EkmVc/VkDUiKvnXYw6rP1Oay5rLQaPwEdwsnCQ6Qw0cfAX
        feP1fAnA4aqlvwtLKmkAzbdXKNrUtvGQtJ1js5o36Uxyu03s/AbkOVvxbok/xIa/
        DTzW9RKPQ2zYW2VZBKoeyX2ungnd74dtLN2RAm6FkIEbu2zQpN7pE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34E98139147;
        Thu, 29 Sep 2022 16:15:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82A20139146;
        Thu, 29 Sep 2022 16:15:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fail early when partial clone prefetch fails
References: <cover.1664316642.git.jonathantanmy@google.com>
Date:   Thu, 29 Sep 2022 13:15:14 -0700
In-Reply-To: <cover.1664316642.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 27 Sep 2022 15:12:28 -0700")
Message-ID: <xmqqczbendil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E3FA6C6-4033-11ED-BE4D-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> This fixes something we noticed at $DAYJOB, when a partial clone
> prefetch intermittently fails but all subsequent fetches work. More
> details are in patch 2's commit message.
>
> Jonathan Tan (2):
>   promisor-remote: remove a return value
>   promisor-remote: die upon failing fetch
>
>  object-file.c     |  4 ----
>  promisor-remote.c | 23 ++++++++++++++---------
>  promisor-remote.h | 11 +++++------
>  3 files changed, 19 insertions(+), 19 deletions(-)

No changes to t/ directory?
