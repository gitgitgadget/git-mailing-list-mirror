Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B971F404
	for <e@80x24.org>; Mon, 12 Mar 2018 23:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeCLXhv (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 19:37:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33531 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeCLXhu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 19:37:50 -0400
Received: by mail-pl0-f68.google.com with SMTP id c11-v6so10271995plo.0
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wSxvSLGW3FrIprXOLdmhd4WwYCkVcmawY8BTACuCGac=;
        b=A60dBH6xRc4P8MIn9nMK/v4Cl6hFpHjFUuU7Z+nS/uDRrg9p1d3Y5PJuyjeGdVvnrI
         RtCq2QtbVf47w0g2k3BAcu7kc9qGVx6myQnNf/uiDYnu5kEyAc1lSYXw76AoI93Jbs8g
         vwM7Q4fyz80tWV1cvi6OsZREKhu82HkHCkpNcazewno+kJoLs5O4zBzECBPMkCs4ynNv
         xCeurN4alr2g/lJQ9MfqYaBZkkX6bvD/4yyHfJoLZFoCQil6hmV0DW7WxCFKE4vwxoX1
         +NMnN+4U3x1PiRZKpzoPXPwj+k2WNn+qO/z5c24pVqoubiWppG8YiFIuCt9/1gn+ZA7w
         39Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wSxvSLGW3FrIprXOLdmhd4WwYCkVcmawY8BTACuCGac=;
        b=AwSpbSaynwJTYE3o8pMPvBIBwCmZfSjn31wuvQczaxlo0H9gD7JZjXonD2TOwI9sGz
         30amwA11WVEKvchSK8whPbDterp8S+MAATrGJqFT8KkbiTr5Dcs+VrmXYDbKplU2vPJX
         33XXaAcSIAcEDRklBXLQ1MfiMLSkSW3nlBaVxCQTUE+QVKmSkr53PVHUFmSKcjXi61l/
         2sihcEevnN4MSo8MoW3My9LpLsx0wwOFGSDzoWlVZHkHbrKGzOlS42ngZFv6n0GWYxgn
         yCisotwzZZ1YxL/o8DMpjpuLqEr2VgVIR6kHz0uKILu0yxEXcmXjG40i4FpCVeUGEM5S
         ilyg==
X-Gm-Message-State: AElRT7Ed5CSLwVa0T/gN2rh2A01qX3ibwqi9Wf8QGkfP9l9l/kqblRaQ
        2X98cKu+q1NkwHFxYJOyOhps+E2o
X-Google-Smtp-Source: AG47ELvdeeBFDcSEEqMikJdcSPvNGUY4nLkOhDgZ+kVC4iNniBeYrZnYlxe7ZAuYgW3SU7InCX1+4w==
X-Received: by 2002:a17:902:5a0d:: with SMTP id q13-v6mr9678806pli.152.1520897870102;
        Mon, 12 Mar 2018 16:37:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o28sm18680823pfa.62.2018.03.12.16.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 16:37:48 -0700 (PDT)
Date:   Mon, 12 Mar 2018 16:37:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180312233747.GB235366@aiede.svl.corp.google.com>
References: <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222202150.GA23985@sigill.intra.peff.net>
 <20180222212634.GC256918@aiede.svl.corp.google.com>
 <20180222214457.GB30638@sigill.intra.peff.net>
 <20180312224355.GC58506@aiede.svl.corp.google.com>
 <20180312232844.GB1968@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312232844.GB1968@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> We could even give it an environment variable, which would allow
> something like:
>
>   tar xf maybe-evil.git.tar
>   cd maybe-evil
>   export GIT_TRUST_REPO=false
>   git log

Interesting idea.  Putting it in an envvar means it gets inherited by
child processes, which if I understand you correctly is a good thing.

[...]
>   1. We have to manually annotate any "dangerous" code to act more
>      safely when it sees the flag. Which means it's highly likely to
>      a spot, or to add a new feature which doesn't respect it. And
>      suddenly that's a security hole. So I'm concerned it may create a
>      false sense of security and actually make things worse.

As an internal implementation detail, this is so obviously fragile
that it wouldn't give me any feeling of security. ;-)  So it should be
strictly an improvement.

As a public-facing feature, I suspect it's a bad idea for exactly that
reason.

FWIW for pager specifically I am going for a whitelisting approach:
new commands would have to explicitly set ALLOW_PAGER if they want to
respect pager config.  That doesn't guarantee people think about it
again as things evolve but it should at least help with getting the
right setting for new plumbing.

Thanks,
Jonathan
