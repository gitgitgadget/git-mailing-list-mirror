Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB0EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 20:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGYUxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 16:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGYUxD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 16:53:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B39E99
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 13:53:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89DCA327B8;
        Tue, 25 Jul 2023 16:53:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vTnSVW5BR0Wh4Br+Yu1GqV2PyKF6hWdZ/l+IHP
        EkiBo=; b=iS/Pt2jYi03f/RRepMph1d/w88LQzGttFqxIqLFCsl20paCNrSU+VO
        lRUmUh7jnQ41/RAj0wlNeRKRC7TpWyYivweixwJGyCtwqnnbAqf7mmndJtqqFL9T
        gx45sWy3tRthb5XBIB/xXuTDXjJs4jWxCUZJofvzacQh/eTbsNlfQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81FC0327B7;
        Tue, 25 Jul 2023 16:53:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 20EA2327B5;
        Tue, 25 Jul 2023 16:52:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
References: <cover.1684790529.git.jonathantanmy@google.com>
        <cover.1689889382.git.jonathantanmy@google.com>
Date:   Tue, 25 Jul 2023 13:52:57 -0700
In-Reply-To: <cover.1689889382.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 20 Jul 2023 14:46:33 -0700")
Message-ID: <xmqqjzunk91y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CF86E78-2B2D-11EE-9718-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, Junio and Taylor, for your reviews. I have included Taylor's
> patches in this patch set.
>
> There seemed to be some merge conflicts when I tried to apply the
> patches Taylor provided on the base that I built my patches on (that is,
> the base of jt/path-filter-fix, namely, maint-2.40), so I have rebased
> all my patches onto latest master.
>
> Jonathan Tan (4):
>   gitformat-commit-graph: describe version 2 of BDAT
>   t4216: test changed path filters with high bit paths
>   repo-settings: introduce commitgraph.changedPathsVersion
>   commit-graph: new filter ver. that fixes murmur3
>
> Taylor Blau (3):
>   t/helper/test-read-graph.c: extract `dump_graph_info()`
>   bloom.h: make `load_bloom_filter_from_graph()` public
>   t/helper/test-read-graph: implement `bloom-filters` mode

Thanks, I seem to have missed this one.  Let's queue this version
and merge it down to 'next', unless there is no other blocking
comments in a few days.

Thanks.
