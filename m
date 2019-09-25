Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D84EB1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 22:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfIYWBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 18:01:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41884 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbfIYVze (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 17:55:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so68626pgv.8
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 14:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XlSBVEeFnRGUeyzTxWxtincGgmquk0lFfnKoudKE2uA=;
        b=Zr2OSyNGcfwA11324mXNSWm5hdPaHm/F2+leDXZhma4Gx4ur/MXde4WrZ+mHI+O2zc
         Srmu7DJQwe8BKzGhceNoRGkaxrKQUshE+Qj9yQQJGhjGb+5VeU2jQp1EhXTXMnmmiDPV
         +potxps5wjHXe2KdzXMOVGdPKhWN/hEWHwC3ZSKoYrxpTbJZmF3QxBNnnvYvrKqzKni/
         BpR6UlLrQ/VxRDj5OaXGG2PHzY3EsdBv78YIkodTAaMKjC5DUUr3DgXbgXq88bXIWkr0
         YrXh45gFJt31ZGeUE6zqbI0pQ2YGoys5vDTtLGTmA45Ple/5jnJMSYRjmRHYCLjLgi3D
         /Egg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XlSBVEeFnRGUeyzTxWxtincGgmquk0lFfnKoudKE2uA=;
        b=j7+o3Sv6crHGxwhicZYnR1cwWnSSroDVPY4Bb+1iMRPKkL78PGHM9faAz0IdBDxskU
         B47/fTeOezp3RmgHQxBb1deyBaCBjjAg2qNxT7zklwav5JJsXti0PsHQDonho5QeOFOW
         fCYnoIG4eFgTeFizOAdxwviIUXf6z+X0YZXHYOVBo7gIOjQUo/z3x1huDNsVrRv+F9aR
         DFHnkR5WiOz7j0s5+T2UmhmOTkqk7177jif3ak6OUNyuj4vxIPIsp/KNumlZUtgqhC4M
         YS/NYa44IdYskviIEn73dH+iEyY2Bk7sBFunLzLQRKWfySUbVnRm8qhQwsBTEAT5Lf1s
         0PBA==
X-Gm-Message-State: APjAAAVsxMnPArCOYtXX29LgrmO9XVXMxCPtFgTHeGmDcAVcaa5kzX8U
        CYwLZMOnJVDHFXkkpnBTgEA=
X-Google-Smtp-Source: APXvYqzg1LF0Hvu4VYCyhebWmqBoyPa56y5F0LOkmTN0rIgbxKFUEn1vK1Kei1WVGbiSW+1BcyUk4Q==
X-Received: by 2002:a63:6b06:: with SMTP id g6mr13418pgc.221.1569448533476;
        Wed, 25 Sep 2019 14:55:33 -0700 (PDT)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id f15sm6452929pfd.141.2019.09.25.14.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 14:55:32 -0700 (PDT)
Date:   Wed, 25 Sep 2019 14:55:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Subject: Re: [BUG] git is segfaulting, was [PATCH v4 04/12] dir: also check
 directories for matching pathspecs
Message-ID: <20190925215530.GA9013@generichostname>
References: <20190912221240.18057-1-newren@gmail.com>
 <20190917163504.14566-1-newren@gmail.com>
 <20190917163504.14566-5-newren@gmail.com>
 <20190925203919.GA89135@generichostname>
 <CABPp-BHyjVSD6_S_dYgPiXM=GVEpT97FqJJearzg4hvKHXfNVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHyjVSD6_S_dYgPiXM=GVEpT97FqJJearzg4hvKHXfNVA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 25, 2019 at 02:28:15PM -0700, Elijah Newren wrote:

[...]

> > Sorry for the information dump, I haven't had the time to properly look
> > into the issue but I just wanted to make sure that you're aware.
> 
> Thanks for testing and sending the heads up.  Unfortunately, I cannot
> reproduce on either Linux or Mac.  Do you have some special ignore
> files or sparse-checkout paths that are important to triggering?
> What's in your config.mak?  

Before, I had an empty config.mak and I also had the following
.git/info/exclude (these are two worktrees I have checked out):

	/jch
	/patches

aside from that, I don't think I've changed anything else. Anyway, to
double-check that it wasn't my setup that was broken, I ran

	cd ..
	git clone git git2
	cd git2
	make configure
	./configure

and then followed the rest the steps and I could still reproduce it.

> What compiler and version?

	$ cc --version
	Apple LLVM version 10.0.1 (clang-1001.0.46.4)
	Target: x86_64-apple-darwin18.7.0
	Thread model: posix
	InstalledDir: /Library/Developer/CommandLineTools/usr/bin

> 
> Here's what I did, just to verify:
> 
> cd ~/floss/git
> git checkout 404ebceda0
> NO_GETTEXT=1 make DEVELOPER=1 -j8   # I leave off the NO_GETTEXT=1 on linux

I don't have NO_GETTEXT on Mac but I don't think it affects anything.

> git worktree add testdir
> git -C testdir checkout master
> git -C testdir fetch https://github.com/git/git.git todo
> bin-wrappers/git -C testdir checkout FETCH_HEAD
> 
> Did I get any of those steps wrong?

Looks correct to me. I don't see why this wouldn't reproduce. I'll send
you more information if I figure anything else out.

Thanks,

Denton

> 
> 
> Thanks,
> Elijah
