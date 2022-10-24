Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F59DFA373F
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 19:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiJXTx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiJXTxN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 15:53:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E22A436
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:17:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61D9A1B6030;
        Mon, 24 Oct 2022 14:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JnjukhcSzNeGheTTy1wzCPbElZO2lwGRjhfmY1
        8K2bQ=; b=EDrLAEf7bNxv6Tx3ht5U5yp5QBtTCVonNZLEtDOzorlCaV+Nkm1QUK
        CMobGIo4k3KLoErBYOXaBFCaKOEBiaqkxCkgs9Y5fGauqv+zjdqGpJSY2yQ/IfJ1
        q1ZnrNW0n9q/Zm2HdoVYKamI6D89NmtSk9gGmgnNXFm/J+4GBtmIc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B91F1B602F;
        Mon, 24 Oct 2022 14:16:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 871CB1B602E;
        Mon, 24 Oct 2022 14:16:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] fsck: remove the unused BAD_TAG_OBJECT
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
        <f32ff5dc4eed5bffe8bb0759c408c3d0861ddb50.1666623639.git.gitgitgadget@gmail.com>
        <xmqqwn8ptb0p.fsf@gitster.g>
Date:   Mon, 24 Oct 2022 11:16:50 -0700
In-Reply-To: <xmqqwn8ptb0p.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        24 Oct 2022 09:57:26 -0700")
Message-ID: <xmqq4jvtt7cd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08455EEE-53C8-11ED-88A6-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: John Cai <johncai86@gmail.com>
>>
>> The BAD_TAG_OBJECT msg-id is not being used anymore, so we can remove
>> it.
>
> Do you have a ready reference to the change that made it no longer
> needed (or stopped detecting the error the message was meant to be
> issued against)?

2175a0c6 (fsck: stop checking tag->tagged, 2019-10-18) stopped
checking the tagged object referred to by a tag object, which the
error message BAD_TAG_OBJECT was about.  Since then the
BAD_TAG_OBJECT message is no longer used.



