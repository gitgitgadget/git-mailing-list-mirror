Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F661F597
	for <e@80x24.org>; Mon, 16 Jul 2018 17:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeGPRzR (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 13:55:17 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:40770 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeGPRzR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 13:55:17 -0400
Received: by mail-yw0-f178.google.com with SMTP id p129-v6so14453055ywg.7
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mVYIupPwVtF44zU4m0aiWu+VtZk6OflLVvJkpKYHqI=;
        b=JzlohQGMlzmhwV3Mnw129T5Njac57ND5zjNWrzt3MS+L44RQiRLtXhrk8YjeIncshy
         10rRCxu4p45IED68MnKLSW+CGSDtaPqLK4wbYxqihd+CpwFt66N52DdPsxilWpBkbw6O
         WmWG/+1YTMCj0NMKTto4OC2oj60sYzjn2QvIHXNKd0scDp/MjsmXR+Ws3RTAFveo88Y4
         7aV4rrfUlAzKZzlzGw+LYy5++gOoPYRZjU30qF1bicHvhCeaAUdMr/3KZsrHLAJ6xTGW
         70NeodoSzPGZz3O0Q62sFMxwIJmlstDJaZ4193XLREvwH4jdSdRAU0w9T2R/DJkXR1HJ
         bQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mVYIupPwVtF44zU4m0aiWu+VtZk6OflLVvJkpKYHqI=;
        b=UOGxPG1zWg98qn3rjeF/aSt0p6exCU3x1wCA2uR2ELFvhubItsZ0YwDS/pY2MpRvJ0
         lv5h8p6XLF/qXa8NsQtgykVy+ZehtFOf/tXukjwXnzpCnY/2NRCXf7+yE3b3dmXfdANd
         fIhVvAEsNGy6iZ+q9FIgoGZVDP7nnbQLvR9h7dH6JZSbAh8Tt7csso7AwvXVUaBPvr8F
         ABWJ25kCoMsx2O/C/v5Im04LdezUVMJbDom4/HYsc2ApSP4sVCXnBkBCJJd7qoGETE/I
         +/YKANNlhfb9f4ICaHRIbkZ9lGjidLxyM+Mgw14lbcNu5YaHxAc0tl5PNi42KSCkjZiD
         BqaA==
X-Gm-Message-State: AOUpUlEQpwcpN4rblljpJzCi41xT2KzOConsYTYYING31AWPXciY1IcS
        8zv8qTB8tLOf5vv+cPG4mx+WxObwS//Oji5nNWlbTw==
X-Google-Smtp-Source: AAOMgpf8EbuVpP6zN04l2wUm2CXUFCnuson4+YN8lvNod4ySnGUdhBgc3/AgiC/j29AKqUgZGrTuiCBejXCcSxqUQSo=
X-Received: by 2002:a81:3758:: with SMTP id e85-v6mr8787238ywa.340.1531762013899;
 Mon, 16 Jul 2018 10:26:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
In-Reply-To: <6b7a50dc-6b71-0e31-030a-42dd1b26bde4@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 10:26:42 -0700
Message-ID: <CAGZ79kYem+uMrhv+CUSDNXtE3C8Pv1cx=aZOyBLG=uo-aQWXeA@mail.gmail.com>
Subject: Re: [PATCH 00/16] Consolidate reachability logic
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This is not your problem, but I find these GitGitGadget
> submissions somewhat annoying.

Another pain point of the Gadget is that CC's in the cover letter
do not work as I would imagine. The line

CC: sbeller@google.com

did not put that email into the cc field.

How did you get Junios email into the TO, though?

Anyway I'll have a look at this series.

Thanks,
Stefan
