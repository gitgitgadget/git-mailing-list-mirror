From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Add "git" link to the end of project line on the
	project_list page.
Date: Mon, 4 Aug 2008 05:20:44 +0200
Message-ID: <20080804032044.GG10151@machine.or.cz>
References: <1217815217-11329-1-git-send-email-warthog19@eaglescrag.net> <1217815217-11329-2-git-send-email-warthog19@eaglescrag.net> <20080804022656.GA32184@machine.or.cz> <1217817517.32240.46.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 05:21:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPqdp-0002gF-Eu
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 05:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYHDDUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 23:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbYHDDUr
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 23:20:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52766 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbYHDDUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 23:20:47 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 26DAD393B321; Mon,  4 Aug 2008 05:20:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217817517.32240.46.camel@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91311>

On Sun, Aug 03, 2008 at 07:38:37PM -0700, J.H. wrote:
> On Mon, 2008-08-04 at 04:26 +0200, Petr Baudis wrote:
> > On Sun, Aug 03, 2008 at 07:00:17PM -0700, warthog19@eaglescrag.net wrote:
> > > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > > index 90cd99b..c33f4ed 100755
> > > --- a/gitweb/gitweb.perl
> > > +++ b/gitweb/gitweb.perl
> > > @@ -108,6 +108,14 @@ our $mimetypes_file = undef;
> > >  # could be even 'utf-8' for the old behavior)
> > >  our $fallback_encoding = 'latin1';
> > >  
> > > +# enable / disable a final link on the project list page
> > > +# that will be the location of that actuall git url
> > > +# it will output this in the format:
> > > +# git://hostname/path/to/tree.git
> > > +# disabled = blank or undef
> > > +# enable = url to prefix before filling in the trailing path to the git repo
> > > +our $projectlist_gitlinkurl = undef;
> > > +
> > >  # rename detection options for git-diff and git-diff-tree
> > >  # - default is '-M', with the cost proportional to
> > >  #   (number of removed files) * (number of new files).

By the way, you should add this to gitweb/README too (though I've never
been too fond of listing the options twice myself; my strategy to avoid
it is to just add as much stuff possible to the $features hash ;-).

> > > +               if( $projectlist_gitlinkurl != undef && $projectlist_gitlinkurl ne "" ){

Coding style conformant and equivalent but simpler variant would be

	if ($projectlist_gitlinkurl) {

right?

> > > +                        print " | ". $cgi->a({-href => "git://projectlist_gitlinkurl/".esc_html($pr->{'path'})}, "git");
> > 
> > You meant $projectlist_gitlinkurl.
> 
> grrr - I've fixed that same bug twice now, had problems with something
> and must have reverted the wrong thing, I'll fix it and re-submit.
> 
> When you do the more generic patch to extend the links I'll flip this
> over to that code, unless you think it's worth holding off and waiting
> for that change to go in first?

It's a new feature so it probably won't make it to 1.6.0 - so let's see
if I manage to submit mine before 1.6.0. ;-)

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
