Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B581F803
	for <e@80x24.org>; Mon,  7 Jan 2019 17:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfAGRON (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 12:14:13 -0500
Received: from mail-vs1-f48.google.com ([209.85.217.48]:39736 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfAGROM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 12:14:12 -0500
Received: by mail-vs1-f48.google.com with SMTP id h78so695271vsi.6
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 09:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LsKab2Pi6lzjnxHvMu90CkE1qmTVIM7LpJTSUbbvQRQ=;
        b=J6f6tV8GeTJ3IvTeJeTFvxgjil3Yi/PFjmvGWb3F8sZH7tXHIfjgqYDLI6xeIOT/hl
         BSNzJEuMv8lW+CqOoMOxZvrNc9CpS1dt+VUPT7sqB6VsLQ414oo3Tg5cZbxSv4xUtY81
         7B6KJtPArJpeve0m0sGJSwnirbMhQE9az8OL1T13Z3h62tzP+sLJziUHL9pjyZAG8dHz
         Hz2HPUKSK4BV7lxCc/sz/+Tnkl0azx56hoB8WdKOWU8CuZwuIaMFjIdGFUfhC9YJV8CZ
         Fv5+HNt4chaGOH/Y64kiEKrrMgremgGYwQlS00LSVgaBepLtP9wnlTrMc7bSQDecj3Hj
         HsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsKab2Pi6lzjnxHvMu90CkE1qmTVIM7LpJTSUbbvQRQ=;
        b=Ati2xxpYINImMDDvIW52Cm5BI+U8H+HM0w1sgSv21IQcy7O1Pfo679h7s1XGLxVMZB
         6HhiWsSgiegqg7evUX3ExfGfqwhJVw6/+sw0J8Lbh3nulxERjCYrhNh5U0SXrsOQo0xG
         CMvjvkEbE95mAYa5CVDy3I47tGJqxu5/udvVclVGgV93f/ngK/A26OOldQB6SINRVCRA
         aZ+qgWYq5ILiXLQkdZ/Z/en1MnKfftRpcOw/XEwLtB9mQusMhbh0FGZcYmalWeW3Rra0
         In5J6ZjNg6XIqfaZJj2pDmPOZFP0rkJuh1fW/n7PISjCtH4ZqpbFaDdrgeBJW6D2gkXw
         0Ezg==
X-Gm-Message-State: AA+aEWYchfzE3YrODwBOKtSYPtIL1WJcu0cHnIhI22ciMlv+Vfj+I1rt
        W8kpVtB7CunHXhBSb1TLWMUz5QyPEmpXgomPGU1VEw==
X-Google-Smtp-Source: AFSGD/VEbp7OSBu9GwqrxdcftDXhj68+4whC31zbM09ai3wB/oEOn8Q/6MvLmd4m5cngXrlAvHIj8nLomhZM6i0z/Gg=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr26303363vsm.116.1546881251282;
 Mon, 07 Jan 2019 09:14:11 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com> <CABPp-BEd5-0Vcv8YApUxo0jK_ofxCORSG5H0wU=kiR2aOY1ztQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901031424340.45@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901031424340.45@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 7 Jan 2019 09:13:59 -0800
Message-ID: <CABPp-BFPSMD1CTsw2aT9586jRoZdGKL=hqMoSqAz_A7LPSfP4A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2018, #02; Fri, 28)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Thu, Jan 3, 2019 at 5:27 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
...
> > I was going to re-ping in early January.  Anyway, it may be worth at
> > least updating your note to "reroll exists".
>
> It is early January! ;-)

Indeed...ping incoming.  :-)

>
> Ciao,
> Dscho
