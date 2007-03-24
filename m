From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] have merge put FETCH_HEAD data in commit message
Date: Sat, 24 Mar 2007 03:21:54 -0700
Message-ID: <7v7it7kkl9.fsf@assigned-by-dhcp.cox.net>
References: <20070321120643.GI20583@mellanox.co.il>
	<7v648u38ws.fsf@assigned-by-dhcp.cox.net>
	<20070322043604.GA6303@mellanox.co.il>
	<7vd531yicx.fsf@assigned-by-dhcp.cox.net>
	<20070322062805.GD6303@mellanox.co.il>
	<7vaby5wxyn.fsf@assigned-by-dhcp.cox.net>
	<20070322074051.GA29341@mellanox.co.il>
	<7vlkhpvgc7.fsf@assigned-by-dhcp.cox.net>
	<20070322083757.GC29341@mellanox.co.il>
	<7vr6rhtvr0.fsf@assigned-by-dhcp.cox.net>
	<20070322104021.GJ29341@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Sat Mar 24 11:22:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HV3O5-0004LA-Nv
	for gcvg-git@gmane.org; Sat, 24 Mar 2007 11:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbXCXKV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 06:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752512AbXCXKV4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 06:21:56 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34877 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbXCXKVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 06:21:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070324102154.CMBV22511.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 24 Mar 2007 06:21:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id eaMu1W0011kojtg0000000; Sat, 24 Mar 2007 06:21:54 -0400
In-Reply-To: <20070322104021.GJ29341@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 22 Mar 2007 12:40:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42991>

"Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:

>> > 3. if I want to have some text coming *before* the commit
>> >    message ignored, there's no way to do this
>> > 4. there's no way to override the subject from within the message
>> >    (like there is with author/From line)
>> 
>> How about this?
>
> Looks good. What about 3?

When e-mailed message has garbage at the beginning (e.g. "Hi!"),
git users can either run "commit --amend" immiediately after
"git am", or edit the mbox with editor before running
"applymbox", so the need has not been felt much us, and that is
the primary reason why it is not there.  Additionally we do not
think it is particularly a good practice to have "cover letters"
at the top (cf. $gmane/5418), so it was never high priority for
us to add that feature to encourage such a practice.

Having said that, on top of the recent work by Don Zickus on
mailinfo, you _could_ add support for scissors "^-- >8 --$" if
you want.

>> Also check t5100 and its sample mailbox,
>> especially the "third patch" from A U Thor, which I forwarded
>> with the subject "another patch".
>
> It's funny ... but what should I look at there, specifically?

It is an example that you can override Subject: (#4 above).
