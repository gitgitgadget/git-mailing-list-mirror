Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEA321FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752846AbdBMUrz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:47:55 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36408 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdBMUry (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:47:54 -0500
Received: by mail-oi0-f67.google.com with SMTP id u143so699201oif.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 12:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bpqGKyx9SwV1ggxqyptFBIypY/sy0pMhXGWjJBia7iY=;
        b=UneRAK/R0l15cOeHh6B0OS1JzhdVfXoD51KiiJSNXgCVeef9B0PBw+3yCZIld2IrmN
         P2THHNtwmGdnyHekgYQDjXiAAaO5ImqJt+1uXKX1r9JhEEKxMojmFDx3O01poJe9KnYg
         9XpbmnsjQwOgR9qHyhwk4psesbWHLJLX9hG3323lwIc4BBc26WT+40ESdNFQX9XETtY1
         01y8NKmczFgur8HRYULMHDfDVc7tDUBQt7i/2e5yzHodzlpZdwT7T8FObYhT5f7pjdEZ
         Bu3O/NTbUGW4slzLnbVgx9vt5hGaNN0ObJv0L3N8vS22Ms6RBU4w4cyNkO5xtDu6qo0w
         WpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bpqGKyx9SwV1ggxqyptFBIypY/sy0pMhXGWjJBia7iY=;
        b=ZEiZU5LjIBxerPGNcnSkmgD+lshJ8wJUbU/3hFLcpQ+WtBdwBjrafgiyWZOUzZyw5r
         IV46XsduluQiX/nf5cV620rVcpR4EvE9OR/4/XZ8XwoDjg7BRhQT7Y1h71a32NKhLxnj
         LLwR+DlClqPKck4gC1etuSCClNyVmSbRKulG58/t74g/LmlYQFQhWSuEfJ/6LHQRKx5a
         jdW+igKB0eEk4n8/bi/jA8vOGKQcoEXzkXx7Xx+DKnJ4LWR7MNAw1zWoK0R6krh6ooJW
         oqMwmdI0SHBNVmNUQq/cqaxIdg4UgJfiz60imFFr03aDilPWWuptfLihQPTaZiE85xnZ
         4HGQ==
X-Gm-Message-State: AMke39nWT+9n8KMDlq2hrekN+dQU1AfCnuQ79bCGtBYV+SRIXHFAToJLvITADTjJtZkRCw==
X-Received: by 10.84.143.195 with SMTP id 61mr32305411plz.46.1487018873821;
        Mon, 13 Feb 2017 12:47:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id 18sm22711558pgf.28.2017.02.13.12.47.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 12:47:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Small regression on Windows
References: <6bc02b0a-a463-1f0c-3fee-ba27dd2482e4@kdbg.org>
        <8488f55c-37b1-1ded-53c5-7cd268210391@jeffhostetler.com>
Date:   Mon, 13 Feb 2017 12:47:52 -0800
In-Reply-To: <8488f55c-37b1-1ded-53c5-7cd268210391@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 13 Feb 2017 15:32:56 -0500")
Message-ID: <xmqqbmu5ddhj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> The warning text is being written to stderr and then main thread
> sleeps for the 4 seconds.  However, stderr has been redirected to
> the pipe connected to the console_thread that handles the
> coloring/pager.  It is in a blocking ReadFile on the pipe and is
> thus stuck until the main thread runs the corrected command and
> closes the pipe.  It then sees the EOF and prints everything in
> the pipe buffer.

IOW, somehow your stderr is not flushing automatically?

> I'll look into fixing this now.

Thanks.
