From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH 1/1] Add "git" link to the end of project line on the
	project_list page.
Date: Sun, 03 Aug 2008 19:38:37 -0700
Message-ID: <1217817517.32240.46.camel@localhost.localdomain>
References: <1217815217-11329-1-git-send-email-warthog19@eaglescrag.net>
	 <1217815217-11329-2-git-send-email-warthog19@eaglescrag.net>
	 <20080804022656.GA32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 04 04:40:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPpzq-0003hw-T4
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 04:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760774AbYHDCj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 22:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759859AbYHDCj2
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 22:39:28 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:53150 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759190AbYHDCj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 22:39:28 -0400
Received: from [172.19.0.93] (c-67-188-226-86.hsd1.ca.comcast.net [67.188.226.86])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m742dLw9014040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Aug 2008 19:39:22 -0700
In-Reply-To: <20080804022656.GA32184@machine.or.cz>
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7930/Sun Aug  3 17:09:38 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Sun, 03 Aug 2008 19:39:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91307>

On Mon, 2008-08-04 at 04:26 +0200, Petr Baudis wrote:
> On Sun, Aug 03, 2008 at 07:00:17PM -0700, warthog19@eaglescrag.net wrote:
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 90cd99b..c33f4ed 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -108,6 +108,14 @@ our $mimetypes_file = undef;
> >  # could be even 'utf-8' for the old behavior)
> >  our $fallback_encoding = 'latin1';
> >  
> > +# enable / disable a final link on the project list page
> > +# that will be the location of that actuall git url
> > +# it will output this in the format:
> > +# git://hostname/path/to/tree.git
> > +# disabled = blank or undef
> > +# enable = url to prefix before filling in the trailing path to the git repo
> > +our $projectlist_gitlinkurl = undef;
> > +
> >  # rename detection options for git-diff and git-diff-tree
> >  # - default is '-M', with the cost proportional to
> >  #   (number of removed files) * (number of new files).
> 
> Note that I will soon submit a generic patch that lets you extend
> the link lists with custom entries - you could easily use that for
> the git links (I'm personally not convinced how useful they really are
> on the project list page), I will use them for the graphiclog, edit and
> fork links at repo.or.cz.

I've found them useful, and there were requests out on the mailing list
for this to be added, thus the patching.  It's not on by default, so
it's impact should be minimal unless people specifically want the link.

> 
> > +                        print " | ". $cgi->a({-href => "git://projectlist_gitlinkurl/".esc_html($pr->{'path'})}, "git");
> 
> You meant $projectlist_gitlinkurl.

grrr - I've fixed that same bug twice now, had problems with something
and must have reverted the wrong thing, I'll fix it and re-submit.

When you do the more generic patch to extend the links I'll flip this
over to that code, unless you think it's worth holding off and waiting
for that change to go in first?

- John 'Warthog9' Hawley
