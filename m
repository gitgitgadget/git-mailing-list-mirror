Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F04720705
	for <e@80x24.org>; Thu,  7 Jul 2016 23:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbcGGXq1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 19:46:27 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33559 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbcGGXqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 19:46:25 -0400
Received: by mail-yw0-f177.google.com with SMTP id j17so28228447ywg.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 16:46:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=okn7qGIjfCUAnWrNM2wkR9Rm+SFC1tGlHI7UYIubGK0=;
        b=SsR2hpiMy2ucIVJX+q/mkaijVhlyP2MY3eHOX1vjPfRPxZ5/BsZZludaxtwFH8Z2vw
         8QPAfrOIrwb6qHcyShA1rztCbmXwchj6Y5k96OTbkNamJG95nY6P3n1A8ZrrsTxLTWdb
         Icsw6SpzHskDUGczeeLBiTptj4MNjXCkzYX/1OcmFrke0PBhFA8Gob5qSb68/8sw21NS
         KqEEOv830DYr2K0jQozopqOUF64MXNy8USN/fMyQvBTXRHoSfsND6QQEXfZqtgiZuIqA
         grjyHW8K00J6vXYv2JtJ0VzdDCPaosZc6iwujG7Q6R+F9GGpnyggpY2QTVLjRqGtreVH
         1YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=okn7qGIjfCUAnWrNM2wkR9Rm+SFC1tGlHI7UYIubGK0=;
        b=EnxLt42sv8Zx1ClAArO5nKbDrgMdDDQtfyLKTADkC7v8vaXg/FGz2kLhihyP7Sl22U
         8b+MvFP/++4B7tfhgVE9ve7WHGjGNyYQlxYiAgtM1WGGc4xJ9Ehm6qfjHz21u22k0DHA
         UhuIkfBcevg7ITJCktnA0wqV4fR870lgR1I7ytsSQQJc9KWIG+UU8xrfTlD3iHyRr1oa
         erZACKfN1H1zyNiCeeb4KQvFen2MsX4+DhmErA6wWHPuNpWfLD9kCwrYdVQ+zAUGxPC2
         vsHad6Fui68Dhra6GX5caDpjqfdIV9/pr4iKTi1T1S963r3CTD59O2V2K1A+YEm0e+WF
         EAtw==
X-Gm-Message-State: ALyK8tJfmR1kUWMRAmT5kQyyw3Jvb7nKtNWk6eVpBt1fwOxgi8YhtfT2Gs68VHDra7bChgU98QwAN1K/Za4o2Q==
X-Received: by 10.13.241.199 with SMTP id a190mr2426906ywf.54.1467934785491;
 Thu, 07 Jul 2016 16:39:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.34.133 with HTTP; Thu, 7 Jul 2016 16:39:26 -0700 (PDT)
In-Reply-To: <20160707184408.GA1916@gmail.com>
References: <20160707184408.GA1916@gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Thu, 7 Jul 2016 16:39:26 -0700
Message-ID: <CA+P7+xoM=-=sokA_+WDuY7KYUwSa=Qu8Y9U1aPHOgSH3n-VZnA@mail.gmail.com>
Subject: Re: git branch doesn't allow me to forcibly delete branch which was
 checked out in a now-deleted worktree dir
To:	Erik Johnson <palehose@gmail.com>
Cc:	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 11:44 AM, Erik Johnson <palehose@gmail.com> wrote:
> % git branch -D archive-extracted-xz
> error: Cannot delete branch 'archive-extracted-xz' checked out at
> '/home/erik/git/salt/archive-extracted-xz'
> % test -d /home/erik/git/salt/archive-extracted-xz || echo "directory
> doesn't exist"
> directory doesn't exist
> % git --version
> git version 2.9.0
>
> I know that I can just get rid of this error by pruning the worktrees,
> but this still seems like incorrect behavior on the part of git branch.
> It shouldn't be telling me that the branch is checked out in a directory
> that does not exist, that is just factually incorrect.
>

Until the worktree status is updated git branch probably isn't
checking itself. It might be worth triggering a worktree prune when
doing branch work. Note that some worktrees may be on removable media
or similar, and thus even if the directory doesn't exist right now,
that does not mean it's no longer checked out. There is already
support for setting a worktree as "persistent", but this means git
branch definitely shouldn't just do its own check for non existent
directory.

Thanks,
Jake

> --
>
> -Erik
>
> "For me, it is far better to grasp the universe as it really is than to
> persist in delusion, however satisfying and reassuring."  --Carl Sagan
>
