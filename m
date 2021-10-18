Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A74C433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 19:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EACC6108E
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 19:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhJRUAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 16:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbhJRUAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 16:00:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C78C06161C
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 12:57:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y3so43589623wrl.1
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=zgk9VPWIURMy4YJo1AaqUKkHGRO3R6IhqqWiXOy2jHU=;
        b=Od0HXfi4mm8iiQu2fjTEJgypdoSGQnUknr3DyUb8cxmiLss4RDY/Mwq5n8CL8Kzlau
         6AlOKOzA4uhTh2BuGVPRcWOt6RJifZ8x7xjtZU4OCFdiTYRn4rhbfUz9dWJ7zMEkOvMP
         cbPOIBS23NBpiX5YJWuhgM8VOR6MVuxrT02/UVF+s5GAe/HHJW8czgfOayLITsBjZFgg
         za2bVBy1TLkAo2i4A72kkrk5wfupdyo0cTNLmmzjXpPvU1fftuFZyMgUaPkMG4KmqFWZ
         NCAdRV07/GnwEuWDgRYg0O+ilUoApzgPH5V6swywo5slmVlV47iS3JjazjE1HFFNXquk
         qkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=zgk9VPWIURMy4YJo1AaqUKkHGRO3R6IhqqWiXOy2jHU=;
        b=zbuw5qfUDC/hrpQd2CE+Xcer2mW2EPbQ0JjQtIvi8eh/sL6NAKbEeaZaDVGFY+B7jl
         EcZi6uoCZG31ADbqtow+uVutUk52l4zgDc1WMpMCGv/hKLHYQnYPyrBeXqd4VxsRcrmz
         VI55zrguVaOcee4MQGNEjl4eg6zOp8MGSm45dQCNQfI/wZKHoYxFshYFCPdJ/1Gg7T1x
         6iEZ4bY1s1uhxO8+CKPw7fKd/m+rwDCLuSwTadyo4TJhDm94QJSq6xpoLr1phJAl3ztc
         FeveFCG53m0PL8ayubSmZCjlgHL5bgbk4AYSt8/P1RhYbr4wxOdWIhirS2t5I2k0amOO
         qbYQ==
X-Gm-Message-State: AOAM530KbLknbU11/3KL5zk1YhjBxpuJjo4FOALXm3YlLAC9J3jPJ/z+
        pY0JN/JU2UxE1QNzjCa53UMD1oGrIV4=
X-Google-Smtp-Source: ABdhPJwdIZNafesGZAnZEEYNa6bTJw1H9i6K+WJgvJqWh3RsBpQwLX1isYOEj1SVPaEcqiU6uZMrxg==
X-Received: by 2002:a05:6000:1689:: with SMTP id y9mr38321506wrd.52.1634587077797;
        Mon, 18 Oct 2021 12:57:57 -0700 (PDT)
Received: from gmail.com (62-47-13-40.adsl.highway.telekom.at. [62.47.13.40])
        by smtp.gmail.com with ESMTPSA id t8sm13276389wrx.46.2021.10.18.12.57.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:57:57 -0700 (PDT)
Date:   Mon, 18 Oct 2021 21:57:55 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     git@vger.kernel.org
Subject: [ANN] git-branchstack: make pull-requests without switching branches
Message-ID: <20211018195755.pcdpx6xyjeawttyu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I like to keep all in-flight commits in a single local branch, so I can test
them in combination and update them easily. git-branchstack allows me to
send select commits upstream as pull requests (for projects that don't accept
patches).  By never touching the worktree, it avoids invalidating builds. See

	https://github.com/krobelus/git-branchstack

To implement this I needed a way to reword (change the commit
message) and reparent commits.  I used the "rebase" function from [git
revise](https://git-revise.readthedocs.io/).  Unlike "git merge-tree"
this can change commit messages, and allows me to resolve conflicts using a
temporary file.  I didn't find another easy way to do this (without touching
my worktree/index).  Is there a plumbing command I can use to create a copy
of a commit, but with a different commit message?

I wonder if there are more use cases for creating/updating commits that are
not on the current branch.
Future "git rebase -i" should only update worktree files when needed (see the
"TODO:" comments in sequencer.c).  Rewording never needs that, so it could,
in theory, work on branches that are not checked out, though that would
complicate the rebase UI even more.
