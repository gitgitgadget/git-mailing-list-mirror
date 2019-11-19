Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E19021F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfKSQ46 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:56:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46388 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfKSQ46 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:56:58 -0500
Received: by mail-lf1-f67.google.com with SMTP id a17so1530357lfi.13
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 08:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uu9tGIZDVtr+X3SzY14up3AbF7eRuArvGrHDh06f1uA=;
        b=EpRRoGFCjTRrJtr1GX7aCJr8wMCNFFa0N2g0zNEtyqrhGlSyvlpJi6KqpoQRuMy4l3
         LKMVoNnYTTqtj514SikbL6Ei/u6TY6CpfPb5TRyYLkobDcHbkJrqGQ0X+HTQXWiqSzSV
         PKeIFNYonNJlX9DSaixga99sg4LW2YkTgBz2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uu9tGIZDVtr+X3SzY14up3AbF7eRuArvGrHDh06f1uA=;
        b=MmCNXfqkL9R++FkUnwtZ0b6j5+yFR61KCihFrMVdxEjiU2BRHPrQ27zuv4gzbfZG2U
         /VDDIqn+MO78BZkAmxsUPqUyAW6U7HSm7IycT5WjdRWW+MW/amGQMBxt7HUuvi4CYf9O
         VxleJmpt6v83oUBp1DuYPgb5olNxHVXCi0CqEaVf6W50l+asqekYQ94+qBG2KYBgaEJo
         of+WiW1Z4CMzvh2cXhW8++VchqQ4Apy1sH+sWw3JQERwBkMbXfkM7n1lq6mq1HZGh9dR
         dtIJQT9tMIyiB8epNhQD1dFzjurUCgJ8ad4cfo7D5yCAVj56YDvySWgGp/nwiWaIq27v
         WO1Q==
X-Gm-Message-State: APjAAAWweW3SzCrRJA0Chu31EZjfAe5kHiWm3RG4s5iNw5GKnYfNnBEY
        1A+SsLoiYMB4t97F6/eXtAq8nbJP7V4Zcy1Q1Ogfug==
X-Google-Smtp-Source: APXvYqxfkz6rUa4ZD5ftBRcGiclmg9yjpzG/wdJNS/gV9eAfhwr9fRGO1cLrPKjRiiDISwGC5DyZRsBYarv5ppp3Sjk=
X-Received: by 2002:a19:5f44:: with SMTP id a4mr4574110lfj.45.1574182614538;
 Tue, 19 Nov 2019 08:56:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
 <pull.436.v4.git.1573973770.gitgitgadget@gmail.com> <20191119152156.tzsh2hxgcgcegvtt@yadavpratyush.com>
In-Reply-To: <20191119152156.tzsh2hxgcgcegvtt@yadavpratyush.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Tue, 19 Nov 2019 10:56:43 -0600
Message-ID: <CAPSOpYvEnWEg8JDyj2ASd-igh6Q41=BUinq1yxwev-DJqyfyWA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] git-gui: revert untracked files by deleting them
To:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 9:22 AM Pratyush Yadav me-at-yadavpratyush.com
|GitHub Public/Example Allow| <172q77k4bxwj0zt@sneakemail.com> wrote:
> On 17/11/19 06:56AM, Jonathan Gilbert via GitGitGadget wrote:
> >  * The initialization code in git-gui.sh (which I'm assuming
> >     translates somehow to git-gui.tcl in the installation?)
>
> Well, the design is a bit strange. git-gui.sh happens to be _both_ a
> shell script and a Tcl script.

Ah, I see -- I had managed to convince myself that they were different
files, but never actually diffed them. In my installation, I have a
file "C:\Program Files\Git\mingw64\libexec\git-core\git-gui.tcl" and
that _is_ the same file as git-gui.sh in the repository. So maybe it's
Windows-specific, maybe not, I'm not sure, but at some point it gets
renamed from git-gui.sh to git-gui.tcl. I incorrectly assumed that the
.tcl file didn't have all the facets of the .sh file. :-P

Thanks,

Jonathan Gilbert
