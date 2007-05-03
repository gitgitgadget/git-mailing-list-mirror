From: david@lang.hm
Subject: Re: FFmpeg considering GIT
Date: Thu, 3 May 2007 13:05:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705031302110.26172@asgard.lang.hm>
References: <loom.20070502T111026-882@post.gmane.org>
 <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-727469530-1178222734=:26172"
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Panagiotis Issaris <takis.issaris@uhasselt.be>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 03 22:19:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjhlv-0000dz-K0
	for gcvg-git@gmane.org; Thu, 03 May 2007 22:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbXECUTY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 16:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbXECUTY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 16:19:24 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:60463
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbXECUTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 16:19:23 -0400
X-Greylist: delayed 757 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2007 16:19:23 EDT
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l43K6KCt014941;
	Thu, 3 May 2007 13:06:20 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070503200013.GG4489@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46103>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-727469530-1178222734=:26172
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 3 May 2007, Petr Baudis wrote:

> On Thu, May 03, 2007 at 08:00:16PM CEST, Uwe Kleine-König wrote:
>
>  I believe that the development scheme is largely independent on the
> version control system, except that git makes the "both ways" equally
> easy. But that doesn't mean that the "multiple people with commit
> access" scheme is wrong or anything. It has important upsides as well -
> there's no single human point of failure (_yes_, if the maintainer gets
> stuck in hospital for two months you can fork and maintain own
> repository, but then it's again just you and it is complicated socially
> etc.), the load of the maintainer is significantly lowered, and in many
> projects there is simply no "single maintainer" but a team of people
> where decisions are made by consensus.
>
>  Still, if this kind of bogus change checkins happens at any frequent
> rate in the ffmpeg project, there is a serious problem somewhere. :-)
> But I think the git way of alleviating this problem would be to have a
> way to hint the pickaxe and blame tools to ignore changes in given
> commits. So, you don't _cover up_ the messy things that happened during
> the history, but avoid in getting in the way in your view. You can still
> look it up (with git log or something) in case you'd need to (perhaps
> the revert patch was a bit complicated because of conflicting with some
> other changes, and a subtle bug was introduced; this would be thousand
> times harder to track down if you would've rewritten the history).
>
>  Would crafting up a patch to implement something like this help ffmpeg
> people in their decision?

is this needed?

wouldn't you do something like

a--b--c--d

oops, b was really bad

rebase c b

a--b--c--d
     \
      c'--d'--e--f

and you just start tagging d', e, f as the releases, logicly changing 
things to

a--b--c'--d'--e--f
     \
      c--d  dead branch

the only thing that this costs is space. unless it's a 'mess up all the 
whitespace in the entire tree' type of thing (and if it was, whoever 
did the commit would see the _huge_ diffstat and probably catch it) it's 
not likely to be a significant amount of space in the overall history.

David Lang
--680960-727469530-1178222734=:26172--
