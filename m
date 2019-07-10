Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26DA1F461
	for <e@80x24.org>; Wed, 10 Jul 2019 06:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbfGJGnP (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 02:43:15 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:35040 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfGJGnP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 02:43:15 -0400
Received: by mail-io1-f50.google.com with SMTP id m24so2398330ioo.2
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vjs5/uJT1Uz6Tt2mJSVu7SjsSQvhk6Tkb/HvG2Jpml8=;
        b=qkSMYWhR1iuZzc5cVfjLEsNO/RI20cjifHMw/ohbN1Q7ERMP4FDnTNUnmseTK08JJZ
         h1oRdXLNqXERz9UhCsiHiXpqS1WwFbTUZPSPfS8EVtl8JvI4JwQ/R/An6W8/6I5plgH1
         1SuwehLgIIf+AtJs8+0zZiVR9lAhLW47hkLaB6KAhTnuNMsiGBnbIxEFrWkRQUnoNOry
         pyf7NDEfKkR4Ecq88R28Jo/SnH1YywzMQtZGOhD53WFZenhMwDVClAh6gSjOBVo/pUpX
         ZkTSaXUJMve1yj3xFf1dCyodieGb/Wos/X5lUnaCvs72W5IBVFYVRusU400QxEbrw7CC
         n49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vjs5/uJT1Uz6Tt2mJSVu7SjsSQvhk6Tkb/HvG2Jpml8=;
        b=tmR6JBRa89citxka+Y63i2vPGrsHz1UxlL8P3tkPaSrGlob7EsY0Lw1zqQkgisUGY9
         7KHWDwH5PYlEz2JgR5k2T3ECw/WgqtjnxDGL7nBPIYC8QMJtWOKAJohzuIEEB7Mly+Ap
         kDZRigdOqaI+hl9ic93r/EiIG839WZ//D2bNJFqrgknZHoT2nRycK1Rq5nDjkEQ2/PHX
         yU/8v7lgOKHh65D/0P+FgLXPXDlcgvKKiC9uVsb+XUwGIv1ifOkOXret/aeC8VPmAn2o
         A+xknLlKXqBALt/vqFHL8JYs9M3lAcnJxqjFGf2lBtHp+ImEzCEZ8JZSVR9PCfL3paFs
         k7vg==
X-Gm-Message-State: APjAAAXf9j6DLAvapk6LAK+DmI8H9ogMOWeQ5miyMWfYI3MBzNVMS4vT
        ae1EohhU6afhBXykengV8C61iDG6dSpFXCx3qV6ljg==
X-Google-Smtp-Source: APXvYqzcXbZNZwGFCPpFabuFnpOyUEOrOFyMD3obcqLR5UaBwLmrM+SS066Eawwr/QeWi6PIBujZhm6+gUCJQFPkMSA=
X-Received: by 2002:a02:c646:: with SMTP id k6mr23142595jan.134.1562740994533;
 Tue, 09 Jul 2019 23:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190708111459.135abe50@zen>
In-Reply-To: <20190708111459.135abe50@zen>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 10 Jul 2019 03:43:02 -0300
Message-ID: <CAHd-oW5Q1PWDzWKpsmdv4ecUMrQTj4Vyh_SoVu6vaFeSFmxE5g@mail.gmail.com>
Subject: Re: Weird behavior with git grep --recurse-submodules
To:     Daniel Zaoui <jackdanielz@eyomi.org>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 8, 2019 at 5:22 AM Daniel Zaoui <jackdanielz@eyomi.org> wrote:
>
> Hi guys,

Hi, Daniel

> I work with submodules and use git grep a lot.
>
> I noted that when it is invoked used with --recurse-submodules, the resul=
t is not as expected for the submodules. I get submodules results as if no =
files were modified (like --cached option) although I would expect results =
taking into account the modifications.
>
> Expected behavior:
> git grep --recurse-submodules string:
> - git grep string // search into main repo
> - for each submodule, git grep string // search into submodule
>
> Actual behavior:
> git grep --recurse-submodules string:
> - git grep string // search into main repo
> - for each submodule, git grep --cached string // search into submodule
>
> Do you get the same behavior? Am I doing something wrong? Was I understan=
dable :-)? Is it a bug?

It seems git-grep was taking into account the worktree modifications
in submodules before f9ee2fc ("grep: recurse in-process using 'struct
repository'", 02-08-2017). I'm not sure, thought, if this behavior
change was a bug during the conversion or a project decision.

CC-ing Brandon, in case he has other inputs

> git --version: git version 2.22.0
> uname -a: Linux daniel 5.1.15-arch1-1-ARCH #1 SMP PREEMPT Tue Jun 25 04:4=
9:39 UTC 2019 x86_64 GNU/Linux
>
> Thanks
> Daniel

Best,
Matheus
