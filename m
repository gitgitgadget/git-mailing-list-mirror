Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 829191F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeILCAC (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 22:00:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35578 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILCAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 22:00:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so27481838wre.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DGx8lX3bVrLpb821svJmIl7Lw3ipNMJSVd41+knQhPU=;
        b=N0C2fR/0/6G9woPQVxzwNAn2DBDaURrZHIZrXDvVepYE7YKiMRz0MsAWMoFxONP5o3
         O88ZX0cM1jNZS6DiifDxl24gXSpZbtZels7m2sEbo7/uHF39JMfLtIQmTCG5LuRmdGE0
         VTi5LbyAHA0eB7DUQgAG1dvF7i013330+dPEgoJL3T/W7Oi5NRhko4q4M8FHzsFc2b3i
         vod9ac9LTT0nY9D75Z867tLUOsCHtCrayQ9rXe3C6Vk/b8TLTRVzNg54H7elhocKuI58
         2PsCRufFeAx1yNnYj60qUlKtPWQkfYwjvYe8haSrSxmWzRjB06BgS7EUQNacNcCa4ivI
         /tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DGx8lX3bVrLpb821svJmIl7Lw3ipNMJSVd41+knQhPU=;
        b=S5x1E+N0wQ5ouUp4z++dzRQeWI2KzqArgSA0jR899j++mzRHPTu+ubMNUHhVq5nfmH
         nHMgOCYlkZi2lhUlx4Tmj80ehH/eZbATHYuiSh5RcNwyqyAnA3Km8r+LLc3u90H8iKj9
         VwEKT4DSv9py4ULf4Z4dSf7tAj/z4cApRvoBolyAAcmOnVb60fTrN4WNeIFTwLAjyq64
         n635OIspEcAXw1JB94rk5Qt3jAupsm3bMehENQTsxLh/nru9n2xw+f8/fvGYJVmy/4QC
         19hXNdM+3Edu4v0MP0SuhX5JAhH6YgX09trk1TaJVZrKzQu4UAgZd3ga5g8ue1K01o2l
         pcZw==
X-Gm-Message-State: APzg51AWRuoA6Y51TUR/oL92Z/JZSEIHoGq2pWDhM6eDR3hQDjuh/pWd
        3TwB77p/tNXTF32SlzeUUJ8=
X-Google-Smtp-Source: ANB0VdZwPnNAWc+aUsHOhDx0BqI60XGOElaORO5POwUU6UtN/vDBJXj2XcEHSAyEqvyS+heWNevSMQ==
X-Received: by 2002:adf:e792:: with SMTP id n18-v6mr8892176wrm.136.1536699535856;
        Tue, 11 Sep 2018 13:58:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 144-v6sm2499897wma.45.2018.09.11.13.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:58:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] t3206-range-diff.sh: cover single-patch case
References: <pull.37.git.gitgitgadget@gmail.com>
        <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
Date:   Tue, 11 Sep 2018 13:58:54 -0700
In-Reply-To: <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 11 Sep 2018
        13:21:06 -0700 (PDT)")
Message-ID: <xmqq4levoinl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit 40ce4160 "format-patch: allow --range-diff to apply to
> a lone-patch" added the ability to see a range-diff as commentary
> after the commit message of a single patch series (i.e. [PATCH]
> instead of [PATCH X/N]). However, this functionality was not
> covered by a test case.
>
> Add a simple test case that checks that a range-diff is written as
> commentary to the patch.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t3206-range-diff.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 3d7a2d8a4d..05ef3263d2 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -154,4 +154,9 @@ do
>  	'
>  done
>  
> +test_expect_success 'format-patch --range-diff as commentary' '
> +	git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&
> +	grep -A 1 -e "\-\-\-" actual | grep "Range-diff:"

Isn't "grep -A" GNUism?
