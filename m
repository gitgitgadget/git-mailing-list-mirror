Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815B61F453
	for <e@80x24.org>; Thu, 14 Feb 2019 19:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502924AbfBNT6i (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 14:58:38 -0500
Received: from mail-qt1-f202.google.com ([209.85.160.202]:35268 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNT6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 14:58:37 -0500
Received: by mail-qt1-f202.google.com with SMTP id k1so6815575qta.2
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ty4awDrlFSbwourQuJjjS4UMj+v5ywMCByB2DWgJRAY=;
        b=KgVwpfpwIU2J87rqGVkO67SWXc8o/VnzuLK9ICa1pjR6FYxBVOFjm6UbSWpnkaiGJw
         bQukX5kIH2RQdyTtfFsQCSeIdWmgEWwQnco/v2cLiXFQLVmre0S3VyltXvsxG40LT9Tb
         eGuI0EGwCY1tfyQzUFRrfyG6JWKS8h+7YrHBtgH/rv3lXB/FgYVcnNecOmTuWPDEegi9
         RqZWeLkWptzAL1HxNIOBVBtWadPbgwYYgbZ71e6/zXxrDgzS6R2Q4gt+35MR3fr+Ugih
         dw0JBhZNQDktDE3BnSmPX8i5pr1azpTv9k1bh/unrlvRwSAgHXSfnry1VXxTWdHb3uoO
         JRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ty4awDrlFSbwourQuJjjS4UMj+v5ywMCByB2DWgJRAY=;
        b=Ddaq9T+l9aYdEH/sZXJ5FEb6ZIXqSQirlF4EhDL7O1n5IdHCtjNQoMN094n+ah6+b2
         Tw0yvR7ukoiJbts0FR56Vxh03feAP7QtgLovGVPZ/7bJcqVZ8VSjoe0n/rux50vhJAWF
         C4jtmpripyJlk3rHgHXT7W7PeKCX6x5W1Q2VzsJs9m73MCrWIeXySF5Kf1+xgRqw8gl6
         xUMnmDAK5Qo13SeN7T+DtcA42BbSO7pDUamfpdEKb3IX2GQq3TWlS9fpsa0PEUzILOsr
         vsw/rerfqOEfHvcwTjfWhpHtmPFtEzpVKvwFxr9AEtMydh76E4X06xHUS3x0AqwH9nqt
         70EA==
X-Gm-Message-State: AHQUAuaBptoWkhr4+ffnOFpAc9lki0KRFOHE8C0WRm3AEarKR9UzjARk
        enMr5JwBbG0UyPLIpQnOu7eQX4fkor0vaUFGOmbU
X-Google-Smtp-Source: AHgI3IY+3ZaqPzc+2HQ4kJ8mmHLJ+dDDSmjosbjF/HfBqowdr5uShNrrFQwqzNCrVCf3W3lTJtm88LywVRKhAlRvIe6D
X-Received: by 2002:a0c:bd83:: with SMTP id n3mr3087923qvg.5.1550174316639;
 Thu, 14 Feb 2019 11:58:36 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:58:25 -0800
In-Reply-To: <20190211203011.GB9072@sigill.intra.peff.net>
Message-Id: <20190214195825.125751-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190211203011.GB9072@sigill.intra.peff.net>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 2/8] tests: always test fetch of unreachable with v0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Tue, Feb 05, 2019 at 04:21:16PM -0800, Jonathan Tan wrote:
> 
> > Some tests check that fetching an unreachable object fails, but protocol
> > v2 allows such fetches. Unset GIT_TEST_PROTOCOL_VERSION so that these
> > tests are always run using protocol v0.
> 
> I think this is reasonable, but just musing on a few things:
> 
>   1. Are we sure going forward that we want to retain this behavior? I
>      feel like we discussed this on the list recently with no real
>      conclusion, but I'm having trouble digging it up in the archive.

One such discussion is here:
https://public-inbox.org/git/20181214101232.GC13465@sigill.intra.peff.net/

>   2. If it does change, is there any way we could automatically find
>      spots like this that would then need to be undone? I cannot think
>      of a good solution, and I don't think it's a show-stopper not to
>      have one, but I thought I'd put it forward as a concept.

We can do so now either by "blaming" one and finding the originating
commit, or by searching for "support fetching unadvertised objects" (I
used the same comment everywhere in the commit [1] so that people can do
this), but I don't know how to enforce this for future work. (We can add
a special variable, but I think it's unnecessary and we can't enforce
that people use that new special variable instead of
GIT_TEST_PROTOCOL_VERSION anyway.)

[1] https://public-inbox.org/git/9b9061985202ec022cc562637d7f62ea599e7d8c.1549411880.git.jonathantanmy@google.com/
