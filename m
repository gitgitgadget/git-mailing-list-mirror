From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/commit.c: fix type warnings from gcc and sparse
Date: Fri, 29 Aug 2014 14:44:35 -0400
Message-ID: <20140829184435.GA29456@peff.net>
References: <5400AC05.9060900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 29 20:44:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNRAA-0004Uz-7q
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 20:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbaH2Soi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 14:44:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:33328 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752914AbaH2Soh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 14:44:37 -0400
Received: (qmail 30012 invoked by uid 102); 29 Aug 2014 18:44:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Aug 2014 13:44:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Aug 2014 14:44:35 -0400
Content-Disposition: inline
In-Reply-To: <5400AC05.9060900@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256175>

On Fri, Aug 29, 2014 at 05:36:21PM +0100, Ramsay Jones wrote:

> On 32-bit platforms (only), gcc and sparse both issue warnings
> about the type of the pointer expression passed as the third
> argument to find_commit_header().  In order to suppress the
> warnings, we simply change the type of the 'len' variable to
> size_t.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Thanks, this looks good to me. I think I just switched between size_t
and "unsigned long" during the development and forgot to tweak this
spot.

> If you need to re-roll your 'jk/commit-author-parsing' series, could
> you please squash this into the equivalent of commit 95b5989
> ("determine_author_info(): reuse parsing functions", 27-08-2014).

I don't think I have any other reason to re-roll at this point. I'm
happy to have this on top, or it can be squashed into the second from
the top (95b5989) if we want to keep the history cleaner.

I'm also happy to re-roll just for this, but my impression is that is
not really any easier on Junio than just squashing a patch in.

-Peff
