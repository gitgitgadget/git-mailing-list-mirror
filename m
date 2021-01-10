Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4554C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 06:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF662388C
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 06:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbhAJG7H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 01:59:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56636 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbhAJG7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 01:59:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 67457116FDA;
        Sun, 10 Jan 2021 01:58:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rQ/CYw2gYNshuw5oVBDzp/J0PXo=; b=BXzKTm
        XG36w0K/Av+xQ9CS7syvRBcrmso4UhzkJado28hVgyqwzM2sbw0or6bbKM8ApXEL
        KJL8LcPUKbTDgDiluPy0eNTLo1cXfwz5d3oJ7TN1xIWBLI4UdtX5SkGavWDocIXG
        kpIT/8TfYrKG2IfF1UTKZnz43/Yis9u+Ux6RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jgAVVe0liwnuKWpfxh1nWP3e2RX1JtyE
        lIbONF+4oOX1hCvCnAPHfplfXHE9AodpFsRXimBw898TN9B1WH6P7RO9WqckwZ1p
        Sk+1Ja5Rhe/5hky2m6b0GspWzgpiFdxiHN7UlPz6R7BYBKMRifwQpNluNTdSEQUA
        sXQjgjDVzvI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 549E0116FD9;
        Sun, 10 Jan 2021 01:58:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEC71116FD8;
        Sun, 10 Jan 2021 01:58:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Utku <ugultopu@gmail.com>,
        Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] doc: remove "directory cache" from man pages
References: <pull.943.git.git.1610124896385.gitgitgadget@gmail.com>
        <X/ilPZ71woYI5vT+@nand.local>
        <EB7BB287-A18B-45FE-B147-F3CF92FE3114@gmail.com>
        <X/i4EMmpCzFVtDiT@nand.local>
Date:   Sat, 09 Jan 2021 22:58:19 -0800
In-Reply-To: <X/i4EMmpCzFVtDiT@nand.local> (Taylor Blau's message of "Fri, 8
        Jan 2021 14:52:48 -0500")
Message-ID: <xmqq5z45cm7o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39FC45A6-5311-11EB-9658-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Jan 08, 2021 at 02:51:05PM -0500, Utku wrote:
>> On the other hand, the document clearly states that the terms "directory
>> cache" and "cache" have been obsoleted by "index", so there is no source
>> of confusion there. On the man pages, there was, which was the reason I
>> felt the need to make this change. I thought that keeping at least one
>> definition of "directory cache" (where this definition clearly states
>> that it is an obsolete term for "index") would be helpful.
>>
>> So what are your thoughts about it? If you think it is better to remove
>> it, please let me know and I will remove it.
>
> I think that is a good reason to leave it as-is. Since you hadn't
> mentioned it in the patch text, I was wondering whether it was an
> omission, or you had intended to leave it that way.
>
> This patch looks good to me as-is.

Yup, I agree with the reasoning to keep the "older documentation may
say dircache".  Will queue.  Thanks.
