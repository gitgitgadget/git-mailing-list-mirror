From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Tue, 23 May 2006 00:02:06 +0200
Message-ID: <20060522220206.GA10488@pasky.or.cz>
References: <4470FC21.6010104@zytor.com> <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE> <44722A8F.9020609@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 00:02:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiITX-0000fe-Sp
	for gcvg-git@gmane.org; Tue, 23 May 2006 00:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWEVWCE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 18:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWEVWCD
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 18:02:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14734 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751145AbWEVWCC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 18:02:02 -0400
Received: (qmail 3626 invoked by uid 2001); 23 May 2006 00:02:06 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <44722A8F.9020609@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20537>

Dear diary, on Mon, May 22, 2006 at 11:18:07PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> said that...
> Sean wrote:
> >On Sun, 21 May 2006 16:47:45 -0700
> >"H. Peter Anvin" <hpa@zytor.com> wrote:
> >
> >>It appears that doing a *local* -- meaning using a file path or file URL 
> >>-- clone or fetch with cogito is just glacial when the repository has an 
> >>even moderate number of tags (and it's fetching the tags that takes all 
> >>the time.)  That's a really serious problem for me.
> >>
> >
> >Peter, does git clone work acceptably for you?
> >
> 
> Well, it does, except it doesn't set up the cogito branches (which one can 
> of course copy manually.)

What about incremental fetches using git-fetch? From a quick scan of the
git-fetch automagic tags following code, it seems to be even
significantly more expensive than Cogito's (in terms of number of
forks).

git-clone has an advantage here since it clones _everything_ while
Cogito fetches only stuff related to the branch you are cloning, and
verifying if what it fetches is sensible for you unfortunately takes a
lot of time. :/ I guess there is no way to verify presence of multiple
objects at once and there is also no way to order local fetch of
multiple objects at once.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
