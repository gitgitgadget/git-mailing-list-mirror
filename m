From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: User-relative paths
Date: Mon, 24 Oct 2005 02:28:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510240219410.25300@iabervon.org>
References: <435ABB99.5020908@op5.se> <7vll0l6pn7.fsf@assigned-by-dhcp.cox.net>
 <435B5AE0.1060400@op5.se> <20051023183757.GS30889@pasky.or.cz>
 <7voe5gypvi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:29:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETvpH-0003Bv-Ea
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 08:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVJXG2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 02:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVJXG2l
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 02:28:41 -0400
Received: from iabervon.org ([66.92.72.58]:7180 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751020AbVJXG2k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 02:28:40 -0400
Received: (qmail 5908 invoked by uid 1000); 24 Oct 2005 02:28:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Oct 2005 02:28:04 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe5gypvi.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10531>

On Sun, 23 Oct 2005, Junio C Hamano wrote:

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

The line:

$(SERVERSIDE_PROGRAMS): srvside-ssh.o

would suffice for that.

	-Daniel
*This .sig left intentionally blank*
