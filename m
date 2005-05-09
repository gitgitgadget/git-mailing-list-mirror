From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH Cogito] Make use of external editor work like CVS
Date: Mon, 9 May 2005 09:33:33 +0200
Message-ID: <20050509073333.GC3599@pasky.ji.cz>
References: <20050508171209.GX9495@pasky.ji.cz> <1115572667.9031.139.camel@pegasus> <20050508173003.GY9495@pasky.ji.cz> <1115574035.9031.145.camel@pegasus> <20050508175156.GA9495@pasky.ji.cz> <1115578658.8949.9.camel@pegasus> <20050508200334.GG9495@pasky.ji.cz> <1115584015.8949.43.camel@pegasus> <20050508210857.GL9495@pasky.ji.cz> <20050509052814.617dceac.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 09:26:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV2eo-0008SE-PR
	for gcvg-git@gmane.org; Mon, 09 May 2005 09:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbVEIHdg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 03:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbVEIHdg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 03:33:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31977 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S263069AbVEIHde (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 03:33:34 -0400
Received: (qmail 8991 invoked by uid 2001); 9 May 2005 07:33:33 -0000
To: Edgar Toernig <froese@gmx.de>
Content-Disposition: inline
In-Reply-To: <20050509052814.617dceac.froese@gmx.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 05:28:14AM CEST, I got a letter
where Edgar Toernig <froese@gmx.de> told me that...
> Petr Baudis wrote:
> >
> > > +               if ! [ $LOGMSG2 -nt $LOGMSG ]; then
> > > +                       rm $LOGMSG $LOGMSG2
> > > +                       die 'Commit message not modified, commit aborted'
> > > +               fi
> 
> Just in case you come to a conclusion some day, how about changing the
> if-test to
> 
> 	if cmp -s $LOGMSG LOGMSG2; then
> 
> ?  :-)  IMHO much better then comparing only the date.
> 
> Ciao, ET.

Much, much worse. What if I really actually do not want to change
anything in the merge message or the series of -m's? Ok, :x didn't work
now since we cannot know. But now, :wq won't do either, and you actually
need to do some silly dummy change now.

I think we should really ask the user as CVS, as Marcel (or whoever)
suggested.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
