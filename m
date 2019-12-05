Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67783C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 14:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCA021823
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 14:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cZ6iRO9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfLEONg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:13:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50264 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729426AbfLEONg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 09:13:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CF3F198A2;
        Thu,  5 Dec 2019 09:13:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1yaPWy/Hgmw55pL1k8xcRl8Vfgg=; b=cZ6iRO
        9D03s9dN8wG7jcjZVOa/5kSoORn9HtbH36Rdh/lzJEyLY45c70Tlg8g+unQjDT3A
        lhCXZOfWRzuOF+mYDv7FL/Qa3cP+zLLVxl/PlDapX2G2PzDrSdKw+5njXg1JMCeb
        Px/6ce55B7GiLs/6/AhNn5zEOAjrF8/lj/Sw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W8c3Y0b4ZqEk7p4Sboilk88qkyNJWWls
        WFk/M6LLiMXrVpcYPe45YupfoBOYHiQ7SOW61QBEOsTk1vW/4i3mYKIY6AfX4khx
        nUzmXxl6NpZxvfcOdIjTMbqkY5hye2ERWYHjubTo3UVajfkfj/CjPY0EXmD4uDd/
        tG8cTCpZtwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5469C198A0;
        Thu,  5 Dec 2019 09:13:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B55521989D;
        Thu,  5 Dec 2019 09:13:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ryenus via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ryenus <ryenus@gmail.com>
Subject: Re: [PATCH 1/1] fix-typo: consecutive-word duplications
References: <pull.482.git.1575517503.gitgitgadget@gmail.com>
        <abb9e55ad5ef72242ee97e03316827b55ef2f4c8.1575517503.git.gitgitgadget@gmail.com>
Date:   Thu, 05 Dec 2019 06:13:33 -0800
In-Reply-To: <abb9e55ad5ef72242ee97e03316827b55ef2f4c8.1575517503.git.gitgitgadget@gmail.com>
        (ryenus via GitGitGadget's message of "Thu, 05 Dec 2019 03:45:03
        +0000")
Message-ID: <xmqqblsm273m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6C806D34-1769-11EA-82B5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ryenus via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ryenus <ryenus@gmail.com>
>
> Correct unintentional duplication(s) of words, such as "the the",
> and "can can" etc.

Understood.

I would rather honor the original when it is not clearly wrong,
misleading to readers or prone to misunderstanding.  Hence, I'd
rather not change this particular one.

> "we didn't do so so far" becomes "we didn't do that so far".

And also this one.

>   * This should use the pathname to decide on whether it wants to do some
>   * more interesting conversions (automatic gzip/unzip, general format
> - * conversions etc etc), but by default it just does automatic CRLF<->LF
> + * conversions etc), but by default it just does automatic CRLF<->LF

Everything else in this patch is improving what is clearly wrong and
is very much appreciated, though.

Just a reminder, as I do not know your cultural background so ryenus
in all lowercase may be your real name, in which case please ignore
this part of the response, but Documentation/SubmittingPatches says

    [[real-name]]
    Also notice that a real name is used in the Signed-off-by: line. Please
    don't hide your real name.

about the Signed-off-by: line.

Thanks.
