Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355D32047F
	for <e@80x24.org>; Mon, 18 Sep 2017 17:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753798AbdIRR0K (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 13:26:10 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:46820 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbdIRR0J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 13:26:09 -0400
Received: by mail-wr0-f174.google.com with SMTP id o42so1113355wrb.3
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 10:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o7HQsnSeogTF1PT3v/3QwwfYMqlq/M5pZU1uSXUUbkI=;
        b=DV1o0ndw/E+8NAPe/X90PI2sF6OCEtRsO3+PJrJxBlNCwH+d5lUsW2tAqyq9wHfXBs
         jeaqMVnH+a2isnVtj3e50nQdek2sGE1n9pkFCqHiBM36qWPvy2V9gSPUr2sqR20wznX5
         8fYK2eSjrwZ9S+cTaNAH54hRgOnKQ1yexiWD/Ng5YAnEVctAVu2Spo/QQ2UoUrI+1JiZ
         7OiLDefg/5JE8tef5HgUmn3MhV/5BU3Bxi8RZ1ciVR8NruYL2LuhZaaJQYqlekvpvsEu
         G1F5GkGPx1zymXWtRXi4iPpa9V5qCplqPHC3T5P/w+GmncmR8P2Pzj7MlHtMX/MfljgD
         B/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o7HQsnSeogTF1PT3v/3QwwfYMqlq/M5pZU1uSXUUbkI=;
        b=q88W8zG5jKHro73pQlDevfdqz+GMQXMpF9OYaTmn9Kc16iLjhAjzV/bemaBMbIWFQ/
         wElkmhP3Bbsm/pOAPRcPDONcINy5vUmKbvRZRHjaA06igiSfrZrJuWZ2Sp9UjTYBvOb1
         yqiE6/98hSH5jzCn2u9QAn54QVjI9PaAqXIS9b57Wf0vaCHgvQNO/3Iw5PN6Fb2Jmv1F
         kffOQH/1Lrqqv8p8RF3DVhn71IekggJdyuf/9ocDJRtxBTRMrYJJVFdB7CK2c1tpUn2z
         tkjAuQtkArz3ptDlSlqypT6AvY80JKEBZUfocdxe4Vi1FqmIP+VCrEkvI7wk25q/M7uE
         yqJw==
X-Gm-Message-State: AHPjjUhwy0cz2brtKBT3JHKpyjwGKaNlzKu8CI/f/+fiq9D5eBBu3ibj
        aCtWCu4WWoam3QWl9HjA7nbu+ixE4VU3tLaWJt0a1RaGARo=
X-Google-Smtp-Source: ADKCNb621SpNhtxpbEPmnF6hrJVCb5R+00t1V99FmEFs2bLyaHTjU+4pl7w5hxgAFj1OhfewxN+U5OHLEB4cxNP/ohA=
X-Received: by 10.223.150.27 with SMTP id b27mr28215327wra.100.1505755568195;
 Mon, 18 Sep 2017 10:26:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.170.68 with HTTP; Mon, 18 Sep 2017 10:26:07 -0700 (PDT)
In-Reply-To: <CAP8UFD2d7y9COGj=bRLk_d+F_M=c7nv802AjBf=R9NnJQB7ohA@mail.gmail.com>
References: <1505679467-20720-1-git-send-email-bugosip@gmail.com>
 <CAP8UFD2f3jXkRHb_S_dK7TDfhBwXQ+O63cBn0J7iQQA-5ysVMQ@mail.gmail.com> <CAP8UFD2d7y9COGj=bRLk_d+F_M=c7nv802AjBf=R9NnJQB7ohA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Sep 2017 10:26:07 -0700
Message-ID: <CAGZ79kZwt5zM1N1=418FHMLZPjMJV55kKbJoat6GT157dxZObA@mail.gmail.com>
Subject: Re: [PATCH] pack: make packed_git_mru global a value instead of a pointer
To:     Christian Couder <christian.couder@gmail.com>
Cc:     phionah bugosi <bugosip@gmail.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 17, 2017 at 1:44 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Sep 17, 2017 at 10:42 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Sun, Sep 17, 2017 at 10:17 PM, phionah bugosi <bugosip@gmail.com> wrote:
>>> Signed-off-by: phionah bugosi <bugosip@gmail.com>
>>> ---
>>>  builtin/pack-objects.c |  5 +++--
>>>  cache.h                |  7 -------
>>>  list.h                 |  6 ++++++
>>>  packfile.c             | 12 ++++++------
>>>  4 files changed, 15 insertions(+), 15 deletions(-)
>>>
>>> This patch makes packed_git_mru global a value instead of a pointer and
>>> makes use of list.h
>>
>> Please explain _why_ you are doing that (why is the resulting code better).
>
> Also the explanations should be in the commit message, that is above
> your "Signed-off-by: ..." line.

A similar patch exists at origin/jn/per-repo-object-store-fixes^^
(I haven't checked if there are differences and if so which
patch is better, all I am noting here, is that there has been
work very similar to this one a couple days prior)
