Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F7A1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 01:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeDSBwv (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 21:52:51 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:32971 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbeDSBwu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 21:52:50 -0400
Received: by mail-wr0-f182.google.com with SMTP id z73-v6so9623746wrb.0
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 18:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zakd0oROB/pzkdM3DnZW8QzHooMHVG/unMm+6oETBjc=;
        b=mdoqEvyrFcO5ixvu5bcmulPV1gpazOuOsTd65M+Vbky0F9y5Q/6VoxRFq75vJZ5sY0
         1cynt2FcLKKCVCqWuBU7XIbjRhPHR4HnHjT+HdBlZITvACIDtaJdofhxdZ++X9W+B1t5
         kit7pFfm9d3UJKhGCHcNIAI4vAm56353h6RrF9PuB7vWPo3SxL1ylET3CDOc7uLrJseB
         BtMV1otNaZWtZjkRlO1IpmiwYt+JP6PwmkM4aLX3RICOVUNgkFwFEnP14eZivnP15Wmn
         efRLNsWm4eNhhA1Q4YgfV6SvamImELWT9gxTFQaKm+KVhp2qUv7abEqNbYOaa4p1X+U4
         L46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zakd0oROB/pzkdM3DnZW8QzHooMHVG/unMm+6oETBjc=;
        b=H0f73rzuhb6YvaoUQE9EAiQgnBbnOt1mi/xEeqMbiW+mVgratga4G2qIcqt4EXrTyO
         L2Z80MIYuZcId0qwyUlUo9LYqzDFOqQ+qP7OZRExbVn9PXRO4Clbf6AEJGWUEA+Y5xwR
         NVMoYlnZYL62Wasv5HaBZQIP5alkD7Tg8rWDSFvYSfztvPg87kiVcV1DzvjB7DC7ETm2
         88ZJEup4xCPFvv3tys2s1NyjoeAzeVyzFoj9JOG15+JoBqkQb72RxCW9sPX0Oeli9nmA
         8XcO6I1iXJRAXkWeU+4/dNGzMR4zAvfgY8oGnTeO/a7R29w2lPrjKosKBPEFvhgzpi8/
         VyGQ==
X-Gm-Message-State: ALQs6tCDg4vR+CNnWXjIhbnxMaWD8uQBQkVCL79MSEJTrWpduIKIGP+y
        xLkN7uzUPXLaaXS0f2zA6bU=
X-Google-Smtp-Source: AIpwx4/aKDB7ColGz66Y5b8qbBG3YnWUpxe0giT+XJlVLX2PSSXDW5JZmbcVaFaSEmOqCL6VIU24hg==
X-Received: by 10.28.146.200 with SMTP id u191mr3247174wmd.115.1524102769256;
        Wed, 18 Apr 2018 18:52:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t76sm3276734wme.17.2018.04.18.18.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 18:52:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Silly "git gc" UI issue.
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
Date:   Thu, 19 Apr 2018 10:52:47 +0900
In-Reply-To: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 18 Apr 2018 18:45:59 -0700")
Message-ID: <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> You get this:
>
>    git gc --prune=npw
>
> Yeah, that "npw" should be "now", which is where the klutz thing comes in.
>
> It turns out that git reacts ridiculously badly to this.

    $ git gc --prune=npw
    Counting objects: 10, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (3/3), done.
    Writing objects: 100% (10/10), done.
    Total 10 (delta 2), reused 10 (delta 2)
    error: failed to run prune

It turns out that prune silently goes away given a bad expiry

    $ git prune --expire=nyah ; echo $?
    129

Regardless of your originai "git gc" issue, we should make "prune"
say something on this error.  And when we do so, I would think that
error message will come before the final "error: failed to run
prune".

Or perhaps we do so and then squelch "error: failed to run prune",
trusting that a corrected "git prune" will always say something when
it fails.



