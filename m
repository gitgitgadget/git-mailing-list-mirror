Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13341F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfAWXjP (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44396 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfAWXjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so4484080wrt.11
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:date:references:user-agent
         :message-id:mime-version;
        bh=8Cz5rMVEsLbo9L8/cI4oHMqUnbG4iXKiCCxu8C9dChw=;
        b=hH+GAbUhJcJ2IKxhcov2PUIHzatua0/+SwH/c+QHtdOGqODFKc/1b0l4cVFBW7Mrah
         AXHymPdqwSEaHmCNntJluUvr6h6EuVu3GMGI919xLx+jNe9pe7+51kqj4ikZaz8tdfu+
         TbP+cVWvYiiJvgc+38/FTVjFZyNpAiAg9NyJx1zNBJ6kTJnlG1MGeDDNF3I6hXCWCbEB
         OeA+MKSxtJCIqysDBHdTHNmtNsc6HmfTNjF5p2kwScUhNjveqa58hIBVoRKRHAFpnNc5
         Y258U1NcsW8Dh+FW8tDWrQ2R6U74CCH7ffRgQ29UiiHcpKffGR54TSwZ2GCjfaEZi4Bd
         Zb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:date
         :references:user-agent:message-id:mime-version;
        bh=8Cz5rMVEsLbo9L8/cI4oHMqUnbG4iXKiCCxu8C9dChw=;
        b=fiRLUifof0z2K6rbBxwQ2gxcF++WN9ugQDLPSSyl5UA0csd0vSmlTno+IEvwiN31xk
         rPmSbuucSNm4LP/z2GRT3JaylrD/yCgpXQbyHhcufRx6TSCXy6TOJkF2hO8eT0k2fqOc
         P2a0ynryyvXVGopfDHizx3AoJh2D1foIfB4Glrpf6kmh0CKSj+wS5BBjD7vrX+SWQC88
         +3GlWL2a0YUOme8wozpbfFBKr4YOZLbTwYmEgHGB8PWaiFAW8nl48Fs6EPnGq4W/kGP1
         aPEixgT1eH3lkOyQxU/4u3cNfKTMcIEiNoKgc2LpKiUe27u/hG/x+s5wZOEVYq6GT9Iu
         Z2gw==
X-Gm-Message-State: AJcUukeH5SquG+52YCY8WEL1gk6n4QFU9HxC/a7JIlHuGey8PpaxRgp6
        ncJ0mIZ5a0A6614nVaSxLV0=
X-Google-Smtp-Source: ALg8bN7r7Gc5AlvjCMVnJ4kwOGnJKofUfNQquDc+hr0J3WD0tL2KnPMuHLzKaIhbuCvuUOHdlx/RJg==
X-Received: by 2002:a5d:65ce:: with SMTP id e14mr4522962wrw.150.1548286753118;
        Wed, 23 Jan 2019 15:39:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c10sm39377615wrr.69.2019.01.23.15.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 10/21] ci: move the Windows job to the top
In-Reply-To: <5bdc6a08a8b8040de3082b1690f16538fcc08682.1548254412.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 23 Jan 2019
        06:40:21 -0800 (PST)")
Date:   Wed, 23 Jan 2019 15:07:17 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <5bdc6a08a8b8040de3082b1690f16538fcc08682.1548254412.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Message-ID: <xmqq7eev54gv.fsf@gitster-ct.c.googlers.com>
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

The same comment applies to 11/21.

Would it hurt readability if these steps are combined?

If 09/21 were "copy travis.yml to create a moral-equivalent set-up
for azure.yml", then it is an entirely different story (i.e. "we
start from an equivalent setup as we have, and then tweak to match
our needs better, and we can view the tweak easier as a separate
step"), but I did not get the impression that it was what happened
there in 09/21.
