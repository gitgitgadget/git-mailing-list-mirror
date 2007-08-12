From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 23:51:24 +0200
Message-ID: <85tzr45smb.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<85abswo9gf.fsf@lola.goethe.zz>
	<20070812200258.GA13298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 12 23:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKLLP-0004hE-TZ
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 23:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761933AbXHLVv2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 17:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762151AbXHLVv2
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 17:51:28 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:60392 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761688AbXHLVv0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 17:51:26 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id C072D17FD38;
	Sun, 12 Aug 2007 23:51:25 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id AB7952793F9;
	Sun, 12 Aug 2007 23:51:25 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 786D8BC5E4;
	Sun, 12 Aug 2007 23:51:25 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id DAA771C3C79D; Sun, 12 Aug 2007 23:51:24 +0200 (CEST)
In-Reply-To: <20070812200258.GA13298@sigill.intra.peff.net> (Jeff King's message of "Sun\, 12 Aug 2007 16\:02\:58 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3936/Sun Aug 12 17:10:09 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55729>

Jeff King <peff@peff.net> writes:

> On Sun, Aug 12, 2007 at 09:10:24PM +0200, David Kastrup wrote:
>
>> I'll probably be able to create a Gnus _backend_ for this sort of
>> setup (there are even backends for directory browsing: most files
>
> You can somewhat prototype this by just dumping the commits to an mbox
> (sorry for the long lines):
>
> git-log \
>   --pretty=format:'From %H Mon Sep 17 00:00:00 2001%nFrom: %an <%ae>%nDate: %ad%nSubject: %s%nMessage-ID: <%H@none>%nReferences: %P%n%n%b' \
>   | perl -pe 's/References: (.*)/"References: " .  %join(" ", map { "<" . $_ . "\@none>" } split \/ \/, $1)/e' \
>   >mbox

One percent too many before join, and the order of the articles is
reversed (--reverse helps here).

It is also a good idea to set gnus-thread-indent to 0 or 1, and
gnus-use-trees seems interesting, though not in a reasonably good
state (the graph layout tries to avoid crossing links and node names,
and that's rather useless).

So actually Gnus would need some kicking into shape before it actually
would present a useful tool.  On the positive side, it takes about 15
seconds sucking up and toposorting the complete group of about 11000
commits from an mbox file (which one would not ever do anyway).  And
that is Elisp.  However, the git history is still rather harmless
considering the commit amounts.

> Also, have you tried looking at tig (make sure to try a recent
> version and use the 'g' command to turn on the graph display)?

There are too many tools around.  Sigh.  Another to try.  Thanks for
the tip.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
