Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B61C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 23:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B337922AED
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 23:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgLUXtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 18:49:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64245 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgLUXtX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 18:49:23 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4930F109C1E;
        Mon, 21 Dec 2020 18:48:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8cditPUoYOGCAA9HiFBPY6aFRZQ=; b=Es2/pl
        x8XQKP7j6JqYd9G+QcIjLLMZFbL6Bso8BAad4sYQ5UQUQX86q/Ilree5/rkhjxwX
        Ovu6nZUFrNFqvbEI7dSOGBuX4vLkO7PBRlFyoULPiNq8Q0P+sKQ2eNpFTDLXx8lf
        EYpBPNVFWdhkSJa+/vV1J0LVxNim+Vq0k8Fjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DBaVODdJi34nitwWCi5F+PFUXha/dlHo
        XFcxH7FSW0tC14fxuvz2HWBgQzvApzwyIJ3mkDwqxApUJzkeblHg3ymAogduApcn
        alkmlTNBadywJ2V4qqJyup9VrZ53U54stEcoMQyilDJvJ+RZSb8rrBWZ9uKi65Qv
        v6pHKoDvAlQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4117F109C1D;
        Mon, 21 Dec 2020 18:48:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 80C86109C1C;
        Mon, 21 Dec 2020 18:48:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Cloning with remote unborn HEAD
References: <20201211210508.2337494-1-jonathantanmy@google.com>
        <cover.1608587839.git.jonathantanmy@google.com>
Date:   Mon, 21 Dec 2020 15:48:38 -0800
In-Reply-To: <cover.1608587839.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 21 Dec 2020 14:30:58 -0800")
Message-ID: <xmqq7dpalnzd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D599BCC-43E7-11EB-9C43-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Jonathan Tan (3):
>   ls-refs: report unborn targets of symrefs
>   connect, transport: add no-op arg for future patch
>   clone: respect remote unborn HEAD

This passes standalone all its tests, but in 'seen', seems to break
some tests.

https://travis-ci.org/github/git/git/builds/750936755 has just
started, but my local tests before publishing the day's integration
result failed 5702, 0031, and 5606 with this topic, and all passed
without the topic.

Thanks.
