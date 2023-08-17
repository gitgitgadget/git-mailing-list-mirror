Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45552C54799
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 19:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354775AbjHQT5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354797AbjHQT4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 15:56:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73ED35B5
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 12:56:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5893120698;
        Thu, 17 Aug 2023 15:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bVC/iGGxzxTYtN+3ysTTfoJ7a8s+jFYa7XYOL+
        frObs=; b=JOIMZIsGWV2Id7vH6qbn7uJzmXjXgzLa08dtC1J3KMitt6cTnL5tEE
        J+ckaro9pZf0b1DDmQnK3GORwDPGi7rVUT1RVBUmURFdqly46P0nRjJkJlTVZHjn
        EfV2OhdGlxvnG59nRtdUP24iaVVwdYEI1hpuMA3NZUDiAOE9yWAaI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5037420697;
        Thu, 17 Aug 2023 15:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D5E920696;
        Thu, 17 Aug 2023 15:56:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Paul Watson <pwatson2@wellmed.net>
Subject: Re: [PATCH] diff: tighten interaction between -w and --exit-code
References: <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
        <xmqqbkfh8nu3.fsf@gitster.g> <xmqqv8ded018.fsf@gitster.g>
        <20230817051059.GA3006160@coredump.intra.peff.net>
        <xmqqy1i9bqcm.fsf@gitster.g>
        <20230817194912.GB3032779@coredump.intra.peff.net>
Date:   Thu, 17 Aug 2023 12:56:23 -0700
In-Reply-To: <20230817194912.GB3032779@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 17 Aug 2023 15:49:12 -0400")
Message-ID: <xmqqttsxbfyw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2528AAC0-3D38-11EE-91A8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, without having really dug into the problem too far, that does
> sound a lot better. I also wonder to what degree you could apply the
> same strategy to other formats (I guess it depends on them removing
> whitespace-only changes from a structure). From the test I posted
> earlier, it does look like many of them have the same blind spots for
> mode-only changes (and I suspect addition/removal of empty files is
> another corner case to check).

I have something cooking.  Stay tuned, without getting excited too
much ;-)

Thanks.
