From: Jeff King <peff@peff.net>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 09:32:46 -0400
Message-ID: <20100803133246.GA15062@coredump.intra.peff.net>
References: <i372v0$3np$1@dough.gmane.org>
 <201008031202.53804.jnareb@gmail.com>
 <20100803124831.GB11608@coredump.intra.peff.net>
 <201008031519.11012.jnareb@gmail.com>
 <20100803132026.GA14883@coredump.intra.peff.net>
 <4C581881.9060202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 03 15:33:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHcH-0002gJ-6c
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521Ab0HCNdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 09:33:06 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:53928 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756468Ab0HCNcw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 09:32:52 -0400
Received: (qmail 12779 invoked by uid 111); 3 Aug 2010 13:32:51 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 03 Aug 2010 13:32:51 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Aug 2010 09:32:46 -0400
Content-Disposition: inline
In-Reply-To: <4C581881.9060202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152518>

On Tue, Aug 03, 2010 at 03:24:17PM +0200, Michael J Gruber wrote:

> > Yes, the good news that this is purely a code problem. The data format
> > is fine. It would just take somebody going through the code and
> > switching all "unsigned long" to "long long" (or time_t, or even
> > "gittime_t" if we want to abstract it).
> 
> ...and fixing the parser algorithm at least in tm_to_time_t()...

Yeah, I should have been more clear. It is _not_ just "sed s/unsigned
long/long long", but rather checking every change to make sure that you
aren't introducing new bugs, and that the code correctly handles signed
types. Which is why nobody has done it. ;)

-Peff
