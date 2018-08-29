Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2AD81F404
	for <e@80x24.org>; Wed, 29 Aug 2018 19:09:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeH2XHj (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 19:07:39 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:52868 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeH2XHj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 19:07:39 -0400
Received: by mail-wm0-f43.google.com with SMTP id y139-v6so6278209wmc.2
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 12:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P23f/OCBBwx1OQarNm78RNf6qg1hCxoHeRN3Uax2YLA=;
        b=LvXvuWTAr8VDoYelmZuYjcaHpTBEvqvDlsDk/VREb5vo0j0tKpMe8S+0vxHSGxiy/O
         O99lN0MkrbsAxeQmTYGnrZXlKg12iQZXkR5Hb0kGXNlgqqn8MGb78LW5cbBgBN/T+Jbn
         2+h8fJyi7BgVlOfHQF97QbR/YI3y0zB2gNVTmxRLU21zXoBBUikX4Vk0Tfbtg+3x2igh
         98aoJO9nNjUJHWJG3dv/bWnJbjnW84do6wdNdgaQr8zmpkfo4GFMEkcg+uAPX4BXsMQC
         Y/TmLvxmiDBIj5Xy9y9X5+ZNluhiYnHSnAQSpcLwFUKYEGTTzFlZW/AhlOqqcD8tXJtB
         7sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P23f/OCBBwx1OQarNm78RNf6qg1hCxoHeRN3Uax2YLA=;
        b=ZvRAYMcfVYiMz6FVrULE9gOGGQlPXWRt7kl2rjk0b1dINQCjbBSKSMgCLyAbE2FoTP
         7F9vaW+q0uehsAf//NePaqMCSEm6+k/sTrqfav/xBgMd6rfxw27eeCqZha8WhkWR7Xi/
         pKS5VgVvM8BlMOC2z7NeAeHOYB4+HlvnlYx76Ws39ukw775A2+UYNc4aKOMmNe93QPxN
         9uekzmbT1QD3PArTHZDMQgrXfLRHWr5dGBRfj244/Fd/57Sz8jBWjtRF5c5/qcxVU8Mx
         Si2mbW0B7dbjC3TUTBtgQtoN6oy0+o0/rYXzLGpDw6Pk8Takf/nwNgL9xxKdUcd0Rn/Z
         M9iA==
X-Gm-Message-State: APzg51CYiBYZjgDd/oOHis96yZ4c7o5dW3mQJ4lNM/xPp5wP+NlSrCL5
        CBT9jqcXNBXJ7z+NNxs2aSs=
X-Google-Smtp-Source: ANB0VdbnXl3axlIEC9ZNuN0yG66wZ+BMJMxpBH7pSgO2JjeeWXEMmAmpnMc4WKg0XzNommswZ6w7kA==
X-Received: by 2002:a1c:9011:: with SMTP id s17-v6mr2297419wmd.146.1535569760960;
        Wed, 29 Aug 2018 12:09:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z184-v6sm23525wmz.0.2018.08.29.12.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 12:09:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>,
        git@vger.kernel.org
Subject: Re: Trivial enhancement: All commands which require an author should accept --author
References: <201808282305.29407.ulrich.gemkow@ikr.uni-stuttgart.de>
        <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet>
Date:   Wed, 29 Aug 2018 12:09:19 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808291653190.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 29 Aug 2018 18:14:22 +0200 (DST)")
Message-ID: <xmqqpny1at28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The `stash` command only incidentally requires that the author is set, as
> it calls `git commit` internally (which records the author). As stashes
> are intended to be local only, that author information was never meant to
> be a vital part of the `stash`.
>
> I could imagine that an even better enhancement request would ask for `git
> stash` to work even if `user.name` is not configured.

This would make a good bite-sized microproject, worth marking it as
#leftoverbits unless somebody is already working on it ;-)
