Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D172E1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 22:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfD2WNG convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 29 Apr 2019 18:13:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51993 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfD2WNG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 18:13:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so1264463wmf.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2019 15:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rh289tJWTta9P8griAXaISSs1qIQr/qOb9QqnxELlg0=;
        b=SUpQbRMCacEZ33QdhU1zFpWaHVBqCMzy84voiKxXBM9pZJabCyPmT+aPFwAh3Ja9R4
         VcPIIMAxumZAd8KRXRx3hzXYzj4D5ToET9+B/eqJndtOiFjuYNkTNlQvmUwoEvkW4YLN
         ulLe4wABU+wFT3lKrw7lpzWGy97i85DE30uPeqhsx9Bj8APffMV+7h2dB0hv3lo9iUGi
         nS0nznQwdRpEDw7Dz2ANkwDhlVfdyCfi2GY1qhEVVwVknk22oWnxK1QpOHfVHgNl55Hp
         DRLCejHX+oC5y860Uv8jROx2ZddKtO08ceusCIU4EVQCAt9xXGYO5kbEhyd21I6C7LOP
         S6EA==
X-Gm-Message-State: APjAAAWgitKdL8VhCetLjT/62Sj0wF02kCCIb54EA1Pn5jrViiKyf7NH
        ZYo26BTP/e4bi5XdwqLLPdVfAAIonYYMPAhocmxG8g==
X-Google-Smtp-Source: APXvYqyUCXUtVvXl+/p4w3ZKcAtMS+apRMLfF0ZIxbhcALt91EWwJukslEehv4vRvWjy+rVgSA1HlT7kli+bWECymhw=
X-Received: by 2002:a1c:a184:: with SMTP id k126mr776849wme.71.1556575984276;
 Mon, 29 Apr 2019 15:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.138.git.gitgitgadget@gmail.com> <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com>
In-Reply-To: <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Apr 2019 18:12:54 -0400
Message-ID: <CAPig+cSiv+4xh6bWDTggBiApywAmAx6eQLq+Dh116kO2+cf_kg@mail.gmail.com>
Subject: Re: [PATCH 1/1] credential: do not mask the username
To:     =?UTF-8?Q?Jaros=C5=82aw_Honkis_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jaros=C5=82aw_Honkis?= <yaras6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 29, 2019 at 6:06 PM Jarosław Honkis via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When a user is asked for credentials there is no need to mask the
> username, so the PROMPT_ASKPASS flag on calling credential_ask_one for
> login is unnecessary.
>
> The `credential_ask_one()` function internally uses `git_prompt()` which
> in case it is given the flag PROMPT_ASKPASS uses masked input method
> instead of git_terminal_prompt, which does not mask user input.
>
> This fixes https://github.com/git-for-windows/git/issue/675

This link is dead. Is there a more modern URL to which this can point?

> Signed-off-by: Jarosław Honkis <yaras6@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
