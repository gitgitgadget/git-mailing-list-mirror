Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A80FC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiDMU3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiDMU3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:29:31 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A298A83005
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:27:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5F7D1273F9;
        Wed, 13 Apr 2022 16:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8/PSiI7wO1S55/TzTMiZXmRyt3YECtUYWJi9nC
        NjxUc=; b=vHBst4bJCo9TQsDbSWbS/8ss8GUk7Ph/SbqchyK5zB9VY+RLEjFTSI
        +9zQ/8gpX/hU0vBqla8zj//k0XqQT2miAvZyTDe/25/9mYDaHsSc6joN9inkaHzh
        8x2qC6zgEuQFDfqGpM6N2+Pz8bnDnsZQMPxGPgAF8LBK7zhEb63kI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB9491273F8;
        Wed, 13 Apr 2022 16:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00AB91273F7;
        Wed, 13 Apr 2022 16:27:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH 0/3] Updates to the safe.directory config option
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
        <xmqq35iharig.fsf@gitster.g>
        <e8383303-e82c-dc23-9f28-6ff566021e82@github.com>
        <xmqqee219bly.fsf@gitster.g>
Date:   Wed, 13 Apr 2022 13:27:05 -0700
In-Reply-To: <xmqqee219bly.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        13 Apr 2022 09:44:41 -0700")
Message-ID: <xmqqmtgo7mqu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 168309E6-BB68-11EC-A208-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Derrick Stolee <derrickstolee@github.com> writes:
>
>> I tried to do my due diligence here, but I will admit to some amount
>> of haste being applied due to the many distinct sources that have
>> motivated the change.
>
> OK.  Thanks for a fast response to a brown-paper-bag bug or two.

Here is a draft release notes to 2.30.4.txt; I may tag this later
tonight (i.e. in 4 hours or so) or perhaps tomorrow morning, together
with the result of merging the fixes into newer maintenance releases.

Thanks, everybody, for working on the issue.


Git v2.30.4 Release Notes (draft)
=================================

This release contains minor fix-ups for the changes that went into
Git 2.30.3, which was made to address CVE-2022-24765.

 * The code that was meant to parse the new `safe.directory`
   configuration variable was not checking what configuration
   variable was being fed to it, which has been corrected.

 * '*' can be used as the value for the `safe.directory` variable to
   signal that the user considers that any directory is safe.


Derrick Stolee (2):
      t0033: add tests for safe.directory
      setup: opt-out of check with safe.directory=*

Matheus Valadares (1):
      setup: fix safe.directory key not being checked
