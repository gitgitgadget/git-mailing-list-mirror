Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85C62036D
	for <e@80x24.org>; Tue, 21 Nov 2017 17:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdKUROd (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 12:14:33 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:41707 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdKUROc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 12:14:32 -0500
Received: by mail-ua0-f169.google.com with SMTP id l25so8741496uag.8
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 09:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5wPJ8jalfA6WPyOqiMuCGcVMvL/ztNsRuepBGukqvzQ=;
        b=jPfFQDLUgozlcPZYVFdSMZ46+pJCds751V5wz5EhEWx30UbEjBfP9wsf94QO1KO0vp
         9d44LMfaO8mCAlJ1edj9Eui0rk1dxiBFkU7d0wUgpzNOp7wIqweRKRXQz6gW8U0PLcnz
         UJe6nOOyvOMR5FkEE8840X1eazJy7vGVg8oIoN2orv4G8ckgviZPCf+hWHpUzEHb6d1c
         bWAkkzdJpXJUnlsFf7xVaetgO7Vhe8bqU6id5BktptZ7f5TuYhV1gZOgKnTqclvUXTCo
         Biey3UO/4y5MqRsB+0JinlsZAKw3QCVKH/JFAo9P8c7Tq5YjUFJyRib3If5L2XKmqS4O
         LuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5wPJ8jalfA6WPyOqiMuCGcVMvL/ztNsRuepBGukqvzQ=;
        b=OLfyihFq9MTzkasNlZKYxKaB8zyOUH+OYRVirly8FmjETwMLO2WZ6/pPpF1EMkZUeg
         qwtrZM4glYSUXgZwOSt9X3r+6oYXhJIOVve+U00DGeXu1XZrVB0T6xFs00kgjZvmXBK3
         ggDyzDvAiRsDMl+9ZuUOName0qOy/Bn6naxPObxMYgNHXRlHVDLClLxu42S6sfTmgqXk
         wcSzpxlZ2U5EKjXL5xhXSApJf2C0M1H0d54wPu1eeYlK9D9ZHZ26KgC1xaCaghxR93e1
         kmGAlDsV+tlynDYmGBraAg++ccftv3Jt3Hl+ZZQabtoK7P4HkbeJNjBkmo1BxHAd+tcb
         6lSg==
X-Gm-Message-State: AJaThX4O6wmnRC1TDQxm3B5EJpI6p36eRyUIZpjfpC85atHIA3iSSt/t
        6fL4M938gPvAU3efzylXpiFOjba9dRaCoZGGrv0=
X-Google-Smtp-Source: AGs4zMa3ARAlLI7SOeQ8LwNXHx2ZLZwUxo7fIHepW2XtdlcNj7Lv4gKbNHa/hHkDY9HDhQIX+Z1sJItAN+Bnlx5iF8E=
X-Received: by 10.176.82.73 with SMTP id j9mr6621839uaa.9.1511284471790; Tue,
 21 Nov 2017 09:14:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Tue, 21 Nov 2017 09:14:30 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1711211303290.20686@ds9.cixit.se>
References: <alpine.DEB.2.00.1711100959300.2391@ds9.cixit.se>
 <20171110102011.yqtka6a3wmgcvkl6@sigill.intra.peff.net> <alpine.DEB.2.00.1711101333030.2391@ds9.cixit.se>
 <7e242038-50e5-2cfc-e810-401af78b8cdc@gmail.com> <alpine.DEB.2.00.1711101436270.2391@ds9.cixit.se>
 <CABPp-BEu_DOg5t0qHnyLYSok+J+onGFPoFBbgp9P-S5JfhcRjw@mail.gmail.com>
 <alpine.DEB.2.00.1711131221150.22867@ds9.cixit.se> <CABPp-BE-bJnLTf7Y-6_uy=+QA2pi=6EAmGy8S2n7B5Ry8ckHuA@mail.gmail.com>
 <alpine.DEB.2.00.1711211303290.20686@ds9.cixit.se>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Nov 2017 09:14:30 -0800
Message-ID: <CABPp-BEQMMa4Q9MOHpjyzAs=n79qMe6XbOn6ryaeKeUtkrxenA@mail.gmail.com>
Subject: Re: cherry-pick very slow on big repository
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 4:07 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Elijah Newren:
>
>> Sure, take a look at the big-repo-small-cherry-pick branch of
>> https://github.com/newren/git
>
>
> With those changes, the time usage is the same as if I set
> merge.renameLimit=1 for the repository, and the end result is identical:
>
> $ time /usr/local/stow/git-v2.15.0-323-g31fe956618/bin/git cherry-pick -x
> 717eb328940ca2e33f14ed27576e656327854b7b
> [redacted 19be3551bc] Redacted
>  Author: Redacted <redacted>
>  Date: Mon Oct 16 15:58:05 2017 +0200
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> real    0m15,345s
> user    0m14,908s
> sys     0m0,528s
>
> Thanks!


Cool, glad it worked for you.  Thanks for testing it out.
