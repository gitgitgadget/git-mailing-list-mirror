Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D401FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 22:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755893AbeAHWF4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 17:05:56 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:39840 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeAHWFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 17:05:55 -0500
Received: by mail-qt0-f173.google.com with SMTP id k19so15558021qtj.6
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 14:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+xob/mJf/N9quM0H2tUrz0CxCvux3sbEW0A2GzRZucU=;
        b=VutXzHr1rzl6pS4mId1j06SzoSjXlkZBi58qeAEk8kwcqpLIa+o9U0D4vDSmwrgP++
         lf3dxL7x+V0n8m6kvcpzM6rCBsJMOOcLzFm33aiXa26ms9VBJEJhY6q/qMk8HI2I8wGP
         OR5qfrx/BU/eQuXd1yNoYyrxlXn+3jIEpedOTWUELUL2UtodKaME9YwKCOF9nGAfzJRy
         /fF6NGIHRDnqRo+tqvacK4D0OhXAetu3m21bG/jAEc4lCITwR2VIcGT0DMh9TJeRjYOP
         CHmnt/tq1GVUnDhnQRDcRhg7nCjcRi9aJJhKwbY0zkA2vXsrrbguwCLJ30u7Ajy9FMWb
         J14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+xob/mJf/N9quM0H2tUrz0CxCvux3sbEW0A2GzRZucU=;
        b=i1ts4Q2OVHBR/yHVhDVeLLavMmMzGMognxU6Pu7Dj+5Ey/BGCrRq43g7s0FKW8o+oC
         yq7Agq2G2ySSn4RS8kd48lV7i7Ni2PY8Uc6jVkzYewkENKB1T3p1mu41eIielGRjFADf
         wFXzZkL/K9J0lFMM8t0W66/mwNiqNQERs0rx+bp1Q1hjoJU6pLM9JpmtJNOWSFpVgUeW
         YNQJTqJ04f3/FRo7SkrCLfXrweuNNWYUL8q5o1TOZndUx9n7x2fAWSDk43zkjWmYwf+M
         owYFUnVqK5ehgjVRBmQLOVQICsjPa4D0z88CAoD0gq37XWGcAk7xxCesdJoU6WRK3aXm
         /4iw==
X-Gm-Message-State: AKGB3mJUQ35oul7ALz+WhCDbG9jxRIIvPSTciXjTS22+FQ/wrezosDVp
        kbgxzFBWLSsPk2dpzY80Gb7iDw==
X-Google-Smtp-Source: ACJfBouAHM0uxCg+0SFl8FaziutCfaC5400HKfBetFTpveBo8Hpq9SqcILCkHEELoGmHrshBAFC9LA==
X-Received: by 10.200.14.130 with SMTP id v2mr18628766qti.289.1515449154744;
        Mon, 08 Jan 2018 14:05:54 -0800 (PST)
Received: from dnj-macbookpro.roam.corp.google.com.com ([172.23.222.209])
        by smtp.gmail.com with ESMTPSA id o145sm8364103qke.9.2018.01.08.14.05.53
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 08 Jan 2018 14:05:54 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     johannes.schindelin@gmx.de
Cc:     avarab@gmail.com, dnj@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v5 2/3] Makefile: add Perl runtime prefix support
Date:   Mon,  8 Jan 2018 17:05:50 -0500
Message-Id: <20180108220550.66256-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <nycvar.QRO.7.76.6.1801082125210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1801082125210.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-01-08 20:27, Johannes Schindelin wrote:

> > Maybe we covered this in previous submissions, but refresh my memory,
> > why is the *_PERL define still needed? Reading this explanation doesn't
> > make sense to me, but I'm probably missing something.
>
> If the reason is to accommodate Windows, I think it'd make more sense to
> change the way Git for Windows handles this, and use the same relative
> paths (if possible, that is, see the GITPERLLIB problems I mentioned
> elsewhere and which necessitated
> https://github.com/git-for-windows/git/commit/3b2f716bd8).
> (...)
> What do you think? Should we just fold the RUNTIME_PREFIX_PERL handling
> into RUNTIME_PREFIX and be done with that part?
> (...)
> As I mentioned in the mail I just finished and sent (I started it hours
> ago, but then got busy with other things while the builds were running): I
> am totally cool with changing this on Windows, too. Should simplify
> things, right?

No objections here. I see it as adding slightly more risk to this patch's
potential impact on Windows builds, but if Git-for-Windows is okay with that,
I'll go ahead and fold RUNTIME_PREFIX_PERL into RUNTIME_PREFIX for
simplicity's sake.

I'll add a "NO_RUNTIME_PREFIX_PERL" flag as per avarab@'s suggestion as a
potential mitigation if a problem does end up arising in Windows builds,
with a note that NO_RUNTIME_PREFIX_PERL can be deleted if everything seems
to be working. What do you think?

> BTW I managed to run your `runtime-prefix` branch through VSTS builds on
> Windows, macOS and Linux and they all pass the test suite. (Including the
> RUNTIME_PREFIX_PERL=YesPlease setting you added for Travis CI testing.)

Great news, thanks for doing this!
