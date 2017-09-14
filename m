Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49718209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 15:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdINPj4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 11:39:56 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:48031 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdINPjz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 11:39:55 -0400
Received: by mail-yw0-f174.google.com with SMTP id t127so479046ywg.4
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=j4ZX/oEZ4MJ74UGoJdp7yAZN5jypeTYHbn35S/fdQ6Y=;
        b=bhR9OL1YF0hzDBOCe3ZeCET/yUl7FL9tRg22K5igJDt4JGRkHuWKhbfM1y5rr9n+cX
         WI39wQmegg+OQIVrwn5agJMMisx8uvTIhsW6boqqZW8o5E60InaX/9WCddwZXq8t6jf5
         0wI1i4Iaxy8akFSldQUsjrnBZM4MZbwYQuMrJ3HVy5visIZXy7tkct9Ej3saqT3/9hWm
         clN4Y7rdtbZleihACgZ+pLp0ihJ3hr4TSGvajsLuCcJmkEwlFz9Gj4FGUd56AGbQrO1h
         luSBBBZGv17nc6gNOcqFodCbqhvCHpJosZAbrGfrtS/TLq8XrNJ904M3nc2Hdt9L1wlj
         BuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=j4ZX/oEZ4MJ74UGoJdp7yAZN5jypeTYHbn35S/fdQ6Y=;
        b=f1wtEDoEIH+TN7PBIPp+5MYyMCJzK17D8GwKyu2oYpLXmi8KkN1li0/naoiPmgbAKV
         HExD6BAzJvm8Tg7HFUUwalgXs2IQss4meG8w5ywx6fxGfCegv6efSGWs8vd8fvUCNqok
         D79uppckNrGa4gihlLTZjGXfLnkhHXwAejQQXKT3j4q27l34yB+VmVr9geV55itYlfa7
         ZAgSyS1yY79Q/uVyRd0whhHWiPQtSQHcFjOXDQmpdZ/UwlDEBuxvIPKhYlL5/BhRqmWN
         L3r5IRPxolUjpA+h8KHb0FQXHPB06VXDUvFyaaxVJi7xnIGYgHPvyb8tsWLtMcLNvZh/
         +17w==
X-Gm-Message-State: AHPjjUhopMosnpxiOlSKQByiajuy0chuBaSVTSgpFhLH2kZVvIJ5lJ2F
        9R39IpLv897WZdQ0EipNmUHEZ/97rsAwnzLyqWPQMA==
X-Google-Smtp-Source: ADKCNb7YqkqzlAWX4Bx1FZEcIM5FmieYS3RJ016pMmlP+uysUh0FHQWzKAoq1exbm/IQKK6/M7QIWlCsvcqMt2XBt9M=
X-Received: by 10.13.251.132 with SMTP id l126mr18587693ywf.175.1505403594546;
 Thu, 14 Sep 2017 08:39:54 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.82.203 with HTTP; Thu, 14 Sep 2017 08:39:53 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 14 Sep 2017 10:39:53 -0500
X-Google-Sender-Auth: MN1AAHcofcQqA-ThFwrXZ4hnQRQ
Message-ID: <CAHd499ApnHpt0CmcQMx+qVQ60NV6auFKkuvikCq2Zut4p4rzaQ@mail.gmail.com>
Subject: Rebase & submodules
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So I often will have a submodule that points to one of my own forks,
because I will have work done on a feature branch that hasn't been
merged upstream yet. Assuming this merge takes a long time to get
approved, I will occasionally rebase my topic branch to keep things up
to date and clean.

However, any previous commits in my parent repository that refer to a
SHA1 prior to the rebase will now be pointing to dangling/orphaned
commits, which means I wouldn't be able to go back to that commit in
history and do `git submodule update` since that checkout will fail.

One obvious solution to this is: Don't rebase. But, this could result
in a lot of merging between the upstream and my fork which would make
things not only ugly, but prevent me from making a pull request that
makes sense to the upstream repository (They'd likely request a rebase
in order to accept the PR, which I wouldn't be able to do for the
reasons outlined above).

Are there any other workflows that would support this kind of model better?
