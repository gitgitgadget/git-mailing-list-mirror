Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2410C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 19:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbiHRTJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345473AbiHRTJL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 15:09:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FD6C00EE
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 12:09:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DAD521C03AF;
        Thu, 18 Aug 2022 15:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qinECa2jyIqG6MZZ+i0ys2gfMeRx6UQfsQOIcH
        3rC4g=; b=roHkb16xze94c8sFZOD6W9UabgWjG1c/M2wEPwn+fv35PYjUH6y6AD
        0bN6/MsLzagwmmu9H88UHyO3/JcngBGpjBsRiyPHKr0vqgsD3mehlx2L/vLrwnZw
        g9+ibuZfrLmTSOI5iCM8PWZzyNYZ7V6Y5B9wWGT4CdVdXgI+vmyEw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D37AC1C03AE;
        Thu, 18 Aug 2022 15:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 51E681C03AC;
        Thu, 18 Aug 2022 15:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org
Subject: Re: vd/*
References: <xmqq7d36s31e.fsf@gitster.g>
        <491d822c-56f0-71df-8815-91ab863ebc9d@github.com>
Date:   Thu, 18 Aug 2022 12:09:04 -0700
In-Reply-To: <491d822c-56f0-71df-8815-91ab863ebc9d@github.com> (Victoria Dye's
        message of "Thu, 18 Aug 2022 11:12:00 -0700")
Message-ID: <xmqq5yippdwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A796758-1F29-11ED-809A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> Junio C Hamano wrote:
>> * vd/scalar-enables-fsmonitor (2022-08-16) 5 commits
>>  - scalar: update technical doc roadmap with FSMonitor support
>>  - scalar unregister: stop FSMonitor daemon
>>  - scalar: enable built-in FSMonitor on `register`
>>  - scalar-[un]register: clearly indicate source of error
>>  - scalar-unregister: handle error codes greater than 0
>> 
>>  "scalar" now enables built-in fsmonitor on enlisted repositories,
>>  when able.
>> 
>>  Will merge to 'next'?
>>  source: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
>
> This should probably be "Expecting a reroll."; I have a couple of changes to
> make in response to [1] and [2] and will send the new version later today.
>
> [1] https://lore.kernel.org/git/f5388e4d-7eb7-9333-6a8e-86ce449aced0@github.com/
> [2] https://lore.kernel.org/git/82716e5b-3522-68f5-7479-1b39811e0cb2@github.com/
>
>> * vd/scalar-generalize-diagnose (2022-08-12) 11 commits
>>  - scalar: update technical doc roadmap
>>  - scalar-diagnose: use 'git diagnose --mode=all'
>>  - builtin/bugreport.c: create '--diagnose' option
>>  - builtin/diagnose.c: add '--mode' option
>>  - builtin/diagnose.c: create 'git diagnose' builtin
>>  - diagnose.c: add option to configure archive contents
>>  - scalar-diagnose: move functionality to common location
>>  - scalar-diagnose: move 'get_disk_info()' to 'compat/'
>>  - scalar-diagnose: add directory to archiver more gently
>>  - scalar-diagnose: avoid 32-bit overflow of size_t
>>  - scalar-diagnose: use "$GIT_UNZIP" in test
>> 
>>  The "diagnose" feature to create a zip archive for diagnostic
>>  material has been lifted from "scalar" and made into a feature of
>>  "git bugreport".
>> 
>>  Will merge to 'next'?
>>  source: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
>
> I think the review on this has stabilized (and, personally, I'm happy with
> the current version). Assuming no late-stage reviews come in, I think this
> is ready for 'next'.

Thanks.
