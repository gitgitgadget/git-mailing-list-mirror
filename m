Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E991F453
	for <e@80x24.org>; Tue, 19 Feb 2019 13:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfBSNWn (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 08:22:43 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:42096 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfBSNWn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 08:22:43 -0500
Received: by mail-ed1-f53.google.com with SMTP id j89so7321626edb.9
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46pCoxAsbMQW67Gc/B8Izqa+5lVMmP+DMDN7nK5mxB8=;
        b=jKPIl/vtW3HOsG1NvV71lpF/KNk4Cg9ha+l8fEry4KuLJvh8w+JEvadHoNTIG2sw+9
         8kjVW6XA91+hMttxrkU3vIoV11Vvytx6kGkyfx0cvMFXQFsNpc96m6CYK9zrmyhsh6g1
         JdKkB26nZa3kA/YcijstqRswGazLSlTHP25UXFHhAKiSWunaZpXnnOg11nQKXfM6P6ut
         uj7brZYSu1//JMTTnult3eOPzT9X8f3LyiXkw8lFHpNG1xj8i+VV/8UiqzOoX8M3O4IM
         lDMZqr3s/MtFXOLiq2PnB1lBUezaGMnch/F+5YpdgWXHnyMRp2IX685G97zkaacJ3TI4
         LaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46pCoxAsbMQW67Gc/B8Izqa+5lVMmP+DMDN7nK5mxB8=;
        b=cranJ2Ki/f1LAxYt9+mBA15My3ypC0FrhSkrqYUHkhTCc1M0YVq6RrzXf8BW1wkBsl
         v2AstyCuDnLdWxCFIysLSG7jX9msivljaJMym+dbQ10Fpd4UA+tc0Tu0i0PmwNcxw9+U
         pcD6Evk4dq/Sz4xOxG/ZwVxDj9rT0oEXFGgJrODcUKLOkU1fAxdJLEsfPuP53XygVjGC
         YPWeQ1yR3V7c7VpjUiwqHKa/U3Y9phiz3brEjfoslhMcTwuZgevtaOCBnsIvyNjVPtmW
         s+Qa49uEHn2HIKNBtRbsZXeZ1bkBi5vqvGqzHSDeyKm+Y2K2X6vOQpQKbgkiGJ6sfuXM
         PFVg==
X-Gm-Message-State: AHQUAubBkw2akBXWYdDNKS/V3PSvmzd/Sa6Ym+HlBROcHiLxGblBfN86
        X6e1606YiuALo7nugYNgVlWseQcbIQ39NOdeuBw=
X-Google-Smtp-Source: AHgI3Ia/o+wYtHjskJhPyYv7XN2vvOv5QF1nBpE4HLWhHBfykyBvMhYwehM22HxoFWHxCjtC9BOsWxbgNhWWNQ0vwoI=
X-Received: by 2002:a05:6402:185a:: with SMTP id v26mr23167125edy.163.1550582561538;
 Tue, 19 Feb 2019 05:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20181204015446.GX890086@genre.crustytoothpaste.net> <20181204192904.40409-1-jonathantanmy@google.com>
In-Reply-To: <20181204192904.40409-1-jonathantanmy@google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 Feb 2019 14:22:29 +0100
Message-ID: <CAP8UFD0VPZEhBTUb--n5RHECUkO81aPcGkTYGi0fqd35rnKr3Q@mail.gmail.com>
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 8:31 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > Some thoughts here:
> >
> > First, I'd like to see a section (and a bit in the implementation)
> > requiring HTTPS if the original protocol is secure (SSH or HTTPS).
> > Allowing the server to downgrade to HTTP, even by accident, would be a
> > security problem.
> >
> > Second, this feature likely should be opt-in for SSH. One issue I've
> > seen repeatedly is that people don't want to use HTTPS to fetch things
> > when they're using SSH for Git. Many people in corporate environments
> > have proxies that break HTTP for non-browser use cases[0], and using SSH
> > is the only way that they can make a functional Git connection.
>
> Good points about SSH support and the client needing to control which
> protocols the server will send URIs for. I'll include a line in the
> client request in which the client can specify which protocols it is OK
> with.

What if a client is ok to fetch from some servers but not others (for
example github.com and gitlab.com but nothing else)?

Or what if a client is ok to fetch using SSH from some servers and
HTTPS from other servers but nothing else?

I also wonder in general how this would interact with promisor/partial
clone remotes.

When we discussed promisor/partial clone remotes in the thread
following this email:

https://public-inbox.org/git/20181016174304.GA221682@aiede.svl.corp.google.com/

it looked like you were ok with having many promisor remotes, which I
think could fill the same use cases especially related to large
objects.

As clients would configure promisor remotes explicitly, there would be
no issues about which protocol and servers are allowed or not.

If the issue is that you want the server to decide which promisor
remotes would be used without the client having to do anything, maybe
that could be something added on top of the possibility to have many
promisor remotes.
