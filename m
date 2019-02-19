Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F631F453
	for <e@80x24.org>; Tue, 19 Feb 2019 20:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfBSUK0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 15:10:26 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:56781 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSUK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 15:10:26 -0500
Received: by mail-ot1-f74.google.com with SMTP id q11so18542642otl.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 12:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZDRH7fewrCGqghdaskB/VBYVoubtmPypaGT07Q+KxAU=;
        b=enElxOUAnuoxdizic3aj5WD7NZVSBj7SqkPUMUCQdJaKJtCHMggYU4v8D7po7umZgQ
         pqlJ51IDMhBLsT8X0Sa9F3H4kq3sgXFCyjVNgN3FRRENa1wyI/YwfSUT1UM6SDBCku2g
         GJR75QnZOdXtuXnTuMlXn50QUrnvaVGVlMDMyrlzBvhEF/H8i3lCPwLoGXfE/e8HyQjs
         WNHAKCvnnm91mS79tvD2JKhZ73LX3tHHwuXolP6jCfXnIp5VacYieymoRY6M8vF5Ue94
         lvcrVpA+vDFseapuCzglX71eaNGNN5NHLK1u0kOGjJ8DTYIXyibg8xG9JXgFKSwmDSWi
         mfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZDRH7fewrCGqghdaskB/VBYVoubtmPypaGT07Q+KxAU=;
        b=YMJzBtGGGqRmWZzIaTe5kabB+26Aa8eFm+vYx8K58x0fTYk4N0JQUq27XX58a39zxa
         w+itbSanTSBSB93L3QQVCSZV7VNBwRiyWqN2FNKv0N6ji1I/Z4awHmc0fIbtOn6laUIz
         akCobc7KPlMQpMnhXmBDWaerc4/fDEAqiL6CZWcrbEKNhoY/4AlbS+x2xOT+pnQ0b/UP
         0U0F4N8wqphDFfQnIwaQbQB9DLt9OhV5r9r//2P/fO8FTXTtziIIMjY0X0fYIK6KBeUj
         7iNXtks2ffoJ7juSaitzuC3KRlakz+slbCcE2sXA+Zq1ap2sQ/C038z8kzDGhY8sDuN9
         r4zQ==
X-Gm-Message-State: AHQUAuaCKtASMj2A+S7wcrsLWnF3FzhvMkM3I37twD14hUQFRgqMQPNr
        EmNcj9w/z8pa9Jq9b/29RbcGi6vwchh4AexnRUbr
X-Google-Smtp-Source: AHgI3IZLBY5kL6Gv9QrCxFjvALv517bYPxFpCdtB+dkXZySALZOCgPMVRcFKeTlHZSvgh+YO7MSVh+nMDfxDE5ei5U3Y
X-Received: by 2002:a9d:650f:: with SMTP id i15mr16817804otl.70.1550607025703;
 Tue, 19 Feb 2019 12:10:25 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:10:22 -0800
In-Reply-To: <CAP8UFD0VPZEhBTUb--n5RHECUkO81aPcGkTYGi0fqd35rnKr3Q@mail.gmail.com>
Message-Id: <20190219201022.237430-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAP8UFD0VPZEhBTUb--n5RHECUkO81aPcGkTYGi0fqd35rnKr3Q@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [WIP RFC 2/5] Documentation: add Packfile URIs design doc
From:   Jonathan Tan <jonathantanmy@google.com>
To:     christian.couder@gmail.com
Cc:     jonathantanmy@google.com, sandals@crustytoothpaste.net,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Good points about SSH support and the client needing to control which
> > protocols the server will send URIs for. I'll include a line in the
> > client request in which the client can specify which protocols it is OK
> > with.
> 
> What if a client is ok to fetch from some servers but not others (for
> example github.com and gitlab.com but nothing else)?
> 
> Or what if a client is ok to fetch using SSH from some servers and
> HTTPS from other servers but nothing else?

The objects received from the various CDNs are still rehashed by the
client (so they are identified with the correct name), and if the client
is fetching from a server, presumably it can trust the URLs it receives
(just like it trusts ref names, and so on). Do you know of a specific
case in which a client wants to fetch from some servers but not others?
(In any case, if this happens, the client can just disable the CDN
support.)

> I also wonder in general how this would interact with promisor/partial
> clone remotes.
> 
> When we discussed promisor/partial clone remotes in the thread
> following this email:
> 
> https://public-inbox.org/git/20181016174304.GA221682@aiede.svl.corp.google.com/
> 
> it looked like you were ok with having many promisor remotes, which I
> think could fill the same use cases especially related to large
> objects.
>
> As clients would configure promisor remotes explicitly, there would be
> no issues about which protocol and servers are allowed or not.
> 
> If the issue is that you want the server to decide which promisor
> remotes would be used without the client having to do anything, maybe
> that could be something added on top of the possibility to have many
> promisor remotes.

It's true that there is a slight overlap with respect to large objects,
but this protocol can also handle large sets of objects being offloaded
to CDN, not only single ones. (The included implementation only handles
single objects, as a minimum viable product, but it is conceivable that
the server implementation is later expanded to allow offloading of sets
of objects.)

And this protocol is meant to be able to use CDNs to help serve objects,
whether single objects or sets of objects. In the case of promisor
remotes, the thing we fetch from has to be a Git server. (We could use
dumb HTTP from a CDN, but that defeats the purpose in at least one way -
with dumb HTTP, we have to fetch objects individually, but with URL
support, we can fetch objects as sets too.)
