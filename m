From: Jeff King <peff@peff.net>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 09:20:26 -0400
Message-ID: <20100803132026.GA14883@coredump.intra.peff.net>
References: <i372v0$3np$1@dough.gmane.org>
 <201008031202.53804.jnareb@gmail.com>
 <20100803124831.GB11608@coredump.intra.peff.net>
 <201008031519.11012.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 15:20:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgHQ5-0004jL-Nw
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 15:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755691Ab0HCNUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 09:20:32 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:48301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116Ab0HCNUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 09:20:32 -0400
Received: (qmail 12680 invoked by uid 111); 3 Aug 2010 13:20:31 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Tue, 03 Aug 2010 13:20:31 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Aug 2010 09:20:26 -0400
Content-Disposition: inline
In-Reply-To: <201008031519.11012.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152516>

On Tue, Aug 03, 2010 at 03:19:09PM +0200, Jakub Narebski wrote:

> > I am not sure there isn't some unportability at the lowest level. We
> > freely interchange between time_t and unsigned long in the low-level
> > date code. It probably happens to work because casting the bits back and
> > forth between signed and unsigned types generally works, as long as you
> > end up with the type that you want. But it isn't necessarily portable,
> > and there can be subtle bugs. See, for example, my recent 9ba0f033.
> 
> Well, at least there is not a problem at lowest of low, i.e. repository
> format level, thanks to the use of textual representation for epoch.

Yes, the good news that this is purely a code problem. The data format
is fine. It would just take somebody going through the code and
switching all "unsigned long" to "long long" (or time_t, or even
"gittime_t" if we want to abstract it).

-Peff
