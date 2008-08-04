From: Petr Baudis <pasky@suse.cz>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Mon, 4 Aug 2008 22:10:20 +0200
Message-ID: <20080804201020.GB32184@machine.or.cz>
References: <20080730125743.GY15356@erda.amd.com> <1217432970.2884.8.camel@localhost.localdomain> <20080730161126.GE31295@erda.amd.com> <1217796793.32240.36.camel@localhost.localdomain> <20080804101200.GC811@erda.amd.com> <1217867214.32240.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Richter <robert.richter@amd.com>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ6Ov-0005kI-5W
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 22:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761145AbYHDUK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760089AbYHDUK0
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 16:10:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42504 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759760AbYHDUKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 16:10:22 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id AE025393B5FA; Mon,  4 Aug 2008 22:10:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217867214.32240.61.camel@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91391>

  Hi,

On Mon, Aug 04, 2008 at 09:26:54AM -0700, J.H. wrote:
> The git link was always meant / intended to be a link to acquire the git
> repository directly, and be independent of what is actually present in
> the cloneurl file, specifically I wanted it to be a (1) git url
> (git://<hostname>/<path>) so that it took advantage of git specifically
> vs. accidentally giving you something with ssh or http.

  we could grep the cloneurl.

  The thing is, some sites like repo.or.cz don't use per-project
cloneurl but do specify pull URLs by @git_base_url_list and this is
introducing unnecessary redundancy.

> and (2) was
> uniform and did *not* depend on something in the repository as with
> large set of repositories, kernel.org, there is no way we can police
> this and we explicitly do not want to have a script that automatically
> adds this or what not.

  Then why do you allow cloneurl in the repositories at all, if you
think the links won't be trustworthy? What is the fundamental difference
between what you show on the project list page and the URLs in the
project summary page?

> I have two other concerns with the patch your proposing
> 
> (1) it's on by default, and it seems that there are a number of sites
> that don't actually want this functionality, making it a configurable
> option would seem prudent in that case

  I actually plan to remove the 'log' link from the project list; I
really wonder about the practicality of the 'git' link... but if there
were any widely used browser integrations (like firing up git-gui when
clicking on a git:// link), I *would* definitely see it more useful than
the 'log' link and add it to repo.or.cz. But I have never heard about
anyone actually doing this (but I think it might make a lot of sense;
thinking about it, I might try to patch msysgit to do this on Windows,
this would be nifty for my current dayjob project :).

> That said, it's probably worth merging the two patches (since I'm
> already there with the configuration options, etc) that way people can
> get either functionality should they choose.

  Configuration options are expensive on human users. Please let's not
add more too carelessly.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
