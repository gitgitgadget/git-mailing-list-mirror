From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Gitweb: Provide Git links in project list?
Date: Mon, 04 Aug 2008 09:26:54 -0700
Message-ID: <1217867214.32240.61.camel@localhost.localdomain>
References: <20080730125743.GY15356@erda.amd.com>
	 <1217432970.2884.8.camel@localhost.localdomain>
	 <20080730161126.GE31295@erda.amd.com>
	 <1217796793.32240.36.camel@localhost.localdomain>
	 <20080804101200.GC811@erda.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Richter <robert.richter@amd.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 18:28:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ2vQ-0006mP-Os
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 18:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862AbYHDQ1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 12:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbYHDQ1r
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 12:27:47 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:51024 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbYHDQ1q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 12:27:46 -0400
Received: from [172.19.0.93] (c-67-188-226-86.hsd1.ca.comcast.net [67.188.226.86])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id m74GRc5S015728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2008 09:27:39 -0700
In-Reply-To: <20080804101200.GC811@erda.amd.com>
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8) 
X-Virus-Scanned: ClamAV 0.88.7/7935/Mon Aug  4 05:58:49 2008 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.1.12 (shards.monkeyblade.net [198.137.202.13]); Mon, 04 Aug 2008 09:27:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91380>

Robert,

Noticed, but while I agree cloneurl is good - I think it kind of defeats
the purpose of what I was originally intending with the 'git' link.
I've gone back in to understand cloneurl better and I genuinely think
this is the wrong approach (or at least not what was originally intended
with the 'git' link as I envisioned it).

The git link was always meant / intended to be a link to acquire the git
repository directly, and be independent of what is actually present in
the cloneurl file, specifically I wanted it to be a (1) git url
(git://<hostname>/<path>) so that it took advantage of git specifically
vs. accidentally giving you something with ssh or http. and (2) was
uniform and did *not* depend on something in the repository as with
large set of repositories, kernel.org, there is no way we can police
this and we explicitly do not want to have a script that automatically
adds this or what not.

I have two other concerns with the patch your proposing

(1) it's on by default, and it seems that there are a number of sites
that don't actually want this functionality, making it a configurable
option would seem prudent in that case

(2) ignoring my comments on why I think using cloneurl for a large site
is bad (after I looked into it), blindly on taking the first option in
the file may lead to the display of unexpected or unintended URLs.

That said, it's probably worth merging the two patches (since I'm
already there with the configuration options, etc) that way people can
get either functionality should they choose.

- John 'Warthog9' Hawley

On Mon, 2008-08-04 at 12:12 +0200, Robert Richter wrote:
> On 03.08.08 13:53:13, J.H. wrote:
> > Working on refactoring the patch so that it can go upstream, one of the
> > things I'm definitely making an assumption about (in my original code)
> > is that the base url will be uniform for the entire project_list (as it
> > is on kernel.org).  If that's acceptable I will probably be able to
> > submit something today, if not I will need to muck about and read out
> > the url from .git/cloneurl (which would be a rather hefty performance
> > hit - needing to read that from each repository)
> 
> John,
> 
> I just sent out a patch that implements this using cloneurl. It seemed
> small and easy to implement and so I just made the change myself.
> 
> Thank you anyway.
> 
> -Robert
> 
