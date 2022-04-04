Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA7AC433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 00:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376782AbiDDAIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 20:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376776AbiDDAH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 20:07:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A953733A23
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 17:06:03 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8740E11E109;
        Sun,  3 Apr 2022 20:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mEQqNEXG3KTNVbSJfLv3HSffvYzZlWMc/80RHg
        L/H40=; b=l8BGGz/0A/SsXXr3BODxk1p3EeTcZvEs4kd8+5z3Puut8zJXJdcEZ5
        FmFKblu+21iYqkg92+uXINgtvuqJKigAZNsVZARQsSXGUP9ityEaKadyyaM3/WfI
        ZiF3rkJIjzBEl/S+vByCvGgmZpWmGaJXg7uJ01h/y/SIvtKHZGTic=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F5F811E108;
        Sun,  3 Apr 2022 20:06:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B90D11E106;
        Sun,  3 Apr 2022 20:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 0/4] Importing and exporting stashes to refs
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220403182250.904933-1-sandals@crustytoothpaste.net>
Date:   Sun, 03 Apr 2022 17:05:59 -0700
In-Reply-To: <20220403182250.904933-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 3 Apr 2022 18:22:46 +0000")
Message-ID: <xmqqtub9soew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 030603C4-B3AB-11EC-BBBE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Changes from v2:
> * Fix uninitialized strbuf.
> * Avoid C99-style initializations.

Thanks.

[1] is a CI run of 'seen' without this topic, while [2] is the same
but with this topic.

t3903.115-117 (stash export) are not very happy in the latter.

e.g. https://github.com/git/git/runs/5808828105?check_suite_focus=true#step:7:6623

[References]

*1* https://github.com/git/git/actions/runs/2086776970 
*2* https://github.com/git/git/actions/runs/2086887176 
