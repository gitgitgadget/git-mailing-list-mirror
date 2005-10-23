From: Petr Baudis <pasky@suse.cz>
Subject: Re: User-relative paths
Date: Mon, 24 Oct 2005 00:25:54 +0200
Message-ID: <20051023222554.GT30889@pasky.or.cz>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se> <20051023183757.GS30889@pasky.or.cz> <7voe5gypvi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 00:27:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EToI3-0006ZF-Hx
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 00:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVJWW0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 18:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbVJWW0E
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 18:26:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35549 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750796AbVJWW0C (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 18:26:02 -0400
Received: (qmail 11909 invoked by uid 2001); 24 Oct 2005 00:25:54 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe5gypvi.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10506>

Dear diary, on Sun, Oct 23, 2005 at 09:50:25PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> >> diff --git a/Makefile b/Makefile
> >> index 903c57c..87188ea 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -359,6 +362,9 @@ git-cherry-pick: git-revert
> >>  %.o: %.S
> >>  	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
> >>  
> >> +$(SERVERSIDE_PROGRAMS) : git-%$X : %.o srvside-ssh.o $(LIB_FILE)
> >> +	$(CC) $(ALL_CFLAGS) -o $@ $(filter %o,$^) $(LIBS)
> >> +
> >>  git-%$X: %.o $(LIB_FILE)
> >>  	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
> >>  
> >
> > Why are you adding own compilation command, and why is it inconsistent
> > with the git-%$X's one?
> 
> Although I'd prefer the simplicity of putting srvside-ssh.o in
> LIB_OBJS, this is arguably defensible; it avoids relinking of
> everything else merely because srvside-ssh.c is changed.

I'm talking only about the compilation command, not about the dependency
line.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
