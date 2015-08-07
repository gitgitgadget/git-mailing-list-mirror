From: Kevin Daudt <me@ikke.info>
Subject: Re: wishlist: make it possible to amend commit messages after push
 to remote
Date: Fri, 7 Aug 2015 18:09:24 +0200
Message-ID: <20150807160924.GA4185@ikke.info>
References: <55C3FA66.90805@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jarkko Hietaniemi <jhi@iki.fi>
X-From: git-owner@vger.kernel.org Fri Aug 07 18:09:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNkDK-0000Tp-O7
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 18:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945908AbbHGQJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 12:09:28 -0400
Received: from ikke.info ([178.21.113.177]:36656 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945895AbbHGQJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 12:09:26 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id 944A34400AE; Fri,  7 Aug 2015 18:09:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55C3FA66.90805@iki.fi>
User-Agent: Mutt/1.5.23+102 (2ca89bed6448) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275469>

On Thu, Aug 06, 2015 at 08:23:02PM -0400, Jarkko Hietaniemi wrote:
> Not for the first time, and probably not for the last, I pushed a commit
> upstream without adding a link for the bug report as I was meaning to.
> 
> Or it could have been...
> 
> - Simple typos.
> 
> - Broken URLs.
> 
> - The impossibility of two consecutive commits referring to each other
> because the older one cannot know what the newer one will be called.
> 
> - The following morning / 5 minutes / 5 second later thinking of
> an additional factoid that would've been great to have in the
> commit message.
> 
> In general, I find the fact that once a commit has left the building,
> it goes into your permanent record, and cannot be changed, ever, to be
> very, very annoying. I get the cryptographic "sealing" with all the
> preceding changes, but...
> 
> Not that I've thought this through... but couldn't there be a bunch of
> "aliases" (new SHAs) for a commit?  The original one being the
> "master", but as/if the commit message is changed, it could get new
> SHAs.  Sort of separating the real data of the commit, and the metadata?
> 
> 

There is something that solves at least part of this problem. It's
called git-notes[1]. This allows you to add notes to objects (ie,
commits) afterwards.

This can be used to attach additional information to a commit without
having to change the commit.

This obviously doesn't help for fixing typos in commits. There does
exist something that works likes you described called git-replace[2].
This allows you for example to replace any commit with any other commit.
For this to work with others, you have to make sure refs/replace/* is
being pushed, and is fetched by others. This can be done by setting up
refspecs, but it has to be done by everone who uses this repo.

One more thing, if you know that no one has fetched the branch you just
pushed yet, you can amend the commit and force-push it without any
problems (I'd sugget using --force-with-lease). 

Hope this helps, Kevin

[1]: http://jk.gs/git-notes.html
[2]: http://jk.gs/git-replace.html
