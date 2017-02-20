Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E9ED201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 08:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdBTIWy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 03:22:54 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33681 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdBTIWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 03:22:53 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so11982636pgj.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 00:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=CabXiO49CdD7yB2dJm2LcOMbFpuFHiRKY0mOrkXWGTY=;
        b=IrPWgJk5Fd4Lqd9U+BiUal8wrWCS7FWVyJIIsU7r2mdSLt59dcUC4x1B3syAiaDSp3
         s2OBugO3D6vZDzG6/2XiUJhJTj+QG0P4TUG3qtLo8413JsVe+/W8uGnH7N5uW6E91/s6
         xw0sMGJza8CsoKupSE8CppWdi6ulf90yLw60/UjNCVsKhEik+gctNADOCqpU8m9MkdOr
         rzCXkF/vwCqg5Pjlwm39oKeZ/jeQZ6OenzvBnctXh/IuVMgnvQAsHXfUZ7aAiUvnyG38
         Y05hQ+RSo6Qu4EA9hmRoWeNj4KmeGNKNci4rh4+eRpo7BEyvn8Jr/UQoLZoUKe7Xzyom
         lioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=CabXiO49CdD7yB2dJm2LcOMbFpuFHiRKY0mOrkXWGTY=;
        b=QJ9EX/Cn2xT3AkxGdPDthA6tky6XiSk1Q8oCO9dPayDrd35EATs3dEGGeHj3AV+ke5
         USDHP5Mb0cjUtn80m7N+RrdjppRQj8eZI6UmTeyTns22RblE2u966gnX8gBE09awTYwY
         9F/q7Y6h9QXk/2WwfWniAWIHjaWB4N/i5gzM0csdAnQaJ3q/CbQvZjirNhBkCUhTsZgA
         8MuM17BsdAdTCTMsK4nIVE2vunkCsvX+KvQBN6zTtlqqvTQhWgmKOcj7PX94aPsAnevs
         YVJJaNZYKlH05zWEMxZn1XdcZtXgY7tVyzT5mnZsN9KnSLV+GR7AOHhyUx4sohLe9A8H
         c7ig==
X-Gm-Message-State: AMke39mKmZgkXQCOByvcF/Kczpgrvzb1U+4Jyi9dwYaCdPKKJZJFD/pBRs4WWimDbf+vxQ==
X-Received: by 10.84.138.3 with SMTP id 3mr29691248plo.94.1487578954297;
        Mon, 20 Feb 2017 00:22:34 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:110e:6fae:3b03:324a])
        by smtp.gmail.com with ESMTPSA id s21sm33455905pgg.65.2017.02.20.00.22.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 00:22:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A_Holm?= <sunny@sunbase.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/6] stash: support pathspec argument
References: <20170217224141.19183-1-t.gummerer@gmail.com>
        <20170219110313.24070-1-t.gummerer@gmail.com>
Date:   Mon, 20 Feb 2017 00:22:32 -0800
Message-ID: <xmqq8tp1l19z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> @@ -55,10 +53,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
>  
>  	Save your local modifications to a new 'stash', and run `git reset
>  	--hard` to revert them.  The <message> part is optional and gives

I didn't notice this during v5 review, but the above seems to be
based on the codebase before your documentation update (which used
to be part of the series in older iteration).  I had to tweak the
series to apply on top of your 20a7e06172 ("Documentation/stash:
remove mention of git reset --hard", 2017-02-12) while queuing, so
please double check the result when it is pushed out to 'pu'.

Thanks.
