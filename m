Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17E871F954
	for <e@80x24.org>; Tue, 21 Aug 2018 00:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeHUEER (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 00:04:17 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:35512 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeHUEEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 00:04:16 -0400
Received: by mail-yb0-f170.google.com with SMTP id o17-v6so5351531yba.2
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2f3QgqHjZ1C0xQ7TXUTM1FO+V/Rk2bHfDx9IMmtgRF0=;
        b=sBf2OU43QqH4BVzcQvlnlKyaj/b7zWVNZ/Esv4qX5AKmNlEfM/aYECO0amS+aMNUpo
         SDPG2pSHhCnhhzXBpKCb7/72LtMgS5S+3vcjThDHymeGpBRf6eLw31zw9673ONE4JBSJ
         HeB+xER2+7BEPminD/He4+CZm3Jy6Z4t+UiNng41esC+2B4PPXZS8DTUwWFgz3y/kO2r
         2x4jECxa6VsvbvpkeOsgh+2CHQHprTq6s4Y8smOoP1dpl9aEYG072tZyZJH7vtTr9jZ1
         4AV3py/5Up8hYGH7ypbTgERunuFWe47lTWz8RCR01hrO0CKiZpC/si6rBPJ4dd2qGBGI
         /EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2f3QgqHjZ1C0xQ7TXUTM1FO+V/Rk2bHfDx9IMmtgRF0=;
        b=QtF8/ibKT19JPf080+ySShW2+Oo7Z09edTXmv72zRv2SRY79lPDvrgAy9gxP+X0IR8
         bDHTfVFFTSWzsOGNxwiOkSv8RZm7iyydtM81q5K28XtT3MwkJnNmHCUYk6XlGryr9ZGg
         4B8pvtswywzw9koHHVeKMVlTEq/rOtXLvIk0xLI1sSTCBPQdxVD8olAVyA1W51WvYNSf
         Pu5KLoPlsd0gayVQGEsJheXyJncWEaR4RdK/I7iax5BmPyHWywqi94cFj13MvLaU/6IY
         x0T+B+zwK+Q1pICGPrl4/XIy4OVUtpPcNqF1b6pFysESICfciU2860+dqgaY5UQMPIE8
         O+KA==
X-Gm-Message-State: AOUpUlEvntTdxao/ya6nRFbAGn/trG1oAoHaq3OS8cHejP/27qKV2pmF
        Ie4aWLVTdgoRQtcJjLbBvUIDBCKMza6yC3GS84Jjww==
X-Google-Smtp-Source: AA+uWPyUHYY47cUANxSv07pVEum8J2Xc6mffN+w4ce4AvZTkXiHx/TBfpG3RRGhfPIU5Ukg30xfYECo9vs0kwacRMlc=
X-Received: by 2002:a25:41c3:: with SMTP id o186-v6mr10189819yba.493.1534812384520;
 Mon, 20 Aug 2018 17:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com> <CAGZ79kbrv62ttBYt7nwO7E4S7wTVWZGceqE6hPjAbhPPWfRkEQ@mail.gmail.com>
 <20180820233901.GC31020@aiede.svl.corp.google.com> <20180821002722.GA174626@aiede.svl.corp.google.com>
In-Reply-To: <20180821002722.GA174626@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 17:46:13 -0700
Message-ID: <CAGZ79kbAmt9qxcoo+hhcZzcGxQ3AxhMLdzmX3ZfL1GzvEBZb2w@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 5:27 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Jonathan Nieder wrote:
> > Stefan Beller wrote:
> >> Junio C Hamano wrote:
>
> >>>  * "git submodule" did not correctly adjust core.worktree setting that
> >>>    indicates whether/where a submodule repository has its associated
> >>>    working tree across various state transitions, which has been
> >>>    corrected.
> >>>    (merge 984cd77ddb sb/submodule-core-worktree later to maint).
> >>
> >> Personally I do not view this as a bug fix but a feature
> >> (but then again my thinking might be tainted of too much
> >> submodule work) hence I would not merge it down.
> >
> > Can you elaborate?
>
> ... ah, I figured it out.  You are saying "would not merge it down to
> maint".  In that case, I agree, since this this is not a recent bug
> (it's existed since before v1.7.10-rc1~14^2~2, 2012-03-02).

Yeah; the behavior was the gold standard for submodules ever since,
so I am wary of changing it under the guise of fixing a bug.
The core.worktree setting doesn't harm the user by default; you
need to craft a very specific situation to benefit from this feature.

Stefan
