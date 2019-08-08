Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9343E1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 12:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbfHHM6L (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 08:58:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53164 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbfHHM6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 08:58:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so2330353wms.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ds8sdOm2lVVGZBxzeTH/LB7Gr6ExKULHxcPXZRMTVAQ=;
        b=OluX5+p6dzFSO/fRZcO2Q/i6PHx+poZ3liRf3WF/+OTNX+D2cRUR13kC7emMF9x5y+
         Q8bjt3FfkLNlARjcMLThtxfSZhME88lfMZ1oPvFLcvJwx4K0bRJqkn9pnZHuGdE1oA6v
         gPWewTyApuVLjg/7J/QP32JniHJ7b2gv79/3tl8dWqvt+G6EkmEMybrHoOFDpFKl8+D4
         +3ylBj+7r6KWhvY+ury4/XEhGbnRiirSTnfSqblkP+lVpBbYRfKiwNu4bFzlHeHkc1US
         xPcf2ZxVZ0c+nnAZaZHIsVLqY8a7iaX2Zf0s+QZFxHA+whUlbe3zihjPzo7HxZkTkiFp
         6MzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ds8sdOm2lVVGZBxzeTH/LB7Gr6ExKULHxcPXZRMTVAQ=;
        b=XAYHprX0oAA0951s78Rq/lDDlbsR69GC+GPEKJ7iy8n6L/Jpy8kwt2Lgu4p7VsO8wD
         ftwKBzobQDV4cJA6KotI5EbC/s7UKTPqYqUpbvzBDH3Gu+fMmLhnxcERCPDRM4WOMAKA
         f5lwNMehLtu1D/w3yT/8hir5uepJgXCHVu+yMvA7/qHDeVs1GeUOkZFLu4FGL48P0/rU
         VWWBL7OzV0Nokztv+6gc3tOGY7HZdyuiOgCqVMiqI2nWaL4TObBsctPYXhsIm2Un7z3X
         lCyn2/sLNwM9Ojrvat5Lj70CdgcdckUGXRWbq2xcoBCxMSSptedXsw4d9Tqbxc9utczx
         IJew==
X-Gm-Message-State: APjAAAW0ij5HhybboCFlGR6Oym42HMhinIPaQWcfkix40G61MZUoyswh
        2/9jsVqwEj9V0+ZPugnKW1O4XqN7
X-Google-Smtp-Source: APXvYqyNIoBMrdSM0ax3iI2nrzAievNgQdto0rwoM3DzXg+gnr7lcztpdpuz5tXDgETPWRjE+AmsXQ==
X-Received: by 2002:a1c:3:: with SMTP id 3mr4441619wma.6.1565269088996;
        Thu, 08 Aug 2019 05:58:08 -0700 (PDT)
Received: from szeder.dev (x4db35692.dyn.telefonica.de. [77.179.86.146])
        by smtp.gmail.com with ESMTPSA id f10sm82843058wrs.22.2019.08.08.05.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 05:58:08 -0700 (PDT)
Date:   Thu, 8 Aug 2019 14:58:05 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH bc/hash-independent-tests-part-4] t: decrease nesting in
 test_oid_to_path
Message-ID: <20190808125805.GH20404@szeder.dev>
References: <20190628225928.622372-1-sandals@crustytoothpaste.net>
 <20190628225928.622372-2-sandals@crustytoothpaste.net>
 <20190808065614.GA209195@google.com>
 <20190808093732.GA12257@sigill.intra.peff.net>
 <20190808113538.GK118825@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808113538.GK118825@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 08, 2019 at 11:35:38AM +0000, brian m. carlson wrote:
> On 2019-08-08 at 09:37:33, Jeff King wrote:
> > On Wed, Aug 07, 2019 at 11:56:14PM -0700, Jonathan Nieder wrote:
> > -- >8 --
> > Subject: [PATCH] t0000: reword comments for "local" test
> > 
> > Commit 01d3a526ad (t0000: check whether the shell supports the "local"
> > keyword, 2017-10-26) added a test to gather data on whether people run
> > the test suite with shells that don't support "local".
> > 
> > After almost two years, nobody has complained, and several other uses
> > have cropped up in test-lib-functions.sh. Let's declare it acceptable to
> > use.
> 
> I'm also in favor of this patch. To my knowledge, the only FLOSS
> POSIX-compliant shell that doesn't support "local" is AT&T ksh, so there
> are a lot of alternatives that folks have (bash, dash, posh, zsh, mksh,
> pdksh, busybox sh, etc.) in case they have a less capable shell.

From these shells:

  - dash and Bash work; no surprise there, being the default shells in
    some of the most popular Linux distros and GfW.

  - mksh works as well (just don't hit ctrl-C while running a test
    involving a daemon with '--verbose-log').

  - Zsh seems to be fundamentally incapable to run our test
    framework.

  - BusyBox sh is fine for the most part, but there are a few test
    failures, where we rely on some options or capabilities of various
    system commands that are not supported by the corresponding
    BusyBox builtins.

  - posh can successfully run a lot of test scripts, but there are a
    lot of failures as well, it skips a few test scripts that it
    shouldn't (claiming that Perl and Bash are not available?!), and
    t0000 aborts with a 'bug in test framework' error.  What's most
    worrying is that it reported a few "known breakage fixed" cases as
    well.

  - pdksh seems to be unavailable in my Linux distro, but since its
    name contains the "ksh" substring I'm sceptical.

So there are not that many alternatives.

Having said that, I'm in favor of using 'local'.

