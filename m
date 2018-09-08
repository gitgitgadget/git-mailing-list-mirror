Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7BA1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 00:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeIHFSr (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 01:18:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45679 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbeIHFSr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 01:18:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so7739694pfo.12
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 17:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yoh1VShvieBGm9PPuJAiJMlf/N0FsQp4TPO+iKkTqJc=;
        b=GJvq2smNv+Hxg21QBCfBBunUDE3EBAqGt4LdhsaWbFmNLYH/yvGAtK5kOXYWvqyVVn
         biFoQaQN55jO4/GLmPov6jfIL2j/v7a9poqj+kDENhPB96rrR2cPW1KgyH7tdChemeUK
         fuRWHXk8VI4s3rVJZxFG16Vd3HAo44bSexl2Yp5Hxm4/bvinDjmLfabileMnIpTnKsP7
         oQxukbNUfdiSjRbH/wd7FoEWJqo/wsG7waW48gaHsMoLuU39AYcqgg1PhaZCTNAAeYXM
         K2BV9mQKyk+bVQ8BEXFPYYdrXsJTTGiNTHGmu1kCWueQYWyM02k9rQQ/8vnc9hhtBoBQ
         ysVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yoh1VShvieBGm9PPuJAiJMlf/N0FsQp4TPO+iKkTqJc=;
        b=rjtg0kh6IaEKM4OWXq276GNsXyfPQlf92aFwdE053BaOU343Q43i3lVdbb44AiM/qo
         GqIfuU8U2R1elzLX9sYrfJJpShzZiWFaQai9Tw2DGspqgtIDNwfZE57Q+abtixXpsHbw
         3cvSeE5F0fLxJVZMXshG/ZAyOB/pcdW5yqk6d8i0JIwYJemlhJGGe/4rCs8CQxHFAGh3
         X3wH9w0oQuSXqY5IP4TF04mnESu10wnG66arM6fhIWJJmat1WsnWDEzEGiEroPcvCfgb
         ykX9AXDIzODLQNeBJh5vVz6YmIGf9geh3ABT1wrlw43JSVIXQ5daGRdhqVRcHaxLohgf
         Lq1Q==
X-Gm-Message-State: APzg51Bq/tnT3t1mqTb4cfSM+7eep355LdG3mRmVAuOyI1nTu3pr4R7o
        uqgWCboFhvHuklwL1rW/Vkxdb1Sr
X-Google-Smtp-Source: ANB0VdYHGomQmYGUuxzEUjd904XkcNLLj2QHs/2uKplNqLlwC93CG+/SFcLp1wOc0khU7FdDc4KQwQ==
X-Received: by 2002:a62:9349:: with SMTP id b70-v6mr11368394pfe.193.1536366916761;
        Fri, 07 Sep 2018 17:35:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 8-v6sm10719226pgu.10.2018.09.07.17.35.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 17:35:16 -0700 (PDT)
Date:   Fri, 7 Sep 2018 17:35:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.org>,
        git-for-windows@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 2.19.0.rc2.windows.1: stash fails with dirty submodule
Message-ID: <20180908003514.GC225427@aiede.svl.corp.google.com>
References: <6e01daf2-5fb7-b6c0-2833-aa696241c609@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e01daf2-5fb7-b6c0-2833-aa696241c609@virtuell-zuhause.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thomas Braun wrote:

> I'm using git with stash and rebase builtins.
>
> $ git --version --build-options
>
> git version 2.19.0.rc2.windows.1
[...]
> mkdir test
> cd test
> git init
> echo 1 > file
> git add file
> git commit file -m "message"
> git submodule add ./ mysubmod
> git commit -m "Add submodule"
> echo 2 > mysubmod/file
> git checkout -b mybranch
> git rebase -i --autosquash master
[...]
> fatal: Unexpected stash response: ''
>
> and that used to work with older git versions.

Thanks for reporting.  I'm cc-ing Dscho, who has been looking for
reports of issues with the new experimental stash and rebase code[2].

Thanks,
Jonathan

> [1]:
> https://github.com/git-for-windows/git/issues/1820#issuecomment-419411808
[2] https://public-inbox.org/git/nycvar.QRO.7.76.6.1808241320540.73@tvgsbejvaqbjf.bet/
