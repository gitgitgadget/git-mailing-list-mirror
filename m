Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8119E20248
	for <e@80x24.org>; Sat,  6 Apr 2019 17:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDFRte (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 13:49:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40111 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDFRte (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 13:49:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so10449789wmi.5
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B/YDGOqX9mFvHYYjfjCxIRZJjJ9SD93U8P/Yfpn4tXQ=;
        b=T5ls5qy7c/gV2sBQZn6J8024OhZg3CN+/vRVLAHlNc8x/x5WPk+cE4Nk/374eGp52w
         HJ+Ft3TbRRhUAcFArkOxEejjzMjJuMImUHie2gOMxuPBBucBdxNujDbaWxbrCbwecevH
         7KbsAj6yvNKTKzZvOaqf3kZMJpkL3RqWFC2rLamWJ6F90n3SLBn2PJzmPM6GnL8rTmiN
         LtqzrTkzwRPbcu+CidYPCqrC6pU0aTll70oRCBxcZEYKOyiLjZQXWGUUOnv8MWJ30/cN
         RK3ArTTPn2AzGA924CvumpbhI7Gr/AJvHbRchZ0qJ8FB8O2RdogNILkV5bF2g+UJlwkm
         pEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B/YDGOqX9mFvHYYjfjCxIRZJjJ9SD93U8P/Yfpn4tXQ=;
        b=bKtzr9ectty/XlwWRYW2INDmF6hO1RqUsa9FJNwdTnOmCIpR0X62oWgfuuoMZw0vF/
         u4ou2LjrcNNSp5clSMkcl7RFrz+nqsThN8lJT8FjACVScBrpCw2376EZAmOt2rAsa+NY
         WU3VsrGro5A6jEGmsa7h5yueZ8H2Z7IAZw3UkJGcadAt8PpMHgKGRKhu9aublsPse3Cy
         E/E/wPxgumPp5yCDV5qyD+gBwKNsu6d4UzFYSU+yXdErD2N0HlvZJaJeiZF1mIXj1cUl
         lfkXPIjnsNkw3fjN3lb+mBc04linF93T+nRGGZip8/Q/s/ejd9pkNTHp8iUw/tZ/jQm9
         oyaA==
X-Gm-Message-State: APjAAAWxXTZyO1+EFMNN8mAoa4rAwGnTK1Qpf1Z8OeyrMSKdX25DO9Nt
        6q3zXA0DGDiQGeH5CTO3v90=
X-Google-Smtp-Source: APXvYqw1CaM8wPEXT32ezXWHVAhvDsXKt9Te5KBG8WERchzhztMSLxZnLP/3W3IT8qKLjC35MVK+Ng==
X-Received: by 2002:a1c:9c14:: with SMTP id f20mr11802720wme.16.1554572972376;
        Sat, 06 Apr 2019 10:49:32 -0700 (PDT)
Received: from szeder.dev (x4db319c1.dyn.telefonica.de. [77.179.25.193])
        by smtp.gmail.com with ESMTPSA id g12sm22991220wrw.40.2019.04.06.10.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 10:49:31 -0700 (PDT)
Date:   Sat, 6 Apr 2019 19:49:29 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Paul Schreiber <paulschreiber@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: subcommand autocomplete fails on 2.21.0
Message-ID: <20190406174929.GD8796@szeder.dev>
References: <E4A677E6-E624-464B-9BC6-AAAE0A77EFFE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E4A677E6-E624-464B-9BC6-AAAE0A77EFFE@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 06, 2019 at 12:36:30PM -0400, Paul Schreiber wrote:
> With git 2.21.0, tab completion no longer works for subcommands.
> 
> STEPS TO REPRODUCE
> 1. install git 2.21.0 from https://git-scm.com/download/mac
> 2. source /usr/local/etc/bash_completion.d/git-extras (manually, or update your .bashrc/.profile and start a new terminal)
> 2. git clone https://github.com/tj/git-extras
> 3. cd git-extras
> 4. sudo make install

By the looks of it, this installs five commands whose names start with
'del':

  git-delete-branch
  git-delete-merged-branches
  git-delete-submodule
  git-delete-tag
  git-delta

If this is indeed the case, then ...

> 5. change directory to a git repository
> 6. type "git del” and press [tab] 
> 
> EXPECTED
> line is changed to "git delete-merged-branches"

... this behavior would, in fact, be a bug, because 'del' is the
unique prefix of those five commands.

> ACTUAL
> [beep]

And I think this is the right behavior, and on a second TAB it should
list all commands whose name starts with 'del'.

> CONFIG
> macOS 10.13.6 (17G5019) and macOS 10.14 (18E226)
> git 2.21.0
> git-extras 4.8.0-dev
> 
> REGRESSION
> Works as expected with git 2.17.0.

