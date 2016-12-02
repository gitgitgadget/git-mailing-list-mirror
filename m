Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7951FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 21:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751635AbcLBV70 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 16:59:26 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36567 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbcLBV7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 16:59:25 -0500
Received: by mail-qk0-f177.google.com with SMTP id n21so293115964qka.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 13:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t20y6UOBVoKzNtoVkl7HbitbKDMZemfsempR8oTmPYI=;
        b=FXiB4xwVOlOUuzUkpBtiLvvo9/UCG9B6MdwRdbaI7uh3kKohYSfSE7FWkSiL+9vC6P
         DR9O+VcLiXILfjbmZdtpClq8vfJ5wV8YmCNhTtilA1ioCuACle0Qilye1QheFDXJCpWs
         vJJOX7wv/KSYfBRpcGldTSJEwlrsQF9L0iDEZFbaXaTQXz4ApywFd70JKqYIakMb9cx/
         Q5m6F6qrxTf+AiO/OsZyxshvmHS9U3mjpMPJLNDAv9+9Aw4SjIrJ8QV6I1SYqWGLXUX0
         TkKJVzEhjghaZm+TaT+mQpAPQkPcgtvc4NEiDNUJo2O1whE0CqMYUEwPFwlYkyJqksu+
         xCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t20y6UOBVoKzNtoVkl7HbitbKDMZemfsempR8oTmPYI=;
        b=mPQVF8C+x/eiP+bJaE9TBsPViRtI3zbJ5o+oesQS+S8UnavUeNdJktgTUaSHLZXqCf
         CbIbvqieZF9ABXxTbhQKy9d6XrNDLcF/e+qGEMd4oDT2DAddW2b28SMx7DeLUWw7RQqo
         V6PFyLjdqSQYs6idl5yL50WIpUFnksBj2pXxkG6y1niyWirqUHK2pS25baTusw4fxV6w
         FVfNPDepR0oNERi4DUfa7EcjoOVfqV1l4hUc/2QeQUEKAiw5O57h93l8Mwy56uPj3pbX
         BPaHBRNuAmOyuEZZnTnkUv3WUvh45/htlHV3SCBI2vGFybPTGfszLL6i14JQwPaADVa9
         znIg==
X-Gm-Message-State: AKaTC01T4u4YVWnVRyksxaG1M8yUM85x4+E5AhUCzjSypPb1ihDFrLyyQdpLbmwrYEnIVmVBJiywa73NMUcrrwwe
X-Received: by 10.55.105.129 with SMTP id e123mr43300875qkc.173.1480715920328;
 Fri, 02 Dec 2016 13:58:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 2 Dec 2016 13:58:39 -0800 (PST)
In-Reply-To: <0be15cd5-4ecb-3d87-93ee-d34d2be2d4c6@ramsayjones.plus.com>
References: <0be15cd5-4ecb-3d87-93ee-d34d2be2d4c6@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Dec 2016 13:58:39 -0800
Message-ID: <CAGZ79kaXeFOL0k1tqPxk76XLrkRH_ApZPC7V=kKK3xN=mPbxJQ@mail.gmail.com>
Subject: Re: [PATCH] worktree: mark a file-local symbol with static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2016 at 12:55 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Stefan,
>
> If you need to re-roll your 'sb/submodule-intern-gitdir'
> branch,

I will need to reroll it.

> could you please squash something similar to this
> into the relevant patch (commit 2529715dc, "worktree: get
> worktrees from submodules", 01-12-2016).
>
> [This is based on pu; ie. on top of merge 86c7f863a, where
> Junio as added the 'flags' parameter.]

Oh, ok. I may just reroll the series on top of nd/worktree-list-fixup

Thanks for the annotation!
Stefan
