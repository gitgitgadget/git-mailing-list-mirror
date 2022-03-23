Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BB5C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 18:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245754AbiCWS3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiCWS3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 14:29:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360551277A
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 11:28:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84D0217969D;
        Wed, 23 Mar 2022 14:28:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nJe0jzgBYRcqI5ntTPqmjFkVMGtEiQgRvfPNDx
        qhvtA=; b=Mxh/NyClwQk4kll3x9FXPCLlhIraEM9MGiTZTndMV4mfohQv4p0AK0
        bJoZo6tiMZQeDXKxOXOjWZ/h9IDdJ5NlyjyJhl1oDa75DIoE+7FX6xlcuFk/LWOM
        I5BsWY3oO90T/I1KU4JdtIh22J2pdFEOvFvz9qazBtW5ogqcUoXj8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7D9AD17969C;
        Wed, 23 Mar 2022 14:28:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E55C017969A;
        Wed, 23 Mar 2022 14:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
References: <xmqqv8wcizi4.fsf@gitster.g>
        <eb10fee5-d6ea-b660-e339-d55a4b669c3c@jeffhostetler.com>
Date:   Wed, 23 Mar 2022 11:28:14 -0700
In-Reply-To: <eb10fee5-d6ea-b660-e339-d55a4b669c3c@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 22 Mar 2022 14:24:57 -0400")
Message-ID: <xmqqk0cksev5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00C96560-AAD7-11EC-BB32-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 3/17/22 7:34 AM, Junio C Hamano wrote:
>> * jh/builtin-fsmonitor-part-2plus (2022-03-13) 16 commits
>>   - fsmonitor-settings: simplify initialization of settings data
>>   - fsmonitor--daemon: add _() to calls to error()
>>   - fsmonitor--daemon: add _() to calls to die()
>>   - compat/fsmonitor/fsm-listen-win32: add _() to calls to error()
>>   - compat/fsmonitor/fsm-listen-darwin: add _() to calls to error()
>>   - fsmonitor-ipc: add _() to calls to die()
>>   - t7527: delete unused verify_status() function
>>   - t7527: fix && chaining in matrix_try()
>>   - t7527: add parameters to start_daemon to handle args and subshell
>>   - t/perf/p7519: cleanup coding style
>>   - t/perf/p7519: use grep rather than egrep in test
>>   - fsmonitor--daemon: refactor cookie handling for readability
>>   - t/helper/fsmonitor-client: cleanup call to parse_options()
>>   - compat/fsmonitor/fsm-listen-darwin: split out GCC-specific declarations
>>   - update-index: convert advise() messages back to warning()
>>   - t/test-lib: avoid using git on LHS of pipe
>>   (this branch uses jh/builtin-fsmonitor-part2.)
>>   Various small fixes and cleanups on part-2 of the same topic.
>>   Needs review.
>>   source: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
>
> I have squashed this into part 2 V7, so this series can be
> discarded.  Thanks (and sorry for the mess).

Will take a (hopefully final) look, and ...


>> * jh/builtin-fsmonitor-part3 (2022-03-09) 28 commits
>> ...
>>   . Merge branch 'jh/builtin-fsmonitor-part2' into jh/builtin-fsmonitor-part3
>>   (this branch uses jh/builtin-fsmonitor-part2.)
>>   More fsmonitor--daemon.
>>   source: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
>
> I just sent a V3 of part 3 that builds upon V7 of part 2.
> The fixups from part 2.5 have been squashed in.

... queue the updated one on top.

Thanks.
