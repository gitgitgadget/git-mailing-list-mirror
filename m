Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B724B1F453
	for <e@80x24.org>; Thu,  2 May 2019 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfEBVtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 May 2019 17:49:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36244 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfEBVtl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 May 2019 17:49:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id w20so1647992plq.3
        for <git@vger.kernel.org>; Thu, 02 May 2019 14:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hxIFxaqfEISTOPkk/PGKDejc4hT5n4NThS304ulMLUE=;
        b=gEGUQIyucncC7SjygsFQnN7jIhTy+xjHt70vzlfnDq/O+j2qoo1Y+iZzg8ygIBpAe6
         6Ok5Fg5/x+6ptbcEML1oH72wCAmhXc+/bOUGiUuxBe6MDoSANDstTMDApJgO8JqIvMFv
         /bqNkIhcYbW5ejt64W1cgcqSWjgJZFeCJYLwh1siZ4eSBbjhJaqRsYWj+itMGrz6VTwy
         28/H2J8JraktYm0jkqgb+FmiyNxreaqeSK5nGrvhhfDN+IqMLHHhHN/jm32OPkwt/k2l
         +ZX3jDwIih4NfR5xfEj778JOvUALwr/62iUT87m7ynw38QuL52ySxhgitl71lImDlpXb
         hqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hxIFxaqfEISTOPkk/PGKDejc4hT5n4NThS304ulMLUE=;
        b=haoi5k/tgBot6WsVtjqCybPKRB0Yd6CEbM53rJzuSmxGu/3K4qSNVtqxcBe0oJFirM
         3hmqEyBD6uBTgNY649vMUjp0EVrFMP1rljOyLWJZF5fIPn4lomuQMk5sy5nbe5kGcmdh
         m104kllWDOwHq70D/nrgOXVbiphqxk5LZmtVR+GdergeeHL5LNEbdGqLuuYFQMeAVO9J
         wDhfxnMr1vs7/7ywjXvBEn2pnoH3xgrZ5ArrBEeDgfMxbFawILePPcSGgQN3ktGGO/iK
         y0K6WUL5vofmx6OJnugfx/QPAmYJ18O72/xDpOU7FiQMHoFSrEJMOedXqQQ2uFswSgAF
         Zkhg==
X-Gm-Message-State: APjAAAWZa+1e/+nOEct3NtGElNJV/4Zc9oj9SyuynGSE8OCkTVCzV+vo
        bFcazhktEW2CIhb5YsDolov7R98D4gd2/A==
X-Google-Smtp-Source: APXvYqzMUzAzxYULQJuw/JwUh2hQgRkViHqGB4t7nvSd79MFbu5J3y5Z1G7guA7FmEhG6jLmtDgkaw==
X-Received: by 2002:a17:902:b614:: with SMTP id b20mr5947533pls.200.1556833780430;
        Thu, 02 May 2019 14:49:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id f14sm233127pgn.77.2019.05.02.14.49.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 02 May 2019 14:49:39 -0700 (PDT)
Date:   Thu, 2 May 2019 14:49:35 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] merge: add --quit
Message-ID: <20190502214935.GA116416@google.com>
References: <20190501131152.314-1-pclouds@gmail.com>
 <20190501131152.314-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501131152.314-3-pclouds@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They both look fine to me, besides a couple typos in the commit message
in this one.

On Wed, May 01, 2019 at 08:11:52PM +0700, Nguyễn Thái Ngọc Duy wrote:
> This allows to cancel the current merge without reseting worktree/index,

"resetting".

> which is what --abort is for. Like other --quit(s), this is often used
> when you forgot that you're in the middle of a merge and already
> switched away, doing different things. By the time you're realize, you
"By the time you've realized" ?

> can't even continue the merge anymore.

Thanks,
Emily
