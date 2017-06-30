Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B224F201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 16:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752000AbdF3QnU (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 12:43:20 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35696 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbdF3QnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 12:43:20 -0400
Received: by mail-pg0-f53.google.com with SMTP id j186so66135313pge.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZE2X6Xf8dMhRJz3a9Ar9y3g2bGVi2SeXInVJr3M2bWI=;
        b=UgBF1xYB72MtfHlkwXUrTvgLANjvqF7DbZOp1jAz2M0yPo1y9PyE6iyNsTEVMsfG4b
         02A6QzD7PMxbB8ldPOhtG6deV6hhHVw/3KL5auAnBHZempul/ZxZmkyNbNJTbsDKvjku
         ii6gzKkWJhf4+uVLAuRcQKLCtfIJpCSdZODbuN+4nqkwseSkvtgqL+eJEYQ9gd949gWC
         xmjMWjUW3grIUpTZzok6z2bLfYQ74F/n8maojdGefucpM2WxL449a6JuTY6wK5qUJiyA
         9Ybdc6wiTjrznkQJ+jJ7i0xqlaAtFJqG7zNdJFqnfOR5N6F9l1bD9MZMm5x40l5dH7Br
         DGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZE2X6Xf8dMhRJz3a9Ar9y3g2bGVi2SeXInVJr3M2bWI=;
        b=moXslpAdKhD9W6nYEXG2FQsG8TRkaJZ96lAWOnaPZ8WLzq1STMKCaiVt7FEGHDdpiw
         vByxG7Lb/I58ga5DBnCYJbjL698yGhBaapZnziz2/qc57hAxNBtViWqDYH7jPEg0tYM6
         AVMM3rhKLumGgarweKUtf01rMRuh62buNjJuhyh32Iwd0BTSOTy1H5X5ecm8iwuejREN
         s23FGenHM7gHYVdFp6zRNRXXT3WTg0KEqNxXC6LiRWjwkQIlddh+rJ9ap34fPSqMp9MK
         +Uebg99MAm4HJhaXch/VZmioVLwY+2kjwFYXCzoz/slZjPFUSTwgQnoMx5edqTz9qGGS
         RUmA==
X-Gm-Message-State: AKS2vOww5u0K+FZubzrKEq/m5ttyE1GQZSkp9up9rHFopdwdBZh6u9nn
        1zc7qpteUS4g8IDvDpc66LxluketK32j
X-Received: by 10.84.232.205 with SMTP id x13mr25870418plm.245.1498840999182;
 Fri, 30 Jun 2017 09:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 09:43:18 -0700 (PDT)
In-Reply-To: <CADHEqX_fiUhnpn6WAFrbDaNJTb1Vbom7Ndn-n6WmQ0gkQ69ZeA@mail.gmail.com>
References: <CADHEqX_fiUhnpn6WAFrbDaNJTb1Vbom7Ndn-n6WmQ0gkQ69ZeA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 09:43:18 -0700
Message-ID: <CAGZ79kZxde9j+O4JDofYLbC2CRk_X0tiwOftEgKQcJLyN409xQ@mail.gmail.com>
Subject: Re: git log use of date format differs between Command Line and
 script usage.
To:     Shaun Uldrikis <stuldrikis@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 9:06 AM, Shaun Uldrikis <stuldrikis@gmail.com> wrote:
> If you supply a non-standard format to the date configuration for git
> log, something like:
> [log]
>         date = format:%Y-%m-%d %H:%M

So I ran

    $ git config log.date  "format:%Y-%m-%d %H:%M"
    $ git config --list |grep log.date
    log.date=format:%Y-%m-%d %H:%M

Then I have a script as
  $ cat script.sh
  #!/bin/sh

  git log >out

after executing I get:

  $ head out
  commit 7930db48ca31b41ac335ae8cd25cb29094d1de5e
  Author: Stefan Beller <sbeller@google.com>
  Date:   2017-06-30 09:26

Also gitk seems to work here.

Rene's answer sounds reasonable,
check the version(s) of Git on your system?
