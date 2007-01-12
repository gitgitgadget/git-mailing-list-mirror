From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Clean up write_in_full() users
Date: Thu, 11 Jan 2007 23:33:46 -0500
Message-ID: <20070112043346.GB24195@spearce.org>
References: <Pine.LNX.4.64.0701112014050.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 12 05:34:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5E72-0001UP-0V
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 05:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbXALEdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 23:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbXALEdx
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 23:33:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48772 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbXALEdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 23:33:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5E6n-0005OV-Q7; Thu, 11 Jan 2007 23:33:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 43CF520FBAE; Thu, 11 Jan 2007 23:33:47 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701112014050.3594@woody.osdl.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36659>

Linus Torvalds <torvalds@osdl.org> wrote:
> I actually think "read_in_full()" should get the same loving tender care 
> too, for all the same reasons. I think "read_or_die()" is totally broken. 
> Anybody who uses "read_or_die()" is buggy by definition, since it will do 
> a partial read AND NOT RETURN ANY INDICATION THAT IT WAS PARTIAL!

AFAIK the only user of read_or_die is sha1_file.c when it reads in
the 12 byte pack header and the 20 byte pack trailer to "quickly"
verify the packfile is sane before using it.  If I recall correctly
it was correct when I created it, but the read_in_full refactoring
changed it.

-- 
Shawn.
