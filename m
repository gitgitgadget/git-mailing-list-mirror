Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A05C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB5B611AF
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhDHVRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:17:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhDHVRU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 17:17:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39AF8C51D4;
        Thu,  8 Apr 2021 17:17:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sdxpmE39+vpXEK3yT4MSyvEhv5k=; b=P4Q0/2
        EGGvMu7ZlT+PR6UCyjysZ1levHqKDKEvEFp9FyAbj5KkiK6AkhUH4GRe3x448L8v
        nU6ki11UGldKbvNAoHEfyqyuBptm780T3baPIZEsZOYCE3RBRTABGWt8h67xMsZY
        /XhSyc4QJnL9iOtcGmzGsjMwk/D1FOLpebaaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n5N1Fgbd2peyi67UkUHsjFLK3xKyTogI
        W+FTDLSU+WvgyhlEbuaLNZGRgjTLWTILrJT85QExMTbJwoCtZDUC8mfO8BgTY592
        /Kzy9UWnCn3RpZ4u4rcXdoM+NzeVTce2mCgu0IIGgHTx3/4PSu6ML/3gLVihmTzf
        a79PowaUHhY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 315EFC51D3;
        Thu,  8 Apr 2021 17:17:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFED0C51D2;
        Thu,  8 Apr 2021 17:17:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8 37/37] docs: unify githooks and git-hook manpages
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-38-emilyshaffer@google.com>
        <xmqq5z0y2540.fsf@gitster.g>
        <7b651fbf-7f54-21b3-3775-d18c20f85a1a@jeffhostetler.com>
Date:   Thu, 08 Apr 2021 14:17:07 -0700
In-Reply-To: <7b651fbf-7f54-21b3-3775-d18c20f85a1a@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 8 Apr 2021 16:20:56 -0400")
Message-ID: <xmqqim4wsch8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C63B1FD6-98AF-11EB-B7FF-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I expect the fsmonitor stuff to take a while.  It is rather large
> and complicated.  My changes in the Documentation are rather minor.
> And I wouldn't want to be the sole reason to hold up Emily's changes.
>
> If it would be helpful, you can add a "revert" commit on top of my
> branch for my documentation commit -or- just drop it completely from
> my series.  Then I can re-adjust/rebase my doc changes before
> I send a V2.

Sounds like a plan.  I'll drop that step for now before the next
integration cycle.

There is another topic that interacts with es/config-hooks topic
badly (which I haven't resolved) in flight, though.

Thanks.
