Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EBD81F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 18:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJKB7h (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 21:59:37 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38615 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJKB7h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 21:59:37 -0400
Received: by mail-wr1-f42.google.com with SMTP id a13-v6so6861080wrt.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nfHYRBt6KmNlouDjjV0jkBQsWaTLtEf7mBcjgtxNYWs=;
        b=nvRM2kLn67jZrw6dqrxy2LZoxc4EYXrN0KRdx9xA95jSzEzTNYNt57U/hXsTUKbv3J
         YwtnhqcHP5ZHZNLNQNvhaJCHz5hU3Rn4sj+T1FgAOnShUpwuN0LBwwLjyaepE4n4KjT5
         xkV+OnfGngb27udHqM03plISzHHk7IGqZ9LABoQA7rk8Yki8vb+7dZD30UhG+KqNeGw3
         rW0LNfHGsjayRze3Uu9bSZGpKwHDd4p7yj6voQ6aMzXU0SieHRWdm8rTAQ1ESJiQM+qE
         NC54qmJara+qDAqQDb0i0oDN1lJV1Bon7hEJDcsKk+wQRsgnwovP9oapECjo5XYvSWtI
         HySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nfHYRBt6KmNlouDjjV0jkBQsWaTLtEf7mBcjgtxNYWs=;
        b=scaH4aegEODAxKrVN090KM0F/Gr7Tsj2LQsKolecIIi8xb0jCN34nM/E3NjTlHFivU
         tzGZ5v2+pMSp+h2RIHHcGF7ENmhsIhZG5s8wMNpODFPuC1ac9EeIVBHj+rGQR7VJ63+A
         RoKqN4VLoebUKB1dVixePIdCTbcQ69TMtCEMqKZIrqetEIJ5cvx62UYTi/sHTpTtw94h
         2rzfIYEcfpTAXugMNYPJ4hbz5uTl9MnihZYosLH0hwCwrQF7WMYoJtw+3ntpu0bW9kSd
         5lH177TgzzSoOknFHtg6Bi9GmuXLM9uL/+4tyTBprScceiZgQHTwxr0rtZPJl+KGyjAZ
         +c+g==
X-Gm-Message-State: ABuFfojIvyVweZ4n23jS4D8RzDUh1EWPGZABHpYP+tCJsbCmoCpjHhtS
        Tr65ftOD3ZjZY0/z2K9cGvCyvf5M
X-Google-Smtp-Source: ACcGV63xf1i44bpBfblCEg8mUrs7UafZiEnFG1eU4FjbhPNOq3XLBnBlqDNGaloKcIKHuETDiqM/Qw==
X-Received: by 2002:adf:8461:: with SMTP id 88-v6mr23389082wrf.251.1539196572368;
        Wed, 10 Oct 2018 11:36:12 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:5442:f733:1c55:6988? ([2001:a62:81d:ab01:5442:f733:1c55:6988])
        by smtp.googlemail.com with ESMTPSA id b1-v6sm15455901wrt.43.2018.10.10.11.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 11:36:11 -0700 (PDT)
Subject: Re: Git svn bug on merging svn branches
To:     =?UTF-8?B?0JDRgNGC0LXQvCDQodC10LzQtdC90L7Qsg==?= 
        <artem.semenov@jarillolabs.com>, git@vger.kernel.org
References: <49aa05bf-1848-51ca-8b98-5f1796dd8bdf@jarillolabs.com>
From:   Andreas Heiduk <asheiduk@gmail.com>
Message-ID: <a74ed565-124c-0047-57ae-5857ab644b23@gmail.com>
Date:   Wed, 10 Oct 2018 20:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <49aa05bf-1848-51ca-8b98-5f1796dd8bdf@jarillolabs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Am 10.10.2018 um 01:38 schrieb Артем Семенов:
> Hello.
> 
> Git svn bug on merging svn branches:
> 
> Svn repository (branches tag trunk).
> 
> 1. Add a some file by svn tools.
> 2. Create a new branch by svn tools (e.g. br1) .
> 3. Create a new branch by svn tools on branch br1 (e.g. br2).
> 4. Add some changes to file f1 in branch br1. Commit by svn tools.
> 5. Clone repository by git svn.
> 6. Create two local branches – br1_svn (on origin/br1) and br2_svn (on
> origin/br2);
> 7. Checkout to br2_svn. Add some changes (e.g add file f2). Execute git
> add, git commit.
> 8. Execute “git merge br1_svn”.
> 9. Checkout to br1_svn.
> 10. Execute “git svn info” - URL refers to br1. (URL:
> https://127.0.0.1/svn/branchtest/branches/br1)
> 11. Execute “git merge br2_svn”.
> 12. Execute “git svn info” - URL refers to br2. (URL:
> https://127.0.0.1/svn/branchtest/branches/br2)

The "CAVEAT" section in the git-svn manual already contains some text about
your case:

       If you do merge, note the following rule: git svn dcommit will attempt
       to commit on top of the SVN commit named in

           git log --grep=^git-svn-id: --first-parent -1

       You must therefore ensure that the most recent commit of the branch you
       want to dcommit to is the first parent of the merge. Chaos will ensue
       otherwise, especially if the first parent is an older commit on the
       same SVN branch.

The paragraphs before these lines give more reasons to avoid a non-linear
history in SVN branches.

Best regards
Andreas Heiduk
