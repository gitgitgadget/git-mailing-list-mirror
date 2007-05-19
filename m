From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (amend)] cvsserver: Add test cases for config file handling
Date: Sat, 19 May 2007 13:00:57 -0700
Message-ID: <7v8xbkwpl2.fsf@assigned-by-dhcp.cox.net>
References: <11790154701376-git-send-email-frank@lichtenheld.de>
	<117901685018-git-send-email-frank@lichtenheld.de>
	<7vtzugqym8.fsf@assigned-by-dhcp.cox.net>
	<20070514125915.GB5272@planck.djpig.de>
	<20070519140521.GA4085@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sat May 19 22:01:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpV6v-00085X-26
	for gcvg-git@gmane.org; Sat, 19 May 2007 22:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756969AbXESUA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 16:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757945AbXESUA7
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 16:00:59 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51766 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756969AbXESUA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 16:00:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519200057.TFE19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 16:00:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 180x1X0011kojtg0000000; Sat, 19 May 2007 16:00:57 -0400
In-Reply-To: <20070519140521.GA4085@planck.djpig.de> (Frank Lichtenheld's
	message of "Sat, 19 May 2007 16:05:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47768>

Frank Lichtenheld <frank@lichtenheld.de> writes:

>> But I certainly don't intend to do all the tests in one big file which
>> will become rather large over time. If you're concerned with code
>> duplication, maybe I should move the code to a separate file and source
>> it from there?
>
> Still waiting on a comment here...

Well, It seems that all of our foreign SCM tests tends to be
slower than other tests, so I would be happier if a single run
of one test covers everything we would want to cover, when I run
"make test", rather than having multiple set-up steps that are
identical in two different tests.  So in that sense, I was not
talking about code duplication which can be solved by splitting
the duplicated part into a separate file and sourcing it from
two scripts -- that is not a solution.

Another thing we would need to decide (with Eric who has the
same issue) is how to structure the tests that try daemons.  We
worked it around by using :fork: for the first cvsserver test,
but we would eventually want the real pserver test as well.
