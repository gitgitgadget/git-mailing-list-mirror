Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F84C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 08:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiHJIpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiHJIpi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 04:45:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD0D61D75
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 01:45:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3F10199BBF;
        Wed, 10 Aug 2022 04:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=x5u2yLvAFOQEVxlk55cfOks4i1JvS3MvKpkU09oW4Hs=; b=CXly
        oLnAnAU3iGfByIZ8NYE0QWXST7ZfSFLI0UsNrQ67EM14eWraolXdXe/s85jbZgxc
        rRwSf9jZy1bUbSHR7umkN5Dqjt1meTcUGAwk+QwmyQfaTyiqA91qtCufWRFEhVRG
        oSEMau2RiSEFJ0nX/EakpiJ1Al5oJdz+Dd16F2Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CB82A199BBE;
        Wed, 10 Aug 2022 04:45:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 72BC4199BB7;
        Wed, 10 Aug 2022 04:45:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] mergetools: vimdiff: restore selective diff mode
References: <20220809004549.123020-1-felipe.contreras@gmail.com>
        <20220809004549.123020-8-felipe.contreras@gmail.com>
        <CAMP44s2RsvXnt8LtDcv+Ai_kCxmtURGWXmwfchO08dhjMxkGhA@mail.gmail.com>
        <YvHv+EcNyHXCNZhK@zacax395.localdomain>
Date:   Wed, 10 Aug 2022 01:45:31 -0700
Message-ID: <xmqqmtccpjv8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB5D919C-1888-11ED-8451-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> On 22/08/08 08:08PM, Felipe Contreras wrote:
>> 
>> Notice that after reorganizing the tab handling my layout becomes really simple:
>> 
>>   set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | 4b
>>
>
> Thanks! I really like this new approach.
>
> I also manually tested your new series (with and without .vimrc) and it works as
> expected in all listed test cases.
>
> This last series gets the best of both worlds:
>
>   - Highglihting works in single window tabs even when there is just one tab
>   
>   - Single tab layouts are not treated differently
>
>   - Generates shorter (easier to understand!) vim command strings (nice!)
>
>   - Opens the gate for a future configuration option that lets you enable "all
>     buffers diff mode" even if they are not visible in a given tab (maybe this
>     could be a new syntax token, *, that "marks" a tab to work in this mode?)
>
> So, definitely a great work. Thanks for the deeper look at the problem and this
> brilliant solution :)

Is that a "Reviewed-by:" I should add while queuing these 7 patches?

Thanks, both.

