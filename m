From: Junio C Hamano <junkio@cox.net>
Subject: Re: pull/push inconsistencies
Date: Tue, 15 May 2007 19:30:21 -0700
Message-ID: <7vy7jpfqki.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
	<7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
	<46a038f90705151811o2159aa5ai84a13e77e790e376@mail.gmail.com>
	<7v646th8a2.fsf@assigned-by-dhcp.cox.net>
	<20070516014002.GA8062@fieldses.org>
	<46a038f90705151851i9027e01x993300b1b50d0285@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 04:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho9He-0002Wk-VE
	for gcvg-git@gmane.org; Wed, 16 May 2007 04:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759273AbXEPCaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 22:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759282AbXEPCaX
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 22:30:23 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53074 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759273AbXEPCaX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 22:30:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516023022.XZQE6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 22:30:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zeWM1W00q1kojtg0000000; Tue, 15 May 2007 22:30:22 -0400
In-Reply-To: <46a038f90705151851i9027e01x993300b1b50d0285@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 16 May 2007 13:51:47 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47406>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

>> I understand him to be saying that it *doesn't* do that, and that he
>> *wants* it to.
>
> I'm probably in a bad-communication day :-/

Sorry, I think I am lacking my medication :-/

> I have locally .git/refs/remotes/origin/foo, and the remote repo has
> refs/heads/foo. I don't have .git/refs/heads/foo in this case. When I
> do git-push, it doesn't really change the remote repo, but it _tells_
> me it has.
>
> So - behaviour-wise, it's fine. It's not changing the remote repo. But
> it tells me it does. It's just plain weird and misleading...

I would agree with that it is misleading or plain wrong if it
says it updated something that it didn't.

>> People think of refs/remotes/origin as a cache of the origin
>> repository's branch heads, and they expect it to be updated on write
>> (push) as well as read (fetch).
>
> Yes ;-)

On a related note, I think recent series from Daniel, parked in
'pu' while 1.5.2 is prepared, contained a new feature to update
the refs/remotes/origin/* on the pushing repository after
git-push, to save one round of fetch (that is, pretend that you
fetched immediately after you pushed).
