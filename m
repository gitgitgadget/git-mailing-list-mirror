Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A303C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 18:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiJGSf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJGSfw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 14:35:52 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FD78C452
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 11:35:48 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 93E141460E7;
        Fri,  7 Oct 2022 14:35:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4jbmm8H6tentZYhm+pFLIQephYoFDS+Y6YKxxz
        jktFQ=; b=uIGeU1k5aoYhihVrt1NngIBqdxCna/MI1mg9LcrMROG8/2pHb4q8jB
        vV0IJxTWUmEGMPcZ+SAjEYTrMlwN5X8J65UnSKVyBgUWEnQUX7UIuNb0HKsS6jgi
        /cnjWc9exMjwjryN+5RH/Jpa9MU0jqQJvOvIyaSCsMER8HCkuQeTw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C11D1460E6;
        Fri,  7 Oct 2022 14:35:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00D521460E5;
        Fri,  7 Oct 2022 14:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     dsal3389 via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dsal3389 <dsal3389@gmail.com>
Subject: Re: [PATCH 2/2] removed else statement
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
        <c107ad9f6ff2d5e00134eb1348f24737774edbac.1665056747.git.gitgitgadget@gmail.com>
        <44d2f602-a299-3bd0-1624-cfdddb6dcda7@github.com>
Date:   Fri, 07 Oct 2022 11:35:45 -0700
In-Reply-To: <44d2f602-a299-3bd0-1624-cfdddb6dcda7@github.com> (Victoria Dye's
        message of "Thu, 6 Oct 2022 09:14:10 -0700")
Message-ID: <xmqqpmf3eb26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC083B78-466E-11ED-B293-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> dsal3389 via GitGitGadget wrote:
>> From: dsal3389 <dsal3389@gmail.com>
>> 
>> there is no need for the else statement if we can do it more
>> elegantly with a signle if statement we no "else"
>
> Similar recommendations on the commit message as in the previous patch [1]:
>
> - title should be prefixed with 'git.c:'
> - title & message should use the imperative mood (e.g. "remove else
>   statement" instead of "removed else statement")
> - please fix typos
>     - s/there/There
>     - s/signle/single
>     - s/we/with(?)

Thanks for these.

>> +	if (argc <= 0) {
>
> nit: argc is always >= 0 [2], so a more appropriate condition would be:
>
>     if (!argc)
>
> There are lots of examples of that '!argc' conditional in Git, but none of
> the 'argc <= 0' pattern, so it's probably best to match convention here.

Yes to this, too.
