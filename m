Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EB11FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbdBIWX4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:23:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36147 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdBIWXx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:23:53 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so1349536pgf.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 14:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5sgzfz/K0t7q6KPKWsOxNei5qXinlJ2zAUvV1QGfF6g=;
        b=M9Nog2WU/iBISkZZemQhINV/5PWPRlUqqtidbq0G9eIHs+DqWz250V1YYpVG9wWjcV
         pj/ewealqx+dJHQwHVg7kvQxJ9Bfw67hkm0h1jHrRTDc1LLUHNFx0oQ6Py0qf6LGD/32
         lks3w61VloegPiuw0Eqwm0sngfzHP5b7mm1doWPE9vZJMzZXL92zNBOcHyTezk7aVlaa
         hmGAwNNq+o/YA3L9JkoISp6P7PQYxwgcPQS71LTi0QVf7Rk0kQ3QaWVysXM0UEsM2hbo
         +xZv64LhWrHMs9CD23ol2CxTKOVlfih4JiUXNce81bQ52y14r0JUd2b5XhJLn9m7P20A
         IGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5sgzfz/K0t7q6KPKWsOxNei5qXinlJ2zAUvV1QGfF6g=;
        b=Ul/jbvzr3Hkb1IyUuj+W0GZGt8f0LTShf4b0i6q8KYvpLH4qAnlnv8svimCKa3yPa9
         w0EY+O9xhF8ChN6ih92r1MzuerMwKmyaCFrPPTUPM4YFPMdlDmahDeKX0uqijQ84w2oE
         f4D+YDkm0m4dsHhZG7fxQLYPwkuUJuAuCwd5bhizBLDV/TMZrQX9ybO2fsq8XFplvyja
         1wijTzZ6dY7noN9yEKODXJ/RV19hDDNzgXCzc2iscUCSmiu2OvLSFPnq7kqW3YFZSQMx
         hWZsK/r9bzLFZBio5njGr2S2zRq9o0KLnSpW2aWSymVC3WS6/U3nIRO8uj757IlSmb/V
         EFEQ==
X-Gm-Message-State: AMke39ncJG4j8PVGrV0ydMSc08g/BgvTT9W1SrvyNN49fZVtIFdiKwdnFvD2go1LI6SRCg==
X-Received: by 10.99.8.133 with SMTP id 127mr6717919pgi.42.1486678565379;
        Thu, 09 Feb 2017 14:16:05 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id b10sm31524462pga.21.2017.02.09.14.16.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 14:16:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com>
        <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702092142020.3496@virtualbox>
        <xmqqwpcznjqi.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702092301070.3496@virtualbox>
Date:   Thu, 09 Feb 2017 14:16:03 -0800
In-Reply-To: <alpine.DEB.2.20.1702092301070.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 9 Feb 2017 23:02:51 +0100 (CET)")
Message-ID: <xmqqd1ernh7g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Almost. While I fixed the performance issues as well as the design
> allowed, I happened to "fix" the problem where an incomplete prefix match
> could be favored over an exact match.

Hmph.  Would it require too much further work to do what you said
the code does:

> The rebase--helper code (specifically, the patch moving autosquash logic
> into it: https://github.com/dscho/git/commit/7d0831637f) tries to match
> exact onelines first, and falls back to prefix matching only after that.

If the code matches exact onlines and then falls back to prefix, I
do not think incomplete prefix would be mistakenly chosen over an
exact one, so perhaps your code already does the right thing?
