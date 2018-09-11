Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EABC21F404
	for <e@80x24.org>; Tue, 11 Sep 2018 22:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeILD0X (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 23:26:23 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:35136 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeILD0W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 23:26:22 -0400
Received: by mail-yb1-f177.google.com with SMTP id o17-v6so10074589yba.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGaq1SGSfS1B0YP7f76hmwYyltqjqnpGl4ZgpJ7oI0k=;
        b=TnljXaNDZajfIgx9TvPL4TIhVdxtFqC7hHKWncDExk9Tcjw/kNk6zFZCmZWR0Ipy+B
         C4hADvFx8Z4ghPTNki3UxopaitZ01oEftRUvetLn2J288aKZQvFK+SMsx6z9f9j6phSf
         lrfrzF6dXyWaWhfmrQ9kb2ZNYeAC//whlds8wl0bTPrZfuNh2+6z2usT6LkXmdEMVCfr
         7w0+aKmHQnYDENKCK8NFL2SCzpXa0gjeviOwOZMLedYpnCZSd4W4FM5Y6JSkFSU+romO
         h3qfeuDZE3WQOaur6dHW+iJXl6Vf71AZ8vX9QKpEjYQWjc2SUJK1wu6rQw9PjsVBeYOz
         3FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGaq1SGSfS1B0YP7f76hmwYyltqjqnpGl4ZgpJ7oI0k=;
        b=djikn49zwB3N2FnLoX9hfg2C9rzaR8P+y8XxtNT7eK9oxXe4Jxz3B3s00I3fP74Cc3
         LtPF33oyhRFzPisWgRKrXj5nDHIFykfDZG4AULbc9ZX+N5A3t9m1kCAFo18R7+ll880F
         V1omLUJFizN4+yxuQKPx0EU0Af03rjw1k2qEQz+olqM1Yf1seUIHHk+6vOxWRK5UXYao
         jdx3rVEf7NqAsHNTndvw+g6GN/t9PcH5pqSsi1/1K0BPNAE9kQ8Mhnky8fPQkPvBCeRM
         7wxjZ/e1pu6NEf1vvC6Si5jv+ul3rTq6WkYp71nJt/+ecLE25R3JjPDROMBBGyakHvG1
         YyIg==
X-Gm-Message-State: APzg51CRShXcQjk2hYoC6YvPazGvNKqcYiG0HPIgM+R1GsrOmdTWeG1u
        wo3cObaNIq9/rIPM3T98hwnOo6pjCE3mrjPFw3onWg==
X-Google-Smtp-Source: ANB0VdbGcv4BWBUiruYOFN3w435nOm1AVtBVyUN2pFJfVQVHFBdNcopbdqFE64Hw4GRCq5c/AfIbHXqSiSIEky7C1KY=
X-Received: by 2002:a81:4418:: with SMTP id r24-v6mr14023338ywa.407.1536704697310;
 Tue, 11 Sep 2018 15:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <6e01daf2-5fb7-b6c0-2833-aa696241c609@virtuell-zuhause.de> <20180908003514.GC225427@aiede.svl.corp.google.com>
In-Reply-To: <20180908003514.GC225427@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Sep 2018 15:24:46 -0700
Message-ID: <CAGZ79kadU6Lb14pwJQv=bYrn5wJxO_0UeoSN5BO0t44HC3q6rg@mail.gmail.com>
Subject: Re: 2.19.0.rc2.windows.1: stash fails with dirty submodule
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git <git@vger.kernel.org>, Philip Oakley <philipoakley@iee.org>,
        git-for-windows@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 5:35 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Thomas Braun wrote:
>
> > I'm using git with stash and rebase builtins.
> >
> > $ git --version --build-options
> >
> > git version 2.19.0.rc2.windows.1
> [...]
> > mkdir test
> > cd test
> > git init
> > echo 1 > file
> > git add file
> > git commit file -m "message"
> > git submodule add ./ mysubmod
> > git commit -m "Add submodule"
> > echo 2 > mysubmod/file
> > git checkout -b mybranch
> > git rebase -i --autosquash master
> [...]
> > fatal: Unexpected stash response: ''
> >
> > and that used to work with older git versions.
>
> Thanks for reporting.  I'm cc-ing Dscho, who has been looking for
> reports of issues with the new experimental stash and rebase code[2].

(It tests fine on my machine and I have no Windows machine at hand,
so ...)
This finally gave me an opportunity to play around with gitgitgadget
and its integrated CI for all major OS, see
https://github.com/gitgitgadget/git/pull/38
which is just the bug report put into our test suite.
