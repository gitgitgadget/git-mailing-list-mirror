From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trying to use AUTHOR_DATE
Date: Sun, 1 May 2005 09:46:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505010934480.2296@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035EDE2C@scsmsx401.amr.corp.intel.com>
 <42730061.5010106@zytor.com> <Pine.LNX.4.58.0504292101230.2296@ppc970.osdl.org>
 <Pine.LNX.4.58.0504292114580.2296@ppc970.osdl.org> <87zmvganq9.fsf@windlord.stanford.edu>
 <1114848175.24014.35.camel@localhost.localdomain> <20050430124048.79119cac.froese@gmx.de>
 <87r7gs87a9.fsf@windlord.stanford.edu> <Pine.LNX.4.58.0504301322130.2296@ppc970.osdl.org>
 <20050501005434.2d47131a.froese@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 18:40:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSHUI-0002B0-2C
	for gcvg-git@gmane.org; Sun, 01 May 2005 18:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVEAQpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 12:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVEAQpa
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 12:45:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:19341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261693AbVEAQpK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 12:45:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j41Girs4012130
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 May 2005 09:44:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j41Giqke021553;
	Sun, 1 May 2005 09:44:53 -0700
To: Edgar Toernig <froese@gmx.de>
In-Reply-To: <20050501005434.2d47131a.froese@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 1 May 2005, Edgar Toernig wrote:
> 
> And I had the impression the strict checks in the original
> version were intentionally ;-)

Btw, here's my test of every single email in my email archive (which is 
not that big any more - after the SCO subpoena, I decided that I never 
want to go through with that kind of crap ever again, so now it's only a 
month or two of things). 

Almost everything seems to follow the RFC's or at least be close enough
that my "accept anything" ends up doing something sane, except for three
emails:

	Date: Fri, 08 Apr 2005 02:20:10 0200 -> bad
	Date: Mon, 18 Apr 05 15:05:29 Hora oficial do Brasil -> bad
	Date: 2002/04/11 18:29:07 -> bad

That first one doesn't have a sign in front of the timezone (I'll fix
things up - right now I end up believing that it's "year 200"), and the
third one has the sane European date order that sorts nicely (and which
I'll also fix up).

The second one is funny. Not just the "Hora oficial do Brasil" (hey, I 
could add it as a real timezone and my parser would do the right thing ;) 
but also because my parser decides that "05" is not a year, but the day in 
the month, so it doesn't see the year.

I can fake out that year thing pretty easily ("if it starts with '0' it's 
not a day of the month"), but it does show just how _strange_ stuff 
there's out there.

("Hora" is also Swedish for "whore", so that timezone does end up being
mentally parsed _quite_ the wrong way for somebody like me who doesn't
speak spanish).

			Linus
