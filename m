Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA64A21847
	for <e@80x24.org>; Wed,  2 May 2018 14:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeEBOUV (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 10:20:21 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37743 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeEBOUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 10:20:17 -0400
Received: by mail-qk0-f195.google.com with SMTP id d74so11324137qkg.4
        for <git@vger.kernel.org>; Wed, 02 May 2018 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jRmdWubDN0NDIOdHNu3wv1g+VT78uLnsufeXXoLFjxo=;
        b=o9M4rNIrjnd3hDU3eUUMVhoqoxMbcwGLJuQ8tjEUznXVMYtkcgIFTbeUYSrjQ1Toa0
         VrMfGwvcunGQ+DWUvP+lqOpC6fb2KEK843Jq9ei8zzw0JWnPz0zOpppTh+qCOQBkKdmv
         DIODgzIFifLWWJIrbuoteQLBJ5qGtqXajma/sI5KaodwuKv4LCI3rCNL56P3esbBV7NU
         2Xsh9Vrlk0HBravRevsMNRuSoVIEo6iuz+WqiD04QRdZ0h5PVPwdPf2yOKxieYJ8nnAU
         wrru64hK5OXmm1IsEJnLzaXU3R2DEtrB0dj5n/yQF/2bvokkmLHVxkPxyI4Val9ZVTyr
         VJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jRmdWubDN0NDIOdHNu3wv1g+VT78uLnsufeXXoLFjxo=;
        b=Tqq7FfvvjxDoluKwE4VkrDGp0SOc8uTKFu1r/xAHFooFZ+1Zj98g5ct2OA/VqnxcKX
         Sv8nFiHzc2jMix67sItxbw5sCOAAQdhMwA5SDXyou/B14Q+25I3uaUupvcZ1JRUonXBU
         uhbvaMDEIicPLXfxG4ZLCVg6ognV/wOm5QNXkiW2SdNYRga4yIDU+yfY69kG5FQ/lT1u
         OtgBOg8i9xZQucXTi0ioDi0D6Ythn4oEF3qQuPIN9PlVRrSoYVmuXtu7cDXWPbQdFpQS
         AIFC6k3nSCsJmHxNvuOXEzYImc1k3UmsvftSeQLLwZKxJ/dJCeu4/JwY9T02axKHrzv3
         zcVg==
X-Gm-Message-State: ALQs6tB6bcTobH6eoupoBSHgK9hsGJjpb0Cjh8KiC88w/Ok761DnhHWB
        sOFZ1NccINW5uqzC15Fk3s4=
X-Google-Smtp-Source: AB8JxZodJ+km9lfHztcvykVMwhtLeStETQGYAGIKQdOhs1R23KQfOFVhTo0Ulu1TV0eJwRDHlnkH3A==
X-Received: by 10.55.214.88 with SMTP id t85mr15498464qki.170.1525270816305;
        Wed, 02 May 2018 07:20:16 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z7sm8716751qke.19.2018.05.02.07.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 07:20:15 -0700 (PDT)
Subject: Re: [PATCH v2] wt-status: use rename settings from
 init_diff_ui_defaults
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        =?UTF-8?Q?Eckhard_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <c466854f-6087-e7f1-264a-1d2df9fd9b5a@gmail.com>
 <50c60ddfeb9a44a99f556be2c2ca9a34@BPMBX2013-01.univ-lyon1.fr>
 <907020160.11403426.1525172946040.JavaMail.zimbra@inria.fr>
 <20180501114316.GB13919@esm>
 <1652522802.213664.1525177431907.JavaMail.zimbra@matthieu-moy.fr>
 <CABPp-BFbVP3iwAbaa2cEPw9Sr+ANJoHHYHOCQ4oAZoVdyX164A@mail.gmail.com>
 <xmqqlgd3x972.fsf@gitster-ct.c.googlers.com>
 <CABPp-BELX8u_CG8BswenAKCo8yvfxxOAOHjAbvh8jAm9gN7Qgw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <443ada66-708e-2034-437f-350797ef9439@gmail.com>
Date:   Wed, 2 May 2018 10:20:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BELX8u_CG8BswenAKCo8yvfxxOAOHjAbvh8jAm9gN7Qgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/1/2018 8:08 PM, Elijah Newren wrote:
> On Tue, May 1, 2018 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Elijah Newren <newren@gmail.com> writes:
>>

> 
> I also just realized that in addition to status being inconsistent
> with diff/log/show, it was also inconsistent with itself -- it handles
> staged and unstaged changes differently.
> (wt_status_collect_changes_worktree() had different settings for break
> detection than wt_status_collect_changes_index().)
> 
> Eckhard, can you add some comments to your commit message mentioning
> the email pointed to by Junio about break detection and rename
> detection being unsafe to use together, as well as the inconsistencies
> in break detection between different commands?  That may help future
> readers understand why break detection was turned off for
> wt_status_collect_changes_index().
> 

Wow, lots of inconsistent behaviors here with diff/merge/status and the 
various options being used.  Let me add another one:

I've been sitting on another patch that we've been using internally for 
some time that enables us to turn off rename and break detection for 
status via config settings and new command-line options.

The issue that triggered the creation of the patch was that if someone 
ran status while in a merge conflict state, the status would take a very 
long time.  Turning off rename and break detection "fixed" the problem.

I was waiting for some of these inflight changes to settle down and get 
accepted before I started another patch series but I thought I should at 
least let everyone know about this additional issue that will need to be 
addressed.
