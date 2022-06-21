Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F8AC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 11:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbiFULpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 07:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350012AbiFULpP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 07:45:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E421FA55
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 04:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 40B58CE1985
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 11:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E88C3411C;
        Tue, 21 Jun 2022 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655811910;
        bh=PTc7PBvlh6T2iOSxUPPCF1xWYbpn5ZQ0LuKB4BtGMrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yg6kRoKPgnPZi2OaURyAVF4RjISUafJRVJiMX5KK8sAuAHKc2mg77//LNv02E4bPU
         R0wAU8Jln6qtNAgkCtIFEUCxlh4EY5taA8UwZOcsQGnmwXHtyNo9h3QPHk02FKZ7bm
         2WNXElbC/p3r+Y6LXeUtk3Tx6PqQ0SMbdj1nva2w=
Date:   Tue, 21 Jun 2022 13:45:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Fabian Stelzer <fs@gigacodes.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: send PGP signed commits/patches with git-send-email(1)
Message-ID: <YrGvQi8kiFf4a/Tk@kroah.com>
References: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
 <20220617120016.txjksectzdugqiod@fs>
 <20220617121212.g7w7v3v4ynw6wlq7@meerkat.local>
 <YrGoqEi3shil7pkM@kroah.com>
 <03af9a8e-cf2c-8a32-330d-debad956683d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03af9a8e-cf2c-8a32-330d-debad956683d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 01:34:01PM +0200, Alejandro Colomar wrote:
> Hi!
> 
> On 6/21/22 13:16, Greg KH wrote:
> > On Fri, Jun 17, 2022 at 08:12:12AM -0400, Konstantin Ryabitsev wrote:
> > > On Fri, Jun 17, 2022 at 02:00:16PM +0200, Fabian Stelzer wrote:
> > > > Konstantin Ryabitsev has done some work in this area especially for kernel
> > > > development by using email headers:
> > > > https://people.kernel.org/monsieuricon/end-to-end-patch-attestation-with-patatt-and-b4
> > > > https://github.com/mricon/patatt
> > > 
> > > Greg refers specifically to patatt signatures. They aren't really specific to
> > > kernel development at all -- they can be used for any patches sent via mail.
> > > 
> > > b4 (the tool used by many maintainers to retrieve patches from lists) will
> > > check patatt-style signatures (in addition to DKIM signatures) to help verify
> > > that the patches come from trusted sources and aren't someone pretending to be
> > > someone else.
> > 
> > Yes, I was referring to patatt here, as linked by Konstantin's blog post
> > above.  It's part of the b4 tool (well, a git subproject in it), real
> > link is at:
> > 	https://git.kernel.org/pub/scm/utils/patatt/patatt.git
> 
> Thank you all for the info.
> It works like charm (I still need to learn b4(1), but patatt(1) is enough
> for me right now). :)

They are independent, patatt I use when sending patches, b4 I use when
accepting patches.  If you never have to accept patches, and read the
mailing lists using the normal way, no need to use b4.

thanks,

greg k-h
