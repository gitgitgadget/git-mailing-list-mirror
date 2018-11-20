Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37D901F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 12:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeKTXYY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:24:24 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43244 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeKTXYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:24:24 -0500
Received: by mail-wr1-f47.google.com with SMTP id r10so1848502wrs.10
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 04:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQfBCYQ1tP0UMhOqSlGrf37ofMbkdmsmIz+oiQ1ERMI=;
        b=I903YOR1XUIw2f9ykedm5Bkee0bWqA/SCtQU6/Oh38k1oF+67S9zkzq18zirdcn7oo
         aHngeMBG2EnNFhtURPGxMZ7hQ9Wq/crHKkteWyA9m0la9MnEt9Tkt2deOVJRzrpkjOnk
         aS1KrIGM/tsNouKMHTEWufw5vtJYQstU+diuVYjfAqbF2vKujtRqTxg+yXEFpx62Wnb5
         VtP9H7+eOXcBelLTt0VyvY2IDWoGyEJQyfhBPsUq3PI4BXdyH58a5exi76GO2MMhaLew
         n4VEVWvjoPolEeqzv1BuEVh32PWiEHfzoYHBFlavsJweKFaRiKh6LotvKk7FuzX4K7Xf
         Oc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQfBCYQ1tP0UMhOqSlGrf37ofMbkdmsmIz+oiQ1ERMI=;
        b=LwMOLRTspRK2YhcuTfgqu8vWZGtMn3EmhlBEjMJMI7giFOXKF2hCFE/PhHJZXenztj
         gIvlaRuSnOClCk2wWi/E2LfcN5I+biIS66k9iGa5OLIw9T89bYEEjv3jC9XHKPEXluF7
         0z/1fY3RcB4yqafWC9ughcF+eKXrDE+OLhLQ7q5IJL0CUWl8y2uQO4x3hwZMRtQkMB82
         VhOlNaREbIYQchCI0vhgYNx6OZEyK65HmUkyRV291oyoh7kYXNbNAYyc0K466N4cTKnN
         4LmnBKZdueGHk5fRVULCOLeslr4k/3ZwWXiFnDPe9nUuytItrioA9aaslpmHz+31Ap6Y
         l7ow==
X-Gm-Message-State: AA+aEWYBdicmJne2pLtn+Udo7YScdtqVm6pdaIpEMGqjyAFZLnwTOpxv
        FTVM2wG2eTB7XnjZyxjeYPCwVB7r
X-Google-Smtp-Source: AFSGD/VtdmT7j8EeaJFRyGyDYVOU2KoFpKJcRh23D9FU6AmHMAnoQewczunSJ8e5PKoPyaCeUM4xqw==
X-Received: by 2002:adf:e3d0:: with SMTP id k16mr1978527wrm.223.1542718522849;
        Tue, 20 Nov 2018 04:55:22 -0800 (PST)
Received: from szeder.dev (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id p125-v6sm841171wmp.2.2018.11.20.04.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:55:22 -0800 (PST)
Date:   Tue, 20 Nov 2018 13:55:20 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     git@vger.kernel.org
Subject: Re: How to prepare patch for git am which remove a file ?
Message-ID: <20181120125520.GZ30222@szeder.dev>
References: <CA+7wUsz5WyRcxMTUWTg13K866vWWp+bVGSZJFU1hRSL1Ehr8Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+7wUsz5WyRcxMTUWTg13K866vWWp+bVGSZJFU1hRSL1Ehr8Aw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 01:39:40PM +0100, Mathieu Malaterre wrote:
> Here is a simple setup:
> 
>   cd /tmp
>   mkdir g
>   cd g
>   git init .
>   wget http://central.maven.org/maven2/org/apache/xmlgraphics/fop/2.1/fop-2.1.pom
>   git add fop-2.1.pom
>   git commit -m "My First Commit"
>   git rm fop-2.1.pom
>   git commit -m "Second Commit"
>   git format-patch HEAD~
>   git reset --hard HEAD~
>   git am 0001-Second-Commit.patch
> Applying: Second Commit
> error: patch failed: fop-2.1.pom:1
> error: fop-2.1.pom: patch does not apply
> Patch failed at 0001 Second Commit
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> What is the black magic to get `git am` to understand this patch ?

The file in question uses CRLF line endings.

  $ git am --keep-cr 0001-Second-Commit.patch
  Applying: Second Commit

For explanation I quote ad2c928001 (git-am: Add command line parameter
`--keep-cr` passing it to git-mailsplit, 2010-02-27):

  c2ca1d7 (Allow mailsplit (and hence git-am) to handle mails with CRLF
  line-endings, 2009-08-04) fixed "git mailsplit" to help people with
  MUA whose output from save-as command uses CRLF as line terminators by
  stripping CR at the end of lines.
  
  However, when you know you are feeding output from "git format-patch"
  directly to "git am", and especially when your contents have CR at the
  end of line, such stripping is undesirable.  To help such a use case,
  teach --keep-cr option to "git am" and pass that to "git mailinfo".

