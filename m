From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack v4 status
Date: Tue, 27 Feb 2007 23:13:51 -0500
Message-ID: <20070228041350.GD5597@spearce.org>
References: <20070227155042.GB3230@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 05:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMGCU-00022v-5a
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 05:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbXB1EN4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 23:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXB1ENz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 23:13:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33721 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbXB1ENz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 23:13:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMGCD-0008KA-7a; Tue, 27 Feb 2007 23:13:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A019420FBAE; Tue, 27 Feb 2007 23:13:51 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070227155042.GB3230@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40891>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Obviously this series has a heavy hand on sha1_file.c,
> builtin-pack-objects.c, builtin-unpack-objects.c, index-pack.c.
> But it will also start to hit less obvious places like commit.c
> and tree-walk.c as we start to support walking the encoded objects
> directly.
> 
> Given the huge size of the series, and the amount of effort we are
> tossing into it, and the fact that I'm trying to make it pu-ready by
> early next week, we would appreciate it if folks could keep changes
> to the above mentioned files limited to critical bug fixes only.  :)

After rereading this message[*1*] several hours later, and also
just learning that Nico will be taking a probably much deserved
vacation soon, my concept of getting this series ready for Junio's
pu-branch by next week is just far too aggressive to be practical.

Nico and I have had a lot of off-list discussion about possible
things we can do with the various encodings and what types of
runtime optimizations they could actually support.  These have
created a lot of cases we really need to explore and confirm as
useful or verify as not-useful before submitting a series to Junio.

Improving the packfile format is a relatively non-trivial change;
we would hate to see people actually start to use a pack v4 file
only to have the encoding change *again* in the near future due to
a better optimization being selected and employed.

That said, I would like to keep the development openly visible
(hence its on repo.or.cz) and would like to encourage people to send
ideas, suggestions, etc.  I think it is very helpful when everyone
knows what is actively being worked on, so they can contribute to
projects they may be interested in, and avoid causing conflicts
with those projects when possible.  ;-)


*1*: Yea, I really do read my own email when vger finally gets
     around to bouncing it back to me.  ;-)

-- 
Shawn.
