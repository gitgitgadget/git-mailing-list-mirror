Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAE0C433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 22:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbiF0WLp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiF0WLo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 18:11:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD3813E8F
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 15:11:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE4EF131619;
        Mon, 27 Jun 2022 18:11:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EpyMDrd/R/d/e3GCDJIlxzhVhoRIaLxrmPFayz
        V8P1c=; b=oa47kUnoJ5sRiK2KflUQmkXaZ8hwwe+PjS6aHL1DFr3VLPTMq2ex85
        Q/Biyv29HHQI89lIInXyBgmZvobc2Mt82n8rxfcj3haVXwnssGJQ8kZ12P+gXfc5
        s6RbZSwglP+IqTYykBFe3i7twZBG2dkXGp0eAKz1MBF3M4ktyf9CQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E52E1131615;
        Mon, 27 Jun 2022 18:11:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C82D131614;
        Mon, 27 Jun 2022 18:11:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 12/16] bisect: teach the `bisect--helper` command to
 show the correct usage strings
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <5dbe233e4ec2f404bb236a8ee71d24e8cb6a4387.1656354677.git.gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 15:11:41 -0700
In-Reply-To: <5dbe233e4ec2f404bb236a8ee71d24e8cb6a4387.1656354677.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 27 Jun 2022
        18:31:13 +0000")
Message-ID: <xmqqwnd1n4de.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1FDD1B7E-F666-11EC-8DA6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In preparation for `bisect--helper` graduating to become the actual
> `bisect` command, we hereby teach it to print the very same usage
> strings as the scripted `git-bisect.sh` does.

Sounds good.  If we stop the series at this stage, a misimplemented
caller might give us an awkweard output, but we are not expecting
end-users to invoke "git bisect--helper -h" to begin with, so it is
perfectly OK.  Somewhere during the journey to fully move it to
builtin/bisect.c this needs to be done, and this step may probably
be the right spot in the series.
