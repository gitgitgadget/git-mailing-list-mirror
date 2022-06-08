Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF58C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 23:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiFHXOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 19:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiFHXO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 19:14:28 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D537BC7
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 16:14:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DACA1410FE;
        Wed,  8 Jun 2022 19:14:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=M8R+AzB9Yb6FCH0oISxfVsR0owHbLuUPk529lR
        HELs4=; b=PmYIrQxJ+oNB/OE/PuE6ifojvgNlKoFiq3yvJNEkx14yWChL9NYyQo
        m8bxdRRmHnK2SoCRVvQFo0HKbX86OgnCMZM9oOwaKE/G03Z9YmEuzIwKVi+nV6df
        8ygggia92/8hQY/FAC0nRo0EJppuZ9NEJ5yZP2AScenI9fjDD7kUI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 659E81410FD;
        Wed,  8 Jun 2022 19:14:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF6131410FC;
        Wed,  8 Jun 2022 19:14:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(github): bring back the 'print test failures' step
References: <pull.1252.git.1654684998599.gitgitgadget@gmail.com>
Date:   Wed, 08 Jun 2022 16:14:22 -0700
In-Reply-To: <pull.1252.git.1654684998599.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 08 Jun 2022 10:43:18
        +0000")
Message-ID: <xmqqtu8uoii9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC10F028-E780-11EC-AFCA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Git now shows better information in the GitHub workflow runs when a test
> case failed. However, when a test case was implemented incorrectly and
> therefore does not even run, nothing is shown.
>
> Let's bring back the step that prints the full logs of the failed tests,
> and to improve the user experience, print out an informational message
> for readers so that they do not have to know/remember where to see the
> full logs.

Makes quite a lot of sense.  Not all test gotchas are caught by
test-lint locally, and something like this would still be needed.

Will queue.
