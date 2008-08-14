From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 18:34:46 +0200
Message-ID: <20080814163446.GD10360@machine.or.cz>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814151451.GA10544@machine.or.cz> <48A45CC9.5040708@griep.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 14 18:36:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTfnv-0000Fk-Gh
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 18:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbYHNQet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 12:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752225AbYHNQes
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 12:34:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41014 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbYHNQes (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 12:34:48 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0D7F53939B46; Thu, 14 Aug 2008 18:34:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48A45CC9.5040708@griep.us>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92369>

On Thu, Aug 14, 2008 at 12:26:49PM -0400, Marcus Griep wrote:
> Petr Baudis wrote:
> > Are you aware of progress.c:throughput_string()? It would make sense to
> > use the same code in both instances.
> 
> I was not. After reviewing it, it is limited to its purposes, but
> consolidating the human-readable-ness is a good idea.

Of course, it would need an usage overhaul. But otherwise, it seems
fine? Terabyte-sized objects in Git would be very troublesome venture
for many reasons.

> (who's got transfer speeds in TiB/s?)

Maybe Dana Brown? ;-)

> > I'd prefer you to keep using binary units instead of the ambiguous
> > prefixes, since we should keep our output consistent and I believe they
> > usually end up to be the least confusing choice. (Otherwise, don't you
> > want to use "bkM" instead of "BKM"? I never really know.)
> 
> In general, "b" would be supplied as a part of the suffix, so that is no
> longer in the prefix list.  The distinction comes with kilo vs. kibi.  In
> an earlier email reply, I mentioned a flag to denote SI versus binary
> periods.  In common nomenclature, Kilo (1000) is designated 'k', while
> Kibi (1024) is designated 'K' (the 'i' after the 'K' is supplied by the
> suffix if desired).  Thus, if the user wants binary, they'll get the capital
> 'K', and if they want SI, they'll get the lowercase 'k'.
> 
> Sound reasonable?

I'm confused - you didn't seem to really address my suggestion. Is there
a good reason _not_ to go with the /.iB/ prefixes, and just forget about
SI? Who is ever going to need SI?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
