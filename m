Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7501F403
	for <e@80x24.org>; Mon,  4 Jun 2018 14:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753564AbeFDOS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 10:18:26 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:39552 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbeFDOSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 10:18:25 -0400
Received: by mail-wr0-f180.google.com with SMTP id w7-v6so32034978wrn.6
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1slR7IfQEYD7rwomp2D1FyMxsN99m9o18XLbViqiT7U=;
        b=pLVXY0D/U67S/LknUh/gr9vUN2X8IRwlm2YIhlZecF2idgKKyJdgQ/n8yBswldLZsU
         GOoWO4w1rbH2O09LVpX79j/NQhZmyf5moKIJvBN7j0tYXesDdR+QaR5ELZ55kaK/pDyj
         XtK2q5AjSuVGO9PxCxjhlO8yOvzcVHi0EuAReOiTWiP04r23XW1diJyQ9vv0LV2zyYFG
         BNLnjxhC7Y0cPHxyrZjqQH2aTVgoV2FBzN4QKEQAkyS95ssNOcu58s6JO36evgvtk1Jh
         ih3oM4D3un8rZSXjy4VQLj6B18x9tUfV/vi3Bqqjk084cRnY2fN3h/9UlqSzMBaoraJa
         HRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1slR7IfQEYD7rwomp2D1FyMxsN99m9o18XLbViqiT7U=;
        b=l1cs/6hCbFTFqBcYA2VLsOX0+7b6592omReUx86wJbgrmqumw+abeQ8dvsQn/hFTNK
         a1XxYRSnzEHfkt4YMWsvYcLObtSmuPFhfdfNdgoNNXwk+HLgOaNytLeLYF6Ikts1VjHF
         V2XdInwW5A4UMRXPujUod3PMlCNhaD+3e0reuJHvdNPdZ+uUygTZegRSZurpZ5D2RIdR
         cXEzo8cApYUDOh5f2wkCnwGh6twQf2EHLO4KA4nmyIlg7Z1UUKb67CkGTUm/mWsnsBQ5
         C1v1d5whIm884p48y1ZNeDhQvczj5JosA/NpDIgr9SvmyCz8F6yGhUqI9rHEPgVXcoa3
         EqMw==
X-Gm-Message-State: ALKqPwcd29/XDWlJbBr1EVXQCql7vncu1NUezbU5yF0vC9j9xmcBH8bG
        OePNJYbhWe4wjeBj9pnneaM=
X-Google-Smtp-Source: ADUXVKLkgWb0uZNindJJumO265twlSpDqaaYSzv8iTIFAmag787yC7eH7YC6oZXpMRwVyNODsUE+vQ==
X-Received: by 2002:a1c:3610:: with SMTP id d16-v6mr9857126wma.126.1528121903896;
        Mon, 04 Jun 2018 07:18:23 -0700 (PDT)
Received: from localhost.localdomain (x590cb90a.dyn.telefonica.de. [89.12.185.10])
        by smtp.gmail.com with ESMTPSA id e80-v6sm434476wmd.1.2018.06.04.07.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Jun 2018 07:18:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jun 2018, #02; Mon, 4)
Date:   Mon,  4 Jun 2018 16:18:17 +0200
Message-Id: <20180604141817.22916-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
References: <xmqqr2lm4pth.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> * jk/index-pack-maint (2018-06-01) 2 commits
>   (merged to 'next' on 2018-06-04 at c553a485e8)
>  + index-pack: handle --strict checks of non-repo packs
>  + prepare_commit_graft: treat non-repository as a noop
> 
>  "index-pack --strict" has been taught to make sure that it runs the
>  final object integrity checks after making the freshly indexed
>  packfile available to itself.
> 
>  Will cook in 'next'.

These patches can't be applied directly on top of v2.17.1, or there
was a wrong merge conflict resolution, or I don't know.  Anyway,
building 368b4e5906 (index-pack: handle --strict checks of non-repo
packs, 2018-05-31) results in:

      CC builtin/index-pack.o
  builtin/index-pack.c: In function ‘final’:
  builtin/index-pack.c:1487:23: warning: passing argument 1 of
  ‘install_packed_git’ from incompatible pointer type
  [-Wincompatible-pointer-types]
      install_packed_git(the_repository, p);
                         ^
  In file included from builtin/index-pack.c:15:0:
  ./packfile.h:39:13: note: expected ‘struct packed_git *’ but argument
  is of type ‘struct repository *’
   extern void install_packed_git(struct packed_git *pack);
               ^
  builtin/index-pack.c:1487:4: error: too many arguments to function
  ‘install_packed_git’
      install_packed_git(the_repository, p);
      ^
  In file included from builtin/index-pack.c:15:0:
  ./packfile.h:39:13: note: declared here
   extern void install_packed_git(struct packed_git *pack);
               ^
  Makefile:2121: recipe for target 'builtin/index-pack.o' failed
  make: *** [builtin/index-pack.o] Error 1



