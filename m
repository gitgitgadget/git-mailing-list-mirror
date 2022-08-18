Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D540C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 21:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345023AbiHRVbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 17:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbiHRVbI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 17:31:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60585222
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 14:31:04 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7DD713B8A7;
        Thu, 18 Aug 2022 17:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p9Bl9/ClY0FnX7X674oxPhySagKcp9JaP1064h
        jTIm0=; b=L4QG6QZDhpnzCTRb4z7+n9SUlaFv6/mSArgmbhE2ejFHfNFx8M4yX6
        OId5xpzKi9smIjYAFZ7o9KXdk6zNc2EMCOvng77KTkmxm8x/6CXyDndzkZYnOLKF
        emghryZQF1q3Wk9Aroh/WTSVPtGS3rFDiqX4ba2NcPTu7VyOCTo7A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD4B913B8A6;
        Thu, 18 Aug 2022 17:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0EB3613B8A4;
        Thu, 18 Aug 2022 17:31:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Max Bernstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] trailer: allow spaces in tokens
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
        <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com>
        <xmqqk075qyq0.fsf@gitster.g> <CM9DZ4Z18PY9.1T2O8U54X66FD@cedar>
        <CAP8UFD1304rQh+9jMUkTmTvmNBxm6BNDt3=d07+C8iXSbJb2RA@mail.gmail.com>
Date:   Thu, 18 Aug 2022 14:31:00 -0700
In-Reply-To: <CAP8UFD1304rQh+9jMUkTmTvmNBxm6BNDt3=d07+C8iXSbJb2RA@mail.gmail.com>
        (Christian Couder's message of "Thu, 18 Aug 2022 22:46:18 +0200")
Message-ID: <xmqqa681nsrv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0ED7AEDE-1F3D-11ED-ADDF-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> I think allowing one white space before the separator is a good idea
> for the following reasons.
> ...
> I think it would be very annoying for users to find out that a number
> of otherwise proper trailers would not be taken into account only
> because they have a white space before the colon. At least there
> should be an option to allow that.

In short, you do not support Max's patch that allows arbitrary
number of white spaces anywhere but at the beginning of line,
but see a room for unrelated improvement from the current code,
namely, to allow exactly one optional space, immediately before
the separator and nowhere else.

It may be a reasonable thing to do that may not break too many
things.  I do not know if that is loose enough to satisify Max's
original wish, though.

Thanks.

