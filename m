From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 3/3] builtin-add: simplify (and increase accuracy of) exclude handling
Date: Mon, 11 Jun 2007 21:15:54 +0200
Message-ID: <20070611191554.GA32151@diku.dk>
References: <20070611123045.GA28814@coredump.intra.peff.net> <20070611133956.GC7008@coredump.intra.peff.net> <20070611150122.GA11020@diku.dk> <20070611155425.GA9316@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:16:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpN3-0000Y4-IE
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333AbXFKTQA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755247AbXFKTQA
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:16:00 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:53448 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbXFKTP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:15:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 114B3F009A;
	Mon, 11 Jun 2007 21:15:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gQjADR5eeECh; Mon, 11 Jun 2007 21:15:54 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id EF991F0025;
	Mon, 11 Jun 2007 21:15:54 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0C3B26DF823; Mon, 11 Jun 2007 21:13:35 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id CEEA762A5D; Mon, 11 Jun 2007 21:15:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070611155425.GA9316@coredump.intra.peff.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49876>

Jeff King <peff@peff.net> wrote Mon, Jun 11, 2007:
> On Mon, Jun 11, 2007 at 05:01:23PM +0200, Jonas Fonseca wrote:
> > I think you could even get rid of has_ignored with something like this.
> 
> Nope, I had originally wanted to do that, but the dir_struct.ignored
> list contains _all_ ignored items, not just those that were originally
> in the pathspec. The prune_ignored call sets uninteresting ones to
> NULL.  That function could compact the list and re-set ignored_nr, but
> it doesn't currently do so.

Ah, I see.

> An even more elegant solution would be for read_directory to mark
> whether an ignored file comes from a pathspec, or was found through
> recursion. That would be more efficient, and it would remove the
> prune_ignored thing, which is IMHO a little hack-ish.
> 
> I don't have time to work on it now, but I might look at it more tonight
> or tomorrow (but please, if you are interested, take a crack at it).

Yes, I think it might be nice for me to do if you don't mind. I would
like some more experience with the git code. Maybe even redo the whole
patch series to also fix the concerns about the alloc_grow macro.

-- 
Jonas Fonseca
