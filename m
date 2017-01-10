Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A7B1FEB3
	for <e@80x24.org>; Tue, 10 Jan 2017 04:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764777AbdAJEgx (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 23:36:53 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36414 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764774AbdAJEgv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 23:36:51 -0500
Received: by mail-pf0-f174.google.com with SMTP id 189so27374592pfu.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 20:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3AZGMKRF7azFFQTlQD+wvJaM/sVqpV6ClRTzyky3rSA=;
        b=NENtBtdFcTRxoeUSo/bevAXnmydC29ogGVxhAhaVFZw28IFAhoGMf3xuB2r/XmP4Sk
         2NAsEL2qI9AdKWrx/CcW5c9sPs+3PKgo6b7fV4pdWi7Ag4lVd1pDjwFTiTuDgFxsUZI3
         ojNqXNmBei7XDE+RTwJJUtWKIM6M//NVqX4mvXf+t1yqh7CEuqesTmqZQmDmvPgu/enc
         jUDe7cVkRF71piLqw6cBlnYf49deA15Lk3m2ANrjWAEG0Vtg/wpnnm9TIvDDpDyv4BgO
         +kHgfNFh6tj0EwDY9lUjHzn9mAVIuJOBU02CU0SFh27czT8Dl5zAr2DKxUsO6SjO5QjY
         nq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3AZGMKRF7azFFQTlQD+wvJaM/sVqpV6ClRTzyky3rSA=;
        b=uhSIgcmEyd3xMuycz8h5dbx3rnSEy4jQurGi89siTnbrRZqMzagFBoIapnMyugTtwQ
         jzSAbCcDD01Byi+1oRmmvyc8KQe9A0qoOuEwMMJmBDPOBhd+ftbH1N9JP7buh15Tl3gn
         47Sek/mQj6dVsNJFNVy1OBKX4jvtHH8SRN7FyphPuwS3tlsfA6nk0j9ROx+hscaWvCu/
         hdQKUGZOmwrG4+heI3pGOoZlyPUMOK7RJCW2mMyYOkTH2/oBNYCf58Yf6WcrFrtgVeD5
         ESSBzYO5j3wWqK9Pmm+mD74KSqYaFBCmenwDks7HPeuEwVe+GLxu7DYxqOopBrUKq6VD
         Wo5Q==
X-Gm-Message-State: AIkVDXLHgrwihGb3KnN/5IztOqGSUk0j9DSFadzgGWjL8B+T6LasEbTJLjcwEDEGrMZwGg==
X-Received: by 10.84.215.200 with SMTP id g8mr1952186plj.161.1484023011153;
        Mon, 09 Jan 2017 20:36:51 -0800 (PST)
Received: from gmail.com (cpe-45-48-248-253.socal.res.rr.com. [45.48.248.253])
        by smtp.gmail.com with ESMTPSA id c71sm1110513pga.22.2017.01.09.20.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jan 2017 20:36:49 -0800 (PST)
Date:   Mon, 9 Jan 2017 20:36:46 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Richard Hansen <hansenr@google.com>
Cc:     git@vger.kernel.org, j6t@kdbg.org
Subject: Re: [PATCH 0/4] fix mergetool+rerere+subdir regression
Message-ID: <20170110043646.qfwcn7d7klag7qtf@gmail.com>
References: <20170104005042.51530-1-hansenr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170104005042.51530-1-hansenr@google.com>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2017 at 07:50:38PM -0500, Richard Hansen wrote:
> If rerere is enabled, no pathnames are given, and mergetool is run
> from a subdirectory, mergetool always prints "No files need merging".
> Fix the bug.
> 
> This regression was introduced in
> 57937f70a09c12ef484c290865dac4066d207c9c (v2.11.0).
> 
> Richard Hansen (4):
>   t7610: update branch names to match test number
>   t7610: make tests more independent and debuggable
>   t7610: add test case for rerere+mergetool+subdir bug
>   mergetool: fix running in subdir when rerere enabled
> 
>  git-mergetool.sh     |   1 +
>  t/t7610-mergetool.sh | 132 ++++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 90 insertions(+), 43 deletions(-)

Thanks for finding these, this reminds me very much of the
recent fixes that had to be done to difftool.

I tested this so,

Acked-by: David Aguilar <davvid@gmail.com>
-- 
David
