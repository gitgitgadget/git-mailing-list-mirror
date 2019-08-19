Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCD4E1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 09:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfHSJ0x (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 05:26:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36893 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfHSJ0w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 05:26:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so858348wme.2
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bUDU6QPj1ox9Ojbvu2YF7Lpuwq4iU6QAeX5NJ61yQMI=;
        b=DusBMnNcxgBEfa3VlA82GfL/36UvbUE+vaO4eruN3uQqhW4+CSUphrN9ny7VNK/NsJ
         dS5bPesye9AoR9vRarCejfmNEGPtOGQewYKUvCAjVnINZBnC8zYW8e/kt2M4XvvGRBjI
         1079fqXJOG5XI5H96OAgrOnkFyfq0c9VW9CjNw3ORzW70gjF4h5hc9AtJ/+KMCjbyfme
         Fd42Gkvv9qu3piptl94kC2BwAYXrHS7bnzxjiHVOXyWllMEqeDJLu6jlywXdsrSW8u5n
         68xkbz6k4HlbWDpQMJtsQrpJ+tru46CCpO3L+wR0Izkwbkhn/jDtCnWLw1ymHPCQxwFu
         7sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bUDU6QPj1ox9Ojbvu2YF7Lpuwq4iU6QAeX5NJ61yQMI=;
        b=Zzf5dzWTerWPb+0nj5R1v2RZ++O7W8K+Qz4FfPGyegsiVA5ddwZuklcrWRMz1PMFXI
         3tVNbNH5NAYaxfSIQp2zqLVHuR7I+kVTyanUc3l9XvV0dB9PODl8Yx2r+hZt9qJVg1mh
         /L3ProVdQborOf9KwwucozZSeR0Wmr/WhkxzM99tg7rZNXqcNiFNlazCeUBKrynxh+Fm
         FFY1dTo42ftEpc8FA0UnmXgRmm+SLDSR/zQZpMxI9O5w93HuR6LgokjBtwKvvM9btBwc
         5Ihk2u6Zg9m/9kLQns0mVKwE/f+sJnXIdlireY3KLjBB322HMIIgyCobI5O/lC7pfJIa
         5Lzg==
X-Gm-Message-State: APjAAAVdZqKuhXG9SJ0dZ2h/95ZhItqhdfzDzGNVN4IDFb5KAdt3+/Nu
        QiHMl5bLhPHihEzGtdvAcOLL20gC
X-Google-Smtp-Source: APXvYqw3slFomQQ5Y5LLTZGWE+xaiKgyvt96QsCYSPYGeOioHJalabfkTknbRtw2k/2V+o2+0X0dsg==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr18228104wml.134.1566206810576;
        Mon, 19 Aug 2019 02:26:50 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id p13sm16531834wrw.90.2019.08.19.02.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 02:26:50 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] git rebase: Make sure upstream branch is left alone.
To:     Ben Wijen <ben@wijen.net>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
References: <20190818095349.3218-1-ben@wijen.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0bef598c-6c89-c699-5290-ee2003db5979@gmail.com>
Date:   Mon, 19 Aug 2019 10:26:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818095349.3218-1-ben@wijen.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben

On 18/08/2019 10:53, Ben Wijen wrote:
> I found an issue with git rebase --autostash <upstream> <branch> with an dirty worktree/index.
> It seems the currently active branch is moved, which is not correct.

I'm not sure I understand what you mean by "the currently active branch 
is moved". 'git rebase --autostash <upstream> <branch>' should checkout 
<branch> (presumably stashing any unstaged and uncommitted changes 
first) and then do rebase <upstream> - what's it doing instead?

Best Wishes

Phillip

> The following patches contain both a test and a fix.
> 
> Ben Wijen (2):
>    t3420: never change upstream branch
>    rebase.c: make sure current branch isn't moved when autostashing
> 
>   builtin/rebase.c            | 18 ++++++------------
>   t/t3420-rebase-autostash.sh | 13 +++++++++----
>   2 files changed, 15 insertions(+), 16 deletions(-)
> 
