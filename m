Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232FD1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 04:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbeDPE5Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 00:57:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46556 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeDPE5P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 00:57:15 -0400
Received: by mail-wr0-f196.google.com with SMTP id d1so22092629wrj.13
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 21:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=oqg7n/yDItCSj1aH2TdhelaMGGgZNzloWQ7QcjtmGQU=;
        b=CV+n9ILk5RbfR+AZmmHdcNK2fMPn0J+nF8dFWCgmsD585BZVWdHl00aa/LyzBGcviR
         IPc4sVo6T68EmfnLHOS4QIW73znfo3qwcUKrGTpBzEP79ShBHtMaBkYyETwjw8U0ZWfl
         YKWwUMncXkSAUFgZQgaLN6oPHG3TKV0iHhUmiOUATo7bN6cm71xOWYWTay4uPZWz9BJU
         CYEMuM9Eff5iYQjgRALmc6n+0eTxWNPCGxGE526q8aixnhvHx2bMqOl88bkuUCL98w9a
         nW7J+18fLRipclCaHSWjpVYG6UqCbpGS0qDJoG85+8aJzDjyzxdq5kVIHVn3UxkWRG+t
         2HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=oqg7n/yDItCSj1aH2TdhelaMGGgZNzloWQ7QcjtmGQU=;
        b=ESRro+wLmBKzXT+6xt4jLiSc/wKGorWq4NgKqTXDET70gCK1SFcXQfjApvlmgvgU3X
         em8IJUjKPLRyj88mb+/K6579eyVZtCbSIeW+mOLVyv81S8ayBI35s3wYYJQ3tdfGaR2p
         4A5xzFZVYTDCU63zcen70pfPvdH/OPoy/i42nGMbpOj0Xj6BNTksN6P2vz4C/9wOYEfN
         kwY6J6mW+zcC4lSF0RKk979S8trSEoHPQK9js9XcwU0d4SgSnKty4uoRl5B2pwQ90eQA
         mSTVR4QSCSTO1YCNgnCYDUWNVmoQIjv6WqF2ssW32B7ANCibaVqZ9PnRGRlUTWNSPxRF
         qOOA==
X-Gm-Message-State: ALQs6tAFEoxrlhOIWmJ1fSEff0AVG14ocaRN0Wy0exqu5qLfaMCBWw+l
        iAJL+25t3973iwt4ygYfK38=
X-Google-Smtp-Source: AIpwx49VQQxVATaJvkeb0YHhThAL7KxsgYdeLuSTTSaju9f2sxWjhVPaVO4Ma5egmJHVSVFeS4eKwQ==
X-Received: by 10.28.184.21 with SMTP id i21mr9627810wmf.94.1523854634537;
        Sun, 15 Apr 2018 21:57:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 185sm10208487wmj.46.2018.04.15.21.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Apr 2018 21:57:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>, larsxschneider@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 0/4] Make DEVELOPER more more flexible with DEVOPTS
References: <20180329150322.10722-1-pclouds@gmail.com>
        <20180414191946.30674-1-avarab@gmail.com>
Date:   Mon, 16 Apr 2018 13:57:13 +0900
In-Reply-To: <20180414191946.30674-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 14 Apr 2018 19:19:42 +0000")
Message-ID: <xmqqin8rycie.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> This is a v4 and replacement of gitster/nd/warn-more-for-devs. I'm
> sending this with Duy's blessing.
>
> The first two patches are the same, except for one trivial
> s/faimily/family/ typo fix.
>
> The third patch in gitster/nd/warn-more-for-devs ("Makefile: add
> EAGER_DEVELOPER mode") is gone, instead there's now a DEVOPTS
> option. The 3/4 and 4/4 add a way to turn off -Werror & the -Wextra
> suppression, respectively.

Looks sensible, mostly.  Will queue.  Thanks.
