From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Trying to use AUTHOR_DATE
Date: Tue, 03 May 2005 00:10:45 +0200
Message-ID: <m3wtqhe0t6.fsf@defiant.localdomain>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
	<42730061.5010106@zytor.com>
	<Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
	<Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org>
	<20050430125333.2bd81b18.froese@gmx.de>
	<1114859594.24014.60.camel@localhost.localdomain>
	<20050430144936.6b05cc90.froese@gmx.de>
	<1114865964.24014.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edgar Toernig <froese@gmx.de>, Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 00:17:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSjD8-0002B7-Aq
	for gcvg-git@gmane.org; Tue, 03 May 2005 00:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVEBWKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 18:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVEBWKy
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 18:10:54 -0400
Received: from khc.piap.pl ([195.187.100.11]:22020 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261173AbVEBWKt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 18:10:49 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id A024510922; Tue,  3 May 2005 00:10:46 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114865964.24014.77.camel@localhost.localdomain> (David
 Woodhouse's message of "Sat, 30 Apr 2005 13:59:23 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> During a leap second, won't tm_sec be 60?

You could rather have two 59th seconds. Or the "seconds" could be, say,
0.1% longer for 1000 s. Depends on synchronization mechanism.

I think 60th second could only be possible with leap-seconds aware
things (NTP, GPS, reference radio clocks etc.).

> And in fact you don't seem to
> handle leap seconds at all, so isn't my_mktime going to be out by one
> second for every leap second which has occurred since 1970?

No, actually the system time (i.e., the number of seconds since 1970)
is already corrected (minutes are seconds/60, hrs = minutes/60 etc.)
You are off calculating time deltas, but I guess if you need such
accuracy your software already knows about leap seconds.
-- 
Krzysztof Halasa
