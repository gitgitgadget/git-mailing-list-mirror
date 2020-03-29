Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E651C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 18:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C74B2076A
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 18:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HxKPphxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgC2SgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:36:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63165 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbgC2SgP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 14:36:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBD28C7FDC;
        Sun, 29 Mar 2020 14:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oRFvtMy6Y6ruf0Z1VsiUh2g1bhE=; b=HxKPph
        xkZLkP22jt+Efib6aaqsERA4WhDozZ16mSHyogkfMDtK6QqhkToDvi4WAgGDJfRW
        aBN4LTFIncMoxm2uo46zjc/1iYgQyfVyY9ItKg1n5a/EnE5PQ884Hdf4W+D/Ei4e
        GTynBOAcut0OTTpzkEsxJXGfDVFOcY4j2cHqs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V6iUWXHYbfBfE98mf+p/Ngn94R6FVCc7
        m5UGjamU7t461sHtedS8dLi1qqfy8OUrEu8JO/NjzuSdPiQ5kLwb9RBe1f/6VuI3
        ONNPspNEI7l4ez69Amq4ByzXVGJ80fbCTLdDwjtv7xH4pVGVxrodOfFcj0z8YtXg
        IPx21MkGSn4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C351FC7FDA;
        Sun, 29 Mar 2020 14:36:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 10789C7FD9;
        Sun, 29 Mar 2020 14:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 00/11] Changed Paths Bloom Filters
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <86a75swuie.fsf@gmail.com>
        <fdcbd793-57c2-f5ea-ccb9-cf34e911b669@gmail.com>
Date:   Sun, 29 Mar 2020 11:36:09 -0700
In-Reply-To: <fdcbd793-57c2-f5ea-ccb9-cf34e911b669@gmail.com> (Garima Singh's
        message of "Fri, 21 Feb 2020 12:41:22 -0500")
Message-ID: <xmqqtv279ffq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29828A34-71EC-11EA-8140-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:

> On 2/8/2020 6:04 PM, Jakub Narebski wrote:
>> "Garima Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> ...
> I have gone back and forth on doing this. I like most of the core Bloom filter
> computations being isolated in one patch/commit. But based on the rest of your
> review, it seems like you are leaning heavily on having this split out. 
> So, I will take a proper stab at doing it for v3. 
> ...
> Thanks for taking the time for reviewing this series so thoroughly! 
> It is greatly appreciated! 

Thanks for a great discussion.  Just a friendly ping to the thread,
so that something from the discussion thread will stay on the first
page of mailing list archive's threaded view ;-)

