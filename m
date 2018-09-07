Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243291F428
	for <e@80x24.org>; Fri,  7 Sep 2018 16:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeIGVal (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 17:30:41 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51387 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeIGVak (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 17:30:40 -0400
Received: by mail-wm0-f52.google.com with SMTP id y2-v6so15375128wma.1
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X17dZ5X8ml0XxNkT2Es0pRSR7Z6bq+qZ1h9Owrrinj4=;
        b=bYQz42q1sbnDR6TQzBlUwmL7wdB60isSzyrrhyaYEO0kBtYrtrE3cbihq916G48lqa
         UVvfDyt9ky04S9XlyEprDiRMrs6EaTYCqtrarx0aoZp7N35I4gqv2QC62x3Bsag3XG60
         7tnCJZZ44TgVxze5nd4USMdPTPFuVmU4KrQUGucNS2fqBM6tplBrQFYdbxENRa1F382g
         d3C7PLZWquqzar2j6uiZJeMJv+zTfx/wrSv840EU1RbZj/Qw8FrEyZROxEELC8rgxuSP
         U2QgyFKBZnxEbMG7djQyDd+/fxHH8cSDEKoFkS177glNhh5RWvkTFK2QoLjGYn07CCkc
         YqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X17dZ5X8ml0XxNkT2Es0pRSR7Z6bq+qZ1h9Owrrinj4=;
        b=hlJSYHoH2Z9USF7meuYJm90X2pJTRvAUu+pylETbcLmTM67moM/pw4hcFRFrQZTVTJ
         oOpUhwvMBoMCsyu00VHGbek2g7si0n5hK+IBanKYad3rtt66Zd9T2gkHguBCIXRgKLti
         PCMgFGN4a5aUuwTiC6wUzDKgg+r61q82HACX83tjF+3NAamRvh4ANClezeC9d+t/r5AB
         syq7WAud5STOQTu2guQqgTy4mGuEEFLyHxgBWZd+M98QxjlUFAMb625YclzL/Ws3aNiB
         P9Vtjge/b5MdnVIcFmYcdTxVunzEsX93cOK8Tph/qqwhkF5oJIM/LwcoeTJSh5op8FBT
         dXgA==
X-Gm-Message-State: APzg51CQrEhyZJBdP6VBv0WSbiVktmVeB70u54KANbCjTBTe3uy51+aP
        vAk8eel4u5EZ3E1A9acT3pI=
X-Google-Smtp-Source: ANB0VdZnDAeVemxXrweyahteF8mneyAXnlUnl3UlW2T7f7ydpHCMMzUB5ydLF0mprSHVGLyMyW8kQA==
X-Received: by 2002:a1c:1943:: with SMTP id 64-v6mr5585956wmz.89.1536338933326;
        Fri, 07 Sep 2018 09:48:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t70-v6sm5583933wmt.30.2018.09.07.09.48.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 09:48:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hultqvist <hultqvist@silentorbit.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Temporary git files for the gitdir created on a separate drive in workdir
References: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
Date:   Fri, 07 Sep 2018 09:48:51 -0700
In-Reply-To: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
        (Hultqvist's message of "Fri, 7 Sep 2018 08:24:01 +0200")
Message-ID: <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hultqvist <hultqvist@silentorbit.com> writes:

> Considering that the gitdir could be located on a different drive than
> the workdir wouldn't it make more sense to create the temporary files
> in a subdirectory inside the gitdir rather tan in the workdir?

I do not think we intend to create temporary files, whose final
destination is somewhere under $GIT_DIR/, in any working tree;
rather, I think we try to create them inside $GIT_DIR (or possibly
if the destination is a file in a subdirectory of $GIT_DIR, then in
the same subdirectory).  What you are seeing definitely smells like
a bug in the worktree code, perhaps getting confused by the fact
that the full path to these places look "unusual" by starting with a
single alphabet followed by a colon (IOW, this may manifest only in
Windows port).


