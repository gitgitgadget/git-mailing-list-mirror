Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23CB41F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 14:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJJVlI (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 17:41:08 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:44876 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJVlH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 17:41:07 -0400
Received: by mail-wr1-f45.google.com with SMTP id 63-v6so5950450wra.11
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mc1Z80aSJdN6iNwTsLGrNHFfv9Fts/PdCIK3JtMTUoo=;
        b=AsUI5/8KW0vYWT963a7DIh4z/A11OjDCVRlIpIEVXRQn2vAoDgI9IKOHytIczU7ApW
         EUgmMrgsBFRAyn3S1mtv8kVsmEO1Z81gVReFE5vA1sKxbWeFBgjjqGKZtdB4KR4l4kJy
         yC5RQ2cnZVh/xK5Nd4F7e6+II6+2LNLquuLH9uYaT0f6ynlymnyjOMwLbHNmXH1yb9RR
         MBA9qB8IT0ySDd+lzh+DKURSFlzLXemNxp/M5sqrJOX/1QplCtRUfGkN4m8fEOF82+sa
         7Vt1BwAZ7w8Bz4goBO5WHFkpuIfakx4dP561VL3BwGUduB371wbuuJ8QIXF6D/FmjyqT
         Bqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mc1Z80aSJdN6iNwTsLGrNHFfv9Fts/PdCIK3JtMTUoo=;
        b=eJhNlPkmadoCpFvFmzY+n29Ha8mQgZddjl4NDTnubwP0nNV1GgqVFZT71xvcbiAPaq
         dM52FuAut3BBCcM2OV3lGSB4lyMxnjhlrOaZmfgregUkPC87ALGRhb9e3hsy+rVO3RyV
         f4qQq000pyBkaRuzoUX+R687/PDwKw9iOO4eLronhsIsrkIrgWsLCQ8n6bVCObBbnUjx
         VaUAPi1Bo0Q7sOo37rJ8Pd5Tibf3cbZT2NOE5jnxSTNVANsFnX8I3kOryxlSaNldVs17
         LlicJLBjN3u5PM8EipvtOVVv0bTP+KmaaYCwsXFNseHQX7kdxHXC3oax155vUfSflKFB
         Jk2A==
X-Gm-Message-State: ABuFfoimnDFyqzrFSGHFTg1kyRMJiKMQU1MX74xKUTfjbBHAYzzJAiM1
        VOBulvFkEN4bDrHTSIj+pEk=
X-Google-Smtp-Source: ACcGV62JDVaCEE8lel+/Gxdthfbf1cInaC5lxL77tqLeId7woedcH/jyekIpUzGOGnjwSa6I/N8fZg==
X-Received: by 2002:adf:d082:: with SMTP id y2-v6mr17291842wrh.314.1539181123581;
        Wed, 10 Oct 2018 07:18:43 -0700 (PDT)
Received: from localhost ([31.127.45.92])
        by smtp.gmail.com with ESMTPSA id h78-v6sm15580129wmd.4.2018.10.10.07.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 07:18:42 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:18:41 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
Message-ID: <20181010141841.GA17445@hank.intra.tgummerer.com>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Junio C Hamano wrote:
> * ps/stash-in-c (2018-08-31) 20 commits
>  - stash: replace all `write-tree` child processes with API calls
>  - stash: optimize `get_untracked_files()` and `check_changes()`
>  - stash: convert `stash--helper.c` into `stash.c`
>  - stash: convert save to builtin
>  - stash: make push -q quiet
>  - stash: convert push to builtin
>  - stash: convert create to builtin
>  - stash: convert store to builtin
>  - stash: mention options in `show` synopsis
>  - stash: convert show to builtin
>  - stash: convert list to builtin
>  - stash: convert pop to builtin
>  - stash: convert branch to builtin
>  - stash: convert drop and clear to builtin
>  - stash: convert apply to builtin
>  - stash: add tests for `git stash show` config
>  - stash: rename test cases to be more descriptive
>  - stash: update test cases conform to coding guidelines
>  - stash: improve option parsing test coverage
>  - sha1-name.c: add `get_oidf()` which acts like `get_oid()`
> 
>  "git stash" rewritten in C.
> 
>  Undecided.  This also has been part of my personal build.  I do not
>  offhand recall if this also had the same exposure to the end users
>  as "rebase" and "rebase -i".  I am tempted to merge this to 'next'
>  soonish.
> 
>  Opinions?

There was a v9 of this series [*1*], which hasn't been picked up yet.
Was that intentional, or an oversight?

I left some comments on that iteration.  Some were just style nits,
but I think at least [*2*] should be addressed before we merge this
down to master, not sure if any of my other comments apply to v8 as
well.  I'm happy to send fixup patches, or a patches on top of
this series for that and my other comments, should they apply to v8,
or wait for Paul-Sebastian to send a re-roll.  What do you prefer?

[*1*]: <cover.1537913094.git.ungureanupaulsebastian@gmail.com>
[*2*]: <20180930174848.GE2253@hank.intra.tgummerer.com>
