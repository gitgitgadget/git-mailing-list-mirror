Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C327BC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441922225D
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o1HgzeCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409455AbgJTUZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:25:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50798 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409452AbgJTUZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:25:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6DE3FA5DF;
        Tue, 20 Oct 2020 16:25:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ko41ZGCe1By82kqQcjMeVWGhYuI=; b=o1Hgze
        COanf8kZP8umF/C0pgX9N02PfDoX5lCw6kMr4sdxlNAab4jYwpsW2GNXlYgF0MEB
        h78fEbef/HhpwsRP+1S3xhtkQ0m/gky7t2WhV6c5jkPsOqRJLAZiMJ9rDhtZEZP4
        aKl7ACh0BRBZrddpL0cPLvzaDb1k0qGEzyKsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jpsldjLE3EKbpfftzcrTjHFTJKg7SkpU
        oIqP/1tY7qAmp7/vToenrFTSMpi5aJ9uCQbv5oQl4KQdSaeLUycYx9/WkZpfkzN2
        h6vOJQa1T52ifjSZA8LLvegGDnWgWPkAaW66PEGJSKGE/FGUhDtACmQroMIFZRwB
        6wSLoh8mhMg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CFCECFA5DE;
        Tue, 20 Oct 2020 16:25:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29026FA5DD;
        Tue, 20 Oct 2020 16:25:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        congdanhqx@gmail.com
Subject: Re: [PATCH v4] t7201: put each command on a separate line
References: <20201017075455.9660-1-charvi077@gmail.com>
        <20201020121152.21645-1-charvi077@gmail.com>
        <xmqqa6wgbqpq.fsf@gitster.c.googlers.com>
        <20201020201535.GB75186@nand.local>
Date:   Tue, 20 Oct 2020 13:25:33 -0700
In-Reply-To: <20201020201535.GB75186@nand.local> (Taylor Blau's message of
        "Tue, 20 Oct 2020 16:15:35 -0400")
Message-ID: <xmqq1rhsbq6a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68B2F334-1312-11EB-94DF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Oct 20, 2020 at 01:13:53PM -0700, Junio C Hamano wrote:
>> Charvi Mendiratta <charvi077@gmail.com> writes:
>>
>> > Modern practice is to avoid multiple commands per line,
>> > and instead place each command on its own line.
>> >
>> > Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>> > ---
>>
>> This looks good, but I am wondering what happened between v3 and
>> v4.
>
> When I applied this locally, I used this patch as a replacement for the
> last patch of v3 [1]. That kept everything passing after each patch.

Oh, so this is a replacement for 5/5 and 1-4/5 of v4 are supposed to
be identical to those from v3?  The difference between [v3 5/5] and
this one is a single typofix on the subject line, it seems, though.

>> As you've demonstrated through the microproject that you can now
>> comfortably be involved in the review discussion, I am tempted to
>> suggest that we declare victory at this point and move on, but I
>> don't know what the plans are for the other 4 patches (I guess we
>> won't miss them that much---the micros are meant to be practice
>> targets).
>
> Yup, ditto.

As [v4] single patch won't apply standalone, we cannot quite declare
the victory yet.  Are [v3 1-5/5] (or [v3 1-4/5] + [v4]) good to the
reviewers of the past rounds?
