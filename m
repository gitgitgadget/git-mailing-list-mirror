From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: dangling commits and blobs: is this normal?
Date: Thu, 23 Apr 2009 13:51:23 +0200
Message-ID: <vpq8wlr4mh0.fsf@bauges.imag.fr>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
	<20090422152719.GA12881@coredump.intra.peff.net>
	<W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
	<alpine.LFD.2.00.0904221331450.6741@xanadu.home>
	<vpqws9cd06b.fsf@bauges.imag.fr>
	<20090422190856.GB13424@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 13:57:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwxY9-00056e-0U
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 13:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbZDWLz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 07:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbZDWLz0
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 07:55:26 -0400
Received: from imag.imag.fr ([129.88.30.1]:59258 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbZDWLzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 07:55:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n3NBpTWp017529
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 23 Apr 2009 13:51:29 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LwxSe-0003EP-0A; Thu, 23 Apr 2009 13:51:24 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LwxSd-0001zS-VU; Thu, 23 Apr 2009 13:51:23 +0200
In-Reply-To: <20090422190856.GB13424@coredump.intra.peff.net> (Jeff King's message of "Wed\, 22 Apr 2009 15\:08\:56 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 23 Apr 2009 13:51:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117332>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 22, 2009 at 08:15:56PM +0200, Matthieu Moy wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > Why so?  Having fewer packs is always a good thing.  Having only one 
>> > pack is of course the optimal situation. 
>> 
>> Good and optimal wrt Git, but not wrt an incremental backup system for
>> example. I have a "git gc" running daily in a cron job in each of my
>> repositories, but to be nice with my sysadmin, I don't want to rewrite
>> tens of megabytes of data each night just because I commited a 2 lines
>> patch somewhere.
>
> You can mark your "big" pack with a .keep, then do your nightly gc as
> usual. You'll have a smaller pack being rewritten each night. When it
> gets big enough, drop the .keep, gc, and then .keep the new pack.

(thanks, I wasn't aware of this .keep thing before reading this
thread)

> Yes, it's a bit more work for you, but having "git gc" optimize by
> default for git's performance seems to be the only sensible course.

Sure. Sorry if my message read as "git gc does the wrong thing", I was
just mentionning that it's not optimal with respect to everything.

-- 
Matthieu
