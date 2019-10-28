Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1411F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 05:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfJ1Ff1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 01:35:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57979 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfJ1Ff1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 01:35:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5204284E3;
        Mon, 28 Oct 2019 01:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gVTPADtt+skxtCgEfagKujiSJH0=; b=PKYJ3D
        ALabK/ja7KSFWC9F5hGYC5VK4y2R8+iIVvsOYZIGz7MEyrlUK5ZTa05nqld/s/aO
        nuMd3krJHG51iUD0/D/fscVWVx/pw/7uGSDL+oWMj+vCNzHrofdqbqzFaTh7qLxK
        kZJ/TsObwhYtbveoCVvFgO8csV7jUUeAW22ww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pk/ThXWNKlXxpr0ArRgeRy0l9pr+3DmB
        gy55coD1RCwH5BB6/lCRIz6/+arLd/cCPSQP03Tjm+w5lVMLG3I5BBxUlF1TJ4Bz
        9uNM03fA7v1jn5OqpKJYL6u4INTmnFUd9ajRyqLnkYMnYSssAjEmqOfVjNu0vK94
        OVMuOREvTFY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DC9B284E2;
        Mon, 28 Oct 2019 01:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EAE04284E1;
        Mon, 28 Oct 2019 01:35:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] stash: handle staged changes in skip-worktree files correctly
References: <pull.355.git.gitgitgadget@gmail.com>
        <4c684be1794cd0c62cc19d9c9558981584ec3e9a.1569483748.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 14:35:23 +0900
In-Reply-To: <4c684be1794cd0c62cc19d9c9558981584ec3e9a.1569483748.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 26 Sep 2019
        00:42:32 -0700 (PDT)")
Message-ID: <xmqqy2x58mas.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDDAC74E-F944-11E9-9E09-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> When calling `git stash` while changes were staged for files that are
> marked with the `skip-worktree` bit (e.g. files that are excluded in a
> sparse checkout), the files are recorded as _deleted_ instead.

Assuming that 1/2 makes sense to all of us, I think the changes in
2/2 make 100% sense.

Will queue.  Thanks.
