Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5609ECD4935
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 23:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjITXJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 19:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjITXJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 19:09:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D91A3
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 16:09:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DA3E1A9730;
        Wed, 20 Sep 2023 19:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=B2PHdcPuS3UnEyMFjxlMNoVC4k4nRfdnOecti0
        BftRg=; b=YbdMkoT4rkGjashirRNtuvMi3kNDx9GOmq2RYbv1tjn6DDw6Oj/tjf
        DF/fy1XOYy1bZOxA6D4CFhjI0s5SstIaSbwDNa2KBs0CLEK6QFNZmGNzBGAUHlsy
        iHDbOhqrxr92An8IL1ujLFCg3GGfmt6tb1i/JslkqPOrxCVp7f6wM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 649D41A972F;
        Wed, 20 Sep 2023 19:09:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C36291A972E;
        Wed, 20 Sep 2023 19:09:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/2] t/t6300: introduce test_bad_atom()
In-Reply-To: <xmqqy1h078tf.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        20 Sep 2023 15:56:28 -0700")
References: <20230920191654.6133-1-five231003@gmail.com>
        <20230920191654.6133-2-five231003@gmail.com>
        <xmqqy1h078tf.fsf@gitster.g>
Date:   Wed, 20 Sep 2023 16:09:21 -0700
Message-ID: <xmqqttro787y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC5CFF94-580A-11EE-9B5E-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +	case "$1" in
>> +	head) ref=refs/heads/main ;;
>> +	 tag) ref=refs/tags/testtag ;;
>> +	 sym) ref=refs/heads/sym ;;
>> +	   *) ref=$1 ;;
>> +	esac
>
> Somehow this indirection makes the two examples we see below harder
> to understand.  ... It does not help that both 'head' and
> 'sym' refer to a local branch ...

Ah, this "sym" thing is a (rather unnatural) symbolic ref inside
refs/heads/ hierarchy, so the naming makes halfway sense.  As it is
also used in test_atom, I no longer find it all that much disturbing.

Everything else I said in my review still stands, I would think.

Thanks.
