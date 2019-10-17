Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4A6D1F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 07:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438315AbfJQHiz (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 03:38:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59855 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfJQHiy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 03:38:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B62108AACA;
        Thu, 17 Oct 2019 03:38:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9CicVFcvR988xP+vMVa2A8+v9FY=; b=fAljEi
        3STTR5w581xKGnJ/SHor+19Zq4IN+WnMrZdxUu3kkuTmKnqAD758EKb0k/xP9uu8
        E0wX4iJsfpDvViFUHpPc4KVS5QmQLWFutLmxTwgkl4EGlDRBQs4V7hZ5ISWm+mFv
        HUz2zvaQoSlQnrcZSPfwsB9WcP8tAUKmPRl0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FaIUhDISdZIowVeu3R9iLMhGZjIzoaw1
        5cYOXMs0RsttoYESF8Bj4Y39fgD46vmQ4qmtjYQEBDNdvZqFRbeZOqQQccw+gBHP
        gwzB0Zdj37dFBsFXLGO6RcOiTY9cIb5QeNZfKZ35liRp33v4ByXbP2x9OYlY/5bC
        AClSycIk9Fc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A39978AAC9;
        Thu, 17 Oct 2019 03:38:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C57288AAC7;
        Thu, 17 Oct 2019 03:38:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/1] builtin/blame.c: constants into bit shift format
References: <pull.382.git.1571250635.gitgitgadget@gmail.com>
        <3b4b8e0353d705ea649c9fb608c021b35e6d8f5b.1571250635.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 16:38:48 +0900
In-Reply-To: <3b4b8e0353d705ea649c9fb608c021b35e6d8f5b.1571250635.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Wed, 16 Oct 2019 18:30:35
        +0000")
Message-ID: <xmqqr23b7ref.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2989275C-F0B1-11E9-9CEA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -#define OUTPUT_SHOW_AGE_WITH_COLOR	04000
> +#define OUTPUT_ANNOTATE_COMPAT      (1<<0)
> +#define OUTPUT_LONG_OBJECT_NAME     (1<<1)
> +#define OUTPUT_RAW_TIMESTAMP        (1<<2)
> +#define OUTPUT_PORCELAIN            (1<<3)
> +#define OUTPUT_SHOW_NAME            (1<<4)
> +#define OUTPUT_SHOW_NUMBER          (1<<5)
> +#define OUTPUT_SHOW_SCORE           (1<<6)
> +#define OUTPUT_NO_AUTHOR            (1<<7)
> +#define OUTPUT_SHOW_EMAIL           (1<<8)
> +#define OUTPUT_LINE_PORCELAIN       (1<<9)
> +#define OUTPUT_COLOR_LINE           (1<<10)
> +#define OUTPUT_SHOW_AGE_WITH_COLOR  (1<<11)

For these small shift counts it probably would not matter, but it
may be a good discipline to make sure they are treated as constants
of an unsigned type (i.e. write them as (1U<<0) etc.).  It probably
starts to matter when you reach 1<<31 if these are bits stuffed into
"unsigned int" on 32-bit arch.

One advantage of octal and hexadecimal notations have is that
0x80000000 is automatically unsigned, IIRC, on such an archtecture.
