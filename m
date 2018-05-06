Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D16D200B9
	for <e@80x24.org>; Sun,  6 May 2018 01:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeEFBFU (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 21:05:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37212 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeEFBFS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 21:05:18 -0400
Received: by mail-wm0-f67.google.com with SMTP id l1-v6so10498916wmb.2
        for <git@vger.kernel.org>; Sat, 05 May 2018 18:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iACTS9m0Bv9vz6gnvAfhAfLsv70haWNiE6/XwWcy9ig=;
        b=bvZVUNyV3FzUvk8OTmfEnYQTnMoOqcJ1QCBsBnTgSp10aHgRMrWdsjpKZCueWYwbGZ
         CJT5zRE5UysbRKuglxQKxCSfAlVouSVA5ts2dWXU1ncpk6REkpcOd+eCSUCM6OxtaVSm
         57nVbGa3tCXQIgQHnzyZVRBIao7i3GUF/nK8km0Ueww2HIA9B2AnYuBBOpAhq+QWgz2Z
         zvqiXd8bAesf/8Bx623dcSqagg2AL9khKW6Qhev/yR/YGG0Sn8QPbt2wtKeCtB+fBpJt
         x3N9GXI9BS+Pj1NdjjYz2D8uRPgabIi4wzp0LJsfFXukdnyIKI0w71LpjEPpGmF6ak+j
         fQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iACTS9m0Bv9vz6gnvAfhAfLsv70haWNiE6/XwWcy9ig=;
        b=ibDxwBNdwYVSuABl5maP7nfO4aPZV+dTeMMYsSIGlwzk5nVfgFEQlvD9gtwwvaxq6l
         seCP+eFEkHoOQuUEQBLmzxQRg2a3H2m12l/ZuqCouBTJq33VB+B9ZZSDbzW7VMm1CWui
         aZopm8yIfQ4RtHiPh1vQP1OnxmKGBLZhQqK748fqULI0Wy/wN5XkjwTOzFnezqMQdNto
         kzOKecdYur+cD0hzuPqqaBWUPhHcLcMr98PRiaTf7IHY+06Df7M0Ae01oRfw4V7ZeKLb
         zHkj/apjXpo6VApyMmQUaza3Z/kRHW68zgRdasKb01ETHGbcKaO2rA/ml88QLFQKNdYb
         Gp0A==
X-Gm-Message-State: ALQs6tA2qul8Jhny9J6UAn/xJvHl/HP+N1c0pzRLZ/fcVL3GIKctzxSR
        pNsEtxCikPCMhmdP1uHvg1c=
X-Google-Smtp-Source: AB8JxZo2KuduV6aWKHZeGg6tz9xW+bjgROdzwwXCi828bMeJIQsthElCBA8SnTXzDoxfKL8i3KzU9w==
X-Received: by 10.28.230.150 with SMTP id e22mr19796940wmi.118.1525568717514;
        Sat, 05 May 2018 18:05:17 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.179.29])
        by smtp.gmail.com with ESMTPSA id 69-v6sm5148541wmi.29.2018.05.05.18.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 May 2018 18:05:16 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
Date:   Sun, 6 May 2018 03:05:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 05/05/2018 23:57, Johannes Schindelin wrote:
> 
> > > This builtin does not do a whole lot so far, apart from showing a
> > > usage that is oddly similar to that of `git tbdiff`. And for a
> > > good reason: the next commits will turn `branch-diff` into a
> > > full-blown replacement for `tbdiff`.
> >
> > One minor point about the name: will it become annoying as a tab
> > completion conflict with git-branch?
> 
> I did mention this in the commit message of 18/18:
> 
>     Without this patch, we would only complete the `branch-diff` part but
>     not the options and other arguments.
> 
>     This of itself may already be slightly disruptive for well-trained
>     fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
>     `git branch origin/master`, as we now no longer automatically append a
>     space after completing `git branch`: this is now ambiguous.
> 
> > It feels really petty complaining about the name, but I just want
> > to raise the point, since it will never be easier to change than
> > right now.
> 
> I do hear you. Especially since I hate `git cherry` every single
> time that I try to tab-complete `git cherry-pick`.
> 
> > (And no, I don't really have another name in mind; I'm just
> > wondering if "subset" names like this might be a mild annoyance in
> > the long run).
> 
> They totally are, and if you can come up with a better name, I am
> really interested in changing it before this hits `next`, even.

I gave this just a quick glance so might be I`m missing something 
obvious or otherwise well-known here, bur why not `diff-branch` instead?

From user interface perspective, I would (personally) rather expect a 
command that does "diff of branches" to belong to "diff family" of 
commands (just operating on branches, instead of "branch" command 
knowing to "diff itself"), and I see we already have `diff-files`, 
`diff-index` and `diff-tree`, for what that`s worth.

Heck, I might even expect something like `git diff --branch ...` to work, 
but I guess that is yet a different matter :)

Thanks, Buga
