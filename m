Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9D71F597
	for <e@80x24.org>; Mon, 30 Jul 2018 22:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeG3Xwv (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 19:52:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41559 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeG3Xwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 19:52:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so14490069wrr.8
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QcuVXB2N/LrnpY0j9ZyoAqGHk6gDsgdO3ht2OVx4ZmY=;
        b=U7yQ2YE8R8xK/gShwTlqmQ+ZmkgLxlrSYUYHCCXuJurfPOk9jmG5MF/ww6A7onL3hS
         XVNyrhuQ+q56QsKG/uQxYGTKGz0Rygz7L/ft3Erp3i9cjjKOWqBFiD6DKMDxUVplKTtv
         DlkI6AKptlybnRONSPjw+iBuogr8UvlDPUzOlgeOsRzTPw0GKhiduI5JBZx41Cy1cn3Q
         OmS8gQIefK3Z7dzm3EMhm7z4Obzab+ndSrw0mwkTNbnVTl2QVcYsgGSqKl3wRbh8iO3c
         KOFxSnm0MCMqUubV3ib185NUvx4ponftZngjic98jKL5m9pvdwkaVBk70Vftu7JKCxYu
         75JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QcuVXB2N/LrnpY0j9ZyoAqGHk6gDsgdO3ht2OVx4ZmY=;
        b=Ej+sx4afp/tgU8WSRMInnUhL2KKdQ4q5LShovN8O9iybPKYq3+kRqHyMBhYxsD5S4l
         +kI0L2nv5QCpvsMr6B/TNh7C1dmRpmp81DXrx73mKCQ+LSejs4ptUDr5tacNH+HPJi6Q
         Sonbh/wK4ng12qM9/slsk/PzNqXVf+v+mGT/lvWTiEYl9jETGVRbDIhUZe/ZYgLHuPHF
         kksFMuPAAmXV4oobchnzlYL7VYlxZA5px/2ZwXJ35z7MliuKhH8I3boEdn9QY0xxgbFE
         bPQmQ1xENRnnzT5UTwXQINBgjNCoxW/NUYkidDtiPkAVu8Ma5SUIuhZ98kjtsvhguomz
         dx3g==
X-Gm-Message-State: AOUpUlGlPi7UYwQYB4kjGSj3y3e4bTBaa4D9KK3BFgJOrSQyTNQy0gIE
        T+BpPss9X5ZLb435wu9cIuk=
X-Google-Smtp-Source: AAOMgpcdcr5n6EQX+CfdF0YxbtobR0jNCbdC7idNS/wf6k8dqYEVRXXpCB+rtQDEqj1QHqhMt7xA2Q==
X-Received: by 2002:a5d:6841:: with SMTP id o1-v6mr19189672wrw.159.1532988946071;
        Mon, 30 Jul 2018 15:15:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x23-v6sm452986wmh.26.2018.07.30.15.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 15:15:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Rerolling patch series to fix t7501
References: <20180715110807.25544-1-sxlijin@gmail.com>
        <20180723020903.22435-1-sxlijin@gmail.com>
Date:   Mon, 30 Jul 2018 15:15:44 -0700
In-Reply-To: <20180723020903.22435-1-sxlijin@gmail.com> (Samuel Lijin's
        message of "Sun, 22 Jul 2018 22:08:59 -0400")
Message-ID: <xmqqo9eoe5f3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> Following up on Junio's review from last time.
>
> Samuel Lijin (4):
>   t7501: add coverage for flags which imply dry runs
>   wt-status: rename commitable to committable
>   wt-status: teach wt_status_collect about merges in progress
>   commit: fix exit code when doing a dry run
>
>  builtin/commit.c  |  32 +++---
>  ref-filter.c      |   3 +-
>  t/t7501-commit.sh | 150 ++++++++++++++++++++++++---
>  wt-status.c       | 258 ++++++++++++++++++++++++----------------------
>  wt-status.h       |  13 +--
>  5 files changed, 298 insertions(+), 158 deletions(-)


It seems that t7512 & t7060 break with this topic queued.
