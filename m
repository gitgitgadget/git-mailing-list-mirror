Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164C5C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 19:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357184AbiASTtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 14:49:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60413 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357177AbiASTta (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 14:49:30 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18BD4F3781;
        Wed, 19 Jan 2022 14:49:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KXrNMMfEDrGF3Webz5ENcsvYa2GDY9BU/1gcxl
        ZGJOo=; b=GVskc2H0wpD3gS56h4TfQE+klcTa2dbky7qG/BIJbzPgaZFdq8YADc
        dmPIr77E6wMFUjd/gB560d1/ZOlQDfYNy9wflLzdx362ISyA9jvSjyYHepNpcsi8
        4Gce+f8LKtkeSqNUZdDPhT/ZwRUt0OdppxLTJP+Ojk95NduRZKWoE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D1FFF3780;
        Wed, 19 Jan 2022 14:49:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71A6DF377F;
        Wed, 19 Jan 2022 14:49:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Frederic Tessier <ftessier@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Dangling copyright in git hook template
References: <CAB7QKarvGGjNf-bvuKqwnAVT_wX_=J+Dh0-AEdKPdVMbkSzW3Q@mail.gmail.com>
Date:   Wed, 19 Jan 2022 11:49:28 -0800
In-Reply-To: <CAB7QKarvGGjNf-bvuKqwnAVT_wX_=J+Dh0-AEdKPdVMbkSzW3Q@mail.gmail.com>
        (Frederic Tessier's message of "Wed, 19 Jan 2022 12:51:34 -0500")
Message-ID: <xmqqbl07mrp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA352DC2-7960-11EC-A2E6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Frederic Tessier <ftessier@gmail.com> writes:

> What did you expect to happen? (Expected behavior)
> New repo initialized containing no copyright claims
>
> What happened instead? (Actual behavior)
> New repo initialized with a copyright claim in .git/hooks/pre-rebase.sample:
> # Copyright (c) 2006, 2008 Junio C Hamano

Because the sample files are copied verbatim, with or without such
copyright notice message, they are copyrighted by their respective
copyright holders.  And their modification and distribution should
follow the same licensing terms (i.e. GPLv2) as our source files.

Removing that single line would not change anything, as these days
the written copyright notice is optional across the globe.

We could probably stop shipping these .sample hook files, or the
users can ignore them with the same ease.

I dunno.  An alternative position on the other extreme is to find
and convince all the copyright holders of template/, relicense these
files under less restrictive license _and_ state the license clearly
in each of these files.  I think that ought to be our long term
direction.

Thanks for bringing this up.
