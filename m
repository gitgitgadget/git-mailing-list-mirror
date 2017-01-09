Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D47C01FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164262AbdAIStt (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 13:49:49 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:32854 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164259AbdAISts (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 13:49:48 -0500
Received: by mail-io0-f176.google.com with SMTP id v96so87215177ioi.0
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 10:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h/D6N0xDAcuqSuwfXvdBwl7llK5x8Ajt7voeiNHyf2s=;
        b=NB0fU2TXuZdniWfzNKYwlmzq6JcGTceBrI/ZMzepVV/LnaeVVVtp5YcU6FbMLDrHvf
         fIkuPl2nfGlapuOXsOyLBNxO8ZcvwJ07thBn4Sw8Ik2+9Cs7quPKM3jNuU0o9FRnSt6D
         /fZC6/Ijeq6c/1rK1KqWNlsxFXslEmL7R6qEYnmtcDvoDXyazZzthK5nOhazcCMG6hk2
         ntykhp5iuvMvpRbFAYRwkYuzuhzb8qHZiB66EolKaPFUdglWNA7EyGzqUrgtykvgymfh
         SBnt+BPgPY8Rq+FxqXP8Y4TCPZVzfEOIUlEwEP9CuCRGC3ML2+SBjtwQSLG4RkEpiJIA
         JNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h/D6N0xDAcuqSuwfXvdBwl7llK5x8Ajt7voeiNHyf2s=;
        b=rgaViCUFSS6Ez6VJ0sLjGXKPQ+LQSOrEWtASTI9qlua/cbldHX+lAYiVruKttHlt6Q
         S2Mf0IkSRtzS+dYecOXCdE4fT8lsaHtn/HHmIhc77FJU8QwgexbhFzNl27JCRbM2qoFV
         AfY0u55v3s3Qpmv3EkCBTPJkCPYsAX3fQY2OGxnmiw0ZnW35sYCxvk2EJT55dfTWFqDs
         ZOtBmKNfDeyFcqySMMVAK4/eOhXzhkPvgufRjFnxt+n/WZ2+keFk3sX9KqbhBfLF/QPI
         OEuYThTn33W0990eDdvhevQFtUvMzSidXUusx44U7lmBk6zbYrSIZmLCMDUjictYiVgZ
         NWXg==
X-Gm-Message-State: AIkVDXJ79Q02fx3/lzfhTL3cfDjcmbKXa+1/z/c3buZnB2hTemSdNL1e7Y2FYA+UzYTJ1LIabT6LEKqEtu4Q+ryL
X-Received: by 10.107.3.160 with SMTP id e32mr8136501ioi.52.1483987787375;
 Mon, 09 Jan 2017 10:49:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 9 Jan 2017 10:49:46 -0800 (PST)
In-Reply-To: <20170109054238.42599-1-hansenr@google.com>
References: <20170106010945.79382-1-hansenr@google.com> <20170109054238.42599-1-hansenr@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jan 2017 10:49:46 -0800
Message-ID: <CAGZ79kZHrkwBigEQbG6GoEAbuN=U0A3e9Vhz6btohYsnUHMYog@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] fix mergetool+rerere+subdir regression
To:     Richard Hansen <hansenr@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2017 at 9:42 PM, Richard Hansen <hansenr@google.com> wrote:
> If rerere is enabled, no pathnames are given, and mergetool is run
> from a subdirectory, mergetool always prints "No files need merging".
> Fix the bug.
>
> This regression was introduced in
> 57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).
>
> Changes since v2:
>   * Added entries to .mailmap.
>   * Patch 2/4 was split into multiple separate commits.
>   * Moved '-O' out of $orderfile.
>   * $orderfile is now adjusted after running cd_to_toplevel.
>   * Added lots of comments.
>   * Other minor tweaks to address review feedback.
>

The changes to tests look all good to me.

Thanks,
Stefan
