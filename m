Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA7D21F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 23:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeJGG64 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 02:58:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46112 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJGG6z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 02:58:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id a2-v6so9932768wrc.13
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 16:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W6csymnLvaAwCjSO1Ju9qsqyGewlns0mhM7guUtGlt4=;
        b=kF7n6+vyd6Dpqa3HUlcZgwRrXYpPCwwTmhgwv8K8j45ZqIf20I+wB2BFrKjt2E1cQL
         AfkhoB2u4C/YO5t22bGrVz1F/p1t0V9KBDlZjekkPuhM4HheVcN1Msk5NTOS/lW0FS3F
         vVK/XUIAKs5tUsmGfa8Ehbr2bD/ZuZwBYz9tPuW/coJkU0C8hYXyM+xhykyHeCAm/pDt
         unQMWhDInuT4Zb6GblYvPunlwCx+etNRTWbdD5H8pW9xUzPZYCGmPdJ2WhwpMhu0Bf6U
         qn6Pgcg8BXIFv2Jk7HDQ/Wj0GZ1ovFkzH7SeyF9IRm8gtdhoF9qKdHa7EuN+tvbTztz4
         aRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W6csymnLvaAwCjSO1Ju9qsqyGewlns0mhM7guUtGlt4=;
        b=PCrzVvUeIglOx/FXyWxnqCa+9ONY8RGJi4S3+X7NWa6+F6Af9fK5bOGSaNEfFHnz2k
         z3C9diIHab9r5ZpOi3/gfZlrQdHq6qifCGkUNxnKZ+xgmzcN1UHwnTTSXZg3OpKYWfDZ
         8PgVF1xss4kxDCKT/Z0nUNfdGVtrh1f/F7eE9kOTGCYLLqk5PMm+STRcLCCF+CT3xv76
         xwC1P32ql21B+zpqwyUczN0OKxMOkapgD5rtANdbZT1dHMzSWpRZAVxrVDLyoUS6aUWv
         EoA/hoPdfBRtRzxRmWtpVa1vjzwyVk6QnrMIIRrUS9nNJ69tNSJk37lbrpgzm9+T5pjn
         T88w==
X-Gm-Message-State: ABuFfohQkMRLZq6vojKk9w8LBQAf70gcEgXgAzuAaGcQMOIzeE2RJ7zI
        J5EGvifEMa2ydXGlYP2koYk=
X-Google-Smtp-Source: ACcGV63/d6Ni4ug0ubHN4i2523rK2Old8MvYHxcmx3k5IdvY0X0/G3RdR/x5u5q9pnTr5MRAtLH9Zw==
X-Received: by 2002:adf:f941:: with SMTP id q1-v6mr11613254wrr.151.1538870022566;
        Sat, 06 Oct 2018 16:53:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c8-v6sm17886743wrb.6.2018.10.06.16.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 16:53:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrn@google.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v5 0/7] subject: Clean up tests for test_cmp arg ordering and pipe placement
References: <cover.1536969438.git.matvore@google.com>
        <cover.1538775186.git.matvore@google.com>
Date:   Sun, 07 Oct 2018 08:53:40 +0900
In-Reply-To: <cover.1538775186.git.matvore@google.com> (Matthew DeVore's
        message of "Fri, 5 Oct 2018 14:54:00 -0700")
Message-ID: <xmqqtvlyvdh7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> This version of the patchset fixes some wording and formatting issues
> pointed out by Junio. The commit message in the first patch has also
> been reworded.


Thanks.

If no further major issues are raised, let's merge it to 'next'.


