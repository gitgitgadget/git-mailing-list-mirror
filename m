Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF3C47095
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 17:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3222F206DD
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 17:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xZ6bVoei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgJCREc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 13:04:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60327 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgJCREc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 13:04:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED122823E0;
        Sat,  3 Oct 2020 13:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ed8Kbj8uUdTEWOvVKt0msp+nJ4E=; b=xZ6bVo
        ei4CITt7Fp7dFnNFJiLf4T3yP+xHBYb7t513ujjOSSxwKguiWw0KcTXwC7YsXCya
        jlKnlmqu7Z55EAbZVjUu3KR0mwIa/w59QhSHhl0DV1p662hKmNIZk32oHN8B4WnP
        58TrSJ1xStHY7V08xsBBwI+B+ZLdpX71TTuqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RVJg3ep0X+0CUCN8qfCwipAXFGzYVcLV
        hhfYAtdrbU8uspFWYgmwLplYdoWic8dYG/qj7YO5wkZhw4nfespqt33ggU1L6L9k
        SsERpPilUDk+3b83Jorjagh8MI3TKMllKE9FrgRsbuEnhpo31ewhW78J7lcxmyOX
        un7vO9ab0F0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5208823DF;
        Sat,  3 Oct 2020 13:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77B1B823DE;
        Sat,  3 Oct 2020 13:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
Subject: Re: [GIT PULL] gitk update
References: <20201003092010.GC3089868@thinks.paulus.ozlabs.org>
Date:   Sat, 03 Oct 2020 10:04:28 -0700
In-Reply-To: <20201003092010.GC3089868@thinks.paulus.ozlabs.org> (Paul
        Mackerras's message of "Sat, 3 Oct 2020 19:20:10 +1000")
Message-ID: <xmqqy2kn8cmb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FF8CE5E-059A-11EB-9199-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@ozlabs.org> writes:

> Hi Junio,
>
> Whenever it's convenient for you, please do a pull from my gitk
> repository at git://ozlabs.org/~paulus/gitk.git to get 6 commits
> updating gitk.
>
> Thanks,
> Paul.

Will do.  Are these the six you mentioned, or am I missing some
other commits?

    $ git log --first-parent --oneline ..paulus/master
    6cd80496e9 gitk: Resize panes correctly when reducing window size
    e244588eb6 gitk: replace tabs with spaces
    a99bc27aec gitk: fix the context menu not appearing in the presence of submodule diffs
    2faa6cdc5e gitk: Un-hide selection in areas with non-default background color
    113ce1243f gitk: add diff lines background colors
    e272a77964 gitk: be prepared to be run in a bare repository
    c1a63459ed gitk: Preserve window dimensions on exit when not using ttk themes
    f177c49a97 gitk: don't highlight files after submodules as submodules
    d4247e0602 gitk: fix branch name encoding error
    b8b60957ce gitk: rename "commit summary" to "commit reference"

Thanks.
