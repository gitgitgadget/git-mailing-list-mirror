Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D11E31F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbeIKVe2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:34:28 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37299 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeIKVe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:34:27 -0400
Received: by mail-wm0-f52.google.com with SMTP id n11-v6so1682880wmc.2
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CNxrlQm3BPHIRnhzZxvLcpzwaCDziKhk/W8h57q8ZaU=;
        b=irx77J06VnQXDsG2K/gp1FmASeZCGr+6oyN8P1nFF9if1Npoxt7QWF7JijuZyIzQQs
         oV7ab8QV7Z39mPH71w6OtN/7uND8nqNX2EEVTlOXz7iI1zheISdxFBsr/hpfBxZY78Vo
         ibVW/j1wyPmzJtk0HPYTLDpQBHCLKz28uMGOndo2K8yYIzqz7UUAiVp9gApJDEfNScJh
         n2K8IysYtMUbLO/jE0TrWgDd2mxibTbQ+Lh4AoLt3SonJU25yEreADOQ2UUQYpddq952
         D75T1UUIv9KYSCWjBjix7CqIF2f8+duqOKUqOACHUUDnTubbrYgYxSsaXggGFYmqpePO
         BdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CNxrlQm3BPHIRnhzZxvLcpzwaCDziKhk/W8h57q8ZaU=;
        b=CyGeosjSADLl8Dcmo8Kbz//r7UmYrF4YIkRugHh6I4uEG42xEfVELhBOaYdtCUvcQ3
         KiIGD9vEYIcmz3qqwjJ9GXR42iGHcpKRfNxjYsVSE+Qv4PT0z/2BZkAQjSGOKl7ZkGKr
         4dSBla4eXlQ8j0wH2K/Wif9keXdvkC/ulSMsQdt++jA1bBJ7MAXxQptVXmbRC3HOvCsO
         UVYL3iGp624FTKkdIXR20DflF8S6vPz+Cd7yQUSZuXDnx+c32B9ydSfuvWDv+PzWa6a3
         89SHjcKDsnXs6VG+UPvSKrADXhACA3oZzUFR89mFh04mb1+edgRnhn6gftOpPuAVpv8K
         PX2A==
X-Gm-Message-State: APzg51CfZMT9JyrIx6CunV5KUWJNXpVfiHnN/AGU51UzFrmH8Xvck0ug
        /T58mXjVXYKaH7EfkMhFyVw=
X-Google-Smtp-Source: ANB0VdZzuv4TZ8eLvRXALZ1TFQGt8aTy4T0ERpn6va3RIpAI2ucN0QXyx6t0yu8eb8Ed3z86r3T0Eg==
X-Received: by 2002:a1c:1a49:: with SMTP id a70-v6mr1865439wma.91.1536683661026;
        Tue, 11 Sep 2018 09:34:21 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id y5-v6sm19624205wrd.5.2018.09.11.09.34.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 09:34:20 -0700 (PDT)
Date:   Tue, 11 Sep 2018 17:34:19 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
Message-ID: <20180911163419.GB4865@hank.intra.tgummerer.com>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
 <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
 <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11, Derrick Stolee wrote:
> On 9/11/2018 12:04 PM, Derrick Stolee wrote:
> > On 9/11/2018 11:38 AM, Derrick Stolee wrote:
> > The patch below includes a test that fails on Mac OSX with a segfault.
> > 
> > GitGitGadget PR: https://github.com/gitgitgadget/git/pull/36
> > Failed Build: https://git-for-windows.visualstudio.com/git/_build/results?buildId=18616&view=logs
> > 
> > -->8--
> > 
> > From 3ee470d09d54b9ad7ab950f17051d625db0c8654 Mon Sep 17 00:00:00 2001
> > From: Derrick Stolee <dstolee@microsoft.com>
> > Date: Tue, 11 Sep 2018 11:42:03 -0400
> > Subject: [PATCH] range-diff: attempt to create test that fails on OSX
> > 
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  t/t3206-range-diff.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > index 2237c7f4af..02744b07a8 100755
> > --- a/t/t3206-range-diff.sh
> > +++ b/t/t3206-range-diff.sh
> > @@ -142,4 +142,9 @@ test_expect_success 'changed message' '
> >         test_cmp expected actual
> >  '
> > 
> > +test_expect_success 'amend and check' '
> > +       git commit --amend -m "new message" &&
> > +       git range-diff changed-message HEAD@{2} HEAD
> > +'
> > +
> >  test_done
> > -- 
> > 2.19.0.rc2.windows.1
> 
> 
> Sorry, nevermind. The test failed for a different reason:

I think you're on the right track here.  I can not test this on Mac
OS, but on Linux, the following fails when running the test under
valgrind:

    diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
    index 2237c7f4af..a8b0ef8c1d 100755
    --- a/t/t3206-range-diff.sh
    +++ b/t/t3206-range-diff.sh
    @@ -142,4 +142,9 @@ test_expect_success 'changed message' '
            test_cmp expected actual
     '
     
    +test_expect_success 'amend and check' '
    +       git commit --amend -m "new message" &&
    +       git range-diff master HEAD@{1} HEAD
    +'
    +
     test_done

valgrind gives me the following:

==18232== Invalid read of size 4
==18232==    at 0x34D7B5: compute_assignment (linear-assignment.c:54)
==18232==    by 0x2A4253: get_correspondences (range-diff.c:245)
==18232==    by 0x2A4BFB: show_range_diff (range-diff.c:427)
==18232==    by 0x19D453: cmd_range_diff (range-diff.c:108)
==18232==    by 0x122698: run_builtin (git.c:418)
==18232==    by 0x1229D8: handle_builtin (git.c:637)
==18232==    by 0x122BCC: run_argv (git.c:689)
==18232==    by 0x122D90: cmd_main (git.c:766)
==18232==    by 0x1D55A3: main (common-main.c:45)
==18232==  Address 0x4f4d844 is 0 bytes after a block of size 4 alloc'd
==18232==    at 0x483777F: malloc (vg_replace_malloc.c:299)
==18232==    by 0x3381B0: do_xmalloc (wrapper.c:60)
==18232==    by 0x338283: xmalloc (wrapper.c:87)
==18232==    by 0x2A3F8C: get_correspondences (range-diff.c:207)
==18232==    by 0x2A4BFB: show_range_diff (range-diff.c:427)
==18232==    by 0x19D453: cmd_range_diff (range-diff.c:108)
==18232==    by 0x122698: run_builtin (git.c:418)
==18232==    by 0x1229D8: handle_builtin (git.c:637)
==18232==    by 0x122BCC: run_argv (git.c:689)
==18232==    by 0x122D90: cmd_main (git.c:766)
==18232==    by 0x1D55A3: main (common-main.c:45)
==18232== 

I'm looking into why that fails.  Also adding Dscho to Cc here as the
author of this code.
