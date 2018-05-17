Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7135F1F51C
	for <e@80x24.org>; Thu, 17 May 2018 18:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeEQSU6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 14:20:58 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40760 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQSU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 14:20:57 -0400
Received: by mail-pg0-f66.google.com with SMTP id l2-v6so2169375pgc.7
        for <git@vger.kernel.org>; Thu, 17 May 2018 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3PtY7j2RylX9kFEHpWXvBuRE46yfGVOOEw1tcrSqaT0=;
        b=DYkDcreeDxcy3XsBmq0AA9dM1W1uimiwtW+O7UpU3rUd+PXlgX+E1amrbAlnYsT0On
         w6bFNsJPJWEomwPd794Prz725XfICPpUSBa2zJKGeLZ3P3vuJLs385RqC8WFpn/Uz3LJ
         TYBX/31YScAN/ybie9xsISRMFfkeYu61duKh8+dEgkiJ7FAoW7fd/gAj0cuNjEhAAtCZ
         K3y/Uu4gtj5JuAYnOlJjESqaANFcasoyHmxkgwV2GwKwtdXtUODupi9lm3e6pwNQh7Uy
         cMHUtMkTOZAFS24CDRscP+QyXSHyY+d0VxuUuBwSsUnPlsIoceu0sqNIqNyzZTylJmT1
         /Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3PtY7j2RylX9kFEHpWXvBuRE46yfGVOOEw1tcrSqaT0=;
        b=oKruHCzME91R2NmDnkOz6n3Ph9Eo86MV2YF7+HyOmUUqauE4UhFLVKpbx+aYpn0zR/
         4a9RUSNTQlght5XcWl9o3l3hgVTusH9fDx7k93LLPJCYhUqYsFdmQtuYHKmhhkC2QIRO
         5oop6q1+idvTzxA9cuSgkUxAGHQsTdlga377MdiFW0sEgG/ysMQCX9RONTkGIR5aU3g4
         sQHFlOs3+F/VrEasCMHKqiq2w7NRtPZdbWxRCdhdm/AmZ8TYXYtdGn9f50v/OLXaY9CC
         XMyXlU+6Cmm6EBn0T4JOm7kQ2eeX3gIRJPFQ7UR2fXH9FTTVM0oKRxPYyQsrCtwI7eOt
         VxDw==
X-Gm-Message-State: ALKqPwfbOLPn3FTLIMoh/69d7u2LYoRez7siSEQHZGvLX4Lq9d7g7Ruk
        gQhGaZwvYSzJwY1qlW9iSnDpMtg7IoqT5159JTBYOA==
X-Google-Smtp-Source: AB8JxZoYP5wYOe7UPPzaHPbwVKMsumm2X0VsW3oi2NCfE01Xz2ZajNldPQZUyQemPKF2r0CtEBTWybUyzKjTsrG1G1Y=
X-Received: by 2002:a62:e903:: with SMTP id j3-v6mr6208847pfh.196.1526581257598;
 Thu, 17 May 2018 11:20:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 17 May 2018 11:20:57 -0700 (PDT)
In-Reply-To: <20180511211504.79877-12-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-12-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 17 May 2018 20:20:57 +0200
Message-ID: <CAN0heSr+Aeu1By2LXxtmQN=Lq3RYwuHgYv36GjRN2Cfg73LA4Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] gc: automatically write commit-graph files
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:
> The commit-graph file is a very helpful feature for speeding up git
> operations. In order to make it more useful, write the commit-graph file
> by default during standard garbage collection operations.

So does it really write by default...

> Add a 'gc.commitGraph' config setting that triggers writing a
> commit-graph file after any non-trivial 'git gc' command. Defaults to
> false while the commit-graph feature matures. We specifically do not

or not...? I guess the first paragraph has simply been there since
before you changed your mind about the default?

> want to turn this on by default until the commit-graph feature is fully
> integrated with history-modifying features like shallow clones.

So if someone would turn this on with a shallow clone, ... Do we want
some note (warning?) around that in the user documentation?

Martin
