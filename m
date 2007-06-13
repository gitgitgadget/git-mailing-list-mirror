From: Bill Lear <rael@zopyra.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 13:56:54 -0500
Message-ID: <18032.15862.835008.22589@lisa.zopyra.com>
References: <1HyUO6-04z4yG0@fwd28.aul.t-online.de>
	<18032.3836.710438.73912@lisa.zopyra.com>
	<Pine.LNX.4.64.0706131916270.5241@castor.milkiway.cos>
	<18032.13176.649702.276044@lisa.zopyra.com>
	<Pine.LNX.4.64.0706131929020.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyY24-0006qS-Rt
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbXFMS5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbXFMS5H
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:57:07 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61570 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbXFMS5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:57:06 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5DIv1G31191;
	Wed, 13 Jun 2007 13:57:01 -0500
In-Reply-To: <Pine.LNX.4.64.0706131929020.4059@racer.site>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50116>

On Wednesday, June 13, 2007 at 19:30:23 (+0100) Johannes Schindelin writes:
>Hi,
>
>On Wed, 13 Jun 2007, Bill Lear wrote:
>
>> Not completely: they don't want to commit, as this will then "pollute"
>> the history in their working repository (which is just temporarily
>> being used to play with a new feature, idea, bug fix, optimization,
>> etc.).  This pollution with a handful of garbage would then have to be
>> undone were they to say "ok, that's really not a good idea".  If a
>> pull into a dirty tree were possible, that last step could be just a
>> simple reset, or continuing to explore with the code, etc.
>
>Notice that I am _not_ saying that CVS is bad. I am saying that their 
>workflow is likely bad (and yes, they should change that workflow, since 
>they now _can_).

Yes, I have urged this.  But, they are stubborn, smart people, and if
they see tool X allow something, they wonder why tool Y does not
support it.

>Two things do they risk happily, which they should not do:
>
>- they test their new feature against different references. For example, 
>  it might well be that they tested cases A, B, and C before pull, and D, 
>  E and F after that. It is really easy to get lost in what you have, and 
>  what not. Now, guess what. Merges are known to break things sometimes. 
>  Even the best merge algorithm. Now your developers say "we tested it, 
>  and the merge broke it, it's not our fault". But it is.

Well, their testing is something along the line of "I'm going to hack
something here, and then I want to see if Joe's latest changes work
with it".  Then, they want to pull in Joe's changes, run a test, and
if their changes don't work, fix them, discard them, etc.

>- That new feature will have to be committed at some stage. Either your 
>  devs commit at the end, which makes it a monster commit, which is bad. 
>  Or they are _already_ using the suggested workflow "commit && pull", 
>  which makes your whole complaint moot.

Perhaps: again, they may just be taking stabs that they know are wild,
and will likely not be committed.

I'm not trying to argue for their point: I do most of my new work
on branches, very rarely on the master branch, and can handle
the git pull not working in a dirty tree with merge issues.

Some of the people we work with are not developers per se: they are
engineers who sometimes like to fiddle (say, with a compiler
optimization setting) and who never push into our company repo.
They only see CVS and compare git to it.  When git prevents you
from doing something they see as perfectly reasonable, they get
annoyed and say "git sucks".  I'm battling in the git corner against
this, but there is only so much I can do.


Bill
