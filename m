Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC239C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 23:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbiCNXUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 19:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiCNXUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 19:20:52 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40411EAF4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 16:19:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94F8018A19F;
        Mon, 14 Mar 2022 19:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+ZOZYFhDCLuzUVAcJOvZ45wu81C0Gt+n4MIMg9
        8vkFQ=; b=cz07jt3OOxrtyOcHwL5ueEVvrCdyNub4pJw+BdAOyCPTC5EBxh6Zc/
        35XAUOJrwKshkC9NWDUNCiOecDKLBp53rkOl5Ra/6nIaPxyQmue6Wz/gG6BaQEun
        lA0tbjj2m6i/CxyNMAa7MzEn123KQj66r12qV32X1qOW1yuZCROLw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CEAD18A19E;
        Mon, 14 Mar 2022 19:19:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14BF218A19D;
        Mon, 14 Mar 2022 19:19:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/9] sparse-checkout: make cone mode the default
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
        <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <xmqqlexcqon9.fsf@gitster.g>
Date:   Mon, 14 Mar 2022 16:19:38 -0700
In-Reply-To: <xmqqlexcqon9.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        14 Mar 2022 20:12:42 +0000")
Message-ID: <xmqqh780jf5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 386EB2C2-A3ED-11EC-8BDF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> == Updates Log ==
>>
>> Changes since v1:
>>
>>  * rebased on master, to remove dependence on en/present-despite-skipped
>>    (which has since merged to master). Earlier version of series wasn't
>>    picked up anyway, so rebasing should be safe.
>>  * Wording and code style tweaks suggested by Stolee in his review
>>
>> == Overview ==
>>
>> This patch changes the default mode for sparse-checkout from non-cone mode
>> to cone-mode, and marks non-cone mode as deprecated. There is no plan to
>> remove non-cone mode, we are merely recommending against its use.
>
> Hopefully there are some convincing explanation to help users
> understand why the cone mode is recommended in the documentation in
> these patches.  Was there a discussion on list to give our unanimous
> support for this plan, or is this only preference by a developer or
> two who have worked on the sparse-checkout code recently?

OK.  There are a few things that I found questionable, but they were
mostly documentation issues (and lack of updates to two places, one
in read-tree and the other in config/core.txt).

Thanks.
