Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA281F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 18:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeJMCYc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 22:24:32 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45825 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbeJMCYc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 22:24:32 -0400
Received: by mail-pg1-f172.google.com with SMTP id t70-v6so6231375pgd.12
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QlmQ+sIgRv6XY/j2MiaiPOVq3T1cbVt9lvd/5icxbN0=;
        b=U0fJnC6G5MEZIKAl8pZ+O3fvjgYI+oeV/5kDQbC5Qb7rh17KrkdMrd2zCsSutRwXfe
         RRyR0YJXTmq8TsGx1Nnk28SEjJtTchmH+KvPABmlO/RiwJpl0NJFN06/0nSZkl9xC52K
         Seazlo4ebKaoLt+ELvmlvJWD13R1u+TtccX2pwSnKZrmf2pU+svttX/FPOb9h2rtf++/
         Sw10r7nnVmzs6Fhhcla8OH/L+KSakUFwSLMhK3BUyTl3MVCCJckKC5qIYMIfOMsxk6rq
         JZHvlGOqRjaIlBYNx6PW/CzpI1oB0iI/auWolWxzMNcjDCr2oc5CNmQZwZ9sKu7mLT5h
         qpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QlmQ+sIgRv6XY/j2MiaiPOVq3T1cbVt9lvd/5icxbN0=;
        b=fxU39FnYsqLtRTpqWHk4BWJz4fLH6xNIdUYlZTX6kEVSGpSWEFPKErtIaZtjgi/sVi
         NQrRLixw4G23ZqilWX3/zevC83zh2kIULiR75d77JHyEwETZebAluJpUTYZer1mA7b7E
         QoNAvpSh9+ieUvFxeYYGG4IkQE2RvB/i1NXzQ1p9CWHeyOTKtzm3upiDBsK2pphZcl4O
         jMQS1IxoxQTDZdJxw+ESSjmZfsAhe+gCZIpJsiBytVnLmt6NZMZEYNMUbU/58vwAL1aL
         8PpI6IsMWlJSacNGsQ28OYIM4JeA1FIsNtoUD87bGrqrdble2NwCikPXRv1GmXvsHHuw
         aCVg==
X-Gm-Message-State: ABuFfoiUM3Et0QJGFHYoT4tZOnAFH/4HAv3xgnuEDvr2MCLfkJi3Qcl0
        dPPg6wrnkXIfcGTAMVOkgjrsn9EA
X-Google-Smtp-Source: ACcGV63R1SvVZfUMXwim+nUDkV+Eh1CGkiXz0iCzpAr6vUYw7X/iGguHvKB5tBa2cIb0yUgKhTWO9g==
X-Received: by 2002:a63:a09:: with SMTP id 9-v6mr6577069pgk.318.1539370239497;
        Fri, 12 Oct 2018 11:50:39 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id l26-v6sm4071614pfg.161.2018.10.12.11.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 11:50:38 -0700 (PDT)
Date:   Fri, 12 Oct 2018 11:50:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [RFC PATCH 00/19] Bring more repository handles into our code
 base
Message-ID: <20181012185037.GA52080@aiede.svl.corp.google.com>
References: <20181011211754.31369-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011211754.31369-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> This applies on nd/the-index (b3c7eef9b05) and is the logical continuation of
> the object store series, which I sent over the last year.
>
> The previous series did take a very slow and pedantic approach,
> using a #define trick, see cfc62fc98c for details, but it turns out,
> that it doesn't work:

Thanks for the heads up --- this will remind me to review this new
series more carefully, since it differs from what was reviewed before.

I think this will be easiest to review with --function-context.  I can
generate that diff locally, so no need to resend.

>    When changing the signature of widely used functions, it burdens the
>    maintainer in resolving the semantic conflicts.
>
>    In the orginal approach this was called a feature, as then we can ensure
>    that not bugs creep into the code base during the merge window (while such
>    a refactoring series wanders from pu to master). It turns out this
>    was not well received and was just burdensome.

I don't agree with this characterization.

The question of who resolves conflicts is separate from the question
of whether conflicts appear, which is in turn separate from the
question of whether the build breaks.

I consider making the build break when a caller tries to use a
half-converted function too early to be a very useful feature.  There
is a way to do that in C++ that allows decoupled conversions, but the
C version forced an ordering of the conversions.  It seems that the
pain was caused by the combination of

 1. that coupling, which forced an ordering on the conversions and
    prevented us from ordering the patches in an order based on
    convenience of integration (unlike e.g. the "struct object_id"
    series which was able to proceed by taking a batch covering a
    quiet area of the tree at a time)

 2. as you mentioned, removal of old API at the same time of addition
 of new API forced callers across the tree to update at once

 3. the lack of having decided how to handle the anticipated churn

Now most of the conversions are done (thanks much for that) so the
ordering (1) is not the main remaining pain point.  Thanks for
tackling the other two in this series.

I want future API changes to be easier.  That means tackling the
following questions up front:

 i. Where does this fit in Rusty's API rating scheme
    <http://sweng.the-davies.net/Home/rustys-api-design-manifesto>?
    Does misuse (or misconverted callers) break the build, break
    visibly at runtime, or are the effects more subtle?

 ii. Is there good test coverage for the new API?  Are there tests
     that need to be migrated?

 iii. Is there a way to automatically migrate callers, or does this
      require manual, error-prone work (thanks for tackling that in
      this one.)

 iv. How are we planning to handle multiple patches in flight?  Will
     the change produce merge conflicts?  How can others on the list
     help the maintainer with integrating this set of changes?

 iv. Is the ending point cleaner than where we started?

The #define trick you're referring to was a way of addressing (i).

[...]
>  79 files changed, 571 insertions(+), 278 deletions(-)

Most of the increase is in the coccinelle file and in improved
documentation.

It appears that some patches use a the_index-style
NO_THE_REPOSITORY_COMPATIBILITY_MACROS backward compatibility synonym
and others don't.  Can you say a little more about this aspect of the
approach?  Would the compatibility macros go away eventually?

Thanks,
Jonathan
