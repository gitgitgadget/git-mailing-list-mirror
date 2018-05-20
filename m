Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CBF1F51C
	for <e@80x24.org>; Sun, 20 May 2018 16:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751956AbeETQBs (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 12:01:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50955 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeETQBs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 12:01:48 -0400
Received: by mail-wm0-f67.google.com with SMTP id t11-v6so21479461wmt.0
        for <git@vger.kernel.org>; Sun, 20 May 2018 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xx2SJgXwVHd9W8UjzNkI6tR542WwaaZTDGhb6oV4Nvk=;
        b=ZqRHkgkW56xoeJpbDYv8JcpDD45fa8n/8coHLh+yDvel4mxohQksfBrUGU5eVLEUOj
         7Qr99Imcvb1DNA1dUiAE0cMJp/eQpMyd8GpGKa1Ytpa/oYD4FalQQMDagT/z/lLebwSX
         aOxe05b3CQ2irZxk2N8CLUTINVTWZx0ffKVNjZ4tA7c/S0ocK+n10SKYf7EmqwvDb9LY
         3VERY5AFnl0rwtLpqtKs267tJbyDmg4VwGSWu19WfGtUrjg385ZnGAOhVqTvpeo4Xvqo
         Db5CNfQGLv4zU/ChY2cVlZT85heEOGMyqix+wvBNhaLxp6lScqYQ88kjS56MAVoCwyCY
         DNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xx2SJgXwVHd9W8UjzNkI6tR542WwaaZTDGhb6oV4Nvk=;
        b=BlUs39jItmdpRXFGTCnEFfAUTIwIjpko0QvG4ZGqu55pMRCiznvqbWnBxaeCXs86+x
         ZN26YjyD2PYVsq4mBKb4aeWm/vzPiv6ZoOL4aGjSJ3WFA+Y2OOx1Ke/lfjzgVfycgNW0
         TUK7FqZs2uO5pVlYiqM0e3qr1UPyTVKwlTMu03rAnXXP54HZ/3w0EoVaCpEGOu128CbW
         45V+vP7TqTgnOKFlEkcTpqVyGSs9uImSO1X2ZcSDUbsZ75kkGQuLwIiQUlyX5PlLujdo
         zwTMgcQ8/9f8KJdKTzkAmbbzHaFQwE5DDQHz59DH1hHh7C3Idk+FlHDw9webPmPVZBLw
         RRyw==
X-Gm-Message-State: ALKqPwfXeR/C6TTvP6AqlgjhUvjw9LE16qrJNRYChnpQKObifUw+2TaH
        XTm7AWviN7aPHwusN08905Y=
X-Google-Smtp-Source: AB8JxZrehi4IRENQ3PMH/82vFoorAwR8ivOtEXkP6pmatP+cyQE7IvOrpxgYSOmMUx3Nh+D7IB9SqA==
X-Received: by 2002:a1c:170f:: with SMTP id 15-v6mr8821298wmx.90.1526832107002;
        Sun, 20 May 2018 09:01:47 -0700 (PDT)
Received: from localhost.localdomain (x4db14276.dyn.telefonica.de. [77.177.66.118])
        by smtp.gmail.com with ESMTPSA id m134-v6sm13021534wmg.4.2018.05.20.09.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 09:01:46 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/9] completion: drop the hard coded list of config vars
Date:   Sun, 20 May 2018 18:01:39 +0200
Message-Id: <20180520160139.11299-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.799.gd371044c7c
In-Reply-To: <20180510141927.23590-8-pclouds@gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The new help option --config-for-completion is a machine friendlier
> version of --config where all the placeholders and wildcards are
> dropped, leaving only the good, completable prefixes for
> git-completion.bash to consume.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/help.c                         |  13 +-
>  contrib/completion/git-completion.bash | 334 +------------------------
>  help.c                                 |  30 ++-
>  help.h                                 |   2 +-
>  4 files changed, 47 insertions(+), 332 deletions(-)

Oh, this diffstat is fantastic! :)

I'm glad to see that enormous hardcoded list go.


