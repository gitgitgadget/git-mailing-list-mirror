From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Update hard-coded header dependencies
Date: Thu, 21 Aug 2014 04:24:40 -0400
Message-ID: <20140821082440.GA16402@peff.net>
References: <20140808215825.GH12427@google.com>
 <20140810194824.GC9886@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 10:24:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKNft-00059Q-DJ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 10:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753755AbaHUIYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 04:24:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:56081 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752846AbaHUIYm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 04:24:42 -0400
Received: (qmail 5524 invoked by uid 102); 21 Aug 2014 08:24:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 03:24:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2014 04:24:40 -0400
Content-Disposition: inline
In-Reply-To: <20140810194824.GC9886@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255601>

On Sun, Aug 10, 2014 at 03:48:24PM -0400, Jeff King wrote:

> On Fri, Aug 08, 2014 at 02:58:26PM -0700, Jonathan Nieder wrote:
> 
> > Maybe it's worth switching to plain
> > 
> > 	LIB_H += $(wildcard *.h)
> > 
> > ?  People using ancient compilers that never change headers wouldn't
> > be hurt, people using modern compilers that do change headers also
> > wouldn't be hurt, and we could stop pretending to maintain an
> > up-to-date list.
> [...]
> Maybe
> 
>   LIB_H += $(shell find . -name '*.h' -print)
> 
> would work?

I took a stab at this and it seems to work. Here's a series.

  [1/2]: Makefile: use `find` to determine static header dependencies
  [2/2]: Makefile: drop CHECK_HEADER_DEPENDENCIES code

-Peff
