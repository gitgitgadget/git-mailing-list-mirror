Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0641F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 11:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406808AbfJRLGY (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 07:06:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51428 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390987AbfJRLGY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 07:06:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so5759503wme.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 04:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wzvvk24MWBR/VnY4EEOB5kGPqplN7mn+QEL8RwaxEXQ=;
        b=GYxlwRfy8l6ma4BxEOEQqPDns7ivFjYPdGsdYGFoedq3PQFUTBfHmTez/HgEp8igzE
         12m1b+/ftWZziuCgHiYCLiOuaVhKXBdiwwLeMnXAZRSkSYVMiiLbSB9hW7SEUIh0zqCt
         CCVPFNyxjUWYJmYvfixchxnPePqNOBEwGIDgPQwXPDBuMyDMGoe4kUcGHHYiXI3Z0F13
         qDRXMvzKOpDPjjBm3147J8CgX6pgxJt0Fd8BrpIu7DA+/mYRdFGsxP2Aazx7TMvlNWAl
         MBgDHArqdgEiftZ0JheIlfj3UESuSYKEsGHS1vRFyKfuFyvcJRBLzG2I6dOpQQDyw/fO
         VUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wzvvk24MWBR/VnY4EEOB5kGPqplN7mn+QEL8RwaxEXQ=;
        b=ZuSgfT0fohnOUufWU5EWoarF+xF7oVELT1V4P0ouA3ejAZvBxi0CBVrd/LbKAvlYsk
         MguzuK+f+DgeCYr1krLtbZUsvReXWAh9BfdhdalIHUXnLc9kJ4gExyU5HS20feHWxvbs
         MgCnI+YEBCPAjZDX1ZjoiTiDyPdH95MQQqxiLmBSXmlrfdr0ls4CyZKMsvnTwLFqjSve
         19rd8YKEvZK1IM/g/DYM1vIov/LTVDVZ1Ia/IIfuxOe4y3/KhKqoxzBzaT5WRFWqv/q+
         IQxohArvLGjqCGIo2jwC8H9NSlN3h/RbOYUpoC8QgLzfque3VdNvS1o2Gt1JPs0i4Mhn
         u5qg==
X-Gm-Message-State: APjAAAXrvAczpr1xRQDTKgbSt+gWBCM2E5aADmrdDfBBFy7lnhdo8Kkr
        owOOdXcpL5d6EzJB0QXHrFw=
X-Google-Smtp-Source: APXvYqy7ttM4qa2TseC5/lE+1dvqctSayh8bsstoE5PIGndyb29sOz2eb1I3r7ZDOqftdatGxicSfw==
X-Received: by 2002:a1c:c90c:: with SMTP id f12mr6804095wmb.97.1571396781567;
        Fri, 18 Oct 2019 04:06:21 -0700 (PDT)
Received: from szeder.dev (x4dbd7267.dyn.telefonica.de. [77.189.114.103])
        by smtp.gmail.com with ESMTPSA id t13sm6388793wra.70.2019.10.18.04.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 04:06:20 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:06:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git_path(): handle `.lock` files correctly
Message-ID: <20191018110618.GZ29845@szeder.dev>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
 <f08c90ea02f6811b310a01301acf46da133f38a9.1571209637.git.gitgitgadget@gmail.com>
 <20191016110440.GV29845@szeder.dev>
 <nycvar.QRO.7.76.6.1910172333360.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910172333360.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 12:05:20AM +0200, Johannes Schindelin wrote:
> > I tried to reproduce this issue in a working tree, but
> > no matter what I've tried, 'git rev-parse --git-dir index.lock' always
> > returned the right path.
> 
> With `s/--git-dir/--git-path/`, I agree.

Right.  I mistyped it a few times on the command line as well, but
then the command's output reminded me that I messed up.  Alas, no such
reminder when writing the email...

> > On a related note, I'm not sure whether the path of the reflogs
> > directory is right while in a different working tree...  Both with and
> > without this patch I get a path pointing to the main working tree:
> >
> >   $ ./git -C WT/ rev-parse --git-path logs
> >   /home/szeder/src/git/.git/logs
> >
> > However, I'm not sure what the right path should be in the first
> > place, given that each working tree has its own 'logs' directory, but
> > only for HEAD's reflog, while everything else goes to the main working
> > tree's 'logs' directory.
> 
> It's like Junio said, the reflog for `HEAD` is special because `HEAD` is
> special. Look for `common_list` in `path.c` (it is a bit confusing, I
> admit, you have to look for the 3rd column of numbers: if it is a `1`,
> then it is a worktree-specific path, if it is `0`, it is supposed to
> live in the "commondir", i.e. in the gitdir of the main worktree).

OK, got it.

I didn't look yesterday at all, but now I did, and, unfortunately, see
two more bugs, and one of them is a "proper" bug leading to bogus
output:

  $ git -C WT/ rev-parse --git-path logs/refs --git-path logs/refs/
  /home/szeder/src/git/.git/logs/refs
  /home/szeder/src/git/.git/worktrees/WT/logs/refs/

