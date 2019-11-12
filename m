Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0226B1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 07:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbfKLHFm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 02:05:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59423 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLHFl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 02:05:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02CB59048F;
        Tue, 12 Nov 2019 02:05:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=76m6u35UXkps5t4ZJ9dnK1HnCVU=; b=DuUpN8
        4vRk6+q9R0WRa7FkhAdw2QadvGwtKpOCX8hLooDFa0tejWxUu0ASkwF3D0H8CLO1
        jww5kvyIfu97UaXLmKkUIgibOGZZophUn9Y3qsZtQdqnFJheDb/O9drT1jjfDa1H
        fyEPJ+upRYQ2rcoNvYIeFCGAlXulqOOWprnbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NbSQKAkCdhjKSIsmkQ+IpBnCBOH+7+7n
        EYYlXnrcK9kOxx+brr7FI9ZX/pIDjl4QZoW7NmR79YSuUrPuRLrskBtzaAhoG+3h
        7BijN5jqk4IbzT3gKOCuqmOBHmB9DV0zg+R6dq5OaL1BcYXDQp+ZZIllVL3Ordap
        g7wo+wFKJrY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F04019048E;
        Tue, 12 Nov 2019 02:05:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 299C09048C;
        Tue, 12 Nov 2019 02:05:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v3 12/21] cache: move doc to cache.h
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <1eca7099efeb6f57be646351d19baaf636a31b2b.1573507684.git.gitgitgadget@gmail.com>
Date:   Tue, 12 Nov 2019 16:05:35 +0900
In-Reply-To: <1eca7099efeb6f57be646351d19baaf636a31b2b.1573507684.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Mon, 11 Nov 2019 21:27:55
        +0000")
Message-ID: <xmqqr22defr4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3F9953C-051A-11EA-87B2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index 321c0ba6a4..6629122703 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -119,9 +119,8 @@ parameters provided by the user over the CLI.
>  
>  `nr` represents the number of `rev_cmdline_entry` present in the array.
>  
> -`alloc` is used by the `ALLOC_GROW` macro. Check
> -`Documentation/technical/api-allocation-growing.txt` - this variable is used to
> -track the allocated size of the list.
> +`alloc` is used by the `ALLOC_GROW` macro. Check `cache.h` - this variable is 
> +used to track the allocated size of the list.

Trailing whitespace.
