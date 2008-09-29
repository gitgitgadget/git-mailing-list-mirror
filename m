From: Scott Moser <smoser@brickies.net>
Subject: Re: [PATCH] explicitly set LANG to 'C' in for guilt run-tests
Date: Mon, 29 Sep 2008 17:01:45 -0400 (EDT)
Message-ID: <alpine.DEB.1.00.0809291700130.935@brickies>
References: <1222714272-9557-1-git-send-email-smoser@brickies.net> <237967ef0809291325p7a0e3581vac348a1e99dbd4ed@mail.gmail.com> <20080929204958.GD31590@josefsipek.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mikael Magnusson <mikachu@gmail.com>, git@vger.kernel.org
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Sep 29 23:03:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkPtR-0006R1-LB
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 23:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYI2VBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbYI2VBs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 17:01:48 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:34837 "EHLO
	spunkymail-a16.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752311AbYI2VBr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2008 17:01:47 -0400
X-Greylist: delayed 7827 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Sep 2008 17:01:47 EDT
Received: from brickies.mosers.us (d14-69-66-169.try.wideopenwest.com [69.14.169.66])
	by spunkymail-a16.g.dreamhost.com (Postfix) with ESMTP id 5957B7B2AF;
	Mon, 29 Sep 2008 14:01:46 -0700 (PDT)
X-X-Sender: smoser@brickies
In-Reply-To: <20080929204958.GD31590@josefsipek.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97054>

On Mon, 29 Sep 2008, Josef Jeff Sipek wrote:
> > If I'm not mistaken, $LANG is used as the ultimate fallback, while LC_ALL is
> > the one that overrides all others, so you probably want to set LC_ALL. I'm
> > unsure which off the specific ones would apply here, but very likely it's
> > LC_COLLATE. In other words, if LC_ALL is set, it is used, otherwise if
> > LC_COLLATE is set it is used, otherwise if LANG is set, it is used,
> > otherwise, "POSIX" is used.
>
> IIRC, my devel system has all of them set to UTF8, _except_ LC_COLLATE (I
> like the case sensitive sort of filenames in ls(1)) which I have set to "C".
> So chances are that the minimum required is LC_COLLATE=C, but overriding
> everything might be safer overall.
>

Yeah, LC_ALL I sprobably correct.  I'm not very "LANG" aware at all.  I
just noticed that test 052 didn't run on my system, and figured out that
was why.

You want a re-send of this patch with LC_ALL ?  Or do you want to make
the modification yourself and apply?

Scott
