Return-Path: <SRS0=VPsx=4V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17083C3F2CE
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBEED21775
	for <git@archiver.kernel.org>; Wed,  4 Mar 2020 16:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lpfTFdea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgCDQSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:18:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50032 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDQSL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Mar 2020 11:18:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 629A5CD0A6;
        Wed,  4 Mar 2020 11:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xesy/YKMD2KuzzM6nTgfFVcsxec=; b=lpfTFd
        eaAVvMyaJiycnLcrRoU7oIJEY9wY/KtMSmaUU77b456MXs0KXHshR1J5M04Vla+c
        gn6FwsXn78lxXNXzTofpKRqk+f/63Gr/uBUKiFs0l8U4Jpdq0tRdiRGNSg4TXTfF
        OZz3ScN7ObUVXBpBwCtN6aWmFw1F80uXzdSYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w7G1WDP663JXgkqsM2Tpyvh1YYPdHyag
        cri/CQLGTKXW9NGrE8phI2Abn6H9qowOjDmUS4VeHJxFx8iXWwhYxBcGIccNI573
        c0jX+6BA/75ZejjhmQ8Y5j0xcfex18BStB1qTwJ8F7Jq9y3IRsT0kLeyS9Wr7OGw
        VFpvmC96e3A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 580ABCD0A5;
        Wed,  4 Mar 2020 11:18:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8DBA2CD0A4;
        Wed,  4 Mar 2020 11:18:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2020, #01; Tue, 3)
References: <xmqqimjl6pvn.fsf@gitster-ct.c.googlers.com>
        <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
Date:   Wed, 04 Mar 2020 08:18:04 -0800
In-Reply-To: <CACg5j262bzzwifXXC3tGu-bbNtojKQe-j1=byaAbrSNo=WtWgg@mail.gmail.com>
        (Heba Waly's message of "Wed, 4 Mar 2020 16:31:33 +1300")
Message-ID: <xmqqpnds5c1v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB3DEDF0-5E33-11EA-9D99-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

>> * hw/advise-ng (2020-03-02) 5 commits
>>  - tag: use new advice API to check visibility
>>  - SQUASH???
>
> A local change that needs to be squashed?

I often leave these changes that are based on what I suggested in my
review (or what somebody else suggested and I found sensible) as a
separate "SQUASH???" patch while queuing, when I can foresee myself
changing minds later (on the other hand, trivial typofixes etc. are
often squashed directly into the patches as I queue), so that these
can be removed easily.

As such, if the original author agrees with the suggestion, it is OK
to include it in the next round (when the suggested change is small
enough, don't bother with "Helped-by").  It is OK to drop it from
the next round when the original author does not agree with the
suggestion, too, but it would be good to say why somewhere in the
discussion.

Thanks.

>>  - advice: revamp advise API
>>  - advice: change "setupStreamFailure" to "setUpstreamFailure"
>>  - advice: extract vadvise() from advise()
>
> Heba
