From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Fix @git_base_url_list usage
Date: Wed, 20 Sep 2006 02:49:35 +0200
Message-ID: <20060920004935.GJ8259@pasky.or.cz>
References: <20060920000946.GC13132@pasky.or.cz> <7v64fjnzyr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 02:50:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPqHX-0004r8-3E
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 02:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWITAth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 20:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWITAth
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 20:49:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11754 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750777AbWITAtg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 20:49:36 -0400
Received: (qmail 5146 invoked by uid 2001); 20 Sep 2006 02:49:35 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64fjnzyr.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27322>

Dear diary, on Wed, Sep 20, 2006 at 02:28:28AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > As it is now, that array was never used because the customurl accessor was
> > broken and ''unless @url_list'' never happenned.
> >
> > Signed-off-by: Petr Baudis <pasky@suse.cz>
> > ---
> >...
> >  sub git_get_project_url_list {
> >  	my $path = shift;
> >  
> > -	open my $fd, "$projectroot/$path/cloneurl" or return undef;
> > +	open my $fd, "$projectroot/$path/cloneurl" or return wantarray ? () : undef;
> >  	my @git_project_url_list = map { chomp; $_ } <$fd>;
> >  	close $fd;
> 
> Why on earth do you want to use wantarray for something like
> this?
> 
> It's not like you are implementinging any fancy DWIM magic.
> 
> Isn't
> 
> 	open my $fd, "foobar" or return;
> 
> much easier to read?

Sure, that's what I meant, I'm only already a bit tired so I just
mimicked the other return in that sub, sorry.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
