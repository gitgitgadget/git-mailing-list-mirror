Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16277C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B04A23119
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nf4gUDxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgHFRTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:19:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55582 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbgHFRSp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:18:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 677DB60256;
        Thu,  6 Aug 2020 13:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cnuBL33SOPpQPdT44Sz9+ln2kdI=; b=Nf4gUD
        xXX5CTNzlbLMUJ1P8v4k3WnFeIsf8cBE5J8vNJGO7+nu980zkZdF1zDEbBYlGapA
        Y4C1ceqGQfATgYak+H9wIFQu/th+JeJhDYSywgzNj7kvcsc42xu6CwjdO0aSnDVB
        vmWLGpZ82atN19hsnBS3GmaG8RctPP6EguBO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kI2ar1APBSMiDiLJYm8IwBep8eFlfEQS
        L7oIk/tDEDEvYEkckiL8xwlObQ5VewKvJqMIvR65PYavDGHBg/sNj1IJ7ttYbIOi
        uHhUChjq6LAJQ506bJUOvufbR92narC42dmQH53Y3dFphJ3VVz5E9lNm8YxCmZGt
        NCnBqvFFigI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F30760254;
        Thu,  6 Aug 2020 13:18:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CF57960253;
        Thu,  6 Aug 2020 13:18:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        chriscool@tuxfamily.org, liu.denton@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH 3/4] t7401: ensure uniformity in the '--for-status' test
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
        <20200805174921.16000-4-shouryashukla.oo@gmail.com>
        <xmqq3650ok53.fsf@gitster.c.googlers.com>
        <20200806085043.GB13942@konoha>
Date:   Thu, 06 Aug 2020 10:18:26 -0700
In-Reply-To: <20200806085043.GB13942@konoha> (Shourya Shukla's message of
        "Thu, 6 Aug 2020 14:20:43 +0530")
Message-ID: <xmqqimdvlml9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D71F77A6-D808-11EA-B707-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> On 05/08 02:30, Junio C Hamano wrote:
>> Shourya Shukla <shouryashukla.oo@gmail.com> writes:
>> 
>> > The '--for-status' test got its expected output from stdin. This is
>> > inconsistent with the other tests in the test script which get their
>> > expected output from a file named 'expected'.
>> >
>> > So, change the syntax of the '--for-status' test for uniformity.
>> 
>> There are a handful examples in t5401 and another one in t3700 that
>> give the "golden master" from the standard input.  When the expected
>> output is used only once, I do not think it is particularlly bad to
>> have it this way.  So,... meh?
>
> I realised what you were trying to say after checking out t5400 and
> t3700. I understand that this change may not be immediately needed but I
> think it does make reading the diff a bit easier since having a '-' as a
> file name does get a bit confusing when reading the output. 

If so, perhaps justifying the change based on that, not on
"consistency", would be a good idea.

        Side note: But would that mean you'd find it "confusing" to
        read output from 3700 and 5400?  Would "test writers should
        get used to it" be a workable alternative solution?

Since "test_cmp expect actual" and "test_cmp - actual <<HERE" are
_both_ valid forms that are useful for different situations, I do
not see a compelling reason to insist on one form is consistently
used and ban the use of the other.

So...
