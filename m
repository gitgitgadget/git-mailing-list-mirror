From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: RFC: adding xdelta compression to git
Date: Tue, 3 May 2005 11:50:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0505031146130.32767@cag.csail.mit.edu>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 17:47:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSzaW-00034g-9I
	for gcvg-git@gmane.org; Tue, 03 May 2005 17:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVECPvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVECPvp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 11:51:45 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:6104 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261768AbVECPvo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 11:51:44 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DSzg3-0007sN-00; Tue, 03 May 2005 11:51:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 2 May 2005, Linus Torvalds wrote:

>> * Changes the repository format.
>
> It wouldn't necessarily. You should be able to do this with _zero_ changes
> to existing objects what-so-ever.

Yes.  The 'chunking' code I posted earlier does this, etc.  It's kinda odd 
computing a SHA-1 including the 'blob <size>\0' header, even when your 
representation doesn't use this type exactly, but it's no big deal.  I'm 
still tinkering with this, btw; I can get modest improvements in 'real' disk 
space used, but nothing earth-shattering (yet).  I'll post the list of 
things I tried and how well they worked at some point, just to save people 
the effort of retrying things.

I've been working from the 'no knowledge of commit structure needed' 
perspective; I think Chris Mason has been using the structure of the 
commit object to guide delta-fication and showing more impressive 
space savings.
  --scott

HTAUTOMAT Legion of Doom payment PBPRIME insurgent shortwave AVBUSY 
Nader PBCABOOSE overthrow explosion Ortega STANDEL ECJOB Sigint FBI
                          ( http://cscott.net/ )
