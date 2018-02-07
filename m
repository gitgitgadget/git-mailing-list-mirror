Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB0D61F404
	for <e@80x24.org>; Wed,  7 Feb 2018 22:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbeBGW6v (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 17:58:51 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36568 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBGW6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 17:58:50 -0500
Received: by mail-lf0-f65.google.com with SMTP id t79so3725415lfe.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 14:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZ5aW5cPoXJAW2//LSVD32c00IHRiXmvhow3PdYa8uA=;
        b=kFwIDNEm4ZKUOk0RFtSYEdXbxSXGJW6/LPJKJfi8X4r6Ga9QVWtJ0uEkYjQhKC8gGw
         xcktrIIB0XTIetyh+/mWBbQ4OxgRCJl3LEQa8Y6T4cGVlV3hHJhfzGgYYHl1mL+dRCfE
         2hIFcrUTf+83I1z0AmtPDgZIH21nuYsuShpmxhK7NFv0w3PtPfVKGdnadKqtQWTqulUY
         ThS38eXsI61/X5+GcKtK2aqW7QFd4jTYw8skM83YhgQKJYWhAz5gD1BRNSiRC5sOnnwO
         NazuXvGxEOJrNW/Q3gzHI8KR6t7ixcKMTNT5Bg5vZ7ii6IQlUeFb2INCiEt8kl/OEhHn
         VLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZ5aW5cPoXJAW2//LSVD32c00IHRiXmvhow3PdYa8uA=;
        b=I9uNHhPMuHHubMs0RpSGPlgh+jzpY4M3//9H9IKnWvokaRssa1gFe4JcLCJIeXSNiT
         wGNQpn4v7cZAD1lwxaeBzCUotrCrc5KxTC9dXiaGjIT+zi/EK26l8O33E+lap7cXMTUo
         EEPFwGp1/n3YVbQstUPcjFB+YYyod1Li3ONS3kJMb2mtbsnGk4USy6NPNaCF3XXpjJ56
         O/Z5TY4tLIBM7NSjtCy+LbHIruc2dHudPFDf7wTOfXHi3uWl5Z4O94KR8hblPJ/5Byxe
         fbUFsdRWn/xdvLYkhz83uZ9Dj6ofAnRsRs6QFsDYS3ID/8bryuHxqrBBTwCMIXDq11XS
         z7Jw==
X-Gm-Message-State: APf1xPBqA93s5TnJUEluRWSLM/XyPpu1EwlStz+VYPxuFif/G59+mxcc
        aNi8md/QYxVMWo9noeGL1D4=
X-Google-Smtp-Source: AH8x224S47h8tF6SR8jb+LFK/GiMRVtPcHwfoWc3kZK8yXBM6M2+Vy4MO4fr9Koim2uI6fbHw1cvmg==
X-Received: by 10.25.162.72 with SMTP id l69mr5464111lfe.38.1518044329163;
        Wed, 07 Feb 2018 14:58:49 -0800 (PST)
Received: from laptop (ti0019a400-3205.bb.online.no. [88.90.224.152])
        by smtp.gmail.com with ESMTPSA id e64sm505349lji.83.2018.02.07.14.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 14:58:48 -0800 (PST)
Message-ID: <1518044326.7000.4.camel@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
From:   =?ISO-8859-1?Q?=D8yvind_R=F8nningstad?= <ronningstad@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Date:   Wed, 07 Feb 2018 23:58:46 +0100
In-Reply-To: <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
         <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
         <87k1vpqq85.fsf@javad.com>
         <nycvar.QRO.7.76.6.1802071818240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

edit: Sending again, hopefully without HTML :). Sorry for spamming.

Hi, I think --recreate-merges is a very exciting feature.

I've also been puzzled by why we can't just pick merge commits directly
including
conflict resolutions, so allow me to join the discussion.

On Wed, Feb 7, 2018 at 6:36 PM, Johannes Schindelin <Johannes.Schindeli
n@gmx.de> wrote:
>
> Hi,
>
> [...]
>
> And guess what happens if you drop that `pick` line in your todo list
and
> then the `merge` command simply tries to re-create the original merge
> commit's changes?
>
> Exactly. The merge will become an evil merge, and will introduce that
very
> much not-wanted and therefore-dropped changes.

I think I understand. Evil merges happen when we change the branch
that is not the mainline..? Is there any reason why the following
wouldn't work?

Imagine rebase is about to pick a merge commit, and we have edited at
least one
commit in each branch to be merged.

1. apply patch mainline_orig..merge_orig
2. apply patch branch1_orig..branch1
...
N. apply patch branchN_orig..branchN
N+1. Commit merge

I do see complications, like the fact that steps 2-N can be done in any
order, with
possibly quite different results. Moving commits from one branch to
another might
not work very well. And what to do when you remove branches or create
new ones?

These problems might be prohibitive, but picking merge commits seems
like
something that should be possible to do.

>
> [...]
>
> So --preserve-merges --first-parent is probably what you were looking
for.

I want this as well :). I don't quite see the risk if it's not used
with --interactive.

> [...]
>
> So no, I do not think that --recreate-merges --first-parent is a good
idea
> at all. Unless you try to do that non-interactively only, *and
disallow it
> in interactive mode*. Because the entire point of the interactive
rebase
> is to allow reordering and dropping commits, in --recreate-merges
even
> moving, introducing and dropping merge commits. The --first-parent
option
> flies in the face of this idea.

FWIW I'd be totally fine with disallowing it in --interactive. It would
be incredibly useful 
e.g. with pull --rebase in merge-based workflows.

BTW what is the difference between --recreate-merges and --preserve-
merges when
--interactive is not present? I apologize if you have explained this
somewhere
else in the patch series.

>
> Ciao,
> Johannes

Thanks,
Øyvind
