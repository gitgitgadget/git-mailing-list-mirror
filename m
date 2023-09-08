Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB42DEEB56F
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 20:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbjIHUhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjIHUhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 16:37:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC9B10DF
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 13:37:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B42B83AC7D;
        Fri,  8 Sep 2023 16:36:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=vK549O1vNmvvMYbnc00ePRdZph1BYoR7nVwTm1
        3gyj8=; b=IS42uW8MKlZqA1E6mtVG4tJo1pMbaRtgxG9zPffSQkvHlxJJaDOUXY
        YMyH8t8KrQXAkVZ0gBrFV1vob5FiN+7iBgPtANyDX5AKBzu5YfgTsBfOsu9tKswB
        b60aeKRcTE7JecAap5HXgIdtE6/Pl4hrmyhLjet3bANm191ASPt1Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC80B3AC7C;
        Fri,  8 Sep 2023 16:36:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14B983AC7B;
        Fri,  8 Sep 2023 16:36:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [PATCH v3 0/6] Introduce Git Standard Library
In-Reply-To: <20230908174134.1026823-1-calvinwan@google.com> (Calvin Wan's
        message of "Fri, 8 Sep 2023 17:41:34 +0000")
References: <a0f04bd7-3a1e-b303-fd52-eee2af4d38b3@gmail.com>
        <20230908174134.1026823-1-calvinwan@google.com>
Date:   Fri, 08 Sep 2023 13:36:47 -0700
Message-ID: <xmqqr0n8s8ps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F5DB1CA-4E87-11EE-A578-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> I have taken this series out of RFC since there weren't any significant
> concerns with the overall concept and design of this series. This reroll
> incorporates some smaller changes such as dropping the "push pager
> dependency" patch in favor of stubbing it out. The main change this
> reroll cleans up the Makefile rules and stubs, as suggested by
> Phillip Wood (appreciate the help on this one)!

What is your plan for the "config-parse" stuff?  The "create new library"
step in this series seem to aim for the same goal in a different ways.

> This series has been rebased onto 1fc548b2d6a: The sixth batch
>
> Originally this series was built on other patches that have since been
> merged, which is why the range-diff is shown removing many of them.

Good.  Previous rounds did not really attract much interest from the
public if I recall correctly.  Let's see how well this round fares.

>  Documentation/technical/git-std-lib.txt | 191 ++++++++++++++++++++

It is interesting to see that there is no "std.*lib\.c" in the set
of source files, or "std.*lib\.a" target in the Makefile.

