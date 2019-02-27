Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 578D820248
	for <e@80x24.org>; Wed, 27 Feb 2019 14:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfB0Oa7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 09:30:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35322 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729276AbfB0Oa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 09:30:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so18216876wrx.2
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 06:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8xhi3UqA0sbiswer0NOBmh68aZ9ASHiktDDaWLhv3VE=;
        b=BkRql/IjnKg9/LUp6iysJcjQWxKJa/A31LhPXw68z+ApXpHnEaw/s56//rNWPxC6cb
         c4IoxPPsDGNteF4XO7HuO9lFSyUbyOCcBK89mdJBowN2Ly8KUyF10JmgW5hhCiPDQKot
         fwVldB06yCL5eBx3Ox6hK2qMd/+dKW684Gm2dE2K0gwzJmitRUbeR/ZMQuOIzzpd8efZ
         kNeui5VyW5oJnSs+11kQHaGVWN1JiZsWi4iDNcPR082++XFmg6Tf0ekTYzgsZTnb4vMG
         ONsF6GPWgknO4AM/vXi8CsTvEwuRzYlGqIq8S1nSl5Ax0361LdwPL5mLLLN6yevlOy5L
         W7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:cc:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8xhi3UqA0sbiswer0NOBmh68aZ9ASHiktDDaWLhv3VE=;
        b=YdvwlWVZ2IDX39E9cR1TBfSL7zvs8GDA3UFTho1oXMNEGh0jFSQ6h8hhQsOgICQ+eh
         qC9AdIt4uDxzi8u/xmx7YOULjO6ZHhYUlL/qyM7SlHouaW5wE842uqJK0NHivqSZVIiB
         U7G81KArzoF5C4st7vmJZR0q+JkBEim+l1aQmXtlXbkGRqSqGTUUt/vgayihCbAMx9eL
         muKBzW1GEuhd4q67xux3IaADcEwibVs/FZ2v6wFEfwGw0jgoQnITWknSwlwUXAzDxCBY
         ZVtmwl+GlJ4vRHtsNGwuRzkWnTJv8RkhbrujOXikG9Zin2Zqh1sUNWVGeOUPlsjg5+Pf
         q/Sg==
X-Gm-Message-State: APjAAAVbgd2T1HoNz+Ed6vdLtBv++8yzyroonlF8oMaP6V/0Hu6Otled
        60GWqeiFNKGbm5EloEVDaww=
X-Google-Smtp-Source: APXvYqzX6hFZFuB2JBVHhHKCrzn9goo3rJtQQeVgWUOXH5T7mVDtyjMLK71VXJLmUGjaZ61RwXEShw==
X-Received: by 2002:adf:824b:: with SMTP id 69mr2755619wrb.24.1551277857050;
        Wed, 27 Feb 2019 06:30:57 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-12-154.as13285.net. [92.22.12.154])
        by smtp.gmail.com with ESMTPSA id m15sm11710307wrx.30.2019.02.27.06.30.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 06:30:56 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
To:     Linus Nilsson <Linus.Nilsson@trimma.se>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
Cc:     Elijah Newren <newren@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <512993fe-51da-745d-031b-37ea162499fb@gmail.com>
Date:   Wed, 27 Feb 2019 14:30:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Linus

On 27/02/2019 12:47, Linus Nilsson wrote:
> Hi
> 
> I have found what I suspect to be a bug, or at least not desirable behavior in my case. In one branch, I have moved all files in a directory to another directory. The first directory is now empty in this branch (I haven't tested whether this is significant). 

I suspect that because you've moved all the files git thinks the 
directory has been renamed and that's why it moves a/file2 when fix is 
cherry-picked in the example below. I've cc'd Elijah as he knows more 
about how the directory rename detection works.

Best Wishes

Phillip

I cherry-picked the commit to another branch that has additional files 
in the first directory. All the files in the first directory are now 
moved to the second directory, and not just the files that were moved in 
the original commit. It happens in Git for Windows, versions 2.20.1 and 
2.21.0.
> 
> It can be reproduced using these steps:
> 
> $ git init
> $ mkdir a
> $ echo Hello > a/file1
> $ git add a/file1
> $ git commit -m 'Add file1'
> $ git checkout -b fix
> $ mkdir b
> $ git mv a/file1 b
> $ git commit -m 'Move file1 to b'
> $ git checkout master
> $ echo Bye > a/file2
> $ git add a/file2
> $ git commit -m 'Add file2'
> $ git cherry-pick fix
> [master 5b63afb] Move file1 to b
>   Date: Wed Feb 27 13:27:45 2019 +0100
>   2 files changed, 0 insertions(+), 0 deletions(-)
>   rename {a => b}/file1 (100%)
>   rename {a => b}/file2 (100%)
> 
> Regards
> Linus Nilsson
> 
