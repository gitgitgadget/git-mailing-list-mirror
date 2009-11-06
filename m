From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Support for no project list on gitweb front page
Date: Fri, 06 Nov 2009 11:03:01 -0800
Message-ID: <4AF472E5.1000602@eaglescrag.net>
References: <1257520265-16699-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 06 20:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6U5j-00035D-JV
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 20:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759643AbZKFTDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 14:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759575AbZKFTDD
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 14:03:03 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:55125 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759207AbZKFTDC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 14:03:02 -0500
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2009 14:03:02 EST
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nA6J3118030360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Nov 2009 11:03:02 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <1257520265-16699-1-git-send-email-pasky@suse.cz>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/9996/Thu Nov  5 22:03:42 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 06 Nov 2009 11:03:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132322>

Petr Baudis wrote:
> On very large sites like repo.or.cz (but maybe also git.debian.org,
> git.kernel.org, etc.),

I think between our own caching (which I'll be submitting a cleaned up 
patch for here shortly for mainline inclusion) and our users want to 
*NOT* deal with searching or pagination this actually isn't that useful 
to us, despite having a signifigant number of projects, and the front 
page (at leas for us) only weighing in at 567,710bytes means that we are 
moving less data to show the git.kernel.org page than facebook does to 
show their home screen (I.E. anything modern can trivially cope with that)

> it is desirable not to have the project list
> on the front page since generating it is significant overhead and it
> takes significant data transfer and load time for the user, who might
> prefer to instead use the search form and possibly content tags to
> navigate to the target project. A link to the full list of projects is
> still available on the front page for users who wish to browse it. The
> whole feature is turned off by default.
> 
> The patch introduces a new config variable $frontpage_no_project_list,
> by default 0 keeping the current behavior; if set to 1, no project list
> will be shown, but all projects will be still scanned if ctags are
> enabled; if set to 2, no project will be shown and no projects will
> be scanned while showing the front page. The compromise value of 1 is
> useful for sites where project scan time is not an issue or which
> use additional project list caching patches.

I question the need for 0,1,2.  If the site doesn't want something like 
the tag cloud they are already going to turn it off with the normal 
cloud system.  I think this should be either a bitmask or an array to 
explicitly turn particular things on or off, or a binary value that 
would *ONLY* deal with showing the project listing.

- John 'Warthog9' Hawley
