Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554FEC433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 21:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiBNVQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:16:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiBNVQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 16:16:22 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C7B11118A
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 13:16:13 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F01511F625;
        Mon, 14 Feb 2022 16:16:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HoQbOOtNBiJPWY8qBVKS0b+DuUKeqZ2ofUJ8Fs
        2M/js=; b=xP3PTe/Sq0vQKprtfDUteDr4YYAuhLixq6ZiNlhlMeHEiVZma4xC3Y
        ghAAObpmXBbOorKs1Pn0YO2e63Byf8je7PZGOUyAP5XXTphvN6l6sGjO4lVJkBgM
        t5qWftJngzrEmTzCH3NcbIEfpKBMhGtl77HyntbMuXNy/kyKv1Zxs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2768C11F624;
        Mon, 14 Feb 2022 16:16:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 925A911F623;
        Mon, 14 Feb 2022 16:16:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2022, #03; Sat, 12)
References: <20220214200155.1412357-1-jonathantanmy@google.com>
Date:   Mon, 14 Feb 2022 13:16:11 -0800
In-Reply-To: <20220214200155.1412357-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 14 Feb 2022 12:01:54 -0800")
Message-ID: <xmqqv8xh1750.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5641E328-8DDB-11EC-AA2D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> * gc/recursive-fetch-with-unused-submodules (2022-02-10) 8 commits
>>  - submodule: fix bug and remove add_submodule_odb()
>>  - fetch: fetch unpopulated, changed submodules
>>  - submodule: extract get_fetch_task()
>>  - t5526: use grep to assert on fetches
>>  - t5526: introduce test helper to assert on fetches
>>  - submodule: make static functions read submodules from commits
>>  - submodule: store new submodule commits oid_array in a struct
>>  - submodule: inline submodule_commits() into caller
>> 
>>  When "git fetch --recurse-submodules" grabbed submodule commits
>>  that would be needed to recursively check out newly fetched commits
>>  in the superproject, it only paid attention to submodules that are
>>  in the current checkout of the superproject.  We now do so for all
>>  submodules that have been run "git submodule init" on.
>> 
>>  Will merge to 'next'?
>>  source: <20220210044152.78352-1-chooglen@google.com>
>
> This should wait at least until a v2 that addresses comments from both
> of us, I believe.

Indeed.  Thanks.
