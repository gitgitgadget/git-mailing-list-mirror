Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 174F21F597
	for <e@80x24.org>; Thu,  2 Aug 2018 06:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbeHBH6P (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 03:58:15 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:35574 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeHBH6P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 03:58:15 -0400
Received: by mail-pg1-f179.google.com with SMTP id e6-v6so620566pgv.2
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 23:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WkIgSmentMYroj5e7e1EDw8TqtfCELnBNTJd284sz9g=;
        b=GwhHMPJCSJzs7jV7M3hlLQ3d4Lusi619sc18TFgP9m1y3qoB6V0/lTnIsqZ6FuQ5q7
         62o7vg/OwH5ajW4yV+kPiX10u4p9z7bRwdbdIudiWXdVeQBfcJEy7ATkAkWpsM5MAHHs
         urk0u30alG9xIvkc7RpjgMLFG7LgVxm/a7TlixwcOtLqdCv+vkrrfBMG5RlBwmFMCey6
         GcjER5uIz+Cn8j9y4VqexOsnJA7a4EdvsnOdeArkFZipZ73GmbJ/Jut0dxXWVaIPsEFx
         tVln4ddFhQ022g1nlEAYDmi8ZTg7a7oCPi0Idrrskk8izSxWkHKHXPO3lEsNLotwE3E+
         TFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WkIgSmentMYroj5e7e1EDw8TqtfCELnBNTJd284sz9g=;
        b=NMI1EncZtxzvdXzAWyJ0pSB/aKVJH2/KSIWkiYdBCCbXJPWZ+Vo+KRgNi+xAS40KAQ
         DYKSwDs5Vq0VKU22CtcTRSv10LHk2lmFxPc8BS3JLwMHb3LLhpbfpvt4UZhQOE7g6EQ8
         b/8qYpr7ty6hohiMW92lawlu2lb3q/lM7pCbOm2x/Y9Clxmuz8fDi90jHq49HGE70E30
         oduFuX18m2RsqhvTVL02Sn+FLapbGQDHXBpyc0EyJ5Qwe41hPPTt9WLjj+VZ4nwtg0f/
         qEzmq1uC3NIbCXZiPFwdASst3sSG0wjTimbvoFvu1pgqYgeTK+SPY/9p2EAUBcAI9dO5
         OLUQ==
X-Gm-Message-State: AOUpUlHHqWkLMoy0I1yNIM4yshVa8BP9EQmPCEER2tXiuDigMcA4TSSD
        l7IXX2luCWEIMpIoyeXZRCI=
X-Google-Smtp-Source: AAOMgpfB3IPeUgReA/5Q/+Z3uL9JrxDdLcnTs4p1vIRDma/X8r3Yzya8hSbQRshQicMh0U+Qgu+SBA==
X-Received: by 2002:a62:201b:: with SMTP id g27-v6mr1464381pfg.253.1533190125314;
        Wed, 01 Aug 2018 23:08:45 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y3-v6sm849531pge.29.2018.08.01.23.08.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 23:08:44 -0700 (PDT)
Date:   Wed, 1 Aug 2018 23:08:42 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: Fetch on submodule update
Message-ID: <20180802060842.GB10757@aiede.svl.corp.google.com>
References: <CAHd499B2VingKU-+7idv9FROYgCmOAzZ7YAQgWdwY1YUeTUVHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499B2VingKU-+7idv9FROYgCmOAzZ7YAQgWdwY1YUeTUVHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Robert Dailey wrote:

> Problem: I want to avoid recursively fetching submodules when I run a
> `fetch` command, and instead defer that operation to the next
> `submodule update`. Essentially I want `fetch.recurseSubmodules` to be
> `false`, and `get submodule update` to do exactly what it does with
> the `--remote` option, but still use the SHA1 of the submodule instead
> of updating to the tip of the specified branch in the git modules
> config.

I think I misread this the first time.  I got distracted by your
mention of the --remote option, but you mentioned you want to use the
SHA-1 of the submodule listed, so that was silly of me.

I think you'll find that "git fetch --no-recurse-submodules" and "git
submodule update" do exactly what you want.  "git submodule update"
does perform a fetch (unless you pass --no-fetch).

Let me know how it goes. :)

I'd still be interested in hearing more about the nature of the
submodules involved --- maybe `submodule.fetchJobs` would help, or
maybe this is a workflow where a tool that transparently fetches
submodules on demand like
https://gerrit.googlesource.com/gitfs/+/master/docs/design.md would be
useful (I'm not recommending using slothfs for this today, since it's
read-only, but it illustrates the idea).

Thanks,
Jonathan
