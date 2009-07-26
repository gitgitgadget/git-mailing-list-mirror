From: Theodore Tso <tytso@mit.edu>
Subject: Re: Performance issue of 'git branch'
Date: Sun, 26 Jul 2009 12:29:28 -0400
Message-ID: <20090726162927.GC17272@mit.edu>
References: <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724234648.GA4616@Pilar.aei.mpg.de> <20090725004122.GA28477@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain> <20090725215739.d074e947.tihirvon@gmail.com> <20090725203130.GB1640@glandium.org> <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain> <alpine.LFD.2.01.0907251406390.3960@localhost.localdomain> <alpine.DEB.1.00.0907260123090.8306@pacific.mpi-cbg.de> <alpine.LFD.2.01.0907252147130.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 18:29:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV6bk-0005ta-JA
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 18:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbZGZQ3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 12:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbZGZQ3t
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 12:29:49 -0400
Received: from thunk.org ([69.25.196.29]:50821 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753758AbZGZQ3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 12:29:48 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1MV6bN-0004i9-37; Sun, 26 Jul 2009 12:29:33 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1MV6bI-0006bg-2C; Sun, 26 Jul 2009 12:29:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907252147130.3960@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124127>

On Sat, Jul 25, 2009 at 09:49:41PM -0700, Linus Torvalds wrote:
> 
> But at the same time, last time I benchmarked the different SHA1 
> libraries, the openssl one was the fastest. I think it has tuned assembly 
> language for most architectures. Our regular mozilla-based C code is 
> perfectly fine, but it doesn't hold a candle to assembler tuning.

So maybe git should import the SHA1 code into its own source base?
It's not like the SHA1 code changes often, or is likely to have
security issues (at least, not buffer overruns; if SHA1 gets thorouhly
broken we might have to change algorithms, but that's a different
kettle of fish :-).

					- Ted
