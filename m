From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] [COGITO] make cg-tag use git-check-ref-format
Date: Tue, 13 Dec 2005 18:00:15 +0100
Message-ID: <20051213170015.GD22159@pasky.or.cz>
References: <11344712912199-git-send-email-matlads@dsmagic.com> <7vy82p9rnb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Atukunda <matlads@dsmagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 18:03:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmDVl-0005DW-Ua
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 18:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbVLMRAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 12:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVLMRAS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 12:00:18 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33229 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964943AbVLMRAR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 12:00:17 -0500
Received: (qmail 10360 invoked by uid 2001); 13 Dec 2005 18:00:15 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy82p9rnb.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13580>

Dear diary, on Tue, Dec 13, 2005 at 12:13:12PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Martin Atukunda <matlads@dsmagic.com> writes:
> 
> > The egrep pattern used by cg-tag is too restrictive. While it will prevent
> > control characters from being specified as a tag name, it will also reject
> > nearly anything written in a non-English language, as noted by -hpa
> >...
> > -(echo $name | egrep -qv '[^a-zA-Z0-9_.@!:-]') || \
> > +git-check-ref-format $name || \
> >  	die "name contains invalid characters"
> 
> Perhaps you meant to say:
> 
> 	git-check-ref-format "$name"
> 
> instead; after all you are dealing with potentially garbage
> input from the user here.
> 
> While you are at it, you might want to also quote $_git/refs/tags
> immediately follows the part that you patched, and there is
> another.

Thank you both for the patch, but I'd be much more comfortable if at
least quotes (both ' and "), backslashes, ? and * would be prohibited in
the names as well. Any chance of also implementing this policy upstream?
Taken to the extreme, using such a names for tags might be perceived as
a possible security vulnerability wrt. the less shell-savy users. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
