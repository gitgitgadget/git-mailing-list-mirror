Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F3BC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EB760F46
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 18:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhJYSUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:20:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51290 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhJYSUk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 14:20:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0184A16ADF2;
        Mon, 25 Oct 2021 14:18:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LwzqI7nKi2X+kdwptcD/01daAXT33lnu3BLpPq
        +eKMo=; b=OVEnmHnHtYrLx2hpcwSzh7nymGQckyrC9SE6ikhaohmOyEwc3/RB6l
        ebMgWobKRfHxZ8C1fO/bjLHAETp7xnRyYybcVzQOkfm8M8ZmHaETL67RxDoMzZaJ
        pMUuzJ93WB0ZzIKdnzZjTKqO6HwWgczGHKcX7aWc7QxHevkONJqis=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE74716ADF1;
        Mon, 25 Oct 2021 14:18:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5477916ADED;
        Mon, 25 Oct 2021 14:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Git Mailing List <git@vger.kernel.org>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [RFC PATCH] mergetools/vimdiff: add vimdiff4 merge tool variant
References: <20211019212020.25385-1-greenfoo@u92.eu>
        <CAJDDKr5frTgh4_x5yvskJfppew3ntvpgBe9MnUB9CfGQaw1TLQ@mail.gmail.com>
Date:   Mon, 25 Oct 2021 11:18:14 -0700
In-Reply-To: <CAJDDKr5frTgh4_x5yvskJfppew3ntvpgBe9MnUB9CfGQaw1TLQ@mail.gmail.com>
        (David Aguilar's message of "Sun, 24 Oct 2021 15:54:49 -0700")
Message-ID: <xmqqk0i10xzt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBDA0EAC-35BF-11EC-8EA3-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> I'm personally not opposed to the vimdiff4 variants (we already have 3
> others) but what I think might be missing is a bit of documentation
> that documents the builtin tools and their variants.

Hmph, are we encouraging everybody to add yet another variant?  I
wonder if we can stop at adding a single "vimdiffX" variant that
takes the layout information (like the one this vimdiff4 passes to
the underlying tool via the command line option) in a configuration
variable and stop adding more variants, or is vim's specification of
the layout we use here via the command line not flexible enough to
serve all future needs?  I also wonder if all the existing vimdiff
variants can be done in terms of such a vimdiffX implementation.

> Right now git-mergetool.txt includes config/mergetool.txt for
> documenting its config variables. It might be worth having a common
> "mergetools.txt" where the builtin tools and variants can be
> documented and then we can include that file from both
> git-mergetool.txt and git-difftool.txt.
>
> That would be a good place to write up the differences between the
> variants, and the diagram you included in the commit message would be
> helpful there as well.

Yup, in any case, I do like the suggestion to document the variants.

Thanks, both.
