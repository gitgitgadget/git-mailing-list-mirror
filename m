Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2731F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbeI1DA0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:00:26 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33863 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:00:26 -0400
Received: by mail-wr1-f48.google.com with SMTP id z4-v6so2678751wrb.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tOBFzj1FNDDgyPo7gBlEpYNfrMqK8FsVkRMn/o6LiQM=;
        b=RV4QiqFVaqDhKTj/Ksi1s5lsbGVLft+N+N4i033lTii6Fppa7fXFo6izTjfrF7XMgg
         7WDEmmUQ52fnVALz+uKSOtyQJpJmFywl3BWdnP6HkfeLUrLKbxQod38jbfDwskJ4Hh8f
         Rt0khAbmYVTxBfSjkOIXoC7m99aqBVYKWK+q9w6lx3aI/FHO46o0+11lPou7qPKIDoYk
         YpYQ4HsMA0PcA+yFkOEycdtEglgxuuW7ztUoVzfO3LSjiQCtTVzmElOVtSHJdhF1Cay4
         HloiVisGJTmOOwgd36bQyG/HiJFi7zEXNh1CO5HiRSN2HdFDH85XdZ5r/ptfvbFJ+/5h
         KDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tOBFzj1FNDDgyPo7gBlEpYNfrMqK8FsVkRMn/o6LiQM=;
        b=r1P4TPn9XTvbUxynQHjVamzF1N5XAzZmuRMZlNqopWL6VwQJYlScimxbyhLk3f6gPl
         1WvJXKz7txnCvfz7j331weR5G0PhoeS2q0HnT1ciFyjDkowjU05ZGqhe0HcuTGtj17qn
         DoZkE1GRoGHO0K07xR0y2Y54UxewK/ObaA8L0/QrEkxJWBYdTYKY/sgrERm1qVwttKOV
         aIi0ZFbC06720Tbdxao8xw85VS9UfpU148DrIiYFdlsgR9sRexJ+i6xTOrGW993OKcCS
         VgDF1V2oA4nForaChl6NOiGHcMWXfbGL9X/IY/3VxGmyloAnTyaJ53BWPOdFOVioVgos
         yQDw==
X-Gm-Message-State: ABuFfojcFERgF6sj+FGsRBEtUA25Atr1LNSR3vqtJwm+LhSnNqIbocMN
        1zpL5Ci1dfTbAMVjJf6sW4GDlQCi
X-Google-Smtp-Source: ACcGV60FIxkGKA1zpqomJxh3tlvucYkmCBiCD3hmxl0vAmpX19p7XDXosBg2bADY3l6PI75HJl25mQ==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr9720509wrg.249.1538080818541;
        Thu, 27 Sep 2018 13:40:18 -0700 (PDT)
Received: from localhost ([2.30.92.34])
        by smtp.gmail.com with ESMTPSA id c9-v6sm1891809wrt.77.2018.09.27.13.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:40:17 -0700 (PDT)
Date:   Thu, 27 Sep 2018 21:40:17 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Ruud van Asseldonk <ruud@channable.com>
Cc:     git@vger.kernel.org
Subject: Re: Null pointer dereference in rerere.c
Message-ID: <20180927204017.GB2253@hank.intra.tgummerer.com>
References: <CAAqqbi=5Dc2yisSG5r71NGvwS7bfQh_aRpxiTbtFm-XHDqjYUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAqqbi=5Dc2yisSG5r71NGvwS7bfQh_aRpxiTbtFm-XHDqjYUw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Ruud van Asseldonk wrote:
> Hi,
> 
> I just ran into a segmentation fault during a rebase with rerere
> enabled. Inspecting the core dump with gdb shows:

Thanks for reporting this bug

> (gdb) bt
> #0  0x000055d673375ce0 in do_rerere_one_path (update=0x7fff03c37f30,
> rr_item=0x55d6746d0b30) at rerere.c:755
> #1  do_plain_rerere (fd=3, rr=0x7fff03c37ef0) at rerere.c:853
> #2  rerere (flags=flags@entry=0) at rerere.c:918
> #3  0x000055d673246b01 in am_resolve (state=0x7fff03c38120) at builtin/am.c:1901
> #4  cmd_am (argc=<optimised out>, argv=<optimised out>,
> prefix=<optimised out>) at builtin/am.c:2394
> #5  0x000055d67323f975 in run_builtin (argv=<optimised out>,
> argc=<optimised out>, p=<optimised out>) at git.c:346
> #6  handle_builtin (argc=<optimised out>, argv=<optimised out>) at git.c:554
> #7  0x000055d6732405e5 in run_argv (argv=0x7fff03c394a0,
> argcp=0x7fff03c394ac) at git.c:606
> #8  cmd_main (argc=<optimised out>, argv=<optimised out>) at git.c:683
> #9  0x000055d67323f64a in main (argc=4, argv=0x7fff03c396f8) at common-main.c:43
> (gdb) info locals
> path = 0x55d6746d08e0 "<file path redacted>"
> id = 0x55d6746d01e0
> rr_dir = 0x55d6746ccb80
> variant = <optimised out>
> path = <optimised out>
> id = <optimised out>
> rr_dir = <optimised out>
> variant = <optimised out>
> both = <optimised out>
> vid = <optimised out>
> path = <optimised out>
> (gdb) print id
> $1 = (struct rerere_id *) 0x55d6746d01e0
> (gdb) print id->collection
> $2 = (struct rerere_dir *) 0x55d6746ccb80
> (gdb) print id->collection->status
> $3 = (unsigned char *) 0x0
> 
> This is using Git 2.17.1 from the 1:2.17.1-1ubuntu0.1 Ubuntu package.
> Looking at the diff between v2.17.1 and master for rerere.c it looks
> like the part of the rerere.c where the null pointer dereference
> happens has not been touched, so the issue might still be there.
> Unfortunately I was unable to reproduce the bug; after removing
> .git/MERGE_RR.lock and restarting the rebase, it completed fine.

I do believe this bug may actually be fixed in master, by 93406a282f
("rerere: fix crash with files rerere can't handle", 2018-08-05).  Do
you by any chance remember if you committed a file that contained
conflict markers during the rebase at some point?

The problem I found at the time looked the same as your backtrace
above in any case.

Would have been nice if you were able to reproduce it, just to make
sure it's not something else we're seeing here.

> Please let me know if there is anything I can do to help diagnose the
> problem, or whether I should report the bug to Ubuntu instead.
> 
> Kind regards,
> 
> Ruud van Asseldonk
