Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276A8ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 18:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiIMS0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiIMS0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 14:26:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F58630E
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 10:44:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28AC4143ED1;
        Tue, 13 Sep 2022 13:44:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L+FkkP/7DFQazn6HjdBjH5VmcR9cZsf7Z8V3B/
        dExGE=; b=R+YXtvkojtxgi3n/TGAdAecZKv3bKk9N9yg6bPCN8P8QhH1z1SUvOW
        /s86AVles44SUh5ejQhgMzFMwHTGvy0Ge70D93FPLd5UgZLu/97FvVv1vAjSL0k2
        ZAeI1CRb0i4SASD1T7Qp+LBe7TdjMreR/uNr4r2zCl+e8FjVDFj7I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CC4F143ED0;
        Tue, 13 Sep 2022 13:44:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65836143EC9;
        Tue, 13 Sep 2022 13:44:13 -0400 (EDT)
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
Subject: Re: [PATCH v6 00/16] Finish converting git bisect into a built-in
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 10:44:12 -0700
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Tue, 30 Aug 2022 18:50:03
        +0000")
Message-ID: <xmqqv8pr8903.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE32A76A-338B-11ED-A5E4-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v5:
>
>  * Fixed the commit message of "bisect run: fix the error message" that had
>    become stale as of v3 due to 80c2e9657f2 "overtaking" it and doing half
>    of its job.
>  * Skipped translation usage strings in "bisect--helper: migrate to
>    OPT_SUBCOMMAND()" that do not contain translatable parts.
>  * Minor white-space clean-up in "bisect--helper: migrate to
>    OPT_SUBCOMMAND()".

Other than "deliberately breaking the first steps that tried a nice
libification that passed 'terms' pair through the codepath could not
be a good idea" thing, we did not see any comments on this round.

Do people not care about this topic, are people all silently happy,
or what?

