Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C49F1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 04:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbeJYMmz (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 08:42:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53521 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJYMmz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 08:42:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id l26-v6so17972wmh.3
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 21:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=frfWTDj7L27aXU7BMzfmJmunb50ksg7osjM0fV9zsoE=;
        b=Nn6qVSmu8msiAKNQ9vBWjiKuGkIgpB1lew14f4ce2i1Q345OnXg7C1cVr2GJkSLVbU
         qFELAQn5VcrLgt0yZuA8/OQ00Q7uarQM23DwiCbJlcPlMsjPMtkUnNhC9KyCVI0JhD5K
         9JMN48k6YCGc4uv1gD+AKAGeCniknJlclo24L63zh0f2KRxNR/pGRHFZnxWKx0GRtzFP
         Pnt72INV2SXyHqxwcpd9M9JoEwarfJ2hgfaKZlcuYtuXqPjkuOitII3S3Fk+8XULi35P
         9IlhvILenFf2GnZ9WaoTLyFN2aR69pnLYdtQX9mKxXSgEvBLeFrI7LUO9Ex9b/ac/8Vf
         bK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=frfWTDj7L27aXU7BMzfmJmunb50ksg7osjM0fV9zsoE=;
        b=Nula27w+aboRzamtLdTDqvHacOy4XdSPT+N55B31gpXATCvbuAsRNENYIOHgHNc6L4
         YXanS303Ef0fHmCxh3dLE3wNqEGDAhYlEOfs3kyyQd2Fvl+XOnN7k0As/aUyqB/F0ZDv
         7uB23hJt/9+rMBuZGKx9Jgm63insHOWvrFM0cPzZIj5SXacfNoxcEw6S0vHMSZmpq9lk
         VGT/KYWWWDdtwWFtdgCm66Noz+3E9bFrGzJ0V5edHrabVWKfIkyF7QD71/cmYUOoASJK
         zFjtvnBe6Wrhg160syDRwQSsliq0aLsCzF3N6g10//U/DE6NEAevbqcvOS8IuTuLvPJL
         8KKg==
X-Gm-Message-State: AGRZ1gKqGtRtH0s866tyGitSE2tgRzvq0cxH1icxvpm0rrn/P6EY1AKN
        frnPAclp83Aht5hfEtF+XWM=
X-Google-Smtp-Source: AJdET5e4WV1LbRY3NQv6GvsNyx5i/+h3/nS8KINXEiDIUlK31lfRE1TgZd94ByNyjHvtVnNMrtbOHw==
X-Received: by 2002:a1c:c142:: with SMTP id r63-v6mr9379wmf.72.1540440718281;
        Wed, 24 Oct 2018 21:11:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y16-v6sm6496929wru.18.2018.10.24.21.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 21:11:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stephen Smith <ischis2@cox.net>
Subject: Re: [PATCH v2 0/2] Work around case-insensitivity issues with cwd on Windows
References: <pull.54.git.gitgitgadget@gmail.com>
        <pull.54.v2.git.gitgitgadget@gmail.com>
        <xmqqin1rmynw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810241720200.4546@tvgsbejvaqbjf.bet>
Date:   Thu, 25 Oct 2018 13:11:56 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810241720200.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 24 Oct 2018 17:20:43 +0200
        (DST)")
Message-ID: <xmqq8t2mll6b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 24 Oct 2018, Junio C Hamano wrote:
>
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>> 
>> > Changes since v1:
>> >
>> >  * Fixed a grammar mistake in the second commit message.
>> 
>> Thanks.  I think this matches what I earlier queued on 'pu' with
>> Stephen's typofix squashed in, so we are good already.
>
> Perfect. Sorry that I forgot to check.

Thanks for double-checking, and I do appreciate the final version,
even if it matches the version I would have in 'pu' if I perfectly
followed all what was said in the review thread, as I am not always
perfect.

