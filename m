Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A015F20357
	for <e@80x24.org>; Fri, 14 Jul 2017 15:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbdGNPUN (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 11:20:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35030 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754215AbdGNPUM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 11:20:12 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so10977231pgc.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=km8w5kSrqzh9N6oa3nPrSJglFzp7RTbpskXcOUZfp0U=;
        b=dn2FwhOCVd6E+h9R+bzgRF3oe223rNlaioJ//p8KT3ruywktHnWYXgh/gNyHjv+UZ0
         VJ1b3EVIMsSZAL+bJKTgpEx6+vUQeyERu9EkuBXpakYfVAP7jznyPlKCByVtLgH1W+uA
         r1Y/xFFi3oMCdDBePH8B6SbYPuE9v+YHuqwR1//q1fLZKE6j4MP53JyYiwCsiPdOZuTV
         WSkkSKxchdhD3BPi/9aKRiqRVs02aPS5Sowm9sKgsDGhkGmSYf3OAJVjqaKGObLFPGK2
         CIailYbo06IzouguVgdQRoTTkPjK38AD+oRUW6ghzq34YKc+3t0Tvilz7jqhH1zQafoR
         Khxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=km8w5kSrqzh9N6oa3nPrSJglFzp7RTbpskXcOUZfp0U=;
        b=qYMOinYjCvPPRmdGiJGeZj1XLSF2rp59bdI7rxoOaWatDm6OUlWgbM7YmlWBSW/m/F
         IKXsRu/8awBr3ThM6a59pymrhGDIZLSz2FKCA2w1ZXxe38EsTGWVJBRdeoCEiUYteUQJ
         iRjWlghKO1aXWJMxrRNT0J0ehpo+umEVxKo/TCoNx8/aiYIpZr5yyEJTIzmcseW++Y+w
         rQ31prM1gNvfYYD4t5sbuz77MO7voHnD9eZM7HwgfIGeDzBohbcUhJDNXJGXCxtC/AmM
         l0Q6bKrQdrhGKWbaJkkUMYWvksFZjNXZJp++2APhEKizvwI7+vAZziNML2Xs8Cf/rkxq
         GbUA==
X-Gm-Message-State: AIVw111YaNQrD9MfGzm5KvfB7R3A8ugdq2OOOxUyj2H3w86TkMIzubNF
        CTShjG+1r3bDKQ==
X-Received: by 10.84.232.7 with SMTP id h7mr16645196plk.193.1500045606591;
        Fri, 14 Jul 2017 08:20:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id p28sm22466741pfl.102.2017.07.14.08.20.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 08:20:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Regression in v2.13.3, fixed in master: aliases in worktrees
References: <alpine.DEB.2.21.1.1707141629400.4193@virtualbox>
Date:   Fri, 14 Jul 2017 08:20:04 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707141629400.4193@virtualbox> (Johannes
        Schindelin's message of "Fri, 14 Jul 2017 16:34:30 +0200 (CEST)")
Message-ID: <xmqq1spjrqor.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The bug is fixed in master already, and I cherry-picked Brandon's config-h
> series that contains the fix into Git for Windows' master branch.

As you can see in Documentation/RelNotes/2.14.0.txt, I actually have
been debating myself if that series should be merged down to 'maint'
as a general bugfix around multi-worktree area for about 3 weeks.

