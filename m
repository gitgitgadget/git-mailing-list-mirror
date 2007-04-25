From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add date format --local-zone
Date: Wed, 25 Apr 2007 12:59:26 -0700
Message-ID: <7vr6q8w7hd.fsf@assigned-by-dhcp.cox.net>
References: <1177482982542-git-send-email-junkio@cox.net>
	<alpine.LFD.0.98.0704250800030.9964@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704250805440.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgneI-0006l7-AW
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 21:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992999AbXDYT72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 15:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993008AbXDYT72
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 15:59:28 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53434 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992999AbXDYT71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 15:59:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070425195926.FZNS1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Apr 2007 15:59:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id rXzR1W00o1kojtg0000000; Wed, 25 Apr 2007 15:59:26 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45557>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 25 Apr 2007, Linus Torvalds wrote:
>> 
>> Ie, it would be better, I think, to use a
>> 
>> 	--date=local
>> 	--date=relative
>> 	--date=UTC
>> 	...
>> 
>> kind of syntax, than have each date flag be different ("--relative-date" 
>> vs "--local-zone"?).

Probably.

> Btw, when you do "--local-zone", you should drop the TZ printout too, I 
> think. It doesn't seem to make any sense to give the *wrong* timezone.

I do not think the definition of "wrong" is so clear.

I would not disagree that showing the authordate in timezone the
author was not in means --local-zone is showing a wrong zone,
but "show timestamps in _my_ zone" is what the option is
specifically asking for.

Originally I did it without timezone, but later I found it
amusing to see "log --since=2007-03-10 --until=2007-03-12".

	Note: in TZ=US/Pacific you would see -0700 and -0800
	during the above commit-time range.
