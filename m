Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 756D120189
	for <e@80x24.org>; Sun, 19 Jun 2016 14:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbcFSOrw (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 10:47:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:56950 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751582AbcFSOrv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 10:47:51 -0400
Received: (qmail 17317 invoked by uid 102); 19 Jun 2016 14:46:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 10:46:30 -0400
Received: (qmail 9037 invoked by uid 107); 19 Jun 2016 14:46:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 19 Jun 2016 10:46:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Jun 2016 10:46:28 -0400
Date:	Sun, 19 Jun 2016 10:46:28 -0400
From:	Jeff King <peff@peff.net>
To:	Vadim Eisenberg <VADIME@il.ibm.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a
 submodule
Message-ID: <20160619144628.GA7402@sigill.intra.peff.net>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net>
 <OFC46A8782.5F47CDBA-ONC2257FD7.00475209-C2257FD7.00483117@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <OFC46A8782.5F47CDBA-ONC2257FD7.00475209-C2257FD7.00483117@notes.na.collabserv.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 04:07:41PM +0300, Vadim Eisenberg wrote:

> The problem is with other tools that use git, like Swift Package Manager - 
> https://swift.org/package-manager/.
> Versions of git before 2.9.0 have no option --no-shallow-submodules. So 
> the tools that use git would have to check if the version of git is 
> greater than or equal 2.9.0 to know to specify that option.

Oh, I agree it's something we should treat as a regression. Using
`--no-shallow-submodules` is just a workaround.

-Peff
