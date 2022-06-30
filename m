Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E31C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiF3RJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiF3RJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:09:19 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633781A80C
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:09:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 781E41341D8;
        Thu, 30 Jun 2022 13:09:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fQVROjVdXLmURJM+uEJyZJyczb0BtgAddzGnpm
        R6YZQ=; b=MQqecWMRgXoIdHUj2uDoceyqkIAxNwQZqgMxrxscvNWLO20i4/xkXh
        kKQ16TkIdYxxI2yPV/GZYFifLL8V1dWX+seUnejcC1TC/GkWBOhObX2cH8tQMfXR
        uIItsqAWWchLKTdj16+LO9hq960mPxiYMy2f1+IclhPfVHGiztYvA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E3331341D7;
        Thu, 30 Jun 2022 13:09:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCE841341D6;
        Thu, 30 Jun 2022 13:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 7/8] rebase: update refs from 'update-ref' commands
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
        <72e0481b643e98c5670eee0bf5c199c4fb693b16.1656422759.git.gitgitgadget@gmail.com>
        <xmqq7d50ij6f.fsf@gitster.g>
        <f2af844e-fc6c-94fd-7cce-0451f57c6576@github.com>
Date:   Thu, 30 Jun 2022 10:09:12 -0700
In-Reply-To: <f2af844e-fc6c-94fd-7cce-0451f57c6576@github.com> (Derrick
        Stolee's message of "Wed, 29 Jun 2022 09:05:44 -0400")
Message-ID: <xmqqedz6f58n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DC4D548-F897-11EC-B120-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 6/28/22 5:15 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> ...
>> It would be nice to also have a test that makes sure that other
>> people will be prevented from checking out a branch whose tips may
>> be updated at the end.
>
> Patch 3 adds the tests that 'git branch -f' cannot update these refs,

Ah, I didn't notice.  We are covered then.  Thanks.
