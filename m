Return-Path: <SRS0=sBbF=2V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2BFC2D0C2
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 19:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56276206DA
	for <git@archiver.kernel.org>; Tue, 31 Dec 2019 19:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n/CNuYkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfLaTHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:07:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54875 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLaTHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Dec 2019 14:07:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAC011B253;
        Tue, 31 Dec 2019 14:06:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gMLXITbhWikeoVSPTg19tSEN4vg=; b=n/CNuY
        kOB61vHfucoLCTs1B6t2hbMv4LAoRW9TgSY9anLIZwOzf4u4HUCk9KvnBx5FtDC3
        P8JSV0GIQpiUVpzJ/ABaB8p8lGFX2fB8j41obNmpKM0dgzfbV0GnF9Gsit9JzRqS
        DJK1fzK49NOirc+jXySk9oazGqQvVRhpxTeVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mpYde8FSuQWrX7v5wlnhdhJba5VwopTA
        SXjChMjJwoG8t5gOsL5HQW3wAGWo+RinNlhOrn6WaXFda4/lauK2U/gZ+mSsS4Ng
        WoA3N7A2BeWx665ljB2HDN2fZ6rrRuAHwmjUIGIgxe2imr6Ok2AvHArxEmJ/UpdO
        Z3zw1oKt9vo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D01CA1B252;
        Tue, 31 Dec 2019 14:06:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3BF8C1B24F;
        Tue, 31 Dec 2019 14:06:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, heba.waly@gmail.com
Subject: Re: [PATCH v2 1/1] commit: display advice hints when commit fails
References: <xmqqbls4aznl.fsf@gitster-ct.c.googlers.com>
        <20191231000420.32396-1-jonathantanmy@google.com>
Date:   Tue, 31 Dec 2019 11:06:55 -0800
In-Reply-To: <20191231000420.32396-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 30 Dec 2019 16:04:20 -0800")
Message-ID: <xmqq7e2cfh68.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B68EC320-2C00-11EA-8A57-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> In any case, here is what I tentatively have in my tree (with heavy
>> rewrite to the proposed log message).
>
> Junio, what are your plans over what you have in your tree? If you'd
> like to hear Heba's opinion on it, then she can chime in; if you'd like
> a review, then I think it's good to go in.

On hold until anything like those happens ;-) 

A random reviewer mentioning something on a patch (either in a
line-by-line critique form or "how about doing it this way instead"
counterproposal form) without getting followed up by others
(including the original author) is a stall review thread, and it
does not change the equation if the random reviewer happens to be me.

>> I didn't try it on my end. Maybe it won't help much, because we think
>> we're going to use the editor right up until we realize it's not
>> committable?
>
> And I think the answer to that is "s" is used throughout the function in
> various ways (in particular, used to print statuses both to stdout and
> to the message template) so any wrapping or corralling of scope would
> just make things more complicated. In particular, the way Heba did it in
> v2 is more unclear - at the time of setting s->hints = 0, it's done

You mean "less clear" (just double checking if I got the negation right)?

> within a "if (use_editor && include_status)" block, but (as far as I can
> tell) the commit message template might also be used when there is no
> editor - for example, as input to a hook. And more importantly, when
> s->hints is reset to the config, we don't know at that point that the
> next status is going to stdout. So I think it's better just to use the
> v1 way.

Yeah, thanks for going back to compare v1 and v2, and I agree with
your assessment.

> The second area of discussion I see is in the commit message. Commit
> messages have to balance brevity and comprehensiveness, and this can be
> a subjective matter, but I think Junio's strikes a good balance.

As one side of the comparison is my own, I won't be a good judge on
this, but yes I tried to strick a good balance as much as possible.

I think I've merged it to 'next' yesterday, but it does not mean
that much as we are in -rc and it is not such an urgent "oops we
broke it in this cycle, let's fix it" issue.  If we see a v3 that
improves it, I do not mind at all reverting what I merged to 'next'
and use the updated one instead (either way, it will be in 'master'
during the next cycle at the earliest).

Thanks.
