Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADCDC433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4678423A54
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbhAUXLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:11:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65310 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbhAUXKt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:10:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07143B4244;
        Thu, 21 Jan 2021 18:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X8MRdBJ8adyNEwKD1fOM4REfqmY=; b=ngmT1Q
        w3A8zg4NXGQXBKigwaTsY/uQfDf6Qb0IqVZWXaRQohpxbJmlfAo5jtkREGx6oQEA
        S1Hi7mqVFJ7hff+nQU8kOMFlvzXakh/zxAPrko2aj1kiwtNKSY+JC0IWedYAbzsr
        siyR9600ayBLWB7BSC4UxtB/ec3gkBMZiCM6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dJ3uYEYll+qNftOANySuneHPXWxmcxRg
        oNofGKllrZ5gd2s/bheBvayxFK0UQF6lEgaZx1OFyRp9e05giEWK8S/nvy9EwZ7P
        hQ0/42l8F0j5Cgvzri4+5WWXnXsKlIWlAITxnSHLFHdRtfBx3hE7pXjU3ss+kYXe
        ZTPiWFxzok0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 593AAB4241;
        Thu, 21 Jan 2021 18:10:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9720B423D;
        Thu, 21 Jan 2021 18:10:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #04; Sat, 16)
References: <xmqq8s8so84r.fsf@gitster.c.googlers.com>
        <20210121183427.1783539-1-jonathantanmy@google.com>
Date:   Thu, 21 Jan 2021 15:10:03 -0800
In-Reply-To: <20210121183427.1783539-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 21 Jan 2021 10:34:27 -0800")
Message-ID: <xmqqbldhc2es.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBF3993E-5C3D-11EB-B38C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> * jt/clone-unborn-head (2020-12-22) 3 commits
>>  - clone: respect remote unborn HEAD
>>  - connect, transport: add no-op arg for future patch
>>  - ls-refs: report unborn targets of symrefs
>> 
>>  "git clone" tries to locally check out the branch pointed at by
>>  HEAD of the remote repository after it is done, but the protocol
>>  did not convey the information necessary to do so when copying an
>>  empty repository.  The protocol v2 learned how to do so.
>> 
>>  What's the status of this thing?
>
> Several people have commented on the high-level approach (and I have
> addressed those comments), but I don't think anyone has said that the
> code itself looks OK. I'll see if I can get some of my colleagues to
> review this.

Thanks.
