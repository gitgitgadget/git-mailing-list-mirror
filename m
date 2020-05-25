Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51545C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 18:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1312071C
	for <git@archiver.kernel.org>; Mon, 25 May 2020 18:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wgx+w0Kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbgEYSNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 14:13:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58651 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387644AbgEYSNc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 14:13:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75C8A6DB0D;
        Mon, 25 May 2020 14:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wf6fvZjDEwccF1LkfmA6mL+xAf4=; b=wgx+w0
        KzbWF9mN0Tx3w0sr2JdKwWAZdQB7q8zljoIp9QTNz7Ug726wWwsIqW/sUtdtmJxQ
        uso67ktGxPZiwPBFuxkuUrqv0JA+BzeRqkfOUoWpiiuLsqYfpAKQzOXRKoDIGwSp
        JZjI7722FbqgZlPQ7KDyWpM0iOyDsWZpZuerM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xL/uaXydDuef/YZHBw1iAxQt0Y04rIhz
        PLbHYgtKE189ENcLNCc/1GvrRyGOG3QLRvFemz8C1ghZ8h6F+F838KJJZ7fKJXyE
        O7WYNWTKrlZ/TxOOQsOL7VXhnv7KnL6mWyJE+d0Svu9ITRwg8MwaV5LcOJ/xudV+
        P3QjoRo/UTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B9166DB0C;
        Mon, 25 May 2020 14:13:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7B4A6DB0B;
        Mon, 25 May 2020 14:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #08; Sun, 24)
References: <xmqqh7w4pulj.fsf@gitster.c.googlers.com>
        <20200525172708.GT6611@pobox.com>
        <20200525175309.GD1915090@camp.crustytoothpaste.net>
Date:   Mon, 25 May 2020 11:13:29 -0700
In-Reply-To: <20200525175309.GD1915090@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 25 May 2020 17:53:09 +0000")
Message-ID: <xmqq8shfq3w6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FC4310C-9EB3-11EA-AF4A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think since this is an anchor link it's just fine to change for
> compatibility.

Given that no other document in tree seems to point at the anchor, I
think the patch is probably OK.

Thanks.
