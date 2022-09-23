Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD39C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiIWRI4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWRIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 13:08:49 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0BD14DAE8
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 10:08:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA8041436DE;
        Fri, 23 Sep 2022 13:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Beoq73ZH0fxjKR8fuGt1URFRSc2l6uZFdbQmwY
        RrDh8=; b=fqBmeIbqJdu/MZoinqGH2uRAkQqwLq5szDiXBAGvzQx9gwVynekYVM
        NVz1poNgSaS05oOg7F0zfGlUJ7AnmL1jjD0WkYrGG04dMF3L8OIv3Tc6AAPwE2WN
        2VZ7yzdil1l1U8wQrRjm7g8/dSs8M08Ix3twWjiTFy478XB7loxb8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C17AF1436DD;
        Fri, 23 Sep 2022 13:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AE221436DC;
        Fri, 23 Sep 2022 13:08:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org,
        derrickstolee@github.com, newren@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v6 0/1] grep: integrate with sparse index
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
        <20220923041842.27817-1-shaoxuan.yuan02@gmail.com>
        <d5c8012b-ccfe-2562-b56c-71b24de900e2@github.com>
Date:   Fri, 23 Sep 2022 10:08:45 -0700
In-Reply-To: <d5c8012b-ccfe-2562-b56c-71b24de900e2@github.com> (Victoria Dye's
        message of "Fri, 23 Sep 2022 09:01:03 -0700")
Message-ID: <xmqqleqauig2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62FD2606-3B62-11ED-A92F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Shaoxuan Yuan wrote:
>> Integrate `git-grep` with sparse-index and test the performance
>> improvement.
>> 
>> Changes since v5
>> ----------------
>> 
>> * Drop the `--sparse` option patch and edit corresponding tests. 
>>   We can wait until a better name is decided to replace `--sparse`.
>> 
>> * Modify the commit message, especially get rid of the `--sparse`
>>   occurences.
>> 
>
> Thanks for the update! Everything in this patch is either part of the
> previous version's patch 3 or comes from the tests & sparse index enabling
> of the previous patch 2. The resulting patch enables the sparse index for
> all usage of '--cached', and avoids any user option changes. 
>
> All that to say, this version looks good to me!

Thanks, all.  Captured but outside the upcoming release so expect
that it will be slow to merge into any of the integration branches.
