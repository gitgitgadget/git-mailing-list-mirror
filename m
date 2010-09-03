From: Ted Ts'o <tytso@mit.edu>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 14:31:20 -0400
Message-ID: <20100903183120.GA4887@thunk.org>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com>
 <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home>
 <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home>
 <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 20:31:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orb2w-0007pt-EK
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 20:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080Ab0ICSbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 14:31:25 -0400
Received: from thunk.org ([69.25.196.29]:51958 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757150Ab0ICSbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 14:31:25 -0400
Received: from root (helo=tytso-glaptop)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1Orb2n-00066U-DL; Fri, 03 Sep 2010 14:31:21 -0400
Received: from tytso by tytso-glaptop with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Orb2m-0002CU-PV; Fri, 03 Sep 2010 14:31:20 -0400
Content-Disposition: inline
In-Reply-To: <7voccezr7m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155261>

On Fri, Sep 03, 2010 at 10:12:29AM -0700, Junio C Hamano wrote:
> Theodore Tso <tytso@MIT.EDU> writes:
> 
> > ...  So people who are willing
> > to participate as part of the peer2peer network can download the
> > instructions for how to make the canonical pack once a month, and use it
> > to create the canonical pack.  If the "Gittorrent master" has spent a
> > lot of time to carefully compute the most efficient set of delta
> > pairings, they will get the slight benefit of a more efficient pack
> > which they could use instead of th eir local one without having to use
> > large values of --window and --depth to "git repack".
> 
> Hmm, is the idea essentially to tell people "Here is a snapshot of Linus
> repository as of a few weeks ago, carefully repacked.  Instead of running
> "git clone" yourself, please bootstrap your repository by copying it over
> bittorrent and then "git pull" to update it"?

Essentially, yes.  I just don't think bittorrent makes sense for
anything else, because the git protocol is so much more efficient for
tiny incremental updates...

So the only other part of my idea is that we could construct a special
set of instructions that would allow them to recreate the carefully
repacked snapshot of Linus's repository without having to download it
from a central seed site.  Instead, they could download a small set of
instructions, and use that in combination with the objects already in
their repository, to create a bit-identical version of the carefully
repacked Linus repository.  It's basically rip-off of jigdo, but
applied to git repositories instead of Debian .iso files.

	       		    	       - Ted
