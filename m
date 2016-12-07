Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA63F20259
	for <e@80x24.org>; Wed,  7 Dec 2016 13:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbcLGNWg (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 08:22:36 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36221 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbcLGNWc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 08:22:32 -0500
Received: by mail-wm0-f42.google.com with SMTP id g23so167904511wme.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 05:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nt5S3K+vVOI/ov1bwuyemLlKlyaBl8sbfSF96cSdz8A=;
        b=0KRuzbux4Wbne8n2XnEBc8H2jt0oc7h4ioVq89Xkts73r7CcczzfyC4VfnpkbPPRaD
         W+nVAJPlDEn70h+5WlT04b2RmceME89dhSTOJcn3TVnfLd+D0kDLTMqDihcLGarH0Lkt
         Oke7FvXxA2lNaJrraW/2BL5yF4kRbIVNB89bdswOLKqgnR8Zp/4JYK9IyMr6AZgav7Zv
         YbL668PPFQS1/5iUK8ikip4MofcHk4RiCrVBo4EBiOUdA8ZXhMneAsmKRzxzbrXKDk2v
         tNDnQ65LkyGwZHN1pSc2r9daCaGiFqYoTSkFVYrI+Hop84SKaABX61ck83dhkKtl4HfU
         gYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nt5S3K+vVOI/ov1bwuyemLlKlyaBl8sbfSF96cSdz8A=;
        b=Nmz/3XS58jxqOFIa3Nq5Q01glaNDaqZPYAKSsdS5x/AMjffKaTfs2mIJipqJKamhu7
         UAvOoSJEFo4mkikinvjotBebPRu4OxLXz9PTxdppYbFq3XjExwbYfSiw4I7Lcga/M7Qr
         vMGOmXZeTO/fPzgBglPPNKA1wf2wuAIWYjsXei+9X2NXWPY4bMNqIK0cA6cSQXRNJqrw
         47q0sl6uprl+lD8MFz1frSF7nv5WtPWqyz4FF2uCCgsGaTMyHX1qOvDyRy678YzNgLfb
         STnZnM6f4i6N8yUmC4wFwn79GjCyOXrskyAyFidUDMRneGshNmyIt1C+dxpdnarRYYC8
         D6Uw==
X-Gm-Message-State: AKaTC01w2RMzSbCugDq+dWoy8zCI6KAD7NDddU8NWKHd6i+mL8SwaSMCRUOBJv88V5qHZoluj+Jb5WXzT+GXyw==
X-Received: by 10.25.207.138 with SMTP id f132mr1372708lfg.151.1481116529190;
 Wed, 07 Dec 2016 05:15:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Wed, 7 Dec 2016 05:15:28 -0800 (PST)
In-Reply-To: <58ab6600-5ac2-9e7d-7cf0-452db40d5f6b@gmx.net>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1b29-65f79716-42c6-4327-acda-8c8d0fe05471-000000@eu-west-1.amazonses.com>
 <1816d5b4-a4c1-7c97-09ff-b11001501423@gmx.net> <CAFZEwPNmB7rYvUTPy6dvfqfbUsjDeEcteLBBH5Wk-G_suE+YTw@mail.gmail.com>
 <58ab6600-5ac2-9e7d-7cf0-452db40d5f6b@gmx.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 7 Dec 2016 14:15:28 +0100
Message-ID: <CAP8UFD2tw_DdYbYgv1uA8+2NiQc8JSvfxgd6Tw_JpKENOE06Gw@mail.gmail.com>
Subject: Re: [PATCH v15 23/27] bisect--helper: `bisect_replay` shell function
 in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stephan,

On Wed, Dec 7, 2016 at 12:40 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> Hi Pranit and Christian and Lars ;)
>
> On 12/07/2016 12:02 AM, Pranit Bauva wrote:
>> On Tue, Nov 22, 2016 at 6:19 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
>>>
>>> Now that I have a coarse overview of what you did, I have the general
>>> remark that imho the "terms" variable should simply be global instead of
>>> being passed around all the time.
>>
>> In a personal conversation with my mentors, we thought it is the best
>> fit to keep it in a struct and pass it around so that it is easier in
>> libification.
>
> I guess you had that conversation at the beginning of the project and I
> think that at that stage I would have recommended it that way, too.
>
> However, looking at the v15 bisect--helper.c, it looks like it is rather
> a pain to do it that way. I mean, you use the terms like they were
> global variables: you initialize them in cmd_bisect__helper() and then
> you always pass them around; you update them "globally", never using
> restricted scope, never ever use a second instantiation besides the one
> of cmd_bisect__helper(). These are all signs that *in the current code*
> using (static) global variables is the better way (making the code simpler).
>
> The libification argument may be worth considering, though. I am not
> sure if there is really a use-case where you need two different
> instantiations of the terms, *except* if the lib allows bisecting with
> different terms at the same time (in different repos, of course). Is the
> lib "aware" of such use-cases like doing stuff in different repos at the
> same time? If that's the case, not using global variables is the right
> thing to do. In any other case I can imagine, I'd suggest to use global
> variables.

Yeah, I wanted to avoid global variables when there is no very good
reason for them to avoid possible libification work later.
And I don't think passing one parameter around to many functions is a
big burden.

Thanks for your reviews,
Christian.
