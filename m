Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BF31F453
	for <e@80x24.org>; Wed, 23 Jan 2019 22:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAWW7D (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 17:59:03 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:36576 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfAWW7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 17:59:03 -0500
Received: by mail-wr1-f44.google.com with SMTP id u4so4438883wrp.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 14:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6p69vqxbB6RlicKPhdsmqxZasTZpiABmr1kCPtTHon4=;
        b=BGmmbki+WfOmKxUf7JH71y2HZ5yk6qlKwlU243IuHHq+ityTpforY9NEeyeQg+Lb5i
         /H1n2LHeXU2TRTj8TNgALf32mXjIax8V2YrW87xaIkcPFlJd5YTa5Dri7hD1JRIj6Q61
         pwBHKjbFpi17hDs2Vmab+6YsNyTRpDrixxKHWiCpj9S22bydc4AJgiaCWOveVTUEx4Ui
         Jq6DAw+uq/4ujKrXiHXMPAG0HBwjH945BrYi+wbOYIQCDfKMmI7FS/rCjnRbJJNItd3v
         Mt8OCNQDQ8jSfbYnXiyQeskuTo8Bi/sgrhIwnDYQNLt8w4ODHrwSEHsA3o+Pg/bzEY3U
         U9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6p69vqxbB6RlicKPhdsmqxZasTZpiABmr1kCPtTHon4=;
        b=o6PzakLLWraDlXRHblF4Xv8sGXBpw8jf05lss29p4Uqz5ldjgV/rDqLEu1D/Qp4tpW
         eZim68pTqfpMhmkTAHNjZJFqa6hZETNNqMpuqvwXEeJJyyuFFYzZ5rHojlpY6KKw+bzd
         lh5PGTjGrAvfsv7T+SFlcKlGnAmdgnMt0NT/caWH93Pus7da1tRNSprwzaad3lgc3kw2
         +qLnGoPCN3U/35Jy3obm/9riD/TT96Atk5C204bE5aOTNok8YaIt8+C2waKx0HBUhKe7
         9hcdOAPq3TIkmuNjPDOPr3aNBjdEVy2UWDyWmdlBW4HBftoXTsGx7nK9tNn4VuOR0ZU2
         kL/g==
X-Gm-Message-State: AJcUukem440XkliRfJEVUzZovdme5i5xDSXUKUcaOiqubdEUU9/vHew0
        K+t3zvv0iUlBVCB8grkOdlA=
X-Google-Smtp-Source: ALg8bN5wGAPSwUEzYfx5HxEksNzZYb5TkwbrjF87GQT+paZVyJxgRZunjdDMqhfQeTnbA8GByqF3JQ==
X-Received: by 2002:adf:f504:: with SMTP id q4mr4783079wro.321.1548284341112;
        Wed, 23 Jan 2019 14:59:01 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o5sm108234367wmg.25.2019.01.23.14.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 14:59:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 10/21] ci: move the Windows job to the top
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <5bdc6a08a8b8040de3082b1690f16538fcc08682.1548254412.git.gitgitgadget@gmail.com>
Date:   Wed, 23 Jan 2019 14:59:00 -0800
In-Reply-To: <5bdc6a08a8b8040de3082b1690f16538fcc08682.1548254412.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 23 Jan 2019
        06:40:21 -0800 (PST)")
Message-ID: <xmqqpnsn7zgr.fsf@gitster-ct.c.googlers.com>
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
> The Windows job currently takes a whopping ~1h20m to complete. Which is
> *far* longer than the next-longest job takes (linux-gcc, ~35m). As such,
> it makes sense to start the Windows job first, to minimize the overall
> run time (which is now pretty safely the run time of the Windows job).

Is the reason why Windows job gets started first is to make sure
that it, which is known to take the longest time, never has to wait
before starting while other jobs run, in case there is limited
parallelism?  The last part of this sentence is what readers of this
step will need in order to be convinced by the justification given,
because (1) if the jobs run totally serially, the order does not
matter much---if anything, running shorter jobs first would give
results from more jobs sooner, and (2) if the jobs run totally in
parallel, the order does not matter as long as we have enough
parallelism.

> This commit is best viewed with `--color-moved`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  azure-pipelines.yml | 172 ++++++++++++++++++++++----------------------
>  1 file changed, 86 insertions(+), 86 deletions(-)

For those who are seeing this azure-pipelines series for the first
time, it would probably be unclear what the point of adding an
entire file in 09/21 and them moving lines around in 10/21 is.  If
somebody asked me why, I wouldn't be able to explain why it is a
good idea.

Would it hurt readability if these two steps are combined?

