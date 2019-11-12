Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ABCE1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 07:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKLHU5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 02:20:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58633 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLHU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 02:20:57 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D1919BB45;
        Tue, 12 Nov 2019 02:20:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=noJoHGgPdrgsBep5J2gDryqh3Ak=; b=E+5/dU
        xOte4aHMvZxKPNIyKkX/cs4yYpIuTWUpMcm1aMyj1rM2PPG7nfFa5qTO9cx/oaCj
        IrW8JhCQyTLmfQfgHhEGUEKefK7U8Q70xoR18XxiHuip6eloO1zTbbhHrnc4hmY6
        hZeZhPprZnKNGdBxI7kFiiIzF30bWQ0l9Jmys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ednWZgUxxVdpmyRHqKsDokYC05lru1y6
        9QhXNZSm/9B8BPUhzhvzWfuBTl6plDBh9AiXQ+Qsq9nWrDeflL8uEOFbtceUK9+j
        /9mF5xbX5/dvcnEZrPHPFtWNg7ESQH9vuBeKZ1ytA+3Vav1B0P8k2WktBCA5bp7t
        ZKf1Ko16V20=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 048939BB44;
        Tue, 12 Nov 2019 02:20:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3353C9BB43;
        Tue, 12 Nov 2019 02:20:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3 01/21] diff: move doc to diff.h and diffcore.h
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <60e80b545f0f74e6fb58b5b6a64ecf3c1bd02d47.1573507684.git.gitgitgadget@gmail.com>
Date:   Tue, 12 Nov 2019 16:20:50 +0900
In-Reply-To: <60e80b545f0f74e6fb58b5b6a64ecf3c1bd02d47.1573507684.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Mon, 11 Nov 2019 21:27:44
        +0000")
Message-ID: <xmqqmud1ef1p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F561AFB4-051C-11EA-A5FA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heba Waly <heba.waly@gmail.com>
>
> Move the documentation from Documentation/technical/api-diff.txt to both
> diff.h and diffcore.h as it's easier for the developers to find the usage
> information beside the code instead of looking for it in another doc file.
>
> Also documentation/technical/api-diff.txt is removed because the information
> it has is now redundant and it'll be hard to keep it up to date and
> synchronized with the documentation in the header files.

> @@ -245,6 +370,7 @@ void diff_emit_submodule_error(struct diff_options *o, const char *err);
>  void diff_emit_submodule_pipethrough(struct diff_options *o,
>  				     const char *line, int len);
>  
> +/* Output should be colored. */

I am not sure the comment belongs here.  Especially if this was
lifted from the description for COLOR_DIFF.

Those preprocessor constants have long been migrated to 1-bit
bitfields in the diff_flags structure and the documentation was left
stale---description on COLOR_DIFF and friends this patch removes from
the doc should be reused to explain these fields, I would think.

Thanks.
