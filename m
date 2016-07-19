Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717A11FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbcGSPcb (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 11:32:31 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34359 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415AbcGSPc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 11:32:29 -0400
Received: by mail-io0-f174.google.com with SMTP id q83so22306181iod.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 08:32:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9INArptBXkyfGWpBPqA0Lxk7sPPEfnhFDnulX0I4FHU=;
        b=Ed3tl3S9R1CE+7OwSgRAGwafyeMHd5hsuXCBdqUzGbWHGaNb2GraTiKca6dwMQZkgZ
         jkreAYb72MYJZyS8sgKvLkl/bk1WTPgmux4i5HzmSseJ41+5jWWQLNANfxZgwR9bl51W
         X8olcvePNonvmI4A6L5nt6yT2a04f8NmRCluQItp7NM4DODQFP1SZy0FQxSd9swkN7SU
         U7VnOYVFrjIUnudXEiGdtrtnZZVwQyUCDYGKMG+aqhLbhn2vadcCYaqiE1yiNQrNy46j
         tkAVW/9VreV6vuciRtiMl+POSFPMwDuMgpPP5dllWrk5lNUIxjLeaPQj9HMFvdkGpoXq
         A8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9INArptBXkyfGWpBPqA0Lxk7sPPEfnhFDnulX0I4FHU=;
        b=muRqsumB/Agr6TmrQkjpYr2tOCR9MDifaJSH4Qx99p6Uy84nZ1EFSm8rbMEbEOSUPu
         QCh5x73Vt2xAb6nRlyuxt0+vllyna6ZFE/1msTcOyQeK6bGuQvaHaZohk4CFleNkg/CY
         TqO6mVUK+lrS7ITd0kYud+2eG6/CZ5vCaP0wfYw3abg2HcjCiaJvmZHNB8ibpXZJeoFu
         Q8UVRlFew3m+UcaLs6TgRpV1WE2xLgU5jQcSq5BrSzYFHJ10Y5qHLpo9vP92JO3op+Pi
         fdbOh1MGm43c3iO5nFZ5h96h9XtgIxJT3s8siv8hf6Ejv7jVTEyBed6IcJpWLIPtPtHd
         /QqQ==
X-Gm-Message-State: ALyK8tLhjEudGGa1LcimTslF0b8x0m6YIwLTrPWBZUxCJKyFDndzC4gPFEEjOeH5BAGwMEdeWFT5lc0+ZAnGig==
X-Received: by 10.107.159.147 with SMTP id i141mr11109143ioe.29.1468942348755;
 Tue, 19 Jul 2016 08:32:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 08:31:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607190910370.3472@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
 <alpine.DEB.2.20.1607190910370.3472@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 19 Jul 2016 17:31:59 +0200
Message-ID: <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 9:18 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> But we can recreate SHA-1 from the same content and verify GPG, right?
>> I know it's super expensive, but it feels safer to not carry SHA-1
>> around when it's not secure anymore (I recall something about
>> exploiting the weakest link when you have both sha1 and sha256 in the
>> object content). Rehashing would be done locally and is better
>> controlled.
>
> You could. But how would you determine whether to recreate the commit
> object from a SHA-1-ified version of the commit buffer? Fall back if the
> original did not match the signature?

Any repo would have a cut point when they move to sha256 (or whatever
new hash), if we can record this somewhere (e.g. as a tag or a bunch
of tags, or some dummy commits to mark the heads of the repo) then we
only verify gpg signatures _in_ the repository before this point.

> That would pose at least these two problems:
>
> 1. The point of a signature is trust. If all of a sudden the signature
> does not match what is supposedly signed, that trust is broken.
>
> 2. The point of going to a stronger hash is to increase the trust. If
> any developer could decide to sign the SHA-1-ified version of any future
> commit, and Git validating it, it would be even worse than not switching
> to a new hash: it would leave us open to collision attacks *and* pretend
> that we prevented such attacks.

GPG signatures are still valid on the old repo (we will keep old repos
around forever, I suppose). And because they sign on the "weak" hash,
sha1, at some point they will be broken (but until then we can still
regenerate sha1 and verify locally). When sha1 is broken, GPG
signatures of the past can't be trusted anymore.

If people care enough about the past, they should re-sign (at least
for tags). Commits can be re-signed by the person who does the
conversion. Yes you have to trust that person. Sort of a painful fresh
start, with hopefully better security.
-- 
Duy
