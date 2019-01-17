Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15D31F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfAQU7L (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:59:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35792 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQU7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:59:11 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so12610093wrb.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xKT6ja3NwP7ceU9jiJL6aznrDU07JmC7qG7JkEVeX4g=;
        b=X3PJ+OIer331/cQ069AGC1HJNriLvsqKuEnN2sYRLLu4ZXZy+J2BjmXuXuWHaEdiaX
         g1b8HZGC0bzEyKSgv/3PRpWNTtnH34mCRFnWYBu/ozRmRJxhHSU0KLaa7Ht4pEF/Rbvu
         FlVHHwTH/CJWni5ZB2HRexO7TaUWWhdG+vnwWKtIrQbxMWw+jomdz09bR21ot6/YPeY7
         4h+sZFZ4LUCcnhyw9AL1g79UFH/oYbGD5x7U9rZufevFjqHTkUeBYnNvPU1yKHmhoOkY
         yoDTq3oGv7ED2Q47TAerkAg+Qm2V41iJ/ZTtYSLad8SGQ3wC/SFD1GMfP8YoSokaYwTa
         zTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xKT6ja3NwP7ceU9jiJL6aznrDU07JmC7qG7JkEVeX4g=;
        b=oXMpmdsT5hPL1muBLnT7zJc6lGx+De9JP9gV5lkz7p+9ff+nyZ2A39VCFUzKeeClck
         EtQxfMMGf3pUsA9pNOgQ8WELkUJf2D/DJXlIsnCvHWKXgJThUAHT4LYXSHj9ZAIQ1OjL
         mDOuHruOzJVWAJokpRJy8T/illRYnSaMWc+pCDT/0VxxzL9DMMhUSwDqFzLBjQ4DjEk8
         G70IDRAExJAcfEf8Tl/Ur+pkXLud3qzR2PU4NjK8RQq8b+W6CBAwxpsxCQna4Bj1fUoH
         yZvS5Xc8eeelPJHTumF8uI93ceOaY/2ROaPxK/J7xpftU+bCRD2LbV3KE0HiAJQ8OwIG
         zYgg==
X-Gm-Message-State: AJcUukegfCYJqrgr4xTRNS66R+siMIyVV67LZG/BGNMbE3xaFDmHb//2
        AV94jP6dY47cQlW0eI1+ZAA=
X-Google-Smtp-Source: ALg8bN5DlR0VNFMWDsm6MRbQXd0zBpJPZaZFYAPdthnnDmG4a37+DGT696B0auAZtCRTJJo5TYX5YA==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr14493162wrp.59.1547758749365;
        Thu, 17 Jan 2019 12:59:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y13sm63961763wrn.73.2019.01.17.12.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:59:08 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/13] Offer to run CI/PR builds in Azure Pipelines
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
        <xmqqo9biigod.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901161503121.41@tvgsbejvaqbjf.bet>
Date:   Thu, 17 Jan 2019 12:59:08 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901161503121.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 16 Jan 2019 15:04:05 +0100 (STD)")
Message-ID: <xmqqk1j3m25f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ...
> See the updated series:
> https://public-inbox.org/git/pull.31.v3.git.gitgitgadget@gmail.com/

Thanks.

I see that you are already planning for v4, but I'll find time to
take a look at what is posted sometime this week anyway.
