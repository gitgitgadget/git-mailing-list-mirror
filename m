Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8941F454
	for <e@80x24.org>; Fri,  8 Nov 2019 03:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbfKHDET (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 22:04:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56908 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKHDES (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 22:04:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 438FF19BE5;
        Thu,  7 Nov 2019 22:04:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+pOOqLNebzHHI1ye4B/aTnrLTSU=; b=WYt28i
        w2g+zwsu4Po1pJtSgt/Z3PULhIVSx1rYwWoB9wvHwuSn10KTaMF/d9ljocPXPmwh
        rUugNEDv7uxdBhuTpaxeiRbw4LqkTQYryZ2f4Y82BtMUIprMhgeM4c3Du4mRfF4/
        CS9JZ2dMpUvchj0XYK0Fc9bV3WLedD0cmsbDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ug3+xdTpHbvq/xkwHPM5yfEzY7WzSxoW
        1TMwoVyLvrj9eb2d0VDVDtAqDXNcR7bCjSNqbrFpCGhwpzZIJPN/H7R5aMxOdKsM
        PgwZ0x5fn35JNU8pGSPSH0mxsVA+N6ld7MyhVDs0Uq5+vWSDlmXOH0RH3ruoUIGJ
        45sQnvvssKw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A44119BE3;
        Thu,  7 Nov 2019 22:04:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 982C519BE2;
        Thu,  7 Nov 2019 22:04:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/5] doc: reset: unify <pathspec> description
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <1740ac7a291cfc81418c2d437201c3373487fa26.1572895605.git.gitgitgadget@gmail.com>
        <xmqqh83hveiz.fsf@gitster-ct.c.googlers.com>
        <b7acd8d1-d17a-29bd-44d3-59d425842c10@syntevo.com>
        <xmqqo8xoqlvf.fsf@gitster-ct.c.googlers.com>
        <5121d118-6a4c-80c1-ccd5-60c3c6b5f6ee@syntevo.com>
Date:   Fri, 08 Nov 2019 12:04:16 +0900
In-Reply-To: <5121d118-6a4c-80c1-ccd5-60c3c6b5f6ee@syntevo.com> (Alexandr
        Miloslavskiy's message of "Thu, 7 Nov 2019 12:05:10 +0100")
Message-ID: <xmqqtv7fnk5r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73D72A5A-01D4-11EA-AE0D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> On 07.11.2019 6:46, Junio C Hamano wrote:
>> I do not know if removal of the only-half-correct "This is the
>> opposite of add" should be part of this change, or it should be a
>> separate fix.  The half-wrong sentene was not introduced by this
>> patch, so leaving it as-is is OK.  It just leaves another thing for
>> us to think about later.
>
> My feeling is that this problem is separate from the topic I'm working
> on. I only touched docs to synchronize <pathspec>, so that I can
> copy&paste new option description in next commit without tailoring it
> to local speech. Also, I must admit that upon reading your
> explanation, I felt that I lack the experience to update the writing
> properly.

Yeah, I do think it is cleaner to leave it as a separate issue.

Thanks.

