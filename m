Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27870C77B7A
	for <git@archiver.kernel.org>; Tue, 16 May 2023 17:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjEPRyc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 13:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEPRya (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 13:54:30 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F188688
        for <git@vger.kernel.org>; Tue, 16 May 2023 10:54:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B498A18E803;
        Tue, 16 May 2023 13:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QzZ+yHPP4nazVtTA6rRThEUkjlDky9rO4MbRSx
        wcCJo=; b=R5GsdOIRuCWJQVvwFz5oP5DQ6O3OAHzzs1yphWFWhwMi4EGSNFbcXP
        4yng0exjZVAPvh4mKTt4YZm8XA0ZoZrDeOU8Ykw+eViPTjycFEwhasH5u/CaryGa
        L21Hiv1fnLEwq0JyLzCbpzEPFbdNs3ZGEHFbdoz2JVgXZlDm2XjWg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC79118E802;
        Tue, 16 May 2023 13:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1547218E801;
        Tue, 16 May 2023 13:54:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] git-compat-util cleanups
References: <20230516170932.1358685-1-calvinwan@google.com>
Date:   Tue, 16 May 2023 10:54:16 -0700
In-Reply-To: <20230516170932.1358685-1-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 16 May 2023 17:09:25 +0000")
Message-ID: <xmqqbkikuppz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADCFD214-F412-11ED-BC62-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> This series focuses on cleaning up and reducing the scope of
> git-compat-util.h by moving headers to their respective files and
> separating out functionality from git-compat-util.h to a new file,
> common.h. I go into more detail in patch 3 as to why I believe this
> separation is useful. 
>
> By the end of this series, git-compat-util.h includes common.h which
> includes wrapper.h and usage.h. Since virtually every file includes
> git-compat-util.h and the large majority of files use functions defined
> in common.h, wrapper.h, and usage.h, I believe it makes sense that those
> are also automatically included with git-compat-util.h.
>
> While this series does not intend to draw clearer boundaries for
> common.h, I am open to ideas for how it can be cleaned up more and if
> there is a better name for the file. 

This seems to have been based on 'master' around Apr 25th of this
year, like 0807e578 (Merge branch 'en/header-split-cache-h',
2023-04-25).  If this were written some time ago and have been
tested internally at $WORK or something, *not* rebasing on a later
tip of 'master' (which you did) is good, but at the same time, it
would be nice to hear on which commit the series is designed to be
applied.  To prepare for the start of the next cycle, however, it
may be even better to rebase it on the tip of more recent 'master'
and test it internally (again), and sending the result out as v2
would very much be appreciated ;-)

Thanks.


