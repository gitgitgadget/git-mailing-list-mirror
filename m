From: Petr Baudis <pasky@suse.cz>
Subject: Re: git/cogito suggestion: tags with descriptions
Date: Sat, 8 Apr 2006 04:35:59 +0200
Message-ID: <20060408023559.GS27689@pasky.or.cz>
References: <20050905184551.GA14720@tumblerings.org> <7vd5nn49uz.fsf@assigned-by-dhcp.cox.net> <20050905212431.GB14720@tumblerings.org> <20050912010051.GJ15630@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 08 04:35:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FS3IB-0002b4-4N
	for gcvg-git@gmane.org; Sat, 08 Apr 2006 04:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964988AbWDHCfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 22:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWDHCfE
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 22:35:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:6356 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964988AbWDHCfD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Apr 2006 22:35:03 -0400
Received: (qmail 23408 invoked by uid 2001); 8 Apr 2006 04:35:59 +0200
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050912010051.GJ15630@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18510>

Dear diary, on Mon, Sep 12, 2005 at 03:00:51AM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Dear diary, on Mon, Sep 05, 2005 at 11:24:31PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > I'm not sure. I'm not as familiar with the low-level git commands as I am with
> > cogito. But cogito has a -d option for giving a tag description. I guess what
> > would be closest to what I was thinking about would be this:
> > 
> > $ cg-tag -d "First draft, everything in place." 0.3 7540e503b9b9c1b03e44ee7fd700c844b2a02224
> > $ cg-tag-ls
> > 0.1     Initial idea complete                 f953b71b21a0bea682c2bed91362f2dce2cc204f
> > 0.3     First draft, everything in place.     7540e503b9b9c1b03e44ee7fd700c844b2a02224 
> > $
> > 
> > or something like that. Currently when I do the above cg-tag command,
> > a subsequent cg-tag-ls gives just:
> > 
> > $ cg-tag-ls
> > 0.1     f953b71b21a0bea682c2bed91362f2dce2cc204f
> > 0.3     7540e503b9b9c1b03e44ee7fd700c844b2a02224
> > 
> > In fact, I probably wouldn't even be interested in seeing the actual hash key
> > unless I gave a special flag, maybe -f (for "full"):
> > 
> > $ cg-tag-ls
> > 0.1     Initial idea complete
> > 0.3     First draft, everything in place.
> > $ cg-tag-ls -f
> > 0.1     Initial idea complete                 f953b71b21a0bea682c2bed91362f2dce2cc204f
> > 0.3     First draft, everything in place.     7540e503b9b9c1b03e44ee7fd700c844b2a02224
> 
> That's a nice idea (except that I'd prefer -l). I'll implement this
> after cogito-0.14.

So, I did. ;-) (In the master branch now.) The format is slightly
different from the proposed one:

	S cogito-0.16rc2   7766e3ba0664
	S cogito-0.17      51392f2dd82a  Poetic cogito-0.17.
	S cogito-0.17rc1   7cb4d8972d5b  Behold, cogito-0.17rc1! Plenty new features and cool stuff.
	% cogito-0.8       f9f0459b5b39
	% cogito-0.9       cc5517b4ea41
	  test             05862786175d

Object IDs are still shown, but abbreviated so they shouldn't get in the
way too much; the full first line is shown in the list output,
untrimmed. The initial flag column denotes signed tags by 'S', "direct
tags" (not pointing to a tag object) by '%' and broken tags by '!'.

P.S.: Also, cg-tag received a lot of improvements in the last two days.
Now features the same cool editor as cg-commit (but only if ran with
-e), -d was renamed to -m (but will stay aliased for quite some time),
cg-tag now also accepts multiple -m options for creating multi-paragraph
descriptions from the commandline, and bunch of other minor stuff was
implemented.

Thanks for the idea,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
