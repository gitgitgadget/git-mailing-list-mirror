From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv5 00/14] git notes
Date: Sat, 12 Sep 2009 11:11:50 -0700
Message-ID: <20090912181150.GN1033@spearce.org>
References: <1252376822-6138-1-git-send-email-johan@herland.net> <200909080512.34634.johan@herland.net> <200909121750.00733.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 20:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmX4o-0004UW-7o
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 20:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbZILSLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbZILSLs
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 14:11:48 -0400
Received: from george.spearce.org ([209.20.77.23]:49731 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956AbZILSLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 14:11:47 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CA227381FD; Sat, 12 Sep 2009 18:11:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200909121750.00733.johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128274>

Johan Herland <johan@herland.net> wrote:
> Shawn, do you have any additional defence for the date-based fanout?

No.

The only defense I have for it is "it sounds like a nice theory
given access patterns", and the note about memory usage you made,
but which I clipped to keep this email shorter. :-)

It was only a theory I tossed out there in a back-seat-driver
sort of way.  Your results show my hunch was correct, it may help.
But they also say it may not help enough to justify the complexity,
so I now agree with you that SHA-1 fan out may be good enough.

> Are 
> there untested reasonable scenarios that would show the benefits of date-
> based fanout?

I don't think there are, your tests were pretty good at covering
things.

> How does the plan for notes usage in your code-review thingy 
> compare to my test scenario?

I think your tests may still have been too low in volume, 115k notes
isn't a lot.  Based on the distributions I was looking at before,
I could be seeing a growth of >100k notes/year.  Ask me again in
5 years if 115k notes is a lot. :-)

But we all know that SHA-1 distributes data quite well, so the SHA-1
fan-out may just need to change from 2_38 to 2_2_2_34 (or something)
to handle that larger volume.

-- 
Shawn.
