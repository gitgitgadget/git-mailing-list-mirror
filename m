Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7111F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438203AbfBNWNx (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 17:13:53 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44349 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbfBNWNx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 17:13:53 -0500
Received: by mail-wr1-f51.google.com with SMTP id v16so8202294wrn.11
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=quQ6OPYMA+SiU7bGiFboObpMN7YRX5+ndFn3JREs9pA=;
        b=U76cxepbwAk1NaiJOUORD0Ya+0rl/NkLv3wwDWppdWyHCfTIoV2+Kkzs5jqLQdUnd9
         fJzHgiYI+5tMbslDpnyq22QFxh/gVzD+YrAJd6YMTH+gfqRas7LJTzK230BaGV7exyQj
         eU08AU1AMLj36ZO2mwuZWa/Bfro+0oxgyPRqFqxA509bKZevpBWjdjRdoGS8Aoih6aH0
         rC5rS8k9FvzFNB1xm1xJ4B0qHaRIK45irae7PsAEOW8JJdvJZchHuTw9HVZHa9VZBNHa
         gcjC3vPVskWzgYhrU0761eRhpM+CZhhEV7EDQGyk83QlDHxYQ5IU8sDL1mj0scS0TRPo
         /1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=quQ6OPYMA+SiU7bGiFboObpMN7YRX5+ndFn3JREs9pA=;
        b=KT30bkysF14F4dG704aXdAd35Fifzc2CblTLnmZ9fMh8CpMz07EHQE7N2s1R7/Rax8
         gGBqDHh3NbzjxMZ0HWLIxmt7lhOtjQg/beuajrzF95YM+0/SJUc+DZpyiJcpW4MIpxMa
         4zzpP1OuSrfiRw4jKxGhl53oWOx5AvRc1nnNL+j6Uhm9RX6tiBiYfaqTpgCp5I8NCLl4
         5xbh5Fs58wyl59nZEkTKRpL2EbYW3A/J9XNGCGCm/Fj/9zcr1t07dpH5LB8xAKvNDkMs
         lgYS+aRpqfHfA3KfaQTF5i9vxLfvf7iRk2LP/9vt/tqrn5/uKwtkZ0pXtVNuHJ5tAviZ
         sk+w==
X-Gm-Message-State: AHQUAubh6sTaDrGT2zDeoF7rYUEoJt8Z139GP5uRx5+xH0aOxgpRU1Be
        YtZeL6wfLPVePyc/BtZvMTo=
X-Google-Smtp-Source: AHgI3IaOzcYscWe7IotxUMqLNjzfw4+N/sqFy+EkXVIttycilTVi51PbSzercFVBdOeViwf94K9e4A==
X-Received: by 2002:adf:c5d3:: with SMTP id v19mr4378340wrg.30.1550182430883;
        Thu, 14 Feb 2019 14:13:50 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f2sm4475498wmb.19.2019.02.14.14.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 14:13:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Randall Becker <rsbecker@nexbridge.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] tests: teach the test-tool to generate NUL bytes and use it
References: <pull.126.git.gitgitgadget@gmail.com>
        <34cde0f2849a098c17ab83786da5ce06f69cfafa.1550179990.git.gitgitgadget@gmail.com>
Date:   Thu, 14 Feb 2019 14:13:49 -0800
In-Reply-To: <34cde0f2849a098c17ab83786da5ce06f69cfafa.1550179990.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 14 Feb 2019
        13:33:12 -0800 (PST)")
Message-ID: <xmqqimxm6msi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In cc95bc2025 (t5562: replace /dev/zero with a pipe from
> generate_zero_bytes, 2019-02-09), we replaced usage of /dev/zero (which
> is not available on NonStop, apparently) by a Perl script snippet to
> generate NUL bytes.
>
> Sadly, it does not seem to work on NonStop, as t5562 reportedly hangs.
> ...
> In the end, though, what counts is that this here change incidentally
> fixes that hang (maybe also on NonStop?). Even more positively, it gets
> rid of yet another unnecessary Perl invocation.

Thanks for a quick band-aid.

Will apply directly to 'master' so that we won't forget before -rc2.

In the meantime, perhaps somebody who knows Perl interpreter's
quirks well can tell us what's different between the obvious and
simple C program and an equivalent in Perl to convince us why this
is a good solution to the problem.

