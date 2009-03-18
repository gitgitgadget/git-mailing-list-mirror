From: "Marcel M. Cary" <marcel@earth.care2.com>
Subject: Re: Suggested Workflow Question
Date: Tue, 17 Mar 2009 18:27:24 -0700
Message-ID: <49C04DFC.10201@earth.care2.com>
References: <loom.20090317T175010-470@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Roger Garvin <yoyodyn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:29:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkaY-0001kL-A0
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbZCRB11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbZCRB11
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:27:27 -0400
Received: from exchange01.earth.care2.com ([38.99.18.107]:7939 "EHLO
	exchange01.earth.care2.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754438AbZCRB10 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 21:27:26 -0400
Received: from [10.100.1.59] (38.99.217.18) by exchange01.earth.care2.com
 (10.102.0.107) with Microsoft SMTP Server id 8.0.813.0; Tue, 17 Mar 2009
 18:27:24 -0700
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <loom.20090317T175010-470@post.gmane.org>
X-PureMessage: [Scanned]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113551>

Roger Garvin wrote:
> I work for a small company with about 15 developers who work concurrently on
> about 10+ projects both in new development and support.
> We do custom software for manufacturing and production systems.  Part of our
> contracts with our customers is a perpetual single use license of the source
> code at each facility.
> So we have a copy of the source on our office server, and another copy at each
> customer site.  When we had only 5 developers it was easier to handle.  Now that
> we are growing we need a source control system and I have been looking heavily
> into Git.  Our old workflow does not seem that it will fit well with Git
> however, but I feel that I need a distributed system to keep track of the office
> version and the on-site versions of our source since development is taking place
> on both.
> (Some customers also have separate development, and testing versions on their
> servers as well.)
> 
> I have created git repositories on a couple of our project source directories as
> test beds.  Right now (second day) I am the only one who is actually using git.
>  Everyone else is simply accessing the files on the server as they have always
> done, and I am making the commits when I see signifigant changes.
> 
> My question is really a request for modified workflow ideas.  My plan was to
> have a master repository in our office server with clones at each customer site,
> and multiple branches for test, QA, and production versions of the source.
> Since most of these customers have closed networks, we would rely on people
> traveling onsite, or emailing patches to get any updates back into our office
> repository.
> 
> Thank you for any assistance for this revision control newb.
> 
> Roger Garvin

The workflow elements you mention so far sound sane to me:

* a repository in your office
* repositories at customer sites
* emailing patches when direct connections are not possible
* test and dev branches for each customer

I presume there will also be a production branch in customer 
repositories on which you arrange production releases... or maybe you 
just tag your test branch when it passes?

When you send patches via email, keep in mind that you'll have to convey 
which branch they belong on "out of band", for example after the commit 
message and above the diffstat.

There was an interesting discussion about maintaining per-client code on 
different branches recently, but I can't find it.

I've found Git to be very flexible.  Maybe you could start by emulating 
your current workflow and refine it as you go?  If you find you don't 
know how code travels currently... well, maybe you can just let your 
team pass patches around until patterns emerge.

Marcel
