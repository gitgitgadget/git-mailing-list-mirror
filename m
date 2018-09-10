Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6298B1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeIJWGX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:06:23 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33074 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJWGX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:06:23 -0400
Received: by mail-yb1-f195.google.com with SMTP id m123-v6so8242046ybm.0
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gAuFtZk5Lx9q+c9cEi9ffdNug88j5A4ooblIGuM4e3U=;
        b=L/ubBO9Kp/oRmNbYbqltskA4eRvEG0iGQWw40GSxgPdcbhJ/FiR/l8yffS8WMV4hAk
         cXaw3oKhobev/vTPp+lZLzUA3NrgenGqeBSyJSX4pOSniOzMXMWFSfujCYQex2nqIJYl
         xEeKxGcxOKiLya2QQ8CVNrp0n4hdzMGRo0ia4h2Xn6YySyNq5d4xO45G+Al7XeFHTwNP
         mOA73Bf/yqRMQfZdu6cYXqbDBsX3UZuE4FaX8pd/s2cM/LLfnrah5opwFe5FIZ6/NlNP
         xoq77rkUMel/U5pi9t25iguwkDWTbq2pAUOSOG+g45vBcxiX1WxOAwwwUYy5/zi/0Tx0
         +bTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gAuFtZk5Lx9q+c9cEi9ffdNug88j5A4ooblIGuM4e3U=;
        b=FjoTc1+vBhb7Bsb7J+11BTZvWKBwrBAmOm4pTFtSVQfGHbrXkAg4zZiqJYVE2k9Jog
         U/qHVhSdP9f5cBaZujXj72OCketOcopIJdN3vCtfetjw7yirc33VJiKOvmwcUSw0QZKR
         UllFOTtsoSuM9aeN9no/8XChHI8NBGPUjc+P9AcegOxnD/nVuRgpIL+vxSVr7y2o6Oly
         H/i5l9BmmiiGQ71YhC4TWdhxMPuyC9ngWJNVPmryFJYtubQGpp34NN79B8dka3cPJ3dk
         Dk4emGSjo/ROj82qU2nOHT0Rri+zc+KSc5r/3DrUJekSgmkBQVx6t9lSAAUlFW9X+D3e
         2Syw==
X-Gm-Message-State: APzg51D7KR2VpatArSolHqw+4gH0nIRODdEek2he9p+dIf7FO+lerpsM
        xPVOiegd6sagpfyw1H9awgiZORG7KDyUlopWEUvyng==
X-Google-Smtp-Source: ANB0VdYOTz4yy20qXcV5q8WMsUBFZPoFsRbXGFhaABbiYBdvSyJq8SCTSTFuiAOKdI6EDPWowwRNsuAw3krSs/7DBxE=
X-Received: by 2002:a25:8205:: with SMTP id q5-v6mr3628717ybk.191.1536599479654;
 Mon, 10 Sep 2018 10:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <2659750.rG6xLiZASK@twilight> <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
 <20180907223515.GD103699@aiede.svl.corp.google.com> <CAGZ79kZvuGEPOSTUqT+y6nxs6W5qaP-BbHT_WQQE7+n=RVNsrw@mail.gmail.com>
 <20180908000946.GA225427@aiede.svl.corp.google.com> <xmqqmussvj72.fsf@gitster-ct.c.googlers.com>
 <deeaa4d5-3982-b47a-d2da-501d52fa38e1@kdbg.org>
In-Reply-To: <deeaa4d5-3982-b47a-d2da-501d52fa38e1@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Sep 2018 10:11:08 -0700
Message-ID: <CAGZ79kac0g_zqxW69PVSi+t59O2bOrcJELHOTt7NVWxVbR88iw@mail.gmail.com>
Subject: Re: [PATCH] Revert "Merge branch 'sb/submodule-core-worktree'" (was
 Re: Old submodules broken in 2.19rc1 and 2.19rc2)
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, allan.jensen@qt.io,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >> Like this (generated using "git revert -m1)?
> >
> > OK.  Thanks for taking care of it.

Yes that looks good to me, thanks!

>
> Please don't forget to remove the corresponding release notes entry.

Makes sense, too.

Thanks,
Stefan
