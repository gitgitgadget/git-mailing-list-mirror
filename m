From: Joachim Berdal Haga <c.j.b.haga@fys.uio.no>
Subject: Re: Compression speed for large files
Date: Tue, 04 Jul 2006 07:42:03 +0200
Message-ID: <44A9FFAB.1010708@fys.uio.no>
References: <loom.20060703T124601-969@post.gmane.org>
 <20060703214503.GA3897@coredump.intra.peff.net> <44A99961.8090504@fys.uio.no>
 <Pine.LNX.4.64.0607031556480.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 07:42:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxdfy-0005wp-9B
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 07:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWGDFmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 01:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWGDFmJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 01:42:09 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:40655 "EHLO
	osl1smout1.broadpark.no") by vger.kernel.org with ESMTP
	id S1751102AbWGDFmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 01:42:08 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java System Messaging Server 6.1 HotFix 0.05 (built Oct 21 2004))
 with ESMTP id <0J1V008U86I54SB0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 04 Jul 2006 07:42:05 +0200 (CEST)
Received: from pep ([80.203.45.67]) by osl1sminn1.broadpark.no
 (Sun Java System Messaging Server 6.1 HotFix 0.05 (built Oct 21 2004))
 with ESMTP id <0J1V0071Z6I4M510@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 04 Jul 2006 07:42:05 +0200 (CEST)
Received: from localhost ([127.0.0.1])	by pep with esmtp (Exim 4.62)
	(envelope-from <c.j.b.haga@fys.uio.no>)	id 1Fxdfg-0001pf-KS; Tue,
 04 Jul 2006 07:42:04 +0200
In-reply-to: <Pine.LNX.4.64.0607031556480.12404@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: c.j.b.haga@fys.uio.no
X-SA-Exim-Scanned: No (on pep); SAEximRunCond expanded to false
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23252>

Linus Torvalds wrote:
> 
> On Tue, 4 Jul 2006, Joachim Berdal Haga wrote:
>> Here's a test with "time gzip -[169] -c file >/dev/null". Random data
>> from /dev/urandom, kernel headers are concatenation of *.h in kernel
>> sources. All times in seconds, on my puny home computer (1GHz Via Nehemiah)
> 
> That "Via Nehemiah" is probably a big part of it.
> 
> I think the VIA Nehemiah just has a 64kB L2 cache, and I bet performance 
> plummets if the tables end up being used past that. 

Not really. The numbers in my original post were from a Intel core-duo,
they were: 158/18/6 s for comparable (but larger) data.

And on a P4 1.8GHz with 512kB L2, the same 23MB data file compresses in
28.1/5.9/1.3 s. That's a factor 22 slowest/fastest; the VIA was only
factor 18, so the difference is actually *larger*.

-j.
