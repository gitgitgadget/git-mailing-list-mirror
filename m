Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687E8C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 17:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbiHRR6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiHRR6I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 13:58:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BF8C0B53
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 10:58:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08E081BF583;
        Thu, 18 Aug 2022 13:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1zQzRuddEttsE8Euiyg46TuhrhiokJyBu149dZ
        Pyo8o=; b=sKGUG7BvImWpVN1Az2AldjsnkMoQP/NOjOksgUERB4V8hXzDuhDmLC
        q+9yiROhIrT7k6G2QqzxBzSu2/xWmaByuRJySsKJKUyXZSKZDNvVpsXstng/j855
        lwpdnvOB7921aH/h18ZDGblJhbDwXQjfnpBqFk3z7W8cQEdbStz9A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F42351BF582;
        Thu, 18 Aug 2022 13:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A86191BF580;
        Thu, 18 Aug 2022 13:58:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Max Bernstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] trailer: allow spaces in tokens
References: <20220818175216.3530525-1-jonathantanmy@google.com>
Date:   Thu, 18 Aug 2022 10:58:02 -0700
In-Reply-To: <20220818175216.3530525-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 18 Aug 2022 10:52:16 -0700")
Message-ID: <xmqqedxdph79.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E5623B0-1F1F-11ED-A953-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The "I want to mention about Signed-off-by: here." test might be a
> sufficient real-world issue.
>
>> I would say that it would be a disaster, if we took any random
>> line with colon : in it in the middle of the commit message and
>> mistook it as a trailer (like the line above), but since we do not
>> allow paragraph breaks in the trailer block, as long as the message
>> has a valid trailer block, it might not be a huge issue.  I dunno.
>
> Yes, it would be fine if the paragraph was two or more lines long, but
> not if it's a single line.

OK, so it seems that we want to fix the documentation, and we have
sufficient test coverage (I didn't notice that Max needed to adjust
the tests to accomodate the new "loose" definition when I wrote the
message you were responding to).

THanks.
