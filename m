From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Sat, 20 Apr 2013 00:06:43 -0400
Message-ID: <20130420040643.GB24970@sigill.intra.peff.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
 <5a8c85faddf7f93ca16d284bde415a32dd76779a.1366389739.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 20 06:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTP4d-0005U5-L1
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 06:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234Ab3DTEGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 00:06:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:44576 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3DTEGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 00:06:47 -0400
Received: (qmail 7084 invoked by uid 102); 20 Apr 2013 04:06:52 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 23:06:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Apr 2013 00:06:43 -0400
Content-Disposition: inline
In-Reply-To: <5a8c85faddf7f93ca16d284bde415a32dd76779a.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221833>

On Fri, Apr 19, 2013 at 06:44:45PM +0200, Michael J Gruber wrote:

> Currently, "diff" and "cat-file" for blobs obey "--textconv" options
> (with the former defaulting to "--textconv" and the latter to
> "--no-textconv") whereas "show" does not obey this option, even though
> it takes diff options.
> 
> Make "show" on blobs behave like "diff", i.e. obey "--textconv" by
> default and "--no-textconv" when given.

Wait, this does the opposite of the last patch. If we do want to do
this, shouldn't the last one have been an "expect_failure"?

I'm not convinced this is the right thing to do, though. It would break:

  git show HEAD:file.c >file.c

Admittedly, such people should be using "checkout" or "cat-file", so I
do not mind too much breaking them if there is a good reason. But I am
not sure what that reason is.

-Peff
