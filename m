Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE26F1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 20:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756094AbcIFUCP (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 16:02:15 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:32854 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbcIFUCM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 16:02:12 -0400
Received: by mail-ua0-f174.google.com with SMTP id 31so58744652uao.0
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hz7vD/h1o4zvuG4UvnOIhzzckuVVuwVnOlXdiPCfV9E=;
        b=TSHbfXRcQwkUjzfVx/UpG+JcOFo28XEotmg5VQIIraLPfTxmXTLAc4WNOD0sklR+gb
         yZXHcPnFR0AiIhjy+rvcbt0i+4XFKDRHJNjH4HQV4kl/czFhYCfivH7BkmyWFm75KDFp
         rmHLoEJD+GhZT9vqmrmCyU8lnOcG7TlN6418TlqwgRxgpYIf+uwfvNaKBW49YZPOWEtX
         7/NgxeMlFCxNH1wxfcZW1/7BXkDbCwCnUj6dnaGx0oRFw7ZZoIeoITzHoVQpSIFFBmU7
         IIte7squZIOUd9jPQZ+BJzMaCz1td5HzeJffm3XwTXwyLl27r3ZDlfzLgjM2bA5l7GeB
         mRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hz7vD/h1o4zvuG4UvnOIhzzckuVVuwVnOlXdiPCfV9E=;
        b=meim48b+VmvgIkK0O4u7s+CpFYDaO+N5PycBtJN2cZ6FdJQl7TCB2H+20dtjqCKM2j
         v9MgHjvLc1Jx/Mzp+0nL4QLQGw+N5ulwYKHSrpipwGxa1LItcCwax6sVSc3q/YePsX8K
         E2DruhOKdkvkMfoQdfAOdtWiM5ZEekBUrSkfoK4iCi4sj28xLtFTP+YgQ5z+wXrWhd+r
         CsK21HSTXtYDLHdqIqRehuC7O+8aDsNsVoNxq6iitzh2Xy3TE3N4uFuFHYKNSC3n+YLy
         O3SFOuJocOdqX9PMllmnBBAEu7xSB1KDtQcA5EwGyi6IJFrIGDGZOOg46UZFI4gwa+6M
         NA5w==
X-Gm-Message-State: AE9vXwPCMvPWqhQItWbSUrfMEd+qd6MfjFgRPJRWJKyI98s7Usf08P4Go+4ALOFySNUV5pN9xF6gom+UmkSqng==
X-Received: by 10.159.33.214 with SMTP id 80mr7641054uac.32.1473192131530;
 Tue, 06 Sep 2016 13:02:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.50.213 with HTTP; Tue, 6 Sep 2016 13:02:11 -0700 (PDT)
In-Reply-To: <CAGZ79kb=LyusFH6tGirGP9qK1k-cov2UubEbKPfeyPRThUsa-Q@mail.gmail.com>
References: <CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com>
 <CAGZ79kb=LyusFH6tGirGP9qK1k-cov2UubEbKPfeyPRThUsa-Q@mail.gmail.com>
From:   Dakota Hawkins <dakotahawkins@gmail.com>
Date:   Tue, 6 Sep 2016 16:02:11 -0400
Message-ID: <CAG0BQX=FFWqR=45g6buujzK2jknx8aZnQoiV_m-QZhcx4Dd52g@mail.gmail.com>
Subject: Re: If a branch moves a submodule, "merge --ff[-only]" succeeds while
 "merge --no-ff" fails with conflicts
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, mwitte@ara.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 6, 2016 at 3:00 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Sep 2, 2016 at 12:22 PM, Dakota Hawkins <dakotahawkins@gmail.com> wrote:
>> Below is a simple reproduction of the issue.
>>
>> The _real_ problem is that this is how our pull request merges work,
>
> So your workflow is the problem or is the actual bug just exposed in
> your workflow?

I believe the workflow just exposes the problem, which is that
generically for this case a fast-forward merge works without conflicts
while a non-fast-forward merge fails with conflicts. Sorry if this
confuses the issue, it's just how we experienced it so I wanted to add
that background.

>> ## Test fast-forward merge, this will work
>> git checkout -b merge-ff-test master # warning: unable to rmdir
>> submodule-location-2: Directory not empty
>> rm -rf ./submodule-location-2
>> git merge --ff-only move-submodule
>>
>
> And no reset/rm in between, i.e. we still have
> submodule-location-2 from  merge-ff-test still around?

That is true in that example, but somewhat immaterial. The first merge
was only to demonstrate that a fast-forward merge works without
conflict. The simplest reproduction is to skip that and get straight
to the failure case:

## Clone and setup branches
git clone https://github.com/dakotahawkins/submodule-move-merge-bug-main-repo.git
cd submodule-move-merge-bug-main-repo
git branch move-submodule origin/move-submodule
git checkout -b merge-no-ff-test master

## This will fail
git merge --no-ff move-submodule
# Auto-merging submodule-location-2
# Adding as submodule-location-2~move-submodule instead
# Automatic merge failed; fix conflicts and then commit the result.

Does that make things a little bit clearer?

Dakota
