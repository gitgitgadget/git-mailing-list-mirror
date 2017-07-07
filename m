Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D21202AE
	for <e@80x24.org>; Fri,  7 Jul 2017 02:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbdGGCNw (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 22:13:52 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33713 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753234AbdGGCNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 22:13:51 -0400
Received: by mail-pg0-f52.google.com with SMTP id k14so9674820pgr.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fp8oiYGmyp3dLb9cIzTT+CDVNS3KARsns6u3SmNhzVc=;
        b=THySCrJj+zt3MqZ6PeLOxxSbY6BeOmdE2DPNIcf1uREsEoeFXcNqX4ABvA4FIVVgZs
         lyxNPWe6Kn2O/ieEnLRRi3pnz2UHX8AnUFdmiBD3OpcpGqlcSMiNLcc8faBHHllNmwEo
         7n3u6kTYbapdIjtiCWhulISLEuNqo8Z+tK7h9xk4Xl2Vxm/9DIgyP2SmbhYVF70DWsB6
         4kiZ2bysyNiQ1IhmVAC1FKOf3FhSmZBmyg+jUjEbYGqOJ0vOAXtS3P1RVd0ScmOb4rLu
         +yLzR4hRZGKW50/pTVMqMNP7qOfHwVWSzYAgXChFRLaQusSfphP+OhnZYhlNE52JzEPe
         BfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fp8oiYGmyp3dLb9cIzTT+CDVNS3KARsns6u3SmNhzVc=;
        b=XZPMLMc6F8XzMIO/YF8oE3A0D+rbkJaQuMXJckDUtiKEGZ8HMqPRVW8f5A8bjHfxhN
         U/d3VwFUhzXqtmAruvfC64W0tEFitsgyiICrT4H2Vqrey/FtsUFpGliYSv2NGcL3CzqU
         sR9Ub2mK5L4FTVIpuDO/60KAl48/1g5rlqjdbrgVo9oJBcMdtGXGlosA2VjvqHhQgX+d
         pdk1rDVgzo/qTk1Z1qH1pXYXo0UT6CLpNfOFIFx86JfP/oJHPZVO7unNYNNA0LgIqMBT
         3yEDwKPSrBdzkBdaGU+HComw6lcdZOUwaau12rfANPM93zRzRWrvtQZ2rXnBTAkL1mDG
         E+mw==
X-Gm-Message-State: AIVw113gx2GF+HW/YloiFzxhW0T5vh6MB0x4efEeRWNcSeWwBeEeSLaV
        dmMKOiPNBt9K/w==
X-Received: by 10.99.172.67 with SMTP id z3mr28388824pgn.246.1499393630948;
        Thu, 06 Jul 2017 19:13:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id 197sm2232346pga.58.2017.07.06.19.13.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 19:13:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2017, #01; Wed, 5)
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kamhPAQrE3GBC=fG=PNNtdHj7iStsqjOojkVMpNy_VEWw@mail.gmail.com>
Date:   Thu, 06 Jul 2017 19:13:49 -0700
In-Reply-To: <CAGZ79kamhPAQrE3GBC=fG=PNNtdHj7iStsqjOojkVMpNy_VEWw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 5 Jul 2017 16:06:26 -0700")
Message-ID: <xmqqbmoxdmea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Speaking of submodules, It's not just features, but I also send bug fixes. ;)
> https://public-inbox.org/git/20170630003851.17288-1-sbeller@google.com/
> (That patch is not related to this series, except for working in the submodule
> area, but I consider that patch more important than e.g. this series.)

I did not see the patch as fixing a bug, though.  

I do agree that overwriting the branch tips in the submodule
repositories, possibly rewinding and discarding user's work done on
the local branches, is indeed a problem.  It however is unclear why
detaching HEAD is a good solution to solve that problem.

After all, there must have been a reason why the user had checked
out a branch and had pointed it at a specific commit (presumably,
so that further work would be done while on the branch, to make it
easier and safer to eventually push the result back to the upstream
of the submodule's project).  So another solution that seems equally
viable, if not even more so, could be to fail the recursive checkout
saying why the checkout cannot be done, just like we fail a checkout
when a local change interferes with updating the contents in the
working tree and the index with an error message explaining which
paths are problematic.

I am *not* saying which one among the above two is better; I am not
even saying that there could be only these two possible solutions.
I just found the posted patch unsatisfactory because it did not make
it clear why the chosen solution is a good one.

Perhaps I misread the description; but that would mean the
description was prone to be misread and has room for improvement ;-)




