From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFD] gitweb configuration
Date: Sun, 18 Jun 2006 15:04:01 +0200
Message-ID: <20060618130401.GM2609@pasky.or.cz>
References: <e720r0$qdv$1@sea.gmane.org> <20060617232358.GK2609@pasky.or.cz> <e72j53$1m1$1@sea.gmane.org> <46a038f90606180042w7b4d11dbvbea28b750ddbc6e2@mail.gmail.com> <7v64iy505x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 15:03:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frwvh-0004RZ-GP
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 15:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWFRNC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 09:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWFRNC4
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 09:02:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51892 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932204AbWFRNCz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 09:02:55 -0400
Received: (qmail 11977 invoked by uid 2001); 18 Jun 2006 15:04:01 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64iy505x.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22076>

Dear diary, on Sun, Jun 18, 2006 at 10:38:02AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
> 
> > On 6/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
> >> So GIT_CONFIG would be ~/.gitconfig, and GIT_CONFIG_LOCAL would be
> >> $GIT_DIR/config or what?
> >
> > I don't quite follow why gitweb needs a GIT_CONFIG_LOCAL defined.
> > Given that it works in a CGI environment, it should read
> > $GIT_DIR/config by default, and $GIT_CONFIG if set (from httpd.conf).
> 
> I am not Pasky, but I think the intent of the patch is to run
> "git repo-config" with GIT_CONFIG pointing at /etc/gitweb.conf
> to obtain server-wide configuration (e.g. finding out where
> repositories are) and then when serving individual repository
> (i.e. after we set up GIT_DIR to point at it) run "git
> repo-config" without GIT_CONFIG to read per-repository
> configuration.  That way we can reuse the configuration parser.

Yes, if $GIT_CONFIG is set, git should be guaranteed to read _no_ config
file except $GIT_CONFIG. The intent of $GIT_LOCAL_CONFIG was to make it
possible to just override the per-repo configfile location, but it just
felt nice to have - I don't insist on it so if people think it's useless
additional complexity I'm happy to say that one goodbye.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
