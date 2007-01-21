From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 12:51:16 -0800
Message-ID: <7vmz4cyugr.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<200701211946.l0LJkTMV022057@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 21:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8jer-0007Xa-Rs
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 21:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbXAUUvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 15:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbXAUUvS
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 15:51:18 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53959 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbXAUUvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 15:51:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121205117.WXRQ16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jan 2007 15:51:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DwqM1W00t1kojtg0000000; Sun, 21 Jan 2007 15:50:22 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701211946.l0LJkTMV022057@laptop13.inf.utfsm.cl> (Horst H. von
	Brand's message of "Sun, 21 Jan 2007 16:46:29 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37342>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> writes:

> What are possible values of that variable? What happens if it is set/unset?
> I'd suppose that if it is set, you get the old format, but that isn't clear.

All are valid questions, but the release notes will be too long
if it made into "migration manual plus full documentation of new
features".  Its purpose is to list things you would want to pay
attention to.

> ...
> I don't see an upgrade path here that doesn't involve keeping cruft "new
> feature is on" variables around indefinitely...

The new feature will be on regardless of the configuration at
some point, perhaps in GIT 2.0.  For now it isn't, and that is
another reason the release notes do not have to (and probably
should not for the sake of brevity) talk about gory details to
turn the feature on.  If we were to do the feature in
"incompatible by default" way, the release notes should talk
about how to turn it off and keep the old way.

>>  - git-add tries to be more friendly to users by offering an
>>    interactive mode.
>
> Why not tell about "git add -i"?

Thanks, will update.  s/mode\.$/mode ("git-add -i")./

>>  - After detaching your HEAD, you can go back to an existing
>>    branch with usual "git checkout $branch".  Also you can
>>    start a new branch using "git checkout -b $newbranch".
>
> Where is such a branch rooted?

I did not think it needs to be mentioned as "git checkout -b
$newbranch" has always been "git checkout -b $newbranch HEAD"
and this is not changed with detached HEAD.  Maybe I should add
"... to start a new branch at that commit" at the end of the
sentence.  Thanks.

>>  - You can even pull from other repositories, make merges and
>>    commits while your HEAD is detached.  Also you can use "git
>>    reset" to jump to arbitrary commit.
>
> Does this leave you on that branch, or still in limbo?

Perhaps "s/\.$/, while still keeping your HEAD detached./".
Will update.

>>    lose the current stat you arrived in these ways, and "git
>>    checkout" refuses when the detached HEAD is not pointed by
>>    any existing ref (an existing branch, a remote tracking
>>    branch or a tag).  This safety can be overriden with "git
>>    checkout -f $branch".
>
> What happens if there are changes in the tracked files?

The answer is "just like normal checkout does", but I think that
level of detail does not belong to the release notes.  The list
of features is meant to be just to introduce what new things
there are, and people interested should learn the details from
the documentation.

> A bit of detail on how to specify shallowness would be nice here...

The same comment as the above applies here.
