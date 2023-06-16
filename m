Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25AEEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 16:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjFPQDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFPQDt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 12:03:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2651BC9
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 09:03:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D84423272;
        Fri, 16 Jun 2023 12:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OaSwqUiej6qKEPWBw1JTxxIxtm1Uor5vaoWMx3
        mT94E=; b=YUKZPspFU8Ei88UfehRLHa5GhBquGULN2McruqzJRCNLkiFYVZvk8P
        8cjrrvo/Uq7xmKvDvRI59uQK8E1gW2g8GVhb5Rxg1Ka48cYyW9z3KvYW0hY70/+r
        aLk3Qe2qc9POtghaIqGAtK5kYRI9Bfnhsjaam2IMYU/nakxP4hd1o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1672D23271;
        Fri, 16 Jun 2023 12:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2098123270;
        Fri, 16 Jun 2023 12:03:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] setup.c: don't setup in discover_git_directory()
References: <pull.1526.git.git.1686771358484.gitgitgadget@gmail.com>
        <9a7602ba-6903-a94a-3bb5-e51c76f08058@gmx.de>
Date:   Fri, 16 Jun 2023 09:03:42 -0700
In-Reply-To: <9a7602ba-6903-a94a-3bb5-e51c76f08058@gmx.de> (Johannes
        Schindelin's message of "Fri, 16 Jun 2023 13:50:22 +0200 (CEST)")
Message-ID: <xmqq1qibs8bl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E7906C6-0C5F-11EE-A4FA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> As explained by 16ac8b8db6 (setup: introduce the
>> discover_git_directory() function, 2017-03-13) and the comment on its
>> declaration, discover_git_directory() is intended to be an entrypoint
>> into setup.c machinery that allows the Git directory to be discovered
>> without side effects, e.g. so that read_early_config() can read
>> ".git/config" before the_repository has been set up.
>>
>> Fortunately, we didn't start to rely on this unintended behavior between
>> then and now, so we let's just remove it. It isn't harming anyone, but
>> it's confusing.
>>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>
> As the author of the commit whose rationale was quoted above, I am
> delighted to provide my ACK to both commit message and diff.
>
> Thanks,
> Johannes

Thanks, both, for writing and reviewing.

Queued.

