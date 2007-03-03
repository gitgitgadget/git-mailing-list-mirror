From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull fails to exit with non-zero status after fatal error
Date: Sat, 03 Mar 2007 14:17:23 -0800
Message-ID: <7vlkie7z0s.fsf@assigned-by-dhcp.cox.net>
References: <45E9A641.8020002@lightspeed.com>
	<Pine.LNX.4.63.0703031913100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vabyu9hcp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703032210010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070303212348.GA17796@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Larry Streepy <larry@lightspeed.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 03 23:17:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNcXg-0005KB-8P
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 23:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932979AbXCCWRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 17:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbXCCWRZ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 17:17:25 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39767 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932979AbXCCWRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 17:17:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070303221724.XPN1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 3 Mar 2007 17:17:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WNHP1W00k1kojtg0000000; Sat, 03 Mar 2007 17:17:24 -0500
In-Reply-To: <20070303212348.GA17796@spearce.org> (Shawn O. Pearce's message
	of "Sat, 3 Mar 2007 16:23:48 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41334>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Sat, 3 Mar 2007, Junio C Hamano wrote:
>> 
>> > -	finish "$new_head" "Fast forward"
>> > +	finish "$new_head" "Fast forward" || exit
>> 
>> Doesn't "exit" default to "exit 0"?
>
> No, it carries the exit status of the prior failed command if the
> prior command failed.  ;-)
>
> For what its worth, I learned that only while hacking on git-merge.
> I think it is highly non-obvious.

Sorry to be a traditionalist.  "sequence && of && commands || exit"
is an established bourne shell idiom.

I do not mind if somebody proposed to change that to "... || exit $?"
to unconfuse uninitiated, though.
