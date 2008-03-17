From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: repo.or.cz renovation
Date: Mon, 17 Mar 2008 11:44:42 -0700
Message-ID: <1205779482.2758.52.camel@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
	 <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
	 <20080314002205.GL10335@machine.or.cz>
	 <1205454999.2758.14.camel@localhost.localdomain>
	 <20080317174934.GC6803@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Mar 17 19:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbKL0-0001uZ-3x
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 19:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYCQSo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 14:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYCQSo5
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 14:44:57 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:52911 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbYCQSo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 14:44:56 -0400
Received: from [10.255.255.198] (65-115-68-195.dia.static.qwest.net [65.115.68.195])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.13.8) with ESMTP id m2HIidPm025152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2008 11:44:39 -0700
In-Reply-To: <20080317174934.GC6803@machine.or.cz>
X-Mailer: Evolution 2.12.3 (2.12.3-1.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/6273/Sun Mar 16 20:03:58 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77452>

On Mon, 2008-03-17 at 18:49 +0100, Petr Baudis wrote:
> On Thu, Mar 13, 2008 at 05:36:39PM -0700, J.H. wrote:
> > 
> > > You are of course right - I wanted to do the rename, but forgot to write
> > > it in the actual code. :-)
> > > 
> > > There is a more conceptual problem though - in case of such big sites,
> > > it really makes more sense to explicitly regenerate the cache
> > > periodically instead of making random clients to have to wait it out.
> > > We could add a 'force_update' parameter to accept from localhost only
> > > that will always regenerate the cache, but that feels rather kludgy -
> > > can anyone think of a more elegant solution? (I don't think taking the
> > > @projects generating code out of gitweb and then having to worry during
> > > gitweb upgrades is any better.)
> > 
> > You could do something similar to the gitweb caching I'm doing,
> > basically if a file isn't generated you make a user wait (no good way
> > around this really).  If a cache exists show it to the user unless the
> > cache is older than $foo.  If a re-generation needs to happen it happens
> > in the background so the user who triggers the regeneration sees
> > something immediately vs. having to wait (at the cost of showing out of
> > date data)
> 
> By the way, the index page is so far really the only bottleneck I'm
> seeing, other than that even project pages for huge repositories are
> shown pretty quickly. Did you ever try to just cache the index page on
> kernel.org? What sort of impact did it have? What evere the hotspots -
> project pages for the main repositories or some less obvious pages?
> 
> Just caching the index would be far less intrusive change than
> introducing caching everywhere and it might help to bring kernel.org
> gitweb back in sync with mainline. :-)

I think we are likely going to want to keep caching everything vs. just
the front page.  There are a few repos that get hit quite a bit and it
would be better to have those cache vs. not.  Really I would argue this
is just a step in the direction of integrating all of my caching changes
back into gitweb vs. us dropping what we've done so far.

BTW I'm about halfway through refactoring my tree from multiple files
back to one, which at that point means I can start bringing it back into
mainline and getting a patch series ready for submission.

- John
