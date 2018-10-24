Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF15D1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 10:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJXSue (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 14:50:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44188 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXSue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 14:50:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id q6-v6so4958227wrw.11
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Z2lMpR3wj7j5KuW8rrte83b2L0M2NdD1CPZlrPm05kQ=;
        b=YuRl0VqcaBd2UIuXzlLHU0wwKxI80li4Q6XGr4yP1DjjEM1mI+ZEfqWFKbMC4ZbgIR
         szrog8x8xyX/5y5GdKkgyyTCP2PBD8Qx6E/vo/BfOLYgrDMwNb0uw8Jps2oj2q//zcfA
         ZzQnoCFz+cOnvIxY40KfzJaYM4lvbofcstAL/XjAHqQED1/DnLYnRg/3e1FpXY8cOALt
         RdfUopSBGvPwvftwPLPtZjaf0zH93Qs3wTwSIrx7jRSPTWqzxGnjbCd3qFrefmrENonG
         Ofg3KfTY0sjmHXekeB1oxxrRU0Xd0/l1LgogrM2jglY6WhQpt+USjCNZgLToT9WdlSW3
         YcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Z2lMpR3wj7j5KuW8rrte83b2L0M2NdD1CPZlrPm05kQ=;
        b=I8H/BkE1Yf40EAWpg15yXSzFuZtddqW9X3hS+8MoeLSHPXhkI1weg3Zfb7geIXCA2u
         mZQC2I18x6I9a7U1YQGnboBJ5vOYYx3zqXI4vMSBYq3q1+Za0NqH7N7AKeSXCC9Vuq+y
         KMZcE3RlfPjH8kLbSBYlXvCXxa30WZbo2lvGaCU4I1cWGr6gh1rAhwBWMEGBL4TbAAHI
         7Gork9Q4+cANBDtmHgZhsdv2NKXNxEVTi3DHr+qEAsrVO3Fg1qxxcWMq8p2wqzAy6RyD
         2fdzHf986GVKv3Mm5p8OUwFcq4Nxl4ZpOQjqwrjcm/igL5FW74KoTzGmMEfBoZk5be4T
         fEHw==
X-Gm-Message-State: AGRZ1gJsptgUcIZIMb9Gr/DgOZKCEjhmUCwCmSVss6ECTAHBExSCMTtc
        pXLWhI7+DACxOj6aolUuVCM=
X-Google-Smtp-Source: AJdET5euAYAJ6mfPS+zHefjYXasJ7DGmkAE8wss4beVNqtjDnZZgthI96vn4eNq64UbVFz0mBrNchw==
X-Received: by 2002:adf:e908:: with SMTP id f8-v6mr2256328wrm.126.1540376581495;
        Wed, 24 Oct 2018 03:23:01 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g204-v6sm984917wmf.42.2018.10.24.03.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 03:23:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Stephen Smith <ischis2@cox.net>
Subject: Re: [PATCH v2 0/2] Work around case-insensitivity issues with cwd on Windows
References: <pull.54.git.gitgitgadget@gmail.com>
        <pull.54.v2.git.gitgitgadget@gmail.com>
Date:   Wed, 24 Oct 2018 19:22:59 +0900
In-Reply-To: <pull.54.v2.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Wed, 24 Oct 2018 02:19:39 -0700 (PDT)")
Message-ID: <xmqqin1rmynw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v1:
>
>  * Fixed a grammar mistake in the second commit message.

Thanks.  I think this matches what I earlier queued on 'pu' with
Stephen's typofix squashed in, so we are good already.

