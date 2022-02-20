Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EC6C433EF
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 20:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiBTUNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:13:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244788AbiBTUNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 15:13:40 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262C37032
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 12:13:18 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D8D8103652;
        Sun, 20 Feb 2022 15:13:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7RZtWaUVtN4/E/J9ZI5byshdHNv9M3kQOkULv5
        uAVng=; b=rwY+S57aLwMgygd8P2Kp/HvY8HZ1H8/ZvgxErpHlK4JabDoVE6SCHg
        c79ZdirWNMR2FJDShaMdZygkeTrvxK7Flk8vH0nWF+F0aqMLA6TpT5nEPEk/84Nv
        LBcwR0N0rGU2+aDUBIThUWWjux8jcFSz4WTrscQRklelfgEFVC32Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 120D3103651;
        Sun, 20 Feb 2022 15:13:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A595103650;
        Sun, 20 Feb 2022 15:13:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 0/5] sparse checkout: fix a few bugs and check
 argument validity for set/add
References: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
        <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
        <88f7f183-10a9-1a54-e940-52c31677ac66@github.com>
Date:   Sun, 20 Feb 2022 12:13:16 -0800
In-Reply-To: <88f7f183-10a9-1a54-e940-52c31677ac66@github.com> (Derrick
        Stolee's message of "Sun, 20 Feb 2022 14:44:04 -0500")
Message-ID: <xmqqwnhpuwir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A8797BA-9289-11EC-B6CA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 2/19/2022 11:44 AM, Elijah Newren via GitGitGadget wrote:
>
>> == Update history ==
>> 
>> Changes since v4:
>> 
>>  * have --skip-checks enable running from a subdirectory in non-cone mode
>>  * make sure new die() messages are marked for translation (and using single
>>    quotes instead of double)
>> 
>> Changes since v3:
>> 
>>  * Use strpbrk() instead of multiple strchr(), fix commit message relative
>>    to backslashes.
>> 
>> Changes since v2:
>> 
>>  * Dropped patch 5
>>  * Added Stolee's Reviewed-by
>
> I looked at the range-diffs for these iterations and found the changes
> to be acceptable. This version (still) looks good to go.

Yup, I think this one is OK enough.  Let's start merging it down.

Thanks.
