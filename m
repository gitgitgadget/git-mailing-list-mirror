From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] wt-status: show author info if status.showauthor is set
Date: Tue, 03 Apr 2007 23:32:15 -0700
Message-ID: <7vy7l87iq8.fsf@assigned-by-dhcp.cox.net>
References: <20070322104021.GJ29341@mellanox.co.il>
	<7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
	<20070404060213.GB31984@mellanox.co.il>
	<20070404062447.GA4136@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 08:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYz2m-0007zk-QS
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 08:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbXDDGcS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 02:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbXDDGcS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 02:32:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47034 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbXDDGcR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 02:32:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404063216.PFBZ1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Apr 2007 02:32:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id iuYG1W0071kojtg0000000; Wed, 04 Apr 2007 02:32:16 -0400
In-Reply-To: <20070404062447.GA4136@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 4 Apr 2007 02:24:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43715>

Jeff King <peff@peff.net> writes:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On Wed, Apr 04, 2007 at 09:02:13AM +0300, Michael S. Tsirkin wrote:
>
>> - Maybe put Author: (or From:? and maybe Subject:?) line in the pre-formatted
>>   commit message, and let the user edit them?
>
> Personally I think it's just clutter, but hey, it's off by default. Of
> course what is the chance that you've turned on status.showauthor in
> your ~/.gitconfig, but you don't have your identity set up properly? :)
>
> Junio, this is somewhat tongue in cheek, but if people like it, please
> take it.

It may be t-i-c, but on the other hand it might make sense to
make git-commit take notice and use it.

If we were to go that route, I suspect it should not be of form
"# author: Who AmI <who.ami@example.com>".

Maybe the updated git-commit commit log message rule could be:

 * If the lines in the first paragraph all begin with "From: ",
   or "Date: " (you do not have to override all of them), they
   are used to override authorship information;

 * If this feature is used, "Subject: " should be among the
   lines in the first paragraph for consistency.

 * Otherwise we will continue doing what we always have been
   doing.
