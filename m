From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header
 dependencies
Date: Tue, 26 Aug 2014 13:29:59 -0400
Message-ID: <20140826172959.GA16394@peff.net>
References: <20140822042716.GE27992@peff.net>
 <20140822043303.GB18192@peff.net>
 <20140825194641.GS20185@google.com>
 <20140825200042.GJ30953@peff.net>
 <20140825204516.GT20185@google.com>
 <xmqqppfol1sx.fsf@gitster.dls.corp.google.com>
 <20140825212705.GU20185@google.com>
 <xmqq4mx0kyrx.fsf@gitster.dls.corp.google.com>
 <20140826123427.GD29180@peff.net>
 <xmqqiolfjio4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:30:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKZN-0006Am-Hx
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbaHZRaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:30:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:59378 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751995AbaHZRaC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:30:02 -0400
Received: (qmail 1978 invoked by uid 102); 26 Aug 2014 17:30:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 12:30:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 13:29:59 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiolfjio4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255923>

On Tue, Aug 26, 2014 at 09:54:19AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Actually as you are not excluding CVS, RCS, etc., and using ??* as
> >> the starting point will exclude .git, .hg, etc. at the top, I think
> >> we can shorten it even further and say
> >> 
> >> 	find ??* -name Documentation -prune -o -name \*.h
> >> 
> >> or something.
> >
> > I had originally considered starting with "find *", but I was worried
> > about shell globbing overflowing command-line limits here. "echo *" on a
> > built tree is about 12K.
> 
> OK.  What I queued is still your original which is the most
> conservative among various "fun" alternatives we have seen so far on
> this thread, so we should be good ;-)

The only thing I think mine does not do that Jonathan suggested is
dropping .hg, etc. I do not know why anyone would track git in hg, but
it might make sense to s/.git/.?/ in what I sent.

(I noticed also that you did not queue the third patch to drop
CHECK_HEADER_DEPENDENCIES; I'm OK if we keep it, but I wanted to make
sure it was not an oversight).

-Peff
