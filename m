Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4752C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 11:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348439AbiFULRI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 07:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiFULRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 07:17:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DACC29CB5
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 04:17:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECDE1B81698
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 11:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A84C3411D;
        Tue, 21 Jun 2022 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655810220;
        bh=VUprz3EVQyKEOSZNmHcTscFSdDM3HQ507RpovE9KUjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHSXM5Q61zQyxsjFcTViJa+OUWhbVYJ8BZfpwPVU0QHuE5FHolveXP93hg5chTb7n
         /F5i7jguBLbejbBTitxN2aIrjsundQ2BgcPDbybWxg7m8moYfsXTvE6/9wRk2hSPLQ
         6oimorQjoTHcPBMaDf5ljbJwoqfQRXmrUbn0UvbY=
Date:   Tue, 21 Jun 2022 13:16:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabian Stelzer <fs@gigacodes.de>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: send PGP signed commits/patches with git-send-email(1)
Message-ID: <YrGoqEi3shil7pkM@kroah.com>
References: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
 <20220617120016.txjksectzdugqiod@fs>
 <20220617121212.g7w7v3v4ynw6wlq7@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617121212.g7w7v3v4ynw6wlq7@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 17, 2022 at 08:12:12AM -0400, Konstantin Ryabitsev wrote:
> On Fri, Jun 17, 2022 at 02:00:16PM +0200, Fabian Stelzer wrote:
> > Konstantin Ryabitsev has done some work in this area especially for kernel
> > development by using email headers:
> > https://people.kernel.org/monsieuricon/end-to-end-patch-attestation-with-patatt-and-b4
> > https://github.com/mricon/patatt
> 
> Greg refers specifically to patatt signatures. They aren't really specific to
> kernel development at all -- they can be used for any patches sent via mail.
> 
> b4 (the tool used by many maintainers to retrieve patches from lists) will
> check patatt-style signatures (in addition to DKIM signatures) to help verify
> that the patches come from trusted sources and aren't someone pretending to be
> someone else.

Yes, I was referring to patatt here, as linked by Konstantin's blog post
above.  It's part of the b4 tool (well, a git subproject in it), real
link is at:
	https://git.kernel.org/pub/scm/utils/patatt/patatt.git

thanks,

greg k-h
