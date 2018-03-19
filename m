Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9ED1F42D
	for <e@80x24.org>; Mon, 19 Mar 2018 08:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932484AbeCSIj0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 04:39:26 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:39722 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932143AbeCSIjY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 04:39:24 -0400
Received: by mail-wr0-f170.google.com with SMTP id c24so5828198wrc.6
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 01:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinogroup-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=dNyGigNfgDLumqZqEhBjNwRYlv6LwxrFPMQ8EaPUu0g=;
        b=Jby+yrZj8LoKfP+db/PvY1Q5sYtUUwpsMSqlu+Kb/cBXCKsUj8YPxngrYtZbY0upgx
         2gR5B2rfABTDEL4+Bz31CuNy41xTIDQzWN14DCxSaCyZmG1wkR94W2IWkJNoHxjXOW5y
         3h55ngs4zZ3zto4gJ5rO14CBStbI+exq1FQggM1b4HvVgi4o6mmGsKRrrWhdk3gedfGO
         aCRjZQHP28kE1AWKul0W5yU/Hh3t+oBauB4LvLOCO0gOhh1Y5K/Tz8OoAedeaaBdwjRK
         ouLKOx52sDD6QDmuAMqsIiqNw0Y742D3UAvzDCb2ZdwPw9SzVAzRGUWmIFx4LQ/+oUB6
         jt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dNyGigNfgDLumqZqEhBjNwRYlv6LwxrFPMQ8EaPUu0g=;
        b=Z9hXxE65pxHf7bv6ZwWHzG9otF4VuqJmngSFGLyG86d5EOCexW0f1IO6e/yXwPtYUU
         Y/Qcr2Jjxz0iRZyoGa/hFqmi6Towc5kPD6XGttJYf5QIjDgq2+4vUH/9uw3CHTr5FV/6
         VaQ1ncZhesorgdH3bxg/krN4XPFwL+1ex2x8JpOETJ8zeBALWZN4wm9lwD51pCOYJTby
         0U46LInihqvQa3SI+LKOA5qkk+3Ou+QoHHABukQtn2a/vd3WSE7712E09T2Xu7a+5Gsq
         BM46iTi0gr7cFQWo8tcVj+bkK0IEdpVbJ/m9Gv7blGqKWEXKH8nRosoZc/o09IUAjtkB
         XPwQ==
X-Gm-Message-State: AElRT7G1pDleVAhny+EVgwoNZib+6P0+exlX1E14EgOqEuK+MNNmhH/G
        B8+BDQiGoFpkjy3ZUINz0uIDNgZKeyJrXTeQIsWw3XhwEZIyvrOE8Dvtuj2BkuNUfIiUy9LcGGZ
        sHI3j1HPM/PrYqRr63/pqmGLr6GXKBtBFvUFEckbVrVYHjE16CtCaVsdIjUc9UyJYsMwlqNNaHZ
        wX/JC/RBTvJgJw6CKKYmRrIM0f7dP5L0pkrkYqHYQ=
X-Google-Smtp-Source: AG47ELuMmfEVQ4S3g1soNOQcvB3F2FmvTfEvGKnaKtXd6phhRDMh/aGWIPX+3rMv3r9ZTUbHOgyCxEIPLzl+hwL9DpA=
X-Received: by 10.223.149.129 with SMTP id p1mr8198841wrp.11.1521448762864;
 Mon, 19 Mar 2018 01:39:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.158.9 with HTTP; Mon, 19 Mar 2018 01:39:02 -0700 (PDT)
From:   Luciano Joublanc <ljoublanc@dinogroup.eu>
Date:   Mon, 19 Mar 2018 08:39:02 +0000
Message-ID: <CAO+-ZX_-COVpzqoAZLRGu4mvLMkLYiR3y7rkCtwmnvJ8kA7txQ@mail.gmail.com>
Subject: Bad refspec messes up bundle.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yesterday I created a git bundle as best as I can remember like this

git bundle save chunk chunk.bundle --all master

Note the 'master' I added accidentally at the end - this was a user
error but still the bundle was created.

When I tried to clone this, I get

~\local\src> git clone 'G:\My Drive\chunk.bundle' fs2-columns
Cloning into 'fs2-columns'...
Receiving objects: 100% (31/31), done.
Resolving deltas: 100% (5/5), done.
fatal: multiple updates for ref 'refs/remotes/origin/master' not allowed.
~\local\src> git bundle verify chunk.bundle
The bundle contains these 3 refs:
3c804437a5f8537db1bfb5d09b7bff4f9950605e refs/heads/master
3c804437a5f8537db1bfb5d09b7bff4f9950605e HEAD
3c804437a5f8537db1bfb5d09b7bff4f9950605e refs/heads/master
The bundle records a complete history.
chunk.bundle is okay

After trying a couple of things, I finally managed to clone it using

~\local\src> git clone -b master --single-branch .\chunk.bundle fs2-columns

i.e. the '--single-branch' option saved me.

Is this a bug? Should bundle allow providing multiple refspecs when
`--all` is provided? I admit this was clearly a case of 'caveat
emptor', but shouldn't this be disallowed (i.e. is there any situation
when this is useful?)

Thanks!

Luciano

-- 
This message is intended only for the personal and confidential use of the 
designated recipient(s) named above.  If you are not the intended recipient 
of this message you are hereby notified that any review, dissemination, 
distribution or copying of this message is strictly prohibited.  This 
communication is for information purposes only and should not be regarded 
as an offer to sell or as a solicitation of an offer to buy any financial 
product, an official confirmation of any transaction, or as an official 
statement of the Dinosaur Group.  Email transmission cannot be guaranteed 
to be secure or error-free.  Therefore, we do not represent that this 
information is complete or accurate and it should not be relied upon as 
such.  All information is subject to change without notice.
