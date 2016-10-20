Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6331F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 19:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754409AbcJTTQA (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 15:16:00 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34438 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754161AbcJTTP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 15:15:58 -0400
Received: by mail-qk0-f172.google.com with SMTP id f128so108301800qkb.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R8UoSK/naG5VNHs57CVfbknxHg+shcen5Mn3js9CLsQ=;
        b=IETddO2F/IwUYVzZdzkZ1JUr0Eu4f16jyx3Bd1kvkVP1CEROEtcG26jzOqJLdnlvhe
         981j1tDo6PPqL7I1+6zjPzdF9bh7e+gkerRBtdd33X2I8GyrBTFQwp44dcUPVxy1ISVs
         qj4K3ZFRylzcBSrOiT7IYPQpgEfnpQh9bPpCeNG+uJbMj/Ttszcxhfv1noOVRQDSqGgh
         E1AMX0Xtrg8GRwC+qy7rfUlSOA7+9uerESqNePtLW0VsQRjMuCdawDSGPbZTC1Nkw0b5
         oaaa9ZHTiDmDRNA++ly3WgkChos9+dlnYZjeg6RHmXyiGTYnFz6BTBDaainhwcQzL1R4
         4GJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R8UoSK/naG5VNHs57CVfbknxHg+shcen5Mn3js9CLsQ=;
        b=c0dtzXinJ4zwvHQ+Js36/5It+hu2Ctpoc6VWvWVryuPny5XdfTmDjxDvwDxhwqi/w8
         kqPlEYPWf/m2jHN3hgEmexYJbt4mF8JehWIV0Z8vGcxF+XGBzDe2FfXp4KbN+N0V+a/T
         AkWxfwVm08lfmTGvhxQOxOfQWyFo9k7XXbrvsjkHlBPOGP10MazYbn1v939PTdfwnuMG
         WjMRdBJzyM1jn/boLQT/GX3Axcr3A4JlHH3X3VzNZiY660hFEYKiO8u+5coIwPmf0YPz
         GjDHi/ZQsurxy8dziQaTn9LZ6myQ7fck/33qLVkYapCHSu+V8fcnrHNNpqIMHA191HNn
         /LiA==
X-Gm-Message-State: ABUngvdYX1nH6s9/uNnn//sm1PoQY+rmLSRSYEvdnwKZ+26UdhEj2Ld5kXdAvWti6I+yDLi5h+dQwjpIDXkzOTMm
X-Received: by 10.55.129.1 with SMTP id c1mr1845191qkd.53.1476990957529; Thu,
 20 Oct 2016 12:15:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 12:15:57 -0700 (PDT)
In-Reply-To: <xmqqwph5m6th.fsf@gitster.mtv.corp.google.com>
References: <20161018210623.32696-1-sbeller@google.com> <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
 <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com> <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
 <xmqq60opnolz.fsf@gitster.mtv.corp.google.com> <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
 <xmqqwph5m6th.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 12:15:57 -0700
Message-ID: <CAGZ79kY4u-k8v3g5Jmod4acwJ81AnJYeYMQZ2tarx6UMGj8Xew@mail.gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 7:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I am not sure.  Certainly we would want to make sure that the normal
>>> case (i.e. no funny trailing junk) to work correctly, but we do want
>>> to protect the fix from future breakage as well, no?
>>
>> Exactly. So not intermediate "root" that we clone from, but adapting the
>> relative URLs. Maybe half the broken tests can switch to 'root' and the others
>> go with the current behavior of cloning . to super.
>>>
>>> Perhaps we can do a preliminary step to update tests to primarily
>>> check the cases that do not involve URL with trailing "/." by either
>>> doing that double clone, or more preferrably, clone from "$(pwd)"
>>> and adjust the incorrect submodule reference that have been relying
>>> on the buggy behaviour.  With that "root" trick, the test would pass
>>> with or without the fix under discussion, right?
>>
>> I assume so, (not tested).
>
> OK.  Thanks for sticking with it.

Do we actually want to fix git-clone as well?
I tried and then I see breakage in 5603-clone-dirname
as ssh://host seems to be an invalid url; it has to end with a slash?

If we were to fix clone as well, then we'd still have a lot of possible stale
data (ending in /.) out there, so maybe we want to not fix clone for
now and only
fix it when computing the submodule url.

So I'll first fix up the test suite to not rely on buggy behavior and
then send this patch
with no change in tests? That sounds strange to me as it hides away the cause.
