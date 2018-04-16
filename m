Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916D61F404
	for <e@80x24.org>; Mon, 16 Apr 2018 01:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDPBSn (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 21:18:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43780 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeDPBSm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 21:18:42 -0400
Received: by mail-wr0-f195.google.com with SMTP id y7so21384221wrh.10
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 18:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pt/TqszU2jPP6XryrHCskziKEGUPdidHQ2jKq2Hd9cQ=;
        b=osTFZ5ZbH7OU8K+X9nJdQjSrdGIqN0jcVh8Zz+QGfoQHTI4a8ecS7baWD2aGzj/98j
         6+vCRT9mDS/OPVKWQEm+stxOwgg1Mk0p7r7tBf7q1C+N0KjaMbwo3GFGIJAon6fcuj/F
         4+6NP9WLga0B968wBfCn80No9Q/t2hQekNY3BGbtoO/7VP3hHY3z62SoCzk74ApSm0X1
         vtudGBLUxa1LbEO3Lb7ciIbjtWCNqThrfkAoXbqW6MVZ6ZUnB7Q7/tPkXyR10uzLDFxB
         ZLvXpq0/Gxz62Yvp/FM9zcjFMqa38xloOBRaB1NA3A1FXF41XskHgEgczfgb2g7nU7rV
         ss1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pt/TqszU2jPP6XryrHCskziKEGUPdidHQ2jKq2Hd9cQ=;
        b=TCsonVl0KvT+uF01iG/Mo4ZafryalMOLqg8QexNRVYQuBPFCoB1A21CfLGgl9pRPiI
         nvULLqdTWbFUEMZeHOzopYIWsIcoDaaxpn7QKR9Xm2fliDJ1PqUuqO0X3wQAHNSV/41L
         t0ymtLTiGsMSLmWR+jTbdSeg7yc/w9PJREhEHLOS4lIExDtJ7mCg3qEVHcoyuKJq04ZJ
         ZAOvbdWBc+vk8GacsnqRbSt1tm/RIfDFo6mLMXjnrZa+KZiDZSwYPQijuQQGpvQm48pL
         x9lJjEVgS8Pqj+jOEDJVJFLWYZduHGpPj83hGuaVj/jE0xbkP7s6QXAIZ0b+Z4XYwqZc
         5rWA==
X-Gm-Message-State: ALQs6tALuCBOwZMMGSQ39lxcmZTg1Mvv4kBDK3tjtPdYKCQyJuM+wROn
        Sm9ee3T6zZ2vARY+nZ9iAvI=
X-Google-Smtp-Source: AIpwx4/uVqyc+PLwLyUgk3Cz6TGDdtKP61fiVyn4q04n+gWqKwejFSzzZl53480fAn4Lpq9Cutg2Cw==
X-Received: by 10.223.144.195 with SMTP id i61mr9284078wri.227.1523841520537;
        Sun, 15 Apr 2018 18:18:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b13sm7576996wmi.42.2018.04.15.18.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 18:18:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     qingyunha@foxmail.com
Cc:     git@vger.kernel.org, Tao Qingyun <845767657@qq.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t1510-repo-setup.sh: rm useless mkdir
References: <20180415024504.2397-1-qingyunha@foxmail.com>
Date:   Mon, 16 Apr 2018 10:18:39 +0900
In-Reply-To: <20180415024504.2397-1-qingyunha@foxmail.com>
        (qingyunha@foxmail.com's message of "Sun, 15 Apr 2018 10:45:04 +0800")
Message-ID: <xmqqfu3wymmo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

qingyunha@foxmail.com writes:

> From: Tao Qingyun <845767657@qq.com>
>
> Signed-off-by: Tao Qingyun <845767657@qq.com>
> ---
>  t/t1510-repo-setup.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
> index e6854b828..972bd9c78 100755
> --- a/t/t1510-repo-setup.sh
> +++ b/t/t1510-repo-setup.sh
> @@ -238,7 +238,6 @@ test_expect_success '#0: nonbare repo, no explicit configuration' '
>  '
>  
>  test_expect_success '#1: GIT_WORK_TREE without explicit GIT_DIR is accepted' '
> -	mkdir -p wt &&
>  	try_repo 1 "$here" unset unset "" unset \
>  		"$here/1/.git" "$here" "$here" 1/ \
>  		"$here/1/.git" "$here" "$here" 1/sub/ 2>message &&

Interesting.  

This was added by 4868b2ea ("setup: officially support --work-tree
without --git-dir", 2011-01-19), together with others like 9/wt that
do get used.  I am not sure if the old codebase needed this directory
created and over time we lost the need for it, or what.
