Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED65C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4749261428
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 23:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhDUXk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:40:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51692 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbhDUXk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 19:40:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E22A1A97F9;
        Wed, 21 Apr 2021 19:40:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=foo+63fUhRXM2ZxfL2xYWiev2ps=; b=FsqV74
        AhMhzKrxW2Ip4Q3ZWzOS7EWWMkUtyowqW0aCvqmrvhJIiaD49YFRnBGBPTXs4ND4
        n16nfsbDnsXgCVYoid68xgK1a2/KCCYozi2GkigiKx37rhFDTXZKHqqRiwRRxJFm
        2HgsAdjqVMGQRZeZ+8zilm7q9S6UvxFSYoZuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YdEwDY3r40rZ+1WL0b0bchFkvRgdVNRv
        9OS38qcfgHYUv9/C3EsxvZecFvsb4P4H3pNZaPfvi/Wx5mRGqPQZdxgjAW8E29W3
        pPjoDmY9ysKMF8zYtUVFX3JxkyqBskZPfJH0pvItQzCupLo0IlgAFjwHJfVwUAnb
        pspPSFl3jyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2CB1A97F8;
        Wed, 21 Apr 2021 19:40:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30B3EA97F7;
        Wed, 21 Apr 2021 19:40:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v11 0/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <pull.913.v11.git.1618672417.gitgitgadget@gmail.com>
        <xmqq5z0kbl8x.fsf@gitster.g>
        <CAOLTT8RKCV+Kpya-_AVjuVGWzs1WtGS8n_+sD0FVzwEpeXGwCw@mail.gmail.com>
        <xmqqfszk1ot6.fsf@gitster.g>
        <CAOLTT8QUA+m1W6-v=ZA205SZo8G5GBKMzJHBzU8DuQSTKiPUBw@mail.gmail.com>
Date:   Wed, 21 Apr 2021 16:40:22 -0700
In-Reply-To: <CAOLTT8QUA+m1W6-v=ZA205SZo8G5GBKMzJHBzU8DuQSTKiPUBw@mail.gmail.com>
        (ZheNing Hu's message of "Wed, 21 Apr 2021 13:47:38 +0800")
Message-ID: <xmqq1rb3xl3t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0E7E87C-A2FA-11EB-8484-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> I admit that your idea makes sense, but we actually have another requirement:
> Construct a trailer with an empty value.

It can be done with a different script given to .cmd, which would
say "exit 0" when allowing an empty string given as its input to
appear in the output.

I was reacting what the "count" example does, and found that
counting commits by all authors (that is what an empty string would
match when given to --author="") somewhat illogical in the context
of that example.

After all, these examples are to pique readers' interest by
demonstrating what the mechanism can do and how it can be used, and
for this feature, I think showing that

 (1) we can squelch the output from unasked-for execution;

 (2) we can reject --trailer=<key>:<value> when we do not like the
     given <value>;

 (3) we can insert the trailer with the value we compute (and it is
     OK for the computed result happens to be an empty string).

should be plenty sufficient.
