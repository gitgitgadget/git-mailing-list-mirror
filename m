Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B0FC61DB3
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjALLf6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 06:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjALLfL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 06:35:11 -0500
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE0BCE0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 03:27:00 -0800 (PST)
Received: from [10.2.11.242] (unknown [10.2.11.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 20EAC189D24E;
        Thu, 12 Jan 2023 12:26:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1673522819; bh=38x/Pg0RuliWcGgjjqgSoHeYq7/gICEbqXwVpCEhiZQ=;
        h=Date:To:Cc:References:Subject:From:In-Reply-To;
        b=vaKJ6hdaOAwyAYrFhWYjTNC82/nBlleYg+rESmD/hwhfvEwCNCe7bxNdVOuQjOJHj
         NlV+klkgBoYVpOOi2bJb0nzPfrIU5Rx4YzKpxjVsUfBVEiEULzw/XkLpF8KpBp0mNC
         Mon/rM+thXV3UeV6Wc6JEUK6Wm4sGoNLX6x5cYYM=
Message-ID: <bfa6c4d2-b18c-3484-995f-2e3809a5c7d5@schinagl.nl>
Date:   Thu, 12 Jan 2023 12:26:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        oliver@schinagl.nl, phillip.wood@dunelm.org.uk
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Content-Language: nl
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Phillip,

Thanks for looking into this! Much appreciated!

> @@ -869,7 +869,9 @@ the files and/or the commit message, amend the 
> commit, and continue   rebasing.
>   
>   To interrupt the rebase (just like an "edit" command would do, but without
> -cherry-picking any commit first), use the "break" command. 
> +cherry-picking any commit first), use the "break" command. A "break" 
> +command may be followed by a comment beginning with `#` followed by a 
> +space.
Any technical reason for this? Traditionally, anything goes after a 
comment marker, so why be exceptional here?


Thanks,

Olliver

>   
>   If you just want to edit the commit message for a commit, replace the
>   command "pick" with the command "reword".
> diff 
> <https://lore.kernel.org/git/pull.1460.git.1673519809510.gitgitgadget@gmail.com/#iZ31sequencer.c> 
> --git a/sequencer.c b/sequencer.c index bcb662e23be..c66f382dfbc 
> 100644 --- a/sequencer.c +++ b/sequencer.c

