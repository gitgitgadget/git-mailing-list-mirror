Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D3C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4071E64F8F
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 18:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhCASSz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 13:18:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59292 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhCASQO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 13:16:14 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33229AAF09;
        Mon,  1 Mar 2021 13:15:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a2L9wirCJBETbzPRTm+dFCGN414=; b=XAcPCI
        ZPnRhbsEIh/CeAX0rGNEPtycSe0NznthWfyc7xhUJbbdxDyP3heaojmHWfaTrCkM
        VVF2BAAX0OYNcU5Q8BLBIbIKNXwu5n543HIe3RPOiUVGR9cEoiXjk+rvGapI0BDj
        8nf293U3uUNxZ6CU0soXuEJjh/wYsa2ngINz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DBGlilyBcUIsbuh/pbbw6HSjFEZhi6V2
        Kx/MOGy9LIckh9PEFx8PFpne/IEydVLktL6OW8HQhMdZuStnYGM2zGf7uO7ukfGT
        6BxJFfiY7Om08nPe97VtaWQT81f1agJ9YYyupvba7JRaL7Vsc3sP+MOjdhaGlcNx
        qzqZNCZvGNo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B00BAAF08;
        Mon,  1 Mar 2021 13:15:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9EBD7AAF06;
        Mon,  1 Mar 2021 13:15:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jason Pyeron <jpyeron@pdinc.us>
Subject: Re: [PATCH 4/4] docs: note that archives are not stable
References: <20210227191813.96148-1-sandals@crustytoothpaste.net>
        <20210227191813.96148-5-sandals@crustytoothpaste.net>
        <87h7lwl5mv.fsf@evledraar.gmail.com>
        <YDvexO2NFM0KZ1Jo@camp.crustytoothpaste.net>
Date:   Mon, 01 Mar 2021 10:15:29 -0800
In-Reply-To: <YDvexO2NFM0KZ1Jo@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Sun, 28 Feb 2021 18:19:48 +0000")
Message-ID: <xmqqpn0irb9a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B5FC282-7ABA-11EB-B7AF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>   The output of 'git archive' is guaranteed to be the same across
>   versions of git, but the archive itself is not guaranteed to be
>   bit-for-bit identical.

I do not quite get this; your original was clearer.  What does it
mean to "be the same across versions of git but not identical" at
the same time?  If output from Git version 1.0 and 2.0 are guranteed
to be the same across versions, what more is there for the readers
to worry about the format stability?

Perhaps you meant

	... is guaranteed to be the same for any given version of
	Git across ports.

or something?  It would allow kernel.org's use of "Konstantin tells
kernel.org users to use Git version X to run 'git archive' and
create detached signature on the output, and upload only the
signature.  The site uses the same Git version X to run 'git
archive' to create a tarball and the detached signature magically
matches, as the output on two places are bit-for-bit identical".

>   The output of 'git archive' has changed
>   in the past, and most likely will in the future.

That is correct as a statement of fact.  I feel that saying it is
either redundant and insufficient at the same time.  If we want to
tell them "do not depend on the output being bit-for-bit identical",
we should say it more explicitly after this sentence, I would think.


