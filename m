From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] remote-curl.c: Fix a compiler warning
Date: Wed, 21 Nov 2012 14:34:53 -0500
Message-ID: <20121121193453.GD16280@sigill.intra.peff.net>
References: <50AD26C3.2090407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:35:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbG4l-0000j4-3E
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:35:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab2KUTe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:34:56 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54445 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755869Ab2KUTe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:34:56 -0500
Received: (qmail 9507 invoked by uid 107); 21 Nov 2012 19:35:48 -0000
Received: from ip68-100-44-35.dc.dc.cox.net (HELO sigill.intra.peff.net) (68.100.44.35)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Nov 2012 14:35:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2012 14:34:53 -0500
Content-Disposition: inline
In-Reply-To: <50AD26C3.2090407@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210168>

On Wed, Nov 21, 2012 at 07:08:51PM +0000, Ramsay Jones wrote:

> In particular, gcc issues an "'gzip_size' might be used uninitialized"
> warning (-Wuninitialized). However, this warning is a false positive,
> since the 'gzip_size' variable would not, in fact, be used uninitialized.
> In order to suppress the warning, we simply initialise the variable to
> zero in it's declaration.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi Junio,
> 
> This is on top of next. (commit df126e108: "remote-curl: hoist gzip
> buffer size to top of post_rpc", 31-10-2012).

Thanks. I meant to apply this during my tenure as maintainer, but it
slipped through the cracks.

-Peff
