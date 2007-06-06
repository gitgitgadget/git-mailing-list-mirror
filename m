From: J "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH] Fix the remote note the fetch-tool prints after storing a fetched reference
Date: Wed, 06 Jun 2007 01:50:47 -0700
Message-ID: <7vps495uvs.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0706060045k4098eb05tc596214f8d9673bf@mail.gmail.com>
	<7v3b157b4j.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0706060142h2df41f11pa0157a360831736@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvrEG-0006jp-5W
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754831AbXFFIut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbXFFIus
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:50:48 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46415 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbXFFIus (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:50:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606085048.QRBW1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 04:50:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 88qn1X0041kojtg0000000; Wed, 06 Jun 2007 04:50:47 -0400
In-Reply-To: <81b0412b0706060142h2df41f11pa0157a360831736@mail.gmail.com>
	(Alex Riesen's message of "Wed, 6 Jun 2007 10:42:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49269>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 6/6/07, Junio C Hamano <gitster@pobox.com> wrote:
>> I suspect the above misses the point.
>
> Depends on the point. I mean to say: the path in the output
> of the command does not exist anywhere.
>
>> The test "ls /home/user/linux" is not relevant.  Ability to say
>> "git fetch /home/user/linux" is.
>
> This is still ambiguous:

Yup, there is an ambiguity.  Always has been.

> Which one was fetched when? /home/user/a or /home/user/a.git?

I am half tempted to say that this is very close to "doctor, it
confuses me when I have both of them".  Imagine the case where
the source were a remote repository _and_ there was no way other
than interacting with it via git protocol.  You cannot really
tell (well, you can tell half, by trying both and if a worked
but a.git didn't you can tell that a.git does not exist) nor you
do not really care.

> Besides, I just noticed git-clone is broken WRT the .git
> as well: I can clone a "a.git" into "b" (and it ignores -l and -s!),
> but I can't fetch the "a" (aka "origin") being in "b". And of
> course, "origin" in "b" is setup as "/path/a", not "/path/a.git".

This probably is worth fixing, independent from what the message
says before or after your patch.
