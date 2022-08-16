Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014C9C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 16:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiHPQQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 12:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiHPQQL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 12:16:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5828675499
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 09:16:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFCD51A2FB1;
        Tue, 16 Aug 2022 12:16:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xos6rEznoKjdBP7j3sKt9AYD3wiR+XROdseg7E
        r0bH8=; b=nll+fJJC711yJ5jouFs/WMY7bju8w4zL8j80OFBwjwaQYxZ9wSfYMa
        JIMv8yWiV0J4OL3lje745y6L0I4c1XXp5QAf5rm6D+8/JCG0lMICHZQ1qKSzHpqO
        cKmnPUjQ9fxc08ANa0n2AlhUFA6MOEhQTyqmAnYt5G5vfctDId0Gc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E14301A2FB0;
        Tue, 16 Aug 2022 12:16:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C39B1A2FAB;
        Tue, 16 Aug 2022 12:16:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: sy/mv-out-of-cone (was Re: What's cooking in git.git (Aug 2022,
 #05; Mon, 15))
References: <xmqq5yityzcu.fsf@gitster.g>
        <2b19b57b-b6b1-8214-d1fd-3ffe9eac2d9d@github.com>
Date:   Tue, 16 Aug 2022 09:16:05 -0700
In-Reply-To: <2b19b57b-b6b1-8214-d1fd-3ffe9eac2d9d@github.com> (Victoria Dye's
        message of "Tue, 16 Aug 2022 09:00:59 -0700")
Message-ID: <xmqq8rnoxiyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB44B470-1D7E-11ED-AD47-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Junio C Hamano wrote:
>> * sy/mv-out-of-cone (2022-08-10) 9 commits
>>  - mv: check overwrite for in-to-out move
>>  - advice.h: add advise_on_moving_dirty_path()
>>  - mv: cleanup empty WORKING_DIRECTORY
>>  - mv: from in-cone to out-of-cone
>>  - mv: remove BOTH from enum update_mode
>>  - mv: check if <destination> is a SKIP_WORKTREE_DIR
>>  - mv: free the with_slash in check_dir_in_index()
>>  - mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
>>  - t7002: add tests for moving from in-cone to out-of-cone
>> 
>>  "git mv A B" in a sparsely populated working tree can be asked to
>>  move a path from a directory that is "in cone" to another directory
>>  that is "out of cone".  Handling of such a case has been improved.
>> 
>>  Will merge to 'next'?
>>  source: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>
>
> After reviewing the latest version [1], I think this is ready for 'next'.
>
> [1] https://lore.kernel.org/git/52b67242-5d91-5406-9c95-9d8ddc49c079@github.com/

Thanks, both.
