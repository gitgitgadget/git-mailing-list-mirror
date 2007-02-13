From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull and tag objects
Date: Mon, 12 Feb 2007 22:17:30 -0800
Message-ID: <7vr6su1szp.fsf@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
	<7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
	<20070210142322.GB25607@thunk.org>
	<Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
	<7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
	<20070212162745.GB2741@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 13 07:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGqyt-0007br-IJ
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 07:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbXBMGRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 01:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbXBMGRc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 01:17:32 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39543 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161093AbXBMGRc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 01:17:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213061730.CWUU22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Feb 2007 01:17:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NuHW1W0111kojtg0000000; Tue, 13 Feb 2007 01:17:31 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39499>

Theodore Tso <tytso@mit.edu> writes:

> On Sat, Feb 10, 2007 at 09:52:29PM -0800, Junio C Hamano wrote:
>> Although it is correct that the people who already saw the
>> original tag would not lose the tag object from their repository
>> when you publish a replacement tag, we have _always_ overwritten
>> the refs/tags/$tag to point at the new one, effectively losing
>> the original.
>
> So I have a suspicion that I have multiple tag objects with the same
> tag name (E2FSPROGS-1_26), from doing an hg conversion.  Is there an
> easy way to search all of the tag objects in my git repository to see
> if this is the case, so I can delete them lest they cause any
> confusion/problems?

"fsck --full" should report "dangling tag".
