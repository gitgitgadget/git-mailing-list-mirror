From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add sendmail -f support to git-send-email.
Date: Tue, 10 Apr 2007 22:18:37 -0700
Message-ID: <7vejmrqyj6.fsf@assigned-by-dhcp.cox.net>
References: <11762425341841-git-send-email-robbat2@gentoo.org>
	<20070410223826.GH2813@planck.djpig.de>
	<7v6483u95i.fsf@assigned-by-dhcp.cox.net>
	<20070411003818.GI2813@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 12:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbVEO-0006nx-Gz
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 07:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbXDKFSk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 01:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbXDKFSj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 01:18:39 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:62908 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161194AbXDKFSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 01:18:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411051837.UGJU1266.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 01:18:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lhJd1W00r1kojtg0000000; Wed, 11 Apr 2007 01:18:38 -0400
In-Reply-To: <20070411003818.GI2813@planck.djpig.de> (Frank Lichtenheld's
	message of "Wed, 11 Apr 2007 02:38:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44207>

Frank Lichtenheld <frank@lichtenheld.de> writes:

>> I thought I saw the '-f' patch somewhere on the list in the last
>> several weeks and there was a discussion on this topic that
>> followed the patch.  Am I hallucinating, or was it not applied
>> because there were some issues?
>
> Can't find anything in the archives. So either I completly suck
> at searching, or it is at least several months old, or you
> are hallucinating :)

It was the thread about update-hook that sends e-mail; the
discussion ends here:

http://thread.gmane.org/gmane.comp.version-control.git/42927/focus=42996

The patch was from Jim Meyering that made the script to
unconditionally pass -f '$envelope_sender'; it was not applied
because the whole e-mail sending business was removed from the
update hook.

We seem to do a "-f '$envelope_sender'" in the example 'post-receive'
hook only when the configuration tells it to, so probably it is
a good idea to follow suit in this program.
