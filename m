Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5E0C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E5D20738
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 16:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lkKQxqki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgGGQp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:45:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54365 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGQp1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 12:45:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3C21D2AFC;
        Tue,  7 Jul 2020 12:45:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B5OZYJQQrYRApCwva8w1JaO+9go=; b=lkKQxq
        kiPeCQsoX+eItrHhkxGFcNojF6nHwfEBsh/oRAEyAiEEK2WcAmXwCGLBPvrqdMUE
        yt46DA2ZwVa4ihbVsJ+Bi/hFlBXXu4YpakeCEvjUv6oLbLEwGhbZrhzrweB3g9N/
        K9fvaMDbTkq5x90Pujos3Y0xGvILDpGUVHo2s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A+8J4uO6PzXAmHZqq+tvcw9UBxBXJO0+
        C2L9PQL6jclEVAZZolbYiBu7ZMppfyI0XIzIUTym4GKvP+rv7PQ0RtLRgMiB5yd1
        mLLc/qfNppyA6IZRqJIy/lKx78DcLsmsB9Hsk2TKUaAwWwprjdkeAOOMeBKUPrRQ
        ggeUthtV5JU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC47AD2AFB;
        Tue,  7 Jul 2020 12:45:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1C9F2D2AFA;
        Tue,  7 Jul 2020 12:45:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul 2020, #01; Mon, 6))
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
        <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
        <xmqqzh8b5pgv.fsf@gitster.c.googlers.com>
        <7ce9163b-eafe-20a8-bd8e-7042807c98f0@gmail.com>
Date:   Tue, 07 Jul 2020 09:45:21 -0700
In-Reply-To: <7ce9163b-eafe-20a8-bd8e-7042807c98f0@gmail.com> (Derrick
        Stolee's message of "Tue, 7 Jul 2020 12:00:12 -0400")
Message-ID: <xmqqimez5l5q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 405445EE-C071-11EA-87C8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Oops, I am not sure what happened here.  There I thought were issues
>> pointed out at least on the latter series but was I hallucinating?
>
> I believe I have resolved all the open comments in both series.

OK, then I do not have to be worried.

Let's merge it down before -rc0.

Thanks.


