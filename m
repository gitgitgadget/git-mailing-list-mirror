Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98BFD1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 17:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbeKACmw (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 22:42:52 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39460 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeKACmv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 22:42:51 -0400
Received: by mail-ed1-f45.google.com with SMTP id e5-v6so14364042eds.6
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQG4Za9DAOfR6mANHgDGN0cd9zvcyOEIGu4MSe+QvnU=;
        b=lX9mxX+YZsCAyyBa/l7gdIWWRdtGwjNPRD1wAjgHUVaO8faN78X8NrQo1qswWZ8A7x
         U898ubdbohbW0v0BcptaBz41QYfydaTb2AqrnHnamg3KUACBY53K5imRDbBkLuWg15AP
         s52ulYps1rzaXLVLrFAtFuFIiK50wjRmtENdQVP9L+SqVaXMwdKevaS+856Thr8SWSEk
         hUn/QRjwk1vH/fQ9DyybOMZW2EvmSrBihnKWdOkU2SDI2L5wABkqm4/unxmwNuA8r51l
         bj8/Mrho3ewwJ77zzPvsLIlOLeOCiia4EQc+8e0f1t4O8qhXUbfRoWrvk6Og4fSUt2xI
         3J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQG4Za9DAOfR6mANHgDGN0cd9zvcyOEIGu4MSe+QvnU=;
        b=lWXypExpl6BCy2ExP9MGZRFaTfZYj+yS+GrhcWUeHyHiw+PVl/1+8q8S5LrxdAOJSo
         JFV0GouQJpCs/v/IJfzIhKS7b9ToGqumNMZrGVa+do9gwAEgDcwJnxKFkaO7Hd9rqGut
         bSuX1ktrDS3FsRglmUXIxb/xeA8eEefCFC4TAITpkEYV+0ayIqFKsjamrxioQ0HLh3IW
         Ne1MkBZdRwDxv4/8ygL3IMO76b7otLWDTCo57zdSydZKrx3ZC5mByLmWoJQ7VwVP/8fM
         jVYJ+Hr+qMirmxGC60hC7BIEUVNr8Fqk6Nqx3GZBHft9PzXZdtKIWAJDPfJT+b8PLsrr
         yjWQ==
X-Gm-Message-State: AGRZ1gIxMTh7HAeOZuEA7gqkLxHmNsOTmNPsNDt1FYtfq8Nezd0UUvFO
        W9LZeV9EFjT1qONzJhZLFHjBf6+yWycnSr65xVO0yw==
X-Google-Smtp-Source: AJdET5erpyEZmZnGnOKP3235fb983E2u7rLrJ5hITz2sXsaZmGHZfHL2pikJ5yrwaxxXof8MIkuvRJwgxvSR8o4353I=
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr2182886ejq.19.1541007829958;
 Wed, 31 Oct 2018 10:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn76N34oBhRZvXKOwP0L_pF=LYbT6ugTgtPYSvnHg=MZVw@mail.gmail.com>
 <xmqqlg6eyc3u.fsf@gitster-ct.c.googlers.com> <CA+X5Wn6vGLiQr8O8UVkJnFpVq+OVzOjtxhtqwtZEsyh0RrSz9w@mail.gmail.com>
In-Reply-To: <CA+X5Wn6vGLiQr8O8UVkJnFpVq+OVzOjtxhtqwtZEsyh0RrSz9w@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 Oct 2018 10:43:38 -0700
Message-ID: <CAGZ79kY+QVN4P2NhuOfDdXH1yHZfOjuA-H6FXS91jundhgo_2A@mail.gmail.com>
Subject: Re: Using --word-diff breaks --color-moved
To:     jamespharvey20@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 12:07 AM james harvey <jamespharvey20@gmail.com> wrote:

> I think these options can co-exist.  I could be wrong, but I'm betting
> the code for "--color-moved" was only written with the typical full
> line(s) diff in mind, and wasn't written with "--word-diff" in mind.

I think it was brought up, but neglected at the time.
