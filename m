Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA9031F453
	for <e@80x24.org>; Sun, 10 Feb 2019 22:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfBJWRQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 17:17:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55547 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJWRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 17:17:16 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so13784710wmh.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 14:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BVqwhAXmvAHsExwLdwDxe2uZJyqgHeABNEDAY0ToPOA=;
        b=k1Y4engETV3VPFzdrjlMQjgx8TKPr7tbmAlKEITv/4yVamweqwLJryNuv/7uC6aZe1
         Fg7Pkjq4x310Nw8Al03sR6QjKBx3P8l3z6Z8RzBqKz6T9eWjCUOua0OOrlk598fuS9g2
         SUFn4d/jSipaMpqdCuZkaV26nYaibhyQxp5cca5P6bbYzAcXuM9fxtg6+LCfJ2skJVj+
         IHPMvdOMfnmco0rrpl8GZ473BLsWMhMnPOUBfXTJHWWCxBUGB/SNC6hCJx4MP9xw03do
         DdQ4nR/gin0XpHSc4zkvIOoZe4Pqh8pneVYNnXE62En4cVOiD3Gl05xoq+EzeFfSuX3O
         WFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BVqwhAXmvAHsExwLdwDxe2uZJyqgHeABNEDAY0ToPOA=;
        b=E8lV6q9xhM+pjqAEoJ1BaYiuG3Kd7S4Wahwqng9Gib9E6uV44kbnnCg46lefLRZTbB
         YFqHvZ8zjUyXW/cFPb7WnLkA2I6ynxAhC95qFzSuoVSSosjaLxLWiXGvLDLDeFxf0ccp
         oJMEdJfyk4IAi8Y5fo1QBdiDh7Nilf0W++m82vYJ+q1U2QPaI/U86lFkoX/ELs9KKEy5
         0+FHThig2gsI+nn28kqwppqJpngTdh5eBoQOZW9vX+xsf+n/PtRiGO90OuBsPQ25CaiZ
         RDWfs1aT1eC9/FedMck0XUh7LgQC0efJz6gkhU6qqaAM8Q23H3i5t2JpULQE0f8pHVUt
         PS7w==
X-Gm-Message-State: AHQUAuZrAjmtPwLTColwexA7j2ZUU1Gg/0g+xx3zZjjau1tItaMv2PXC
        Yg6qcMrY/d54BDa7afP2TWI=
X-Google-Smtp-Source: AHgI3IaiMvByuOo5d2ixoP5LDudel4ZJJBkopye9Jc6ngFsyfb8UGNsW4lYMf2RiRNL5ioSFXah+XA==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr6777200wme.135.1549837034436;
        Sun, 10 Feb 2019 14:17:14 -0800 (PST)
Received: from localhost ([109.180.252.133])
        by smtp.gmail.com with ESMTPSA id y1sm11723525wru.4.2019.02.10.14.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 14:17:13 -0800 (PST)
Date:   Sun, 10 Feb 2019 22:17:12 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
Message-ID: <20190210221712.GA9241@hank.intra.tgummerer.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
 <20190208113059.GV10587@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190208113059.GV10587@szeder.dev>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/08, SZEDER Gábor wrote:
> On Thu, Dec 20, 2018 at 09:44:34PM +0200, Paul-Sebastian Ungureanu wrote:
> > Add stash push to the helper.
> > 
> > Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> 
> This patch causes rare failures in 't3903-stash.sh', I've seen it
> break for the first time today in a Travis CI build:

Thanks for reporting this.  I was going to take a look at it, but
unfortunately I can't seem to reproduce the issue even with --stress
(I let it run for ~1000 repetitions and then aborted it).

Which platform did you see/test this on, and which compile options did
you use?  I went through a failures on
https://travis-ci.org/git/git/builds, but couldn't find this
particular one.  Could you point me at the failed run?

>   +echo bar3
>   +echo bar4
>   +git add file2
>   +git stash -k
>   Saved working directory and index state WIP on stashbranch: d3a23d9 alternate second
>   +cat file
>   +cat file2
>   +test bar,bar4 = bar,bar2
>   error: last command exited with $?=1
>   not ok 20 - stash -k
> 
> Steps to reproduce:
> 
>   $ git checkout -f fa38428f76
>   HEAD is now at fa38428f76 stash: convert push to builtin
>   
>   # fb7d1e3ac8 (test-lib: add the '--stress' option to run a test
>   # repeatedly under load, 2019-01-05)
>   $ git merge --no-commit fb7d1e3ac8
>   Automatic merge went well; stopped before committing as requested
>   $ make && cd t
>   <snip>
>   $ ./t3903-stash.sh --stress -r 1,13,14,20
>   # wait, it tends to fail in <30 repetitions
> 
> I run stress testing on its parent for over 800 repetitions, no sign
> of failure yet.
