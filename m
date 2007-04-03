From: Junio C Hamano <junkio@cox.net>
Subject: Re: Distribution of longest common hash prefixes
Date: Tue, 03 Apr 2007 13:25:26 -0700
Message-ID: <7vhcrxw6h5.fsf@assigned-by-dhcp.cox.net>
References: <20070402145857.GA13293@bohr.gbar.dtu.dk>
	<Pine.LNX.4.64.0704020817250.6730@woody.linux-foundation.org>
	<86bqi6kae7.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0704020938470.6730@woody.linux-foundation.org>
	<86y7laitlz.fsf@blue.stonehenge.com>
	<86r6r2isva.fsf@blue.stonehenge.com>
	<m3r6r1jsmq.fsf@lugabout.jhcloos.org>
	<867istcrhr.fsf@blue.stonehenge.com>
	<20070403172123.GD27706@spearce.org>
	<Pine.LNX.4.64.0704031046150.6730@woody.linux-foundation.org>
	<7vhcrxz5a8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704031529300.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	James Cloos <cloos@jhcloos.com>, git@vger.kernel.org,
	Peter Eriksen <s022018@student.dtu.dk>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYpZO-0006eA-0K
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945905AbXDCUZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbXDCUZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:25:28 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:65001 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422671AbXDCUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:25:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403202527.WEUU24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 16:25:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ikRS1W0091kojtg0000000; Tue, 03 Apr 2007 16:25:27 -0400
In-Reply-To: <alpine.LFD.0.98.0704031529300.28181@xanadu.home> (Nicolas
	Pitre's message of "Tue, 03 Apr 2007 15:34:02 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43653>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 3 Apr 2007, Junio C Hamano wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > Yeah, the short SHA1 form is obviously always going to be risky. But in 
>> > practice, since people almost always use it just for commits, it's 
>> > probably good enough in practice, and even if you get a collision in 8 
>> > nibbles, most of the time it will probably be trivial to figure out which 
>> > one was meant, so it's not like it's a disaster if somebody ends up 
>> > reporting a bug with a non-unique abbreviation.
>> 
>> Are you hinting to update sha1_name.c::get_sha1() so that we do
>> not accept abbreviated non-commit object names?
>
> NO, I hope not.
>
> Instead (and if the concern is real) we should error out when the 
> abbreviated name is ambigous and impose no restriction otherwise.

I stated it wrongly.  What I was getting at was that we might
want to consider an abbreviation that matches only a single
commit unambiguous even when there are ambiguous objects of
other kinds.

Not that I consider it a pressing issue, though.
