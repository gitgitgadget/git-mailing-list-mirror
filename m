From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Restoring files from old commits
Date: Sat, 14 Jul 2007 11:50:49 -0700
Message-ID: <7vbqeeizue.fsf@assigned-by-dhcp.cox.net>
References: <4698BD17.5080205@random-state.net>
	<20070714123754.GA29622@piper.oerlikon.madduck.net>
	<20070714143233.GC2544@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Nikodemus Siivola <nikodemus@random-state.net>,
	martin f krafft <madduck@madduck.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 20:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9mhj-0003VG-E7
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 20:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763458AbXGNSuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 14:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763768AbXGNSuw
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 14:50:52 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43267 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763686AbXGNSuu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 14:50:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714185051.IKFJ1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 14 Jul 2007 14:50:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PWqp1X00K1kojtg0000000; Sat, 14 Jul 2007 14:50:50 -0400
In-Reply-To: <20070714143233.GC2544@steel.home> (Alex Riesen's message of
	"Sat, 14 Jul 2007 16:32:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52495>

Alex Riesen <raa.lkml@gmail.com> writes:

> martin f krafft, Sat, Jul 14, 2007 14:37:54 +0200:
>> also sprach Nikodemus Siivola <nikodemus@random-state.net> [2007.07.14.1409 +0200]:
>> > What is the recommended way to restore individual files
>> > (or directories) in the working tree to the content they
>> > had in a given commit?
>> 
>> As per my comment on IRC, I think
>> 
>>   git checkout <tree-ish> <path>
>> 
>> is the way.
>
> It does not work for directories, though.

Are you sure about that?  I just did this in my git.git workspace:

	$ mv Documentation Documentation-
        $ git checkout HEAD Documentation/
        $ diff -r Documentation- Documentation
