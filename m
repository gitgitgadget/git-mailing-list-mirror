From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 13/10] tests for various pack index features
Date: Wed, 11 Apr 2007 10:51:03 -0400
Message-ID: <20070411145103.GP5436@spearce.org>
References: <alpine.LFD.0.98.0704101607390.28181@xanadu.home> <7vr6qrr51r.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704110850010.28181@xanadu.home> <20070411130932.GA17094@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Olivier Galibert <galibert@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 16:51:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbeAa-0004OS-Tv
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 16:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752951AbXDKOvW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 10:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbXDKOvW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 10:51:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55355 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbXDKOvV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 10:51:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hbe9z-0005iv-TT; Wed, 11 Apr 2007 10:50:59 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5081620FBAE; Wed, 11 Apr 2007 10:51:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070411130932.GA17094@dspnet.fr.eu.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44240>

Olivier Galibert <galibert@pobox.com> wrote:
> On Wed, Apr 11, 2007 at 08:57:09AM -0400, Nicolas Pitre wrote:
> > Hmmm what we need is a random data generator that always produces the 
> > same thing.  I'll hack something to replace urandom.
> 
> Don't hack something, ues the standard reference, the Mersenne Twister.
> 
>   http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html
> 
> PRNGs are the same as cryptosystems, it's very easy to hack up
> something and get it very, very wrong.  And it's unnecessary, since
> there are very good ones available.

Indeed.  But Mersenne Twister doesn't have code to produce a random
file of size X given an initial constant seed of Y, does it?
A small program to produce X random bytes starting with seed Y
still needs to be hacked up.

Probably the smart thing to do here is to embed a copy of MT with
constant seeds so we always get the same data file produced on
every system, no matter what the implementation of the C library's
rand routine is.

Although MT is not GPL. It has its own license, one with a small
advertising clause...

-- 
Shawn.
