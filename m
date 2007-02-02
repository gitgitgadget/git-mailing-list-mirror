From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Thu, 01 Feb 2007 17:25:34 -0800
Message-ID: <7vmz3xmju9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070201234706.GP17617@mellanox.co.il>
	<Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 02 02:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCnBc-0004YG-MU
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 02:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423053AbXBBBZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 20:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423058AbXBBBZg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 20:25:36 -0500
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:58259 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423053AbXBBBZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 20:25:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202012535.QQEH1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Feb 2007 20:25:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JRRb1W00T1kojtg0000000; Thu, 01 Feb 2007 20:25:35 -0500
In-Reply-To: <Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 2 Feb 2007 00:53:14 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38444>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 2 Feb 2007, Michael S. Tsirkin wrote:
> ...
>> One can always get more branches later, is my approach.
>
> Yes. But in the same vein, one can add _one_ branch to an empty repo 
> either. So, with your reasoning, your patch wouldn't be needed to begin 
> with.

Indeed.

> But I find it useful. Even the version where you are not limited to one 
> branch.

I am not against the general idea of tracking a subset of
branches, but issues include:

 [1] tracking multiple (but not all) branches, as you pointed out,

 [2] how this should interact with later fetches from the same
     remote.

 [3] allowing similar "track these branches from a new remote
     from now on" in an already initialized repository.

Perhaps by specifying the --branch parameter in an wildcard
fashion, remote.*.fetch can be initialized to that wildcard and
later new branches that match the wildcard pattern ca be fetched
(which is a strawman solution for [1] and [2]).  I suspect [3]
belongs to what "git remote" should allow you to do, but in that
case maybe "git init-db ; git remote *that-new-command*" would
be a single uniform way to solve all of the above?

I personally feel this is post 1.5.0 material.
