Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF622070F
	for <e@80x24.org>; Thu, 15 Sep 2016 17:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbcIOR3w (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 13:29:52 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:36724 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbcIOR3v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 13:29:51 -0400
Received: by mail-it0-f42.google.com with SMTP id o3so107251631ita.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8G3koPu9TEvPCmpYj22oxnO23zXkprhtJsTPQDixvdU=;
        b=m+OqQ+mqzJ5/JsFq790OaEagvUr2DK2VBVfBAb6X8ITUHYw/lE+ofvDWf0vZJAnLRF
         +WeHOxYAyvo02crk7y7WSKJT+iPZyWIXQpl5JVbjL2aVmbNVlpxa+QIlHZwbfj8RaVvi
         jz4VYvxLIr5xrrCXlrnoVlJVEb9TDEvw/kOke6s9h1wQiAIuezBEXRNM5vD6L24xnsFq
         0lTinfC1SkNchfY0h78Bz7KNW9vkexvDt7GgboMJs6nfnToPlPj51YvAidGfnG7ZI8CG
         4Q7MYBXccTeWRUYT6g0QLqiItMTWWT0UFx8tmKdvg6pBHfviECjYbC4n3XZWhEQL8nLH
         yrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8G3koPu9TEvPCmpYj22oxnO23zXkprhtJsTPQDixvdU=;
        b=Md8ZOjThLDKazRmVGt5+CpJ3Vqj3EXhJkjX5QoYH2q2L81hLLNeRxtGHYNzuSMGTvO
         fwxCWPsuVER/LIBqunN4/dHm208WJTWQzCKX+3EsJmCS+vmZDQectmRDz6VW4vgs+7tu
         bVNc6e4n+sf+qaiHayCyoU5jLj7yyADFi8RJHBRJFpTwA1EJjBm2bhkqX0w90Q+G1Zqs
         WIJJCvGnskmCRQvhDx1tGjoKCnVtL0P0VCs+AsrZyubi0vXMzHT4uu0iHr5mAB7e2FyH
         tumXBti/+xs9aJiHV1aHnFtKHa/WX1LU8LFljuUJVeMti5vbhxpFllsa97OueM/RsX4E
         ko0Q==
X-Gm-Message-State: AE9vXwOJkR7HkpcX+w1b80Suvfu6sxSN9sRXaitUZ5ZWf59knyupKaCalt0SFvBO0xLon/Ti3paKi6LtaYrlP4An
X-Received: by 10.107.153.129 with SMTP id b123mr18239497ioe.160.1473960590330;
 Thu, 15 Sep 2016 10:29:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Thu, 15 Sep 2016 10:29:49 -0700 (PDT)
In-Reply-To: <20160915164035.GL9830@onerussian.com>
References: <20160915130233.GC9833@onerussian.com> <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
 <20160915164035.GL9830@onerussian.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Sep 2016 10:29:49 -0700
Message-ID: <CAGZ79kYDpF5C6dXoi9ghmy40XDK1Gz-8HjmKQ_m_v_pUS1ZmDA@mail.gmail.com>
Subject: Re: [wishlist?] make submodule commands robust to having
 non-submodule Subprojects
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 9:40 AM, Yaroslav Halchenko <yoh@onerussian.com> wrote:
>
> On Thu, 15 Sep 2016, Stefan Beller wrote:
>
>> > I think it would be more logical to make it a 'warning:' not a 'fatal:' and
>> > proceed.
>
>> So maybe we would want to introduce a switch
>>   `--existing-but-unconfigure-gitlinks=(warn|ignore)`
>> as well as
>> `git config submodule.existing-but-unconfigured (warn|ignore)`
>> for a more permanent solution?
>
> possibly ignorant question:  is  gitlink === Subproject    or a
> Subproject is a kinda of a gitlink and there are other gitlinks which
> aren't Subprojects? ;)
>

gitlink is the internal name (just like a file is called blob, or a directory is
called tree; there is no file system equivalent for e.g. commits, or
gitlinks)

gitlinks as a basic building block only points at a sha1 to be part of
the repository.

Submodules use gitlinks to point at (usually) different projects, e.g.
a library.

Subprojects in Git is a loose term, it could mean submodule or part of your
repo merged in via the git-subtree command. Or a sub project can
be just a loose repository inside your repository.

gitlinks do not necessarily need to track other projects; it's "just a pointer"
to a specific version of a repository.

So to come back to your question: yeah In that response I meant
submodule==gitlink, though naming the internal data structure to be
more explicit. (What if we invent a new way to do submodules not
using gitlinks? Then that config option may be less confusing and
backwards compatible. That is unlikely though. So I guess we'll settle
with a different name)
