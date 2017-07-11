Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A05BA2035A
	for <e@80x24.org>; Tue, 11 Jul 2017 18:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756140AbdGKSTo (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 14:19:44 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36824 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756107AbdGKSTo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 14:19:44 -0400
Received: by mail-pf0-f176.google.com with SMTP id q86so57570pfl.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P1Gj7cGTwbVOFU0xeCuHfxfW3jtrMEvHGJNhENppJ24=;
        b=TFIGLBH00Hf1otXoHfGeRrFKIKeBmdHSWYmu+xawU5WvVilJBxFNnSR+LxG4pWUPYA
         N8w9DLzv6aBQJQyMsWQLV3y9XedQxeqdv6WWqjeVknbH0lfpzqCN1HPhL8slfw4TRQpg
         3x4HjkTmq/2o5ib4iC0glyPQuCgEMqcz2i07FJyn5Jk9Ib9fI20v4a847y6Y7OmDjhkH
         vCPWgihS9d9pGmIFB+ea103/pJc5vjAzMbjrQOUlppiAoGsLZKWMlZB9N4nHFPfX/47o
         V3fyrCum+vNCVRxd9E4Toiu4OQERxZRKvFvXWZJt5vbNmMbi9ZOupU9ZzrSno6q6EiZc
         84eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P1Gj7cGTwbVOFU0xeCuHfxfW3jtrMEvHGJNhENppJ24=;
        b=A9JN+fUFXz9eHFTYxr6/x/UIqFL/khCuMp8Cvx8aSdLbP95Hwo/8QbT2isdBZm87c3
         Cjr7wmHHqhPkvlP73q7GVhfj3OkacxXJZI55QUMxsv7pubXesKQlsB9N9E7ftdXUBwZN
         5mGsKqLq662k42XisKYMEy5Tp3ECV1tiElj3M89oA9qmUQrqX0hY6R4SYw55C0KQX5eZ
         zBn+GCKRdjYL6kgtyRZVMyxh2uJcS71xsf5ScAYgvQ1JN8LoJRF/cUmGnxyFE8ZUk+El
         1VdAlTj3UWZxr3i7r4Zkdez/aQOr3fPeMilOQdQPUiVWIk7illS03n5V/7ZCIFWc4ZrJ
         kjNQ==
X-Gm-Message-State: AIVw110WpUC7ZP0GrA5v7NtWa0dRXRbC6pU1ok7UcYsdnAOLZPiSog4G
        FZ8HGOX4DK+zb/slusad/AD+kz2PLCRL
X-Received: by 10.99.147.19 with SMTP id b19mr1216850pge.154.1499797183162;
 Tue, 11 Jul 2017 11:19:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 11 Jul 2017 11:19:42 -0700 (PDT)
In-Reply-To: <CAEcERAzRMo+fRPbc3_MAU2XgKUyaLAeCVsZvCr9FbSjo7u+MfA@mail.gmail.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <xmqqh8yi3mur.fsf@gitster.mtv.corp.google.com> <CAEcERAzRMo+fRPbc3_MAU2XgKUyaLAeCVsZvCr9FbSjo7u+MfA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Jul 2017 11:19:42 -0700
Message-ID: <CAGZ79kb6-cDo8tmLdJzY=xd-SM_sM0aM9B6=vcKv6DWspmK7vQ@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Nikolay Shustov <nikolay.shustov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 11:10 AM, Nikolay Shustov
<nikolay.shustov@gmail.com> wrote:
> Thank you for the explanation. The example about backend and frontend
> is relevant even though I normally have to deal with more layers at
> the same time.
>
> However, in my case I have the thing that you have already tried to
> address, partially: the changes always align with file boundaries BUT
> not with directory boundaries. Imagine you have the stack of backend,
> data transport and frontend layers. The feature has to touch all three
> layers thus resulting in the changes in the apparently different
> directories. Thus, making the distinction by the pathspec (if I
> understood it right from reading the documentation) would not help.
>
> The attributes could be a solution, if I could:
> 1. create attribute designated to the feature
> 2. "mark" uncommitted files in different directory with that attribute

1+2 should be answered by the gitattributes man page
https://git-scm.com/docs/gitattributes


> 3. filter the list of unchanged files with such attribute

This sounds like one of
  "git status :(attr:backend) ."
  "git status :(exclude,attr:backend) ."

> 4. create commit for the files only with the certain attribute
>
> You've kindly demonstrated that #4 is doable; however I could not
> clearly get for the Git documentation if #1 - #3 are achievable...
> Could you point me to the right place in the documentation, please?
>
