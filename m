Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6CC1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 03:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753767AbeDID3S (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 23:29:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37057 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeDID3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 23:29:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id l49so7511401wrl.4
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I2zRAaXNpiEC1heZ808Y16IG/vk6w1oZyZXVSgS7VJk=;
        b=YypjxehmbDTUTOJnKPX5Fogp+YN8Qv5Fu6ZTJ2cV1PGqN0pArV3VMFU/zQ81ZerHXj
         /nmg4Kp3S+1OzSyiFu9Jl6un7AFfVE7LmnpfxW79oKe/KfQEh5zwdrYNA4LRinTbN86h
         8/995rMC+stybNBFbHyhFxFxe+Fak0sd7zkg4shjNDiKeCeZtvJ0JgGCqvlMaLvNZKzo
         8Uyctxv22uWYCfdzpf0rZbtpxUugUgpYuvYFqSoGG2R25/n5QsfvTdrIlgola6Hp60jE
         UgywUOvGNEDQCJJQq38EWnX8/e14BXoeV1C2MifOdOrYJ4QiSNb8v0EvR5G1gLxtx1qK
         DFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I2zRAaXNpiEC1heZ808Y16IG/vk6w1oZyZXVSgS7VJk=;
        b=Qutb9+JLfTqIefnOiOavHW5VX4sMN9b9D0uC98yfx6Hk7Fh6hxs2D9TocXCE13WC0q
         QZ/zoD+LNH2dxG3aA4VdZfjwn1m7LBV3PyuB/bFluj2U4lWGnH+8dA1ELM/LG1/ocuYy
         scU63KXjWXDDRhsGVyQJitRonJ1r7vPOH7aQhfOsOges7Jsi8/S2ncW0IdZmnSndlLO7
         oam61s7qoHiZ+xE0dMoMM+hwh8eCby7T6sOM/E4TRfAAfINBBtmnZNvEtrsOgVWqWCWv
         5gB5crkTpqiO0flRF3gjAIKPFAoKFc2gu6ZNQ418QUOmEKUlc6phbf9GUf10SbvpBw11
         kaww==
X-Gm-Message-State: AElRT7GdSkbBIk0Nff5PkMryUh0M4f1tAPTzeZ7uVQ7l7tuiHy3MwYcm
        Pcr/8e6V/53qRTNMR5/mohg=
X-Google-Smtp-Source: AIpwx4/6DfKl8OQMDdmpokPxm3UkCr35r8AGEUBqZmx/S9AHkW0Ku6onhS8P3ptcSEn4sdnTk4B5Zw==
X-Received: by 10.223.226.14 with SMTP id j14mr23364808wri.17.1523244554822;
        Sun, 08 Apr 2018 20:29:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o20sm12477459wro.7.2018.04.08.20.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 20:29:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t/helper: 'test-chmtime (--get|-g)' to print only the mtime
References: <20180406221947.28402-1-ungureanupaulsebastian@gmail.com>
Date:   Mon, 09 Apr 2018 12:29:12 +0900
In-Reply-To: <20180406221947.28402-1-ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Sat, 7 Apr 2018 01:19:47
        +0300")
Message-ID: <xmqqvad15a7r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> -	find .git/rr-cache/ -type f | xargs test-chmtime -172800 &&
> +	test-chmtime -172800 $(find .git/rr-cache/ -type f) &&

You've sneaked this kind of rewrite in, as if you are testing to see
how careful the reviewers are ;-).

We often use "find piped to xargs" pattern to avoid unbounded number
of paths from appearing on a command line, busting platform limits.
In the case of these test scripts, it does not matter very much, but
such a "we can save a process and a pipe this way" optimization is
not within the scope of "chmtime +v often is piped to sed only to
strip path---let's give it a way to just grab the timestamp" topic.
Not a very welcome change.

Having said that, I do not want this to be rerolled if this
unrelated "removal of find-piped-to-xargs pattern" is the only
niggle in the patch, as I've already checked if these conversions
are safe (they are---we are not dealing with hundreds of stuff in
.git/objects/ or .git/rr-cache/).  There were conflicts caused by
this patch and nd/combined-test-helper (which makes the test-chmtime
standalone binary as a subcommand of test-tool); I think I resolved
them correctly, but please double check when I update the public
repositories in several hours.

Thanks.
