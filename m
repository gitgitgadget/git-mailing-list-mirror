Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C2220248
	for <e@80x24.org>; Mon,  4 Mar 2019 15:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbfCDPrW (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 10:47:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34987 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDPrV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 10:47:21 -0500
Received: by mail-qt1-f195.google.com with SMTP id p48so5609155qtk.2
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=lmPHEtEpI0VB8sqbv5dpV6i9e0wlQEUVxP+uE4vG9WM=;
        b=Fm4cIET6L12tyLs76X6rWSyKtLrozLQ/uRFEwOkjUe5y1E74y9GMQXS1DuxMbDaF4F
         w9NtfAaHIbsaXO9xHASz+IobzGhbk4M9buB4wNTIK8B9ZwLcRplK9DObR7R+PE/XOxkA
         KZ8Ep353poE/IVfLVr/5ohzRsJXR6R3hZK91mWyXBqU0zbrC7rLXtWcNftAOctEOekkV
         vkNuYiWfLI9ExPYPLkxicGrAuHGyjsBPNnOFvObJfc/zJ885QDUxaxg4yYrMzESDIFKw
         V86gxPo8Ohi/bET+KGrVAwJaO38ZvZKRp5ndOCmDlh767QqxC/akDICG6ldxJuP0ipuW
         DEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=lmPHEtEpI0VB8sqbv5dpV6i9e0wlQEUVxP+uE4vG9WM=;
        b=iIokfmoqlurjr7bnaCIzRTlFVf7GeoCuPdXJJmy1b6pUi3oaVrYvqKkp1I2Vn61prC
         IzKZ8/XGDogtMGygDgR2X8TiiNeWnkYQgKgsIpQ+DcBUu4pcZ9lu/XTi2W2XK0vC+Cg8
         cAfM0Wy68FwHBTz1b9XMSwHZRISE6vQfj96BvOHXq5IPGTiCDaV44CbvH1SzOvWHQuZV
         Q4waEAJ/eOuEu67Wa0SzAClGgidjAlauqx3GAXdXsd8xFeh5OtDPy4t9AYceINXAJAJg
         hos8wjhB7w54RufspxXwjns5+5wkGOd76F/eqs+x7tCqUSRdfyxknXy9oVS6y1gL+XID
         elAA==
X-Gm-Message-State: APjAAAUabUgXlUcc98TrHd59ll59VF6rqw2BFSr6PTmcqeuJPySjfjSh
        oyDu9tWHoOvkekMQeIfz5rhKUaTNWYE=
X-Google-Smtp-Source: APXvYqzsSXpEJe4FHDFiz/CtuaK4JXbSDstua3O0Cnk7+R8pnf6Zy6KMQzC6YgNjYgnESzgbZ9lT/A==
X-Received: by 2002:a0c:be91:: with SMTP id n17mr14890836qvi.32.1551714440355;
        Mon, 04 Mar 2019 07:47:20 -0800 (PST)
Received: from [10.124.100.9] ([66.210.32.226])
        by smtp.gmail.com with ESMTPSA id n14sm4480723qtk.97.2019.03.04.07.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:47:19 -0800 (PST)
From:   Kenneth Cochran <kenneth.cochran101@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: [RFC PATCH 0/4] Add alias option to git branch
Message-Id: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
Date:   Mon, 4 Mar 2019 09:45:45 -0600
Cc:     Sahil Dua <sahildua2305@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.100.39)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=46rom c1bad54b29ae1c1d8548d248f6ecaa5959e55f7b Mon Sep 17 00:00:00 2001
From: Kenneth Cochran <kenneth.cochran101@gmail.com>
Date: Mon, 4 Mar 2019 09:40:22 -0600
Subject: [RFC PATCH 0/4] Add alias option to git branch
Cc: Sahil Dua <sahildua2305@gmail.com>,
    Duy Nguyen <pclouds@gmail.com>,
    Jeff King <peff@peff.net>

I find myself often using git symbolic-ref to get around work =
requirements to use branch names that are not very human friendly.
There are a few problems with this:
	- There=E2=80=99s a lot of text to type
	- Mistyping certain parts (heads/refs) will do things other than =
create a branch alias
	- It will happily overwrite an existing branch
	- Deleting one that is checked out will put HEAD in an invalid =
state.

I think this solution is much better; however, I=E2=80=99m not super =
familiar with the codebase, so I=E2=80=99m sure it can be improved.
I=E2=80=99d appreciate any feedback.

Kenneth Cochran (4):
  branch: add "--alias" option to create an alias
  refs: add function to iteratively dereference symref chain
  worktree: symref should be found anywhere in chain
  branch: disallow accidentally breaking symrefs

 Documentation/git-branch.txt |  8 ++++
 builtin/branch.c             | 49 ++++++++++++++++++++-
 refs.c                       | 28 ++++++++++++
 refs.h                       | 13 ++++++
 t/t3207-branch-alias.sh      | 83 ++++++++++++++++++++++++++++++++++++
 worktree.c                   | 18 +++++---
 6 files changed, 191 insertions(+), 8 deletions(-)
 create mode 100755 t/t3207-branch-alias.sh

--=20
2.17.1


