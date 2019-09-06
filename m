Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC7D1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 10:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392127AbfIFK6a (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 06:58:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51277 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731628AbfIFK6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 06:58:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id k1so6044540wmi.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qkqc8swoaZQvU/+1Wc8V8vEhdSXxDEpP/Yakb0SsMPE=;
        b=ihcm0ZLu23xvb1CR6OoYQYkR2gm+rU0jtDC0WI4CAmVux5nowZ6j9eK67gq18zAVnR
         PVkWnkTedfz+R+WLP9zFEvAeLnTVvcUls+94iFKAkp+S42N8YHlnQrfYiuGQNGqK6H6a
         Hwt4R7lMmqRo2bxYBBTACpZE5HZC2OYAfZpt3jHQJtZXkVinj230vQLcxKmcxNTay5Jx
         7vW0KWFHIgSqHF26ZdFqP9Bk4H8j+M/Bq+0KWTCS9XfH/pnkM+5fCbGRNfoJBJRVRRLw
         A5uMvbicRk78iQVbhFA8WnD4ho9xGpEtue8faq8I4GbOXZAh0rvsbMBC2hhKALwRhZG2
         X7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qkqc8swoaZQvU/+1Wc8V8vEhdSXxDEpP/Yakb0SsMPE=;
        b=VedD9jC+fMt2PFi+NyYuSsT3slacbxKVq5IdA74F25oCxCDV5jGrBCMb19c1KPCnfL
         34d0SBKBlaad1VvXKFOKdoxBBHpl5xyp6Xg+JURS4Kg/BBC0EWk3kd2okSsVMOBZGayr
         UQoMfrRo9YBgSTiduGr21QJRatOV5QblpEhWZ/n5abCkPY8xGzbQmgvFkBFf/jvW9/e8
         WYz61ifcuta9L2tT/5hgqh6fIJmiHNkc1guBv8DFYuKRcEmmRRLjfqtctv+r0B5hmFtF
         NpaugwepPSkUPIeWcWqVJM/CtFjRZdRh3pNe/y+4oMu93wl9lYRUVZ4AOkU5/Oug9P8Z
         73ew==
X-Gm-Message-State: APjAAAVUeE54Zt54UHYJhominD39Ea+dBFuILkizPfNWTYCPtRUoQBf9
        XsfgHlTNsbwj2zc8+CAEPv0=
X-Google-Smtp-Source: APXvYqxRxK8d5G0jFKKDcP5nqvFK5ZxWkTZ09jP3eodCL8z13LOx40YqQQeEJa9XTQq8mgDDIAEjRg==
X-Received: by 2002:a7b:c7cc:: with SMTP id z12mr6641002wmk.80.1567767508279;
        Fri, 06 Sep 2019 03:58:28 -0700 (PDT)
Received: from szeder.dev (x4db936a8.dyn.telefonica.de. [77.185.54.168])
        by smtp.gmail.com with ESMTPSA id g73sm8188433wme.10.2019.09.06.03.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 03:58:27 -0700 (PDT)
Date:   Fri, 6 Sep 2019 12:58:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: install P4 from package to fix build error
Message-ID: <20190906105825.GD32087@szeder.dev>
References: <20190906102711.6401-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190906102711.6401-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 12:27:11PM +0200, SZEDER Gábor wrote:
> To test 'git-p4' in the Linux Clang and GCC build jobs we used to
> install the 'p4' and 'p4d' binaries by directly downloading those
> binaries from a Perforce filehost.  This has worked just fine ever
> since we started using Travis CI [1], but during the last day or so
> that filehost appeared to be gone: while its hostname still resolves,
> the host doesn't seem to reply to any download request, it doesn't
> even refuse the connection, and eventually our build jobs time out
> [2].
> 
> Now, this might be just a temporary glitch, but I'm afraid that it
> isn't.

Well, now would you believe it, while I was testing this patch (I even
made a gitgitgadget PR to run it on Azure Pipelines! :) and touching
up its log message the good old Perforce filehost sprang back to life,
and the CI build jobs now succeed again even without this patch.

> Let's install P4 from the package repository, because this approach
> seems to be simpler and more future proof.
> 
> Note that we used to install an old P4 version (2016.2) in the Linux
> build jobs, but with this change we'll install the most recent version
> available in the Perforce package repository (currently 2019.1).

So I'm not quite sure whether we really want this patch.  It depends
on how important it is to test 'git-p4' with an old P4 version, but I
don't really have an opinion on that.

