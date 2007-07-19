From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 18:17:52 +0200
Message-ID: <vpqsl7kiczz.fsf@bauges.imag.fr>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org>
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<Pine.LNX.4.64.0707191310430.14781@racer.site>
	<86wswwa8ej.fsf@lola.quinscape.zz>
	<7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com>
	<Pine.LNX.4.64.0707191642270.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 18:27:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBYqW-00089x-M5
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 18:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933210AbXGSQ1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 12:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933156AbXGSQ1O
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 12:27:14 -0400
Received: from imag.imag.fr ([129.88.30.1]:40803 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765942AbXGSQ1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 12:27:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6JGHqkQ023678
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 18:17:52 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IBYhM-0000Ok-3A; Thu, 19 Jul 2007 18:17:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IBYhM-0002ta-0r; Thu, 19 Jul 2007 18:17:52 +0200
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Brian Gernhardt <benji@silverinsanity.com>,  David Kastrup <dak@gnu.org>, git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0707191642270.14781@racer.site> (Johannes Schindelin's message of "Thu\, 19 Jul 2007 16\:43\:30 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 19 Jul 2007 18:17:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53004>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> More and more I get the impression that this thread is just not worth it.  
> The problem was solved long ago, and all that is talked about here is how 
> to complicate things.

The problem was not _solved_, it was _worked around_.

Adding a .gitignore or whatever other file to mean "the directory
exists" is clearly a good workaround, but still, you have to use
"git-add $dir/.gitignore" where you really _mean_ "git-add $dir/". I
can see no reason for the presence of this .gitignore file other than
"err, I've put it here because git doesn't manage empty directories".

The fact that you need a FAQ entry for that actually shows there is a
problem. You don't have a FAQ for "Q: How to I add a file? A: Use
git-add file", you shouldn't need a FAQ for "How do I add a
directory", it should just work as expected.

You claim it "solves" the problem, but have you ever used an importer
like git-svn on a project that uses empty directories as placeholders
(I do have this problem in daily life because my colleagues still use
SVN)? What is the meaning of this .gitignore file the day you export
it to anything outside git?

If you ignore problems because they have a workaround, then even CVS
can be usable. People have been working around CVS's problems for
years, and many people are happy with CVS because they didn't realise
that solving problems is better than working around them (See the
OpenCVS project ...). Fortunately, git doesn't have as many problems
to work around as CVS ;-).

I'm happy with the answer "it should be done, but not by me, send a
patch", and I can't really complain myself since I did not send a
patch, but here, you're complaining about someone who actually starts
volunteering to solve the problem, which I can't agree with.

-- 
Matthieu
