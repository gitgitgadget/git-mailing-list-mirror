From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add pack.depth option to git-pack-objects and change default depth to 50
Date: Tue, 08 May 2007 22:03:30 -0700
Message-ID: <7v8xbyzizh.fsf@assigned-by-dhcp.cox.net>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
	<11786309073709-git-send-email-tytso@mit.edu>
	<11786309072612-git-send-email-tytso@mit.edu>
	<alpine.LFD.0.99.0705081136050.24220@xanadu.home>
	<20070508163044.GA15796@thunk.org>
	<alpine.LFD.0.99.0705081323040.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 09 07:03:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HleL7-0003VG-6n
	for gcvg-git@gmane.org; Wed, 09 May 2007 07:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967581AbXEIFDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 01:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967716AbXEIFDo
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 01:03:44 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:36118 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967581AbXEIFDn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 01:03:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509050344.CMSC24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 01:03:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wt3W1W00W1kojtg0000000; Wed, 09 May 2007 01:03:39 -0400
In-Reply-To: <alpine.LFD.0.99.0705081323040.24220@xanadu.home> (Nicolas
	Pitre's message of "Tue, 08 May 2007 13:35:40 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46661>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 8 May 2007, Theodore Tso wrote:
>
>> On Tue, May 08, 2007 at 11:38:46AM -0400, Nicolas Pitre wrote:
>> > On Tue, 8 May 2007, Theodore Ts'o wrote:
>> > 
>> > > Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
>> > 
>> > I'd prefer if tests were performed on the performance impact before 
>> > changing the default depth.  If done separately from this patch then the 
>> > commit log could contain those results as well.
>> 
>> The following results are on a recent git repository, using time to
>> record the real, user, and sys times on the two commands: "git-gc
>> --no-reuse-delta --window=X --depth=Y" and "git log --pretty=oneline
>> -S'object' > /dev/null".  All of these tests were done with a hot
>> cache, so disk speed didn't enter into the calculations.
> [...]
>> My conclusion given this quick benchmark is that it seems to me that
>> changing the defaults of --depth to 50, and keeping --window at 10, is
>> a reasonable thing to do.
>
> Effectively.
>
> I'd still prefer to see the default changed in a patch of its own 
> though.

I'll split the patch into two and apply them separately.
